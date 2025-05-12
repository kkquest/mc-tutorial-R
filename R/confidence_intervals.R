#' -----------------------------------------------------------------------------
#' Confidence Interval Data Frame Builder 
#'
#' Computes point estimates and 95% confidence intervals across varying sample sizes
#' Applied to every var reduction technique and standard MC 
#'
#' @param vec:           Numeric vector of Monte Carlo draws
#' @param sample_sizes:  Integer vector of sample sizes at which to evaluate estimates.
#' @param true_p:        Known true probability of our example.
#' @param alpha:         Significance level (default is 95%).
#'
#' @return Returns a data.frame with columns:
#' n        - sample size
#' estimate - sample mean at that n
#' lower    - lower bound of the (1-alpha)% CI
#' upper    - upper bound of the (1-alpha)% CI
#' true_p   - true probability.
#' @examples
#' df <- ci_df(vec=rnorm(1000), sample_sizes = c(100,500,1000), true_p = 0.5)
#' @export
ci_df <- function(vec, sample_sizes, true_p = NULL, alpha = 0.05) {
  # # For each sample size, compute estimate and CI
  rows <- lapply(sample_sizes, function(n) {
    # Sample mean
    est <- mean(vec[1:n])
    # Standard error
    se <- sqrt(var(vec[1:n]) / n)
    # Half-width of CI
    halfw <- qnorm(1 - alpha/2) * se
    
    # Return a one row data frame for the current n
    data.frame(
      n        = n,
      estimate = est,
      lower    = est - halfw,
      upper    = est + halfw
    )
  })
  
  # Combine all rows into a single data.frame
  df <- do.call(rbind, rows)
  
  # Attach the true probability 
  if (!is.null(true_p)) attr(df, "true_p") <- true_p
  
  return(df)
}




