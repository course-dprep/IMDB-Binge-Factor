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
	R -e "dir.create('$(OUTPUT)')
	Rscript -e "knitr::knit2html(input='$(PAPER)/data_exploration.Rmd', output='$(OUTPUT)/data_exploration.html')"


# 2. Generate Analysis & Conclusion Report
$(OUTPUT)/analysis_conclusion.html: $(PAPER)/analysis_conclusion.Rmd
	R -e "dir.create('$(OUTPUT)')
	Rscript -e "knitr::knit2html(input='$(PAPER)/analysis_conclusion.Rmd', output='$(OUTPUT)/analysis_conclusion.html')"



.PHONY: all clean

# Clean up generated HTML reports
clean:
	Rscript -e "unlink('$(OUTPUT)/*.html', recursive=F)"

