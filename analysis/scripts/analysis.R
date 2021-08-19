# Analysis script

library(here)
library(tidyverse)
library(broom)

corr_counts <- readr::read_csv(here("analysis/data/derived_data/corr_counts.csv"))
corr_comb <- readr::read_csv(here("analysis/data/derived_data/corr_comb.csv"))
sol_corr <- readr::read_csv(here("analysis/data/derived_data/sol_corr.csv"))

# ANOVA -------------------------------------------------------------------

anova_treat <- corr_comb %>%
  group_by(treatment) %>%
  do(tidy(aov(weight ~ treatment, data = corr_comb)))
treat_df <- c(anova_treat$df[1], anova_treat$df[2])
treat_f.stat <- signif(anova_treat$statistic[1], 3)
treat_p <- signif(anova_treat$p.value[1], 3)


# Chi-squared --------------------------------------------------------------

# Chi-squared test on size ratios
# Expected: solution ratios
# Observed: sample ratios

# Pearson correlation -----------------------------------------------------

# Standardise counts using Z-score
z_count <- corr_comb %>%
  filter(treatment != "control") %>%
  group_by(treatment) %>%
  mutate(std_total = (total - mean(total, na.rm = T)) / sd(total, na.rm = T)) %>%
  mutate(log_total = log(total))

# Pearson correlation
count_cor <- cor.test(z_count$weight, z_count$std_total,
                      use = "pairwise.complete", conf.level = 0.9)

# Calculate number of starches per mg calculus

starch_per_mg <- corr_comb %>%
  mutate(starch_per = total / weight) %>%
  group_by(treatment) %>%
  mutate(std_starch_per = (starch_per - mean(starch_per, na.rm = T)) / sd(starch_per, na.rm = T)) %>%
  ungroup()

starch_cor <- cor.test(starch_per_mg$weight, starch_per_mg$std_starch_per,
                       use = "pairwise.complete", conf.level = 0.9)
