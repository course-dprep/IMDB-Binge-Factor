########################
########################
#ENGINEER NEW VARIABLES#
########################
########################

# --- Loading Libraries and Dataset --- #
library(dplyr)
library(tidyverse)

merged_data <- read_csv('../../gen/temp/merged_data.csv')
title_episode_filtered <- read_csv("../../gen/temp/title_episode_filtered.csv")

# --- Create New Variables --- #

# total_years and  episode_count
engineered_data_01 <- merged_data %>%
  mutate(
    endYear = as.numeric(endYear),
    startYear = as.numeric(startYear),
    total_years = endYear - startYear
  )

# Calculate the total number of episodes for each series
episode_count <- title_episode_filtered %>%
  group_by(parentTconst) %>%
  summarise(episode_count = n(), .groups = 'drop')  # Count the number of episodes per series

# Merge the episode count back into the engineered_data
engineered_data <- engineered_data_01 %>%
  left_join(episode_count, by = c("tconst" = "parentTconst"))

# --- Save Data --- #
write.csv(engineered_data, file = "../../gen/temp/engineered_data.csv", row.names = FALSE)

