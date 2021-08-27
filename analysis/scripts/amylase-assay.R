#library(byocstarch)
devtools::load_all()
library(tidyverse)

# Upload data -------------------------------------------------------------

plt1_ph1 <- readr::read_table(
  here::here("analysis/Amylase/ExpM_plate1_photometric1.txt"),
  col_names = F)
plt1_ph2 <- readr::read_table(
  here::here("analysis/Amylase/ExpM_plate1_photometric2.txt"),
  col_names = F)

plt2_ph1 <- readr::read_table(
  here::here("analysis/Amylase/ExpM_plate2_photometric1.txt"),
  col_names = F)
plt2_ph2 <- readr::read_table(
  here::here("analysis/Amylase/ExpM_plate2_photometric2.txt"),
  col_names = F)


# Data prep ---------------------------------------------------------------



# Standard curve ----------------------------------------------------------

# convert mL 0.2% Maltose to mg maltose
#mg_malt <- c(3.75, 15, 30, 45, 60, 75, 150) * 0.002
# two standard curves prepared: one in h2o and one in artificial saliva (BMM)
stdH2O1.ph1 <- stdcurve(plt1_ph1, cols = 7:9)
#stdH2O1.ph1 <- stdcurve(plt1_ph1, cols = 7:9, mg_maltose = mg_malt)
stdBMM1.ph1 <- stdcurve(plt1_ph1, cols = 10:12)
#stdBMM1.ph1 <- stdcurve(plt1_ph1, cols = 10:12, mg_maltose = mg_malt)

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
# plt1_ph1.res <- sep_samples(plt1_ph1)
# plt1_ph2.res <- sep_samples(plt1_ph2)
# plt2_ph1.res <- sep_samples(plt2_ph1)
# plt2_ph2.res <- sep_samples(plt2_ph2)

# saliva calculation
split_results <- lapply(phot_results, split, f = ~ solution)
saliva_samples <- list("plate1_phot1_saliva" = split_results$plate1_phot1$saliva,
                       "plate1_phot2_saliva" = split_results$plate1_phot2$saliva,
                       "plate2_phot1_saliva" = split_results$plate2_phot1$saliva,
                       "plate2_phot2_saliva" = split_results$plate2_phot2$saliva) %>%
  lapply(select, !solution)
#lapply(saliva_samples, select, !solution)
#sample_calc(split_results$plate1_phot1$saliva, std_curve = stdH2O1.ph1, dilf = 2, ml_enz = 0.075)

# saliva1_ph1 <- split_results$plt1_ph1$saliva
# saliva1_ph2 <- split_results$plt1_ph2$saliva
# saliva2_ph1 <- split_results$plt2_ph1$saliva
# saliva2_ph2 <- split_results$plt2_ph2$saliva

# saliva1_ph1 <- plt1_ph1.res$saliva
# saliva1_ph2 <- plt1_ph2.res$saliva
# saliva2_ph1 <- plt2_ph1.res$saliva
# saliva2_ph2 <- plt2_ph2.res$saliva


# saliva_results <- lapply(
#   saliva_samples,
#   sample_calc,
#   stdcurve = c(stdH2O1.ph1, stdH2O1.ph2, stdH2O2.ph1, stdH2O2.ph2),
#   dilf = 2,
#   ml_enz = 0.075)

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


# colour tables

# test <- plt1_ph1_result %>%
#   mutate(background = spec_color(1:10, end = 0.9, option = "A", direction = -1))
