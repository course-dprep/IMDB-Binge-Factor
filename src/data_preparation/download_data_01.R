###################
###################
###DOWNLOAD DATA###
###################
###################

# INPUT
# --- Download Data --- #
# URLs to the IMDb datasets
urls <- c(
  "https://datasets.imdbws.com/title.basics.tsv.gz",
  "https://datasets.imdbws.com/title.episode.tsv.gz",
  "https://datasets.imdbws.com/title.ratings.tsv.gz"
)

# Paths to save the datasets in the data folder
output_files <- c(
  "../../data/title_basics.tsv.gz",
  "../../data/title_episode.tsv.gz",
  "../../data/title_ratings.tsv.gz"
)

# --- Save Data --- #
mapply(download.file, urls, output_files)
