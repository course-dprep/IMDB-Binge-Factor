
# Regression Model 1: Using total_years
library(dplyr)

# Load the cleaned dataset
cleaned_data <- read_csv("gen/output/cleaned_data.csv")


# Log transform numVotes (control variable)
cleaned_data <- cleaned_data %>%
  mutate(log_numVotes = log(numVotes + 1))  # Add 1 to avoid log(0)

# Log transform averageRating (dependant variable)
cleaned_data <- cleaned_data %>%
  mutate(log_averageRating = log(averageRating + 1))  # Add 1 to avoid log(0)


# Run regression
model1 <- lm(log_averageRating ~ total_years + log_numVotes, data = cleaned_data)


# Summary of the model
summary(model1)

# Save the model summary to a text file
capture.output(summary(model1), file = "gen/output/regression_model_1_summary.txt")





