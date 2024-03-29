% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/amylase.R
\name{stdcurve}
\alias{stdcurve}
\title{Standard curve calculation}
\usage{
stdcurve(
  std_data,
  cols = NULL,
  ml_maltose = c(0.00375, 0.015, 0.03, 0.045, 0.06, 0.075, 0.15)
)
}
\arguments{
\item{std_data}{Data frame with the photometric readings of the standard curve.}

\item{cols}{Vector containing the column numbers containing the standard curve photometric readings. If NULL, all columns assumed to be standard curve measurements.}

\item{ml_maltose}{vector of length 7 containing the volume (ml) of 0.2\% maltose solution added to the assay.}
}
\description{
Standard curve calculation
}
