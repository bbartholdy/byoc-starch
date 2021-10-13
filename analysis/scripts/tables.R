# Script for tables

library(here)
library(tidyverse)

corr_counts <- readr::read_csv(here("analysis/data/derived_data/", "corr_counts.csv"))
corr_comb <- readr::read_csv(here("analysis/data/derived_data/", "corr_comb.csv"))
sol_corr <- readr::read_csv(here("analysis/data/derived_data/", "sol_corr.csv"))

# Sample weights ----------------------------------------------------------

# create data frame with mean and sd by treatment
anova_tbl <- corr_comb %>%
  group_by(treatment) %>%
  summarise(mean = mean(weight, na.rm = T),
            sd = sd(weight, na.rm = T),
            min = min(weight, na.rm = T),
            max = max(weight, na.rm = T)) %>%
  mutate(across(where(is.numeric), signif, 3))


# Solution counts ---------------------------------------------------------

count_sol <- sol_corr %>% # create a data frame with solution count means
  group_by(solution, starch) %>%
  summarise(across(c(s, m, l, total), mean, na.rm = T))

# add a row containing the combined counts for the mixed treatment
count_sol_comb <- sol_corr %>%
  filter(solution == "mix") %>%
  group_by(starch) %>%
  summarise(across(c(s, m, l, total), mean, na.rm = T)) %>%
  ungroup() %>%
  summarise(across(c(s, m, l, total), sum, na.rm = T)) %>%
  mutate(starch = "both",
         solution = "mix") %>%
  select(solution, starch, s, m, l, total)

# Sample counts -----------------------------------------------------------

count_sample <- corr_counts %>% # create a data frame with treatment count means
  group_by(treatment, starch) %>%
  filter(treatment != "control") %>%
  summarise(across(c(s, m, l, total), mean, na.rm = T))

corr_comb %>%
  filter(treatment == "mix") %>%
  summarise(across(c(s, m, l, total), mean, na.rm = T))# %>%

count_sample_comb <- corr_comb %>% # create a data frame with treatment count means
  filter(treatment == "mix") %>%
  #group_by(starch) %>%
  summarise(across(c(s, m, l, total), mean, na.rm = T)) %>%
  ungroup() %>%
  #summarise(across(c(s, m, l, total), sum, na.rm = T)) %>%
  mutate(starch = "both",
         treatment = "mix") %>%
  select(treatment, starch, s, m, l, total)


count_sample_comb_sd <- corr_comb %>%
  filter(treatment == "mix") %>%
  group_by(treatment) %>%
  summarise(across(c(s, m, l, total), sd, na.rm = T)) %>%
  ungroup() #%>%
  #select(s, m, l, total) %>%
  #signif(digits = 3)

count_sample_sd <- corr_counts %>% # create a data frame with treatment count SD
  group_by(treatment, starch) %>%
  filter(treatment != "control") %>%
  summarise(across(c(s, m, l, total), sd, na.rm = T)) %>%
  ungroup() %>%
  add_row(count_sample_comb_sd, .after = 2) %>%
  select(s, m, l, total) %>%
  signif(digits = 3)

# Proportional counts -----------------------------------------------------

### for combined mix counts ###
# calculate proportion of starches...
prop_comb <- count_sample_comb %>%
  mutate(count_sample_comb[,3:6] / count_sol_comb[,3:6])
### end for combined mix counts ###

prop <- count_sample %>%
  ungroup() %>%
  mutate(count_sample[,3:6] / count_sol[,3:6]) # calculate proportion of starches
