#' -----------------------------------------------------------------------------
#' Plotting Monte Carlo Estimates
#'
#' Generates a clear, annotated plot showing point estimates and confidence
#' intervals across sample sizes, with a dashed line marking the known true p.
#' Designed for our tutorial’s rare-event example (P(Z₁+Z₂>4)).
#'
#' @param df: ci_df() containing columns:
#'            n  – sample size
#'            estimate – sample mean
#'            lower – lower CI bound
#'            upper – upper CI bound
#' @param true_p:  True probability.
#' @param title:   Plot title.
#'
#' @return Returns a ggplot2 object.
#' @examples
#' df <- ci_df(vec=rnorm(5000), sample_sizes = c(100, 1000, 5000), true_p = 0.5)
#' plot_estimates(df, true_p = 0.5, title = "MC Estimates by Sample Size")
#' @export
plot_estimates <- function(df, true_p, title) {
  ggplot(df, aes(x = factor(n), y = estimate)) +
    # Points for each estimate
    geom_point(size = 3) +
    # Error bars for CI
    geom_errorbar(aes(ymin = lower, ymax = upper), width = 0.2) +
    # True prob added as a dashed line
    geom_hline(yintercept = true_p, linetype = "dashed") +
    # Fix the y-axis limits for more evident plot comparison
    scale_y_continuous(limits = c(-0.001, 0.0075)) +
    labs(title = title, x = "Number of Sims", y = "Estimate") +
    theme_minimal()
}
