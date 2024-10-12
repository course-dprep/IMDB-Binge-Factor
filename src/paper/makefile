SHELL := /usr/bin/env bash

# Directory definitions
ROOT_DIR = ../..
SRC = $(ROOT_DIR)/src
OUTPUT = $(ROOT_DIR)/gen/output
PAPER = $(SRC)/paper

# Targets
all: $(OUTPUT)/data_exploration.html $(OUTPUT)/analysis_conclusion.html

# 1. Generate Data Exploration Report
$(OUTPUT)/data_exploration.html: $(PAPER)/data_exploration.Rmd
	Rscript -e "dir.create('$(OUTPUT)', showWarnings = FALSE)"
	Rscript -e "rmarkdown::render(input = '$(PAPER)/data_exploration.Rmd', output_file = '$(OUTPUT)/data_exploration.html')"

# 2. Generate Analysis & Conclusion Report
$(OUTPUT)/analysis_conclusion.html: $(PAPER)/analysis_conclusion.Rmd
	Rscript -e "dir.create('$(OUTPUT)', showWarnings = FALSE)"
	Rscript -e "rmarkdown::render(input = '$(PAPER)/analysis_conclusion.Rmd', output_file = '$(OUTPUT)/analysis_conclusion.html')"

.PHONY: all clean

# Clean up generated HTML reports
clean:
	Rscript -e "unlink('$(OUTPUT)/*.html', recursive=F)"


