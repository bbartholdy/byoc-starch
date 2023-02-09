#' Correct starch counts
#'
#' Calculates the number of starches on a whole microscope slide based on the
#' proportion of slide that was actually counted.
#'
#' @param raw integer. absolute number of starches counted.
#' @param prop numeric. Proportion of slide that was counted.
#' @param vol numeric. Volume of EDTA on the mounted slide.
#' @export

correct_count <- function(raw, prop, vol){
  corrected <- raw * (1 / prop) * (vol / 20)
  corrected
}

#' Extrapolates the counts from a slide to the total count over the course of the
#' experiment.
#' @param @inheritParams correct_count
#' @param vol numeric. Volume of starch added to the sample wells.
#' @param days integer. Number of days starch was included in experiment treatments.
#' @export

extrap_count <- function(raw, prop, vol, days){
  extrap <- raw * (1 / prop) * 100 * days
  extrap
}
