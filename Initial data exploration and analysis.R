# To read tsv files, you need to load the readr package
install.packages('readr')
library(readr)

# Load other packages that you will need to analyse the data
install.packages('tidyverse')
install.packages('dplyr')
library(tidyverse)
library(dplyr)

# Create vectors containing the urls where the data is store, read them and load the datasets
# Create the vector
urls = c("https://datasets.imdbws.com/title.basics.tsv.gz", "https://datasets.imdbws.com/title.episode.tsv.gz", "https://datasets.imdbws.com/title.ratings.tsv.gz")

# Use lapply to read in all files:
datasets <- lapply(urls, read_delim, delim='\t', na = '\\N')

# Access individual datasets
title_basics <- datasets[[1]]
title_episode <- datasets[[2]]
title_ratings <- datasets[[3]]

# To view the datasets, use the code View()

View(title_basics)

View(title_episode)

View(title_ratings)

# Get a quick overview of the data by using the code summary()

summary(title_basics)

summary(title_episode)

summary(title_ratings)

# Get specific summary statistics
#Summary statistics of title_episode

title_episode_summary <- title_episode %>%
  summarise(num_rows=n(),
            num_cols=ncol(.),
            missing_values_tconst=sum(is.na(tconst)),
            missing_values_parentTconst=sum(is.na(parentTconst)),
            missing_values_seasonNumber=sum(is.na(seasonNumber)),
            missing_values_episodeNumber=sum(is.na(episodeNumber)) 
  )%>%
  print()

#Summary statistics of title_ratings

title_ratings_summary <- title_ratings %>%
  summarise(num_rows=n(),
            num_cols=ncol(.),
            missing_values_tconst = sum(is.na(tconst)),
            missing_values_averageRating = sum(is.na(averageRating)),
            missing_values_numVotes = sum(is.na(numVotes))
  ) %>%
  print()

#Summary statistics of title_basics

title_basics_summary <- title_basics %>%
  summarise(num_rows=n(),
            num_cols=ncol(.),
            missing_values_tconst = sum(is.na(tconst)),
            missing_values_titleType = sum(is.na(titleType)),
            missing_values_startYear= sum(is.na(startYear)),
            missing_values_endYear= sum(is.na(endYear))
  )%>%
  print()

# filtering TV series alone using titleType(tvEpisode) from title_basics

tv_series <- title_basics %>%
  filter(titleType == "tvEpisode")

# Merged with ratings using tconst

tv_series_ratings <- tv_series %>%
  inner_join(title_ratings, by = "tconst")
print(nrow(tv_series_ratings))

# Merging with title_episode using tconst to add parentTconst to tv_series_ratings

tv_series_ratings_with_parent <- tv_series_ratings %>%
  left_join(title_episode %>% 
              select(tconst,parentTconst), by= "tconst")
head(tv_series_ratings_with_parent)
View(tv_series_ratings_with_parent)

# With the help of the package ggplot2 we can make plots (To only show the output and hide the code, we use echo = False)
# Plotting
library(ggplot2)

ggplot(tv_series_ratings_with_parent, aes(y = averageRating)) +
  geom_boxplot(fill = "blue", color = "black", outlier.color = "red") +
  labs(title = "Boxplot of TV Series Average Ratings", y = "Average Rating") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))


ggplot(tv_series_ratings_with_parent, aes(x = averageRating))+ geom_bar() +
  labs(title = "Distribution of Average Ratings for TV Series", x = "Average Rating", y = "Count") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))

# Model free evidence to support our research question  
# Plot for Series Length vs Average Rating
# Compute Series Length
# Calculate the length of each TV series based on the number of episodes.
# Compute the number of episodes for each series
total_episodes <- title_episode %>%
  group_by(parentTconst) %>%
  summarize(total_episodes = n(), .groups = 'drop')  # Count episodes

# Compute and sort the number of episodes for each series
total_episodes_sorted <- title_episode %>%
  group_by(parentTconst) %>%
  summarize(total_episodes = n(), .groups = 'drop') %>%
  arrange(desc(total_episodes))

# Print the sorted result
View(total_episodes_sorted)

# Select and rename the columns from tv_series_ratings_with_parent
ratings_to_merge <- tv_series_ratings_with_parent[, c("parentTconst", "averageRating")]
names(ratings_to_merge)[names(ratings_to_merge) == "averageRating"] <- "averageRating_series_wise"

# Merge the two data frames
total_episodes_sorted <- merge(total_episodes_sorted, 
                               ratings_to_merge, 
                               by = "parentTconst", 
                               all.x = TRUE)

# scatter plot 
library(ggplot2)

### title: "Plotting TV Series Length (total episodes) vs Average Ratings"

ggplot(total_episodes_sorted, aes(x = total_episodes, y = averageRating_series_wise)) +
  geom_jitter(na.rm = TRUE, alpha = 0.3, size = 1, width = 0.1) +  # Add jitter
  labs(
    title = "Relationship between Total Episodes and Average Customer Ratings",
    x = "Total number of Episodes",
    y = "Average customer Rating"
  ) +
  theme_minimal()


### "Plotting TV Series Length (total years run) vs Average Ratings"

# Convert endYear to character if it is numeric
tv_series_ratings_with_parent <- tv_series_ratings_with_parent %>%
  mutate(
    endYear = as.character(endYear),  
    endYear = na_if(endYear, '\\N'),  
    endYear = as.numeric(endYear),    
    startYear = as.numeric(startYear),
    length = ifelse(is.na(endYear), 2024 - startYear, endYear - startYear) # Calculate length
  )

ggplot(tv_series_ratings_with_parent, aes(x = length, y = averageRating)) +
  geom_jitter(alpha = 0.2, size = 0.7, width = 0.1, height = 0.1) +  # Further reduce point size and opacity
  geom_smooth(method = "lm", color = "red", se = FALSE) +  # Add a linear trend line
  labs(
    x = "Length of TV Series (years)",
    y = "Average Rating",
    title = "Length of TV Series vs. Average Rating"
  ) +
  theme_minimal(base_size = 15) +  # Increase text size for better readability
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),  # Center the title and make it bold
    axis.text.x = element_text(angle = 45, hjust = 1)  # Rotate x-axis labels
  )


#---Now lets count the amount of NA's per dataset---#

#Amount of NA's of title_basics
Sum_NA_title_basics <-sum(is.na(title_basics))

#Amount of NA's of title_episode
Sum_NA_title_episode <- sum(is.na(title_episode))

#Amount of NA's of title_ratings
Sum_NA_title_ratings <- sum(is.na(title_ratings))





#----Now lets try and delete the NA's in the datasets---#
library(tidyr)
#remove Na's from title_basics
title_basics_no_NAs <- drop_na(title_basics)
View(title_basics_no_NAs)
summary(title_basics_no_NAs)



#remove Na's from title_episode
title_episode_no_NAs <- drop_na(title_episode)
View(title_episode_no_NAs)
summary(title_episode_no_NAs) 



#---Merging the three datasets---#

merged_data <- title_basics_no_NAs %>%
  inner_join(title_ratings_no_NAs, by = "tconst") %>%
  inner_join(title_episode_no_NAs, by = c("tconst" = "parentTconst"))



#---Create new variable years of tvseries as that is our X variable---#

#Nieuwe column YearEnd-YearStart to look how long the series are..
merged_data <- merged_data %>%
  mutate(series_lengths = endYear-startYear)


#---Removing outliers---#

#we are removing the outliers for series_length, averageRatings, numVotes

remove_outliers_iqr <- function(column) {
  Q1 <- quantile(column, 0.25)
  Q3 <- quantile(column, 0.75)
  IQR_value <- IQR(column)
  lower_bound <- Q1 - 1.5 * IQR_value
  upper_bound <- Q3 + 1.5 * IQR_value
  column >= lower_bound & column <= upper_bound
}

# Columns to check for outliers
columns_to_check <- c("series_lengths", "averageRating", "numVotes")

# Apply outlier removal and combine results
cleaned_data <- merged_data[
  rowSums(sapply(merged_data[columns_to_check], remove_outliers_iqr)) == length(columns_to_check), 
]

# View cleaned data
View(cleaned_data)
