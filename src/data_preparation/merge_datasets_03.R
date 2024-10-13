##################
##################
##MERGE DATASETS##
##################
##################

# --- Loading Libraries and Datasets --- #
library(dplyr)
library(readr)

title_basics_filtered <- read_csv("../../gen/temp/title_basics_filtered.csv")
title_episode_filtered <- read_csv("../../gen/temp/title_episode_filtered.csv")
title_ratings <- read_delim(gzfile("../../gen/temp/title_ratings.tsv.gz"), delim = "\t", na = "\\N")


# --- Merging Datasets --- #
# Merging datasets based on tconst (common identifier)
merged_data <- title_basics_filtered %>%
  inner_join(title_ratings, by = "tconst") %>%
  inner_join(title_episode_filtered, by = c("tconst" = "parentTconst"))


# --- Save Data --- #
write_csv(merged_data, file = "../../gen/temp/merged_data.csv", row.names = FALSE)

