# Regression Model
library(dplyr)
library(readr)
library(kableExtra)

# Load the cleaned dataset
cleaned_data <- read_csv("../../gen/output/cleaned_data.csv") 

# Log transform `episode_count`,`numVotes` and `averageRating`
cleaned_data_model_02 <- cleaned_data %>%
  mutate(
    log_episode_count = log(episode_count + 1),  
    log_averageRating = log(averageRating + 1),
    log_numVotes = log(numVotes + 1)
  )

# Run regression
model <- lm(log_averageRating ~ + total_years + log_episode_count + log_numVotes , data = cleaned_data_model_02)

# Summary of the model
summary_model <- summary(model)
print(summary_model)

# Save the model as an RDS file
saveRDS(model,"../../gen/output/model.rds")

# Generate HTML summary 
html_model <- paste(
  "<html><body>",
  "<h2>Regression Model Summary</h2>",
  "<pre>",
  paste(capture.output(summary_model$coefficients), collapse = "\n"),
  "</pre>",
  "</body></html>",
  sep = "\n"
)

# Save the HTML to a file
writeLines(html_model, "../../gen/output/regression_model_summary.html")

# save the output as a text file to reference in the rmarkdown 
model_summary_text <- capture.output(summary(model))

writeLines(model_summary_text, con = "../../gen/output/model_summary.txt")








