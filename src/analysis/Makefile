SHELL := /usr/bin/env bash

# Directory definitions
ROOT_DIR = ../..
DATA = $(ROOT_DIR)/data
TEMP = $(ROOT_DIR)/gen/temp
OUTPUT = $(ROOT_DIR)/gen/output
SRC = $(ROOT_DIR)/src
ANALYSIS = $(SRC)/analysis

# Scripts
REGRESSION_SCRIPT = $(ANALYSIS)/regression_model.R

# All output targets
all: $(OUTPUT)/regression_model_summary.html 


# Run Regression Model 2
$(OUTPUT)/regression_model_summary.html: $(REGRESSION_SCRIPT) $(OUTPUT)/cleaned_data.csv
	R -e "dir.create('$(OUTPUT)')"
	Rscript --vanilla "$(REGRESSION_SCRIPT)"


.PHONY: all clean

# Clean 
clean:
	Rscript -e "unlink('$(OUTPUT)/*.*', recursive=F)"

