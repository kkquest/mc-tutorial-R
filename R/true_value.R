#' -----------------------------------------------------------------------------
#' True Value for Simple Monte Carlo Example
#'
#' Provides the true theoretical probability of the event Z₁+Z₂>4
#' under independent standard normal draws, used as a reference in CI plots.
#'
#' @format Numeric scalar.
#' @examples
#' # Reference line in convergence plots:
#' true_estimate
#'
#' @export
true_estimate <- 1 - pnorm(4/sqrt(2))
