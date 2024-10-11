


# Directory definitions
ROOT_DIR = ../..
DATA = $(ROOT_DIR)/data
TEMP = $(ROOT_DIR)/gen/temp
OUTPUT = $(ROOT_DIR)/gen/output
SRC = $(ROOT_DIR)/src
PAPER = $(SRC)/paper

# Scripts
DOWNLOAD_SCRIPT = $(SRC)/data_preparation/download_data_01.R
DROP_SCRIPT = $(SRC)/data_preparation/drop_missing_values_02.R
MERGE_SCRIPT = $(SRC)/data_preparation/merge_datasets_03.R
ENGINEER_SCRIPT = $(SRC)/data_preparation/engineer_variables_04.R
CLEAN_SCRIPT = $(SRC)/data_preparation/cleaned_data_05.R


# All output targets
all: $(DATA)/title_basics.tsv.gz $(DATA)/title_episode.tsv.gz $(DATA)/title_ratings.tsv.gz \
     $(TEMP)/title_basics_filtered.csv $(TEMP)/title_episode_filtered.csv $(TEMP)/merged_data.csv \
     $(TEMP)/engineered_data.csv $(OUTPUT)/cleaned_data.csv 


# 1: Download Data
$(DATA)/title_basics.tsv.gz $(DATA)/title_episode.tsv.gz $(DATA)/title_ratings.tsv.gz: $(DOWNLOAD_SCRIPT)
	@mkdir -p $(DATA)
	Rscript --vanilla "$(DOWNLOAD_SCRIPT)"

# 2: Impute, Drop Missing Values, and Filter TV Series
$(TEMP)/title_basics_filtered.csv $(TEMP)/title_episode_filtered.csv: $(DROP_SCRIPT) $(DATA)/title_basics.tsv.gz $(DATA)/title_episode.tsv.gz $(DATA)/title_ratings.tsv.gz
	@mkdir -p $(TEMP)
	Rscript --vanilla "$(DROP_SCRIPT)"
	
# 3: Merge Datasets
$(TEMP)/merged_data.csv: $(MERGE_SCRIPT) $(TEMP)/title_basics_filtered.csv $(TEMP)/title_episode_filtered.csv
	@mkdir -p $(TEMP)
	Rscript --vanilla "$(MERGE_SCRIPT)"	

# 4: Engineer Variables
$(TEMP)/engineered_data.csv: $(ENGINEER_SCRIPT) $(TEMP)/merged_data.csv
	@mkdir -p $(TEMP)
	Rscript --vanilla "$(ENGINEER_SCRIPT)"
	
# 5: Clean the Data
$(OUTPUT)/cleaned_data.csv: $(CLEAN_SCRIPT) $(TEMP)/engineered_data.csv
	@mkdir -p $(OUTPUT)
	Rscript --vanilla "$(CLEAN_SCRIPT)"
	

.PHONY: all clean 

# Clean up intermediate files (only keep the final cleaned data)
clean:
	rm -f $(TEMP)/*.csv





