library(tidyverse)

corr_counts <- readr::read_csv(here("analysis/data/derived_data/", "corr_counts.csv"))
corr_comb <- readr::read_csv(here("analysis/data/derived_data/", "corr_comb.csv"))
sol_corr <- readr::read_csv(here("analysis/data/derived_data/", "sol_corr.csv"))

# group by starch category
# the mix treatment/solution is separated into starch types
sol_sep <- sol_corr %>%
  group_by(solution, starch) %>%
  summarise(across(c(s, m, l, total), mean))

samp_sep <- corr_counts %>%
  group_by(treatment, starch) %>%
  filter(treatment != "control") %>%
  summarise(across(c(s, m, l, total), mean, na.rm = T))

# transpose data frames to create pie charts
# solution count data
ratio_sol_sep <- sol_sep %>%
  filter(solution != "mix") %>% # removed mixed treatment
  select(!total) %>%
  t %>%
  as.data.frame %>%
  rownames_to_column("size") # create size variable
colnames(ratio_sol_sep)[2:3] <- c("potato", "wheat")
ratio_sol_sep <- ratio_sol_sep[-c(1:2),]
ratio_sol_sep <- ratio_sol_sep %>%
  mutate(across(c(potato, wheat), as.character)) %>%
  mutate(across(c(potato, wheat), as.numeric)) %>%
  mutate(wheat = wheat / sum(wheat)) %>%
  mutate(label_wheat = scales::percent(wheat)) %>%
  mutate(potato = potato/ sum(potato)) %>%
  mutate(label_potato = scales::percent(potato))

# sample count data
ratio_samp_sep <- samp_sep %>%
  filter(treatment != "mix") %>% # removed mixed treatment
  select(!total) %>%
  t %>%
  as.data.frame %>%
  rownames_to_column("size") # create size variable
colnames(ratio_samp_sep)[2:3] <- c("potato", "wheat")
ratio_samp_sep <- ratio_samp_sep[-c(1:2),]
ratio_samp_sep <- ratio_samp_sep %>%
  mutate(across(c(potato, wheat), as.character)) %>%
  mutate(across(c(potato, wheat), as.numeric)) %>%
  mutate(wheat = wheat / sum(wheat)) %>%
  mutate(label_wheat = scales::percent(wheat)) %>%
  mutate(potato = potato/ sum(potato)) %>%
  mutate(label_potato = scales::percent(potato))

ratio_sep <- rbind(ratio_sol_sep, ratio_samp_sep)
ratio_sep$type <- c(rep("solution", 3), rep("sample", 3))
#ratio_sep$ymax_wheat <- cumsum(ratio_sep$wheat)
#ratio_sep$ymin <- c(0, head(ratio_sep$ymax_wheat, n = -1))


# Pie charts --------------------------------------------------------------

# size ratios as pie charts
# pie chart for size ratios in wheat solution
pl_wheat1 <- ratio_sep %>%
  select(!contains("potato")) %>%
  ggplot(aes(x = type, y = wheat, fill = size)) +
  #geom_rect(xmin = 2, xmax = 3, ymin = ratio_sep$ymin, ymax = ratio_sep$ymax_wheat) +
  geom_bar(stat = "identity", width = 1, colour = "white") +
  coord_polar(theta = "y") +
  theme_void() +
  #geom_text(aes(x = 2, label = label_wheat)) +
  scale_fill_viridis_d(name = "Size", labels = c("Large", "Medium", "Small"))

pl_potato1 <- ratio_sep %>%
  select(!contains("wheat")) %>%
  ggplot(aes(x = type, y = potato, fill = size)) +
  #geom_rect(xmin = 2, xmax = 3, ymin = ratio_sep$ymin, ymax = ratio_sep$ymax_wheat) +
  geom_bar(stat = "identity", width = 1, colour = "white") +
  coord_polar(theta = "y") +
  theme_void() +
  #geom_text(aes(x = 2, label = label_wheat)) +
  scale_fill_viridis_d(name = "Size", labels = c("Large", "Medium", "Small"))

# transpose solution data frame
ratio_sol_mix <- sol_sep %>%
  filter(solution == "mix") %>%
  select(!total) %>%
  t %>%
  as.data.frame() %>%
  slice(-c(1, 2)) %>%
  rename(potato = V1, wheat = V2) %>%
  rownames_to_column(var = "size") %>%
  mutate(across(c(potato, wheat), as.character)) %>%
  mutate(across(c(potato, wheat), as.numeric)) %>%
  mutate(wheat = wheat / sum(wheat)) %>%
  mutate(label_wheat = scales::percent(wheat)) %>%
  mutate(potato = potato/ sum(potato, na.rm = T)) %>%
  mutate(label_potato = scales::percent(potato))

# transpose sample data frame
ratio_samp_mix <- samp_sep %>%
  filter(treatment == "mix") %>%
  select(!total) %>%
  t %>%
  as.data.frame() %>%
  slice(-c(1, 2)) %>%
  rename(potato = V1, wheat = V2) %>%
  rownames_to_column(var = "size") %>%
  mutate(across(c(potato, wheat), as.character)) %>%
  mutate(across(c(potato, wheat), as.numeric)) %>%
  mutate(wheat = wheat / sum(wheat)) %>%
  mutate(label_wheat = scales::percent(wheat)) %>%
  mutate(potato = potato/ sum(potato, na.rm = T)) %>%
  mutate(label_potato = scales::percent(potato))

# combine the mixed-treatment data frames
ratio_mix <- rbind(ratio_sol_mix, ratio_samp_mix)
ratio_mix$type <- c(rep("solution", 3), rep("sample", 3))

# create data frame containing the difference between solution and sample
# single starch treatment
ratio_diff_sep <- ratio_samp_sep[,2:3] - ratio_sol_sep[,2:3]
ratio_diff_sep <- data.frame(size = c("s", "m", "l"), ratio_diff_sep)
diff_sep <- ratio_diff_sep %>%
  mutate(across(c(potato, wheat), function(x) signif(x * 100, 3)))
# mixed starch treatment
ratio_diff_mix <- ratio_samp_mix[,2:3] - ratio_sol_mix[,2:3]
ratio_diff_mix <- data.frame(size = c("s", "m", "l"), ratio_diff_mix)
diff_mix <- ratio_diff_mix %>%
  mutate(across(c(potato, wheat), function(x) signif(x * 100, 3)))

# size ratios as pie charts
# pie chart for size ratios in wheat solution
pl_wheat2 <- ratio_mix %>%
  select(!contains("potato")) %>%
  ggplot(aes(x = type, y = wheat, fill = size)) +
  #geom_rect(xmin = 2, xmax = 3, ymin = ratio_sep$ymin, ymax = ratio_sep$ymax_wheat) +
  geom_bar(stat = "identity", width = 1, colour = "white") +
  coord_polar(theta = "y") +
  theme_void() +
  #geom_text(aes(x = 2, label = label_wheat)) +
  scale_fill_viridis_d(begin = 0.7,
                       name = "Size",
                       labels = c("Large", "Medium", "Small"))
  #scale_fill_manual(values = viridisLite::viridis(3, begin = 0.7),
  #                  name = "Size", labels = c("Large", "Medium", "Small"))

pl_potato2 <- ratio_mix %>%
  mutate(potato = if_else(is.na(potato), 0, potato)) %>% # fix colour issue
  select(!contains("wheat")) %>%
  #filter(size != "s") %>% # this caused m to have a different colour that pl_wheat2
  ggplot(aes(x = type, y = potato, fill = size)) +
  geom_bar(stat = "identity", width = 1, colour = "white") +
  coord_polar(theta = "y") +
  theme_void() +
  #geom_text(aes(x = 2, label = label_wheat)) +
  scale_fill_viridis_d(begin = 0.7,
                       name = "Size",
                       labels = c("Large", "Medium", "Small"))
  #scale_fill_manual(values = viridisLite::viridis(3, begin = 0.7)[c(1,2)],
  #                  name = "Size", labels = c("Large", "Medium", "Small"))

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
  labs(x = "Weight (mg)",
       y = "Total Starch Count (z-score)") +
  theme_bw() +
  scale_colour_viridis_d()


# plot of correlation between weight and starches per mg calculus
pl_cor2 <- starch_per_mg %>%
  filter(treatment != "control") %>%
  ggplot(aes(weight, std_starch_per, col = treatment, shape = treatment)) +
    geom_point(size = 2) +
    labs(x = "Weight (mg)",
       y = "Starch count per mg of calculus (Z-score)") +
    theme_bw() +
    scale_colour_viridis_d()
