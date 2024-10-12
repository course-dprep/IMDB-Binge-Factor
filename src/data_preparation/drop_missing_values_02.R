##################
##################
#DATA PREPARATION#
##################
##################

# --- Loading Libraries and Loading Data --- #

library(dplyr)
library(tidyverse)
library(here)

# INPUT

title_basics <- read_delim(gzfile('../../data/title_basics.tsv.gz'), delim = "\t", na = "\\N")
title_episode <- read_delim(gzfile('../../data/title_episode.tsv.gz'), delim = '\t', na = "\\N")
title_ratings <- read_delim(gzfile('../../data/title_ratings.tsv.gz'), delim = '\t', na = "\\N")


# --- Dropping NAs --- #

# Filter only TV series as the RQ is limited only to TV series
# Motivation: Dropping rows with missing values in startYear, 
# and imputing for endYear with group median (grouping logic= 15 year rolling window)
# dropping missing seasonNumber, episodeNumber in title_episode
# no missing values in title_ratings

# 1: Filter only TV series and remove rows with missing startYear

title_basics_filtered <- title_basics %>%
  dplyr::filter(titleType == "tvSeries" & !is.na(startYear))

# 2. Impute missing endYear values using a rolling window of 15 years
# Adding a new column to group by 15-year intervals for median calculation

title_basics_filtered <- title_basics_filtered %>%
  mutate(
    startYear_group = (startYear %/% 15) * 15  # Grouping startYear into 15-year intervals
  ) %>%
  group_by(startYear_group) %>%
  mutate(
    endYear = ifelse(
      is.na(endYear),
      median(endYear, na.rm = TRUE),  # Impute missing endYear with the median for each group
      endYear
    )
  ) %>%
  ungroup() 

# Dropping missing values in title_episode
title_episode_filtered <- title_episode %>%
  dplyr::filter(!is.na(seasonNumber) & !is.na(episodeNumber))


# --- Save Data --- #
write.csv(title_basics_filtered, file = "../../gen/temp/title_basics_filtered.csv", row.names = FALSE)
write.csv(title_episode_filtered, file = "../../gen/temp/title_episode_filtered.csv", row.names = FALSE)
file.copy("../../data/title_ratings.tsv.gz", "../../gen/temp/title_ratings.tsv.gz",overwrite = TRUE)  # Copying the title_ratings file (as it has no missing values)



