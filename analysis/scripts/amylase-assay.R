# if(require(byocstarch, quietly = T)) {
#   library(byocstarch)
# } else {
#   devtools::load_all()
# }

library(tidyverse)

# Functions ---------------------------------------------------------------

#' Standard curve calculation
#' @param std_data Data frame with the photometric readings of the standard curve.
#' @param cols Vector containing the column numbers containing the standard curve photometric readings. If NULL, all columns assumed to be standard curve measurements.
#' @param ml_maltose vector of length 7 containing the volume (ml) of 0.2% maltose solution added to the assay.
#' @importFrom magrittr %>%
#' @importFrom dplyr slice n
stdcurve <- function(std_data, cols = NULL, ml_maltose = c(3.75, 15, 30, 45, 60, 75, 150)){
  if(!is.null(cols)){
    std_data <- std_data[,cols]
  }
  # delta 540 calculation
  mg_maltose <- 0.002 * ml_maltose
  replicates <- dim(std_data)[2]
  pht_blank <- std_data[8,] %>%
    slice(rep(1:n(), each = 7))
  pht_meas <- std_data[1:7,] - pht_blank

  pht_meas <- c(pht_meas[, seq(1:replicates)]) %>%
    unlist()
  # Linear regression
  stdCurve_data <- data.frame("d540" = pht_meas, "mgMaltose" = rep(mg_maltose, replicates))
  std_curve <- lm(d540 ~ mgMaltose, stdCurve_data)
  # Plot of standard curve
  p_stdcurve <- stdCurve_data %>%
    ggplot(aes(x = mgMaltose, y = d540)) +
    geom_point() +
    geom_smooth(formula = "y ~ x", method = "lm", se = F) +
    theme_bw()
  out <- list("std_curve" = std_curve, "plot" = p_stdcurve, "blank" = pht_blank[1,], "replicates" = replicates, "model" = stdCurve_data)
  return(out)
}

#' Amylase activity in sample calculation
#' @param samp_data data frame with the photometric readings of the samples.
#' @param cols vector containing the column numbers of the sample photometric readings. If NULL, all columns assumed to be standard curve measurements.
#' @param std_curve an object from the `stdcurve` function output.
#' @param dilf dilution factor of samples. Or, dad I'd like to ...
#' @param ml_enzyme volume of the sample used in the assay.
#' @importFrom magrittr %>%
#' @importFrom dplyr slice n

sample_calc <- function(samp_data, cols = NULL, std_curve, dilf, ml_enz){
  if(!is.null(cols)){
    samp_data <- samp_data[,cols]
  }
  #rownames(samp_data) <- NULL
  #colnames(samp_data) <- NULL
  #samp_data_mat <- as.matrix(samp_data)
  replicates <- std_curve$replicates
  model <- std_curve$std_curve
  b0 <- coef(model)[1]
  b1 <- coef(model)[2]
  blank <- std_curve$blank
  n_rows <- nrow(samp_data)
  n_cols <- ncol(samp_data)
  samp_data <- samp_data %>%
    mutate(across(everything(), as.numeric))
  blank_mat <- blank %>%
    slice(rep(1:n(), each = n_rows))
  samp_data_corr <- samp_data - blank_mat

  out <- as.data.frame(matrix(nrow = n_rows, ncol = n_cols))
  for(i in 1:dim(samp_data)[2]){
    unk <- samp_data_corr[,i]
    malt_mg <- (unk - b0) / b1
    units <- malt_mg * dilf / ml_enz
    out[,i] <- units
  }
  return(out)
}

#' Highly specialised function to separate saliva and bmm samples
#' @param data data frame containing the photometric readings
sep_samples <- function(data){
  saliva <- data[1:3, 1:3]
  bmm <- data[c(4:8),]
  bmm <- bmm[,1:3]
  colnames(bmm) <- c("X1", "X2", "X3")
  bmm2 <- data[1:3, 4:6]
  colnames(bmm2) <- c("X1", "X2", "X3")
  bmm <- rbind(bmm,bmm2)
  saliva$solution <- "saliva"
  bmm$solution <- "bmm"
  out <- as.data.frame(rbind(saliva, bmm))
  #out <- list("saliva" = saliva, "bmm" = bmm)
  return(out)
}

# sep_samples <- function(data){
#   saliva <- data[1:3, 1:3]
#   bmm <- data[c(4:8),]
#   bmm <- bmm[,1:3]
#   colnames(bmm) <- c("1", "2", "3")
#   bmm2 <- data[1:3, 4:6]
#   colnames(bmm2) <- c("1", "2", "3")
#   bmm <- rbind(bmm,bmm2)
#   out <- list("saliva" = saliva, "bmm" = bmm)
#   return(out)
# }


# Upload data -------------------------------------------------------------

plt1_ph1 <- readr::read_tsv(
  here::here("analysis/data/raw_data/ExpM_plate1_photometric1.csv"),
  col_names = F)
plt1_ph2 <- readr::read_tsv(
  here::here("analysis/data/raw_data/ExpM_plate1_photometric2.csv"),
  col_names = F)

plt2_ph1 <- readr::read_tsv(
  here::here("analysis/data/raw_data/ExpM_plate2_photometric1.csv"),
  col_names = F)
plt2_ph2 <- readr::read_tsv(
  here::here("analysis/data/raw_data/ExpM_plate2_photometric2.csv"),
  col_names = F)


# Data prep ---------------------------------------------------------------



# Standard curve ----------------------------------------------------------

# convert mL 0.2% Maltose to mg maltose

# two standard curves prepared: one in h2o and one in artificial saliva (BMM)
stdH2O1.ph1 <- stdcurve(plt1_ph1, cols = 7:9)
stdBMM1.ph1 <- stdcurve(plt1_ph1, cols = 10:12)

stdH2O1.ph2 <- stdcurve(plt1_ph2, cols = 7:9)
stdBMM1.ph2 <- stdcurve(plt1_ph2, cols = 10:12)

stdH2O2.ph1 <- stdcurve(plt2_ph1, cols = 7:9)
stdBMM2.ph1 <- stdcurve(plt2_ph1, cols = 10:12)

stdH2O2.ph2 <- stdcurve(plt2_ph2, cols = 7:9)
stdBMM2.ph2 <- stdcurve(plt2_ph2, cols = 10:12)


# Samples -----------------------------------------------------------------

# Data prep

plates <- list("plate1_phot1" = plt1_ph1, "plate1_phot2" = plt1_ph2,
               "plate2_phot1" = plt2_ph1, "plate2_phot2" = plt2_ph2)
phot_results <- lapply(plates, sep_samples)

# saliva calculation
split_results <- lapply(phot_results, split, f = ~ solution)
saliva_samples <- list("plate1_phot1_saliva" = split_results$plate1_phot1$saliva,
                       "plate1_phot2_saliva" = split_results$plate1_phot2$saliva,
                       "plate2_phot1_saliva" = split_results$plate2_phot1$saliva,
                       "plate2_phot2_saliva" = split_results$plate2_phot2$saliva) %>%
  lapply(select, !solution)

sal1_ph1 <- sample_calc(saliva_samples$plate1_phot1_saliva,
                        std_curve = stdH2O1.ph1,
                        dilf = 2, ml_enz = 0.075)
sal1_ph2 <- sample_calc(saliva_samples$plate1_phot2_saliva,
                        std_curve = stdH2O1.ph2,
                        dilf = 2, ml_enz = 0.075)
sal2_ph1 <- sample_calc(saliva_samples$plate2_phot1_saliva,
                        std_curve = stdH2O2.ph1,
                        dilf = 2, ml_enz = 0.075)
sal2_ph2 <- sample_calc(saliva_samples$plate2_phot2_saliva,
                        std_curve = stdH2O2.ph2,
                        dilf = 2, ml_enz = 0.075)

# bmm calculation

bmm_samples <- list("plate1_phot1_bmm" = split_results$plate1_phot1$bmm,
                       "plate1_phot2_bmm" = split_results$plate1_phot2$bmm,
                       "plate2_phot1_bmm" = split_results$plate2_phot1$bmm,
                       "plate2_phot2_bmm" = split_results$plate2_phot2$bmm) %>%
  lapply(select, !solution)

bmm1_ph1 <- sample_calc(bmm_samples$plate1_phot1_bmm,
                        std_curve = stdBMM1.ph1,
                        dilf = 1, ml_enz = 0.075)
bmm1_ph2 <- sample_calc(bmm_samples$plate1_phot2_bmm,
                        std_curve = stdBMM1.ph2,
                        dilf = 1, ml_enz = 0.075)
bmm2_ph1 <- sample_calc(bmm_samples$plate2_phot1_bmm,
                        std_curve = stdBMM2.ph1,
                        dilf = 1, ml_enz = 0.075)
bmm2_ph2 <- sample_calc(bmm_samples$plate2_phot2_bmm,
                        std_curve = stdBMM2.ph2,
                        dilf = 1, ml_enz = 0.075)

# results in units / mL enzyme where a unit is mg maltose released in 6 minutes
plt1_ph1_result <- rbind(sal1_ph1, bmm1_ph1)
plt1_ph2_result <- rbind(sal1_ph2, bmm1_ph2)
plt2_ph1_result <- rbind(sal2_ph1, bmm2_ph1)
plt2_ph2_result <- rbind(sal2_ph2, bmm2_ph2)
