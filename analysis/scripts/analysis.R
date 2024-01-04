# R Script for correcting counts according to volume and proportion of slide counted

# Dependencies ------------------------------------------------------------

library(here)
library(dplyr)
library(broom)
library(tidyr)
library(ggplot2)

# Upload data -------------------------------------------------------------

# starch counts in samples
#raw_counts <- readr::read_csv("../data/raw_data/starch_counts.csv")

# starch counts in solutions
#sol_counts <- readr::read_csv("../data/raw_data/solution_counts.csv")


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
#readr::write_csv(sol_corr, "analysis/data/derived_data/sol_corr.csv")

# combining potato and wheat counts from mixed treatment solution

sol_long <- sol_corr %>%
  group_by(solution, starch) %>%
  summarise(across(c(s,m,l, total), mean, na.rm = T)) %>%
  pivot_longer(cols = c(s,m,l, total), values_to = "count", names_to = "size") %>%
  rename(treatment = solution) # rename to be consistent with sample counts

sol_comb <- sol_corr %>%
  filter(solution != "mix") %>%
  group_by(solution, starch) %>%
  summarise(across(c("s","m","l","total"), mean)) %>%
  ungroup() %>%
  add_row(sol_corr[5:6,c("solution", "starch", "s","m","l","total")], ) %>%
  rename(treatment = solution) %>% # I should have done better naming the raw data...
  mutate(sample = "solution")

sol_comb_long <- sol_corr %>%
  group_by(solution, starch) %>%
  summarise(across(c(s,m,l, total), mean, na.rm = T)) %>%
  pivot_longer(cols = c(s,m,l, total), values_to = "count", names_to = "size") %>%
  filter(size != "total") %>%
  group_by(solution, starch) %>%
  mutate(percent = count / sum(count, na.rm = T) * 100) %>%
  rename(treatment = solution) # rename to be consistent with sample counts


# Apply correction --------------------------------------------------------

corr_counts <- raw_counts %>%
  #filter(treatment != "control") %>%
  mutate(across(c(s, m, l, total), correct_count, portion_slide, vol)) %>%
  select(!c(vol, portion_slide)) %>%
  filter(sample != "st2C6")
#readr::write_csv(corr_counts, "analysis/data/derived_data/corr_counts.csv")

corr_counts_long <- corr_counts %>%
  #filter(treatment != "control") %>%
  pivot_longer(cols = c(s,m,l, total), values_to = "count", names_to = "size")

# combining potato and wheat counts from mixed treatment samples

# merge Row C rows with the sum of counts
corr_comb <- corr_counts %>%
  group_by(sample, plate, row, treatment, weight) %>%
  summarise(across(c(s,m,l,total), sum, na.rm = T))

# corr_comb <- corr_counts %>%
#   select(!starch) %>%
#   pivot_wider(names_sep = "", values_from = c(s, m, l, total),
#               values_fill = NA,
#               values_fn = function(x) sum(x, na.rm = T))
#readr::write_csv(corr_comb, "analysis/data/derived_data/corr_comb.csv")

corr_comb_long <- corr_counts_long %>%
  filter(treatment != "control") %>%
  group_by(treatment, starch, size) %>%
  summarise(count = mean(count, na.rm = T))

#corr_counts <- readr::read_csv(here("analysis/data/derived_data/corr_counts.csv"))
#corr_comb <- readr::read_csv(here("analysis/data/derived_data/corr_comb.csv"))
#sol_corr <- readr::read_csv(here("analysis/data/derived_data/sol_corr.csv"))

# ANOVA -------------------------------------------------------------------

anova_treat <- aov(weight ~ treatment, data = corr_comb) %>%
  tidy
treat_df <- c(anova_treat$df[1], anova_treat$df[2])
treat_f.stat <- signif(anova_treat$statistic[1], 3)
treat_p <- signif(anova_treat$p.value[1], 3)

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

# Standardise counts using Z-score
z_count <- corr_comb %>%
  filter(treatment != "control") %>%
  group_by(treatment) %>%
  mutate(std_total = (total - mean(total, na.rm = T)) / sd(total, na.rm = T))

# Pearson correlation
count_cor <- cor.test(z_count$weight, z_count$std_total,
                      use = "pairwise.complete", conf.level = 0.9)

