#' -----------------------------------------------------------------------------
#' Standard Monte Carlo Sampler - Baseline for Rare-Event Example
#'
#' Draws n samples of Z1+Z2 under N(0,1) and checks if they exceed a threshold.
#' Serves as our baseline.
#'
#' @param n:         Integer number of draws.
#' @param threshold: Numeric cutoff for our rare-event test (we use 4 in our tutorial).
#' @param seed:      Optional RNG seed for exact reproducibility.
#'
#' @return Returns numeric vector of 0/1 indicators for each sample.
# @examples
#' rare_event_standard(n =1000, threshold = 4, seed = 42)
#' @export
rare_event_standard <- function(n, threshold, seed = NULL) {
  # Set the seed for reproducibility
  if (!is.null(seed)) set.seed(seed)
  
  # Draw z1 and z2 vectors of length n
  z1 <- rnorm(n)
  z2 <- rnorm(n)
  
  # Returns 1 if z1+z2 > threshold, else 0
  as.numeric(z1 + z2 > threshold)
}


#' -----------------------------------------------------------------------------
#' Inverse CDF-based Sampler for Antithetic Wrapper
#'
#' Converts uniform pairs (u1,u2) to normals via qnorm,
#' then checks if their sum exceeds threshold.
#' Used internally by antithetic_mc().
#'
#' @param u1,u2:     Uniform draws in (0,1).
#' @param threshold: Numeric cutoff for the rare-event test (we use 4).
#'
#' @return Returns a single 0/1 indicator for the pair.
#' @examples
#' sim_antithetic(u1 = runif(1), u2 = runif(1), threshold = 4)
#' @export
sim_antithetic <- function(u1, u2, threshold = 4) {
  z1 <- qnorm(u1)
  z2 <- qnorm(u2)
  
  # Returns 1 if z1+z2 exceeds our tutorial threshold 
  as.numeric(z1 + z2 > threshold)
}



#' -----------------------------------------------------------------------------
#' Y Simulator for Control Variates
#'
#' Indicator for Y = 1{z1+z2 > threshold},
#' used by control_variate_mc() to compute raw estimates.
#'
#' @param z1,z2:     Numeric draws.
#' @param  threshold: Numeric cutoff for our rare-event test (we use 4).
#'
#' @return Returns 0/1 indicator.
#' @examples
#' sim_y_cv(z1 = rnorm(1), z2 = rnorm(1), threshold = 4)
#' @export
sim_y_cv <- function(z1, z2, threshold = 4) {
  as.numeric(z1 + z2 > threshold)
}



#' -----------------------------------------------------------------------------
#' X Simulator for Control Variates
#'
#' Computes X=z1+z2 whose expectation under N(0,1)+N(0,1) is known (0).
#' Enables computation of control variate adjustments in control_variate_mc().
#'
#' @param z1,z2: Numeric draws.
#' @param threshold ignored for signature consistency*.
#'
#' @return Returns the sum z1+z2.
#' @examples
#' sim_x_cv(z1 = rnorm(1), z2 = rnorm(1))
#' @export
sim_x_cv <- function(z1, z2, threshold = NULL) {
  z1 + z2
}



