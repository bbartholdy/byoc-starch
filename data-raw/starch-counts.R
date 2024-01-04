## code to prepare `starch-counts` dataset goes here

library(here)
library(dplyr)
devtools::load_all()

# Upload data -------------------------------------------------------------

# starch counts in samples
raw_counts <- readr::read_csv(here("analysis/data/raw_data/starch_counts.csv"))

# starch counts in solutions
sol_counts <- readr::read_csv(here("analysis/data/raw_data/solution_counts.csv"))


# Outlier detection and removal -------------------------------------------

# raw_counts %>%
#   filter(treatment != "control") %>%
#   ggplot() +
#   geom_boxplot(aes(x = starch, y = total, fill = starch))

# Only lower outliers were considered, as this would suggest that there may have
# been a problem with the sample and incorporation of starches. Given that all
# samples were treated equally, there is no reason to consider upper outliers
# problematic.


# Solution counts ---------------------------------------------------------

sol_corr <- sol_counts %>%
  mutate(across(c(s, m, l, total), extrap_count, portion_slide, vol_slide, days = 16))

# Apply correction --------------------------------------------------------

corr_counts <- raw_counts %>%
  #filter(treatment != "control") %>%
  mutate(across(c(s, m, l, total), correct_count, portion_slide, vol)) %>%
  select(!c(vol, portion_slide)) %>%
  filter(sample != "st2C6")


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


usethis::use_data(corr_comb, overwrite = TRUE)
usethis::use_data(corr_counts, overwrite = TRUE)
usethis::use_data(sol_corr, overwrite = TRUE)
