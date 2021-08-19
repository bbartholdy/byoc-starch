# R Script for correcting counts according to volume and proportion of slide counted

# Dependencies ------------------------------------------------------------

library(magrittr)
library(dplyr)
library(here)
library(readr)

# Upload data -------------------------------------------------------------

 # starch counts in samples
raw_counts <- readr::read_csv(here("analysis/data/derived_data/", "starch_counts.csv"))

 # starch counts in solutions
sol_counts <- readr::read_csv(here("analysis/data/derived_data/", "solution_counts.csv"))

# Functions ---------------------------------------------------------------

 # function to correct counts for volume and proportion of slide counted

correct_count <- function(raw, prop, vol){
  corrected <- raw * (1 / prop) * (vol / 20)
  corrected
}

 # function to extrapolate solution counts to 1 ml exposure per day

extrap_count <- function(raw, prop, vol, days){
  extrap <- raw * (1 / prop) * 100 * days
  extrap
}

# Outlier detection and removal -------------------------------------------

raw_counts %>%
  filter(treatment != "control") %>%
  ggplot() +
  geom_boxplot(aes(x = starch, y = total, fill = starch))

# Only lower outliers were considered, as this would suggest that there may have
  # been a problem with the sample and incorporation of starches. Given that all
  # samples were treated equally, there is no reason to consider upper outliers
  # problematic.


# Solution counts ---------------------------------------------------------

sol_corr <- sol_counts %>%
  mutate(across(c(s, m, l, total), extrap_count, portion_slide, vol_slide, days = 16))
readr::write_csv(sol_corr, here("data", "sol_corr.csv"))

# Apply correction --------------------------------------------------------

corr_counts <- raw_counts %>%
  #filter(treatment != "control") %>%
  mutate(across(c(s, m, l, total), correct_count, portion_slide, vol)) %>%
  select(!c(vol, portion_slide)) %>%
  filter(sample != "st2C6")
readr::write_csv(corr_counts, here("data", "corr_counts.csv"))

# Combining mixed treatment counts ----------------------------------------

  # combining potato and wheat counts from mixed treatment samples

# merge two adjacent rows and add variables s, m , l, total

corr_comb <- corr_counts %>%
  select(!starch) %>%
  pivot_wider(names_sep = "", values_from = c(s, m, l, total),
              values_fill = NA,
              values_fn = function(x) sum(x, na.rm = T))
readr::write_csv(corr_comb, here("data", "corr_comb.csv"))
