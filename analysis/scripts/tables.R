# Script for tables

library(here)
library(tidyverse)

#corr_counts <- readr::read_csv(here("analysis/data/derived_data/", "corr_counts.csv"))
#corr_comb <- readr::read_csv(here("analysis/data/derived_data/", "corr_comb.csv"))
#sol_corr <- readr::read_csv(here("analysis/data/derived_data/", "sol_corr.csv"))

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

sol_out <- sol_comb_long %>%
  pivot_wider(id_cols = c(treatment, starch), names_from = size, values_from = count) %>%
  mutate(total = sum(s,m,l, na.rm = T))

sol_comb_row <- sol_out %>%
  group_by(treatment) %>%
  filter(treatment == "mix") %>%
  summarise(starch = "both",
            across(where(is.numeric), sum, na.rm = T))

sol_comb_out <- sol_out %>%
  ungroup() %>%
  add_row(sol_comb_row, .after = 2)

# Sample counts -----------------------------------------------------------

samp_comb_row <- corr_comb_long %>%
  pivot_wider(names_from = size, values_from = count) %>%
  group_by(treatment) %>%
  filter(treatment == "mix") %>%
  summarise(across(where(is.numeric), sum, na.rm = T)) %>%
  mutate(sample = "sample",
         starch = "both") %>%
  select(treatment, starch, s, m, l, total, sample)

samp_sd_row <- corr_counts_long %>%
  ungroup() %>%
  filter(treatment == "mix") %>%
  group_by(sample, size) %>%
  summarise(count = sum(count, na.rm = T)) %>%
  group_by(size) %>%
  summarise(sd = sd(count, na.rm = T)) %>%
  mutate(treatment = "mix",
         starch = "both") %>%
  pivot_wider(names_from = size, values_from = sd) # discrepancy from table


corr_sd_long <- corr_counts_long %>%
  filter(treatment != "control") %>%
  group_by(treatment, starch, size) %>%
  summarise(sd = sd(count, na.rm = T),
            count = mean(count, na.rm = T))


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


# Proportional counts -----------------------------------------------------

prop_samp <- corr_comb_long %>%
  filter(size != "total") %>%
  mutate(sample = "sample")

prop_sol <- sol_comb_long %>%
  select(!percent) %>%
  mutate(sample = "solution")

prop <- prop_sol %>%
  full_join(prop_samp) %>%
  pivot_wider(names_from = size, values_from = count) %>%
  group_by(sample, treatment, starch) %>%
  mutate(total = sum(s,m,l, na.rm = T)) %>%
  pivot_longer(cols = c(s,m,l,total), names_to = "size", values_to = "count") %>%
  pivot_wider(names_from = sample, values_from = count) %>%
  mutate(prop = sample / solution,
         perc = scales::percent(prop, accuracy = 0.01))

prop_comb_row <- prop %>%
  filter(treatment == "mix") %>%
  group_by(size) %>%
  summarise(treatment = "mix",
            starch = "both",
            solution = sum(solution, na.rm = T),
            sample = sum(sample, na.rm = T)) %>%
  mutate(prop = sample / solution) %>%
  select(!c(solution, sample)) %>%
  pivot_wider(names_from = size, values_from = prop)


perc_comb_row <- prop %>%
  filter(treatment == "mix") %>%
  group_by(size) %>%
  summarise(treatment = "mix",
            starch = "both",
            solution = sum(solution, na.rm = T),
            sample = sum(sample, na.rm = T)) %>%
  mutate(prop = sample / solution,
         perc = scales::percent(prop, accuracy = 0.01)) %>%
  select(!c(prop, solution, sample)) %>%
  pivot_wider(names_from = size, values_from = perc)
