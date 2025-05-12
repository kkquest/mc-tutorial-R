#' -----------------------------------------------------------------------------
#' Antithetic Monte Carlo Estimator
#'
#' Pairs each uniform draw with its antithetic counterpart (U vs. 1−U)
#' to estimate P(Z₁+Z₂>threshold).
#'
#' This directly implements the rare-event example from our tutorial with threshold = 4.
#'
#' @param sim_fn:    Function(u1, u2, threshold).
#' @param n_sims:    Total draws.
#' @param seed:      Optional RNG seed for exact reproducibility
#' @param threshold: Numeric cutoff for our Z₁+Z₂>threshold test (default 4).
#'
#' @return Returns a length-n_sims vector of pair-averaged estimates.
#' @examples
#' antithetic_mc(sim_fn = sim_antithetic, n_sims = 1e3, seed = 42, threshold = 4)
#' @export
antithetic_mc <- function(sim_fn, n_sims, seed = NULL, threshold = 4) {
  # Set the seed for reproducibility
  if (!is.null(seed)) set.seed(seed)
  # Draw n_sims uniforms twice
  U1 <- runif(n_sims)
  U2 <- runif(n_sims)
  
  # For each pair (u1,u2):
  # 1. Compute sim_fn(u1, u2, threshold): indicator for Z₁+Z₂>4
  # 2. Compute sim_fn(1-u1, 1-u2, threshold): its antithetic twin
  # 3. Average the two outcomes to achieve negative correlation
  mapply(function(u1, u2) {
    y1 <- sim_fn(u1, u2, threshold = threshold)
    y2 <- sim_fn(1-u1, 1-u2, threshold = threshold)
    mean(c(y1,y2))
  }, U1, U2)
}
#' -----------------------------------------------------------------------------


#' -----------------------------------------------------------------------------
#' Control Variate Monte Carlo Estimator
#'
#' Uses an auxiliary variable X with known mean to correct noisy estimates of Y.
#' In our tutorial, Y = 1{Z₁+Z₂>threshold} and X = (Z₁+Z₂).  E[X]=0 under N(0,1)+N(0,1).
#'
#' @param sim_fn:   Function(z1, z2, threshold).
#' @param cv_fn:    Function(z1, z2).
#' @param cv_known: Known E[X] (0 for sum of two standard normals).
#' @param n_sims:   Total draws.
#' @param seed:     Optional RNG seed for exact reproducibility
#' @param ...:      To pass threshold.
#'
#' @return Returns length-n_sims vector: Y_i−β·(X_i−E[X])
#' @examples
#' control_variate_mc(sim_fn = sim_y_cv, cv_fn = sim_x_cv, cv_known = 0,
#'                   n_sims = 1e3, seed = 42)
#' @export
control_variate_mc <- function(sim_fn, cv_fn, cv_known, n_sims, seed = NULL, ...) {
  # Set the seed for reproducibility
  if (!is.null(seed)) set.seed(seed)

  # Define the vectors
  ys <- numeric(n_sims)
  xs <- numeric(n_sims)
  
  # For each iteration, draw z1,z2, compute Y and X
  for (i in seq_len(n_sims)) {
    z1 <- rnorm(1); z2 <- rnorm(1)
    ys[i] <- sim_fn(z1, z2)    
    xs[i] <-cv_fn(z1, z2)   
  }
  
  # Compute β = Cov(Y,X)/Var(X) to prevent zero variance
  beta <- if (var(xs) > 0) cov(ys, xs) / var(xs) else 0
  
  #Subtract the control’s scaled deviation (X - E[X]) from Y to correct estimates
  ys - beta * (xs - cv_known)
}



#' -----------------------------------------------------------------------------
#' Importance Sampling Monte Carlo Estimator
#'
#' Draws from a shifted normal (mean=mu_shift) to focus on the rare tail Z₁+Z₂>threshold,
#' then reweights each draw by p(s)/q(s) to remain unbiased.
#'
#' @param n_sims:    Total draws.
#' @param mu_shift:  Mean of proposal N(mu_shift, 2) (we used 2 to hit threshold 4).
#' @param threshold: Our set threshold.
#' @param seed:      Optional RNG seed for exact reproducibility
#'
#' @return Returns length-n_sims vector: indicator(s>threshold)*p(s)/q(s).
#' @examples
#' importance_mc(n_sims = 1e3, mu_shift = 2, threshold = 4, seed =42)
#' @export
importance_mc <- function(n_sims, mu_shift = 2, threshold = 4, seed = NULL) {
  # Set the seed for reproducibility
  if (!is.null(seed)) set.seed(seed)
  
  # Draw s from proposal
  s <- rnorm(n_sims, mean = mu_shift, sd = sqrt(2))
  
  # Compute I[S>threshold]
  I <- as.numeric(s > threshold)
  
  # Compute importance weight = p(s)/q(s)
  w <- dnorm(s, mean = 0, sd = sqrt(2)) /
    dnorm(s, mean = mu_shift,sd = sqrt(2))
  
  # Return weighted estimate
  I * w
}
