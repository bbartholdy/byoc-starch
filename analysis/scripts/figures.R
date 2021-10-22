library(tidyverse)
source(here("analysis/scripts/analysis.R"))
#corr_counts <- readr::read_csv(here("analysis/data/derived_data/", "corr_counts.csv"))
#corr_comb <- readr::read_csv(here("analysis/data/derived_data/", "corr_comb.csv"))
#sol_corr <- readr::read_csv(here("analysis/data/derived_data/", "sol_corr.csv"))


sol_comb_long_pie <- sol_comb_long %>%
  group_by(treatment, starch) %>%
  mutate(percent = count / sum(count, na.rm = T) * 100,
         type = "solution")

samp_comb_long_pie <- corr_comb_long %>%
  filter(size != "total") %>%
  group_by(treatment, starch) %>%
  mutate(percent = count / sum(count, na.rm = T) * 100,
         type = "sample")

pie_datf <- samp_comb_long_pie %>%
  full_join(sol_comb_long_pie)

pl_wheat1 <- pie_datf %>%
  filter(treatment == "wheat") %>%
  ggplot(aes(x = type, y = percent, fill = size)) +
    geom_bar(stat = "identity", width = 1, colour = "white") +
    coord_polar(theta = "y") +
    theme_void() +
    scale_fill_viridis_d(name = "Size",
                         labels = c("large", "medium", "small"),
                         end = 0.5)

pl_potato1 <- pie_datf %>%
  filter(treatment == "potato") %>%
  ggplot(aes(x = type, y = percent, fill = size)) +
    geom_bar(stat = "identity", width = 1, colour = "white") +
    coord_polar(theta = "y") +
    theme_void() +
    scale_fill_viridis_d(name = "Size",
                         labels = c("large", "medium", "small"),
                         end = 0.5)

pl_wheat2 <- pie_datf %>%
  filter(treatment == "mix",
         starch == "wheat") %>%
  ggplot(aes(x = type, y = percent, fill = size)) +
  geom_bar(stat = "identity", width = 1, colour = "white") +
  coord_polar(theta = "y") +
  theme_void() +
  scale_fill_viridis_d(name = "",
                       labels = c("large", "medium", "small"),
                       begin = 0.6)

pl_potato2 <- pie_datf %>%
  filter(treatment == "mix",
         starch == "potato") %>%
  ggplot(aes(x = type, y = percent, fill = size)) +
  geom_bar(stat = "identity", width = 1, colour = "white") +
  coord_polar(theta = "y") +
  theme_void() +
  scale_fill_viridis_d(name = "",
                       labels = c("large", "medium", "small"),
                       begin = 0.6) +
  theme(legend.position = "none")

(pl_wheat1 + pl_potato1) / (pl_wheat2 + pl_potato2) + plot_layout(guides = "collect") + plot_annotation(tag_levels = "A")


# Scatter plot ------------------------------------------------------------

# Standardise counts using Z-score
z_count <- corr_comb %>%
  filter(treatment != "control") %>%
  group_by(treatment) %>%
  mutate(std_total = (total - mean(total, na.rm = T)) / sd(total, na.rm = T))

# Pearson correlation
count_cor <- cor.test(z_count$weight, z_count$std_total,
                      use = "pairwise.complete", conf.level = 0.9)
cor_r <- signif(count_cor$estimate, 3)
cor_ci <- signif(count_cor$conf.int, 3)

# Convert r correlation result to text (MAY NEED TO GO BACK TO results.Rmd FILE)
direct_cor <- ifelse(cor_r < 0, "negative", "positive")
strength_cor <- if(cor_r >= 0.8){
  "very strong"
} else if(cor_r < 0.8 & cor_r >= 0.6){
  "strong"
} else if(cor_r < 0.6 & cor_r >= 0.4){
  "moderate"
} else if(cor_r < 0.4 & cor_r >= 0.2){
  "weak"
} else{
  "very weak"
}

# Plot of correlation between weight and count
pl_cor <- ggplot(z_count,
       aes(weight, std_total, col = treatment, shape = treatment)) +
  geom_point(size = 2) +
  theme_bw() +
  labs(x = "Weight (mg)",
       y = "Total starch count (z-score)",
       colour = "Treatment",
       shape = "Treatment") +
  scale_colour_viridis_d()
## Multi-plot figure test ##
pl_cor <- ggplot(z_count,
        aes(y = weight, x = std_total, col = treatment, shape = treatment)) +
  geom_point(size = 2) +
  theme_bw() +
  labs(y = "Weight (mg)",
       x = "Total starch count (z-score)") +
  scale_colour_viridis_d() +
  theme(axis.title.x = element_text(size = 10))
## End: Multi-plot figure test ##

# plot of correlation between weight and starches per mg calculus
pl_cor2 <- starch_per_mg %>%
  filter(treatment != "control") %>%
  ggplot(aes(weight, std_starch_per, col = treatment, shape = treatment)) +
    geom_point(size = 2) +
    theme_bw() +
    labs(x = "Weight (mg)",
       y = "Starch count per mg of calculus (z-score)",
       colour = "Treatment",
       shape = "Treatment") +
    scale_colour_viridis_d()

## Multi-plot figure test ##
pl_cor2 <- starch_per_mg %>%
  filter(treatment != "control") %>%
  ggplot(aes(y = weight, x = std_starch_per, col = treatment, shape = treatment)) +
  geom_point(size = 2) +
  theme_bw() +
  labs(y = "Weight (mg)",
       x = "Starch count per mg of calculus (z-score)") +
  scale_colour_viridis_d() +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.title.x = element_text(size = 10))
