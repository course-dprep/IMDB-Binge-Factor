

# Directory definitions
SRC = src
DATA_PREP =	$(SRC)/data_preparation
ANALYSIS =	$(SRC)/analysis
PAPER =	$(SRC)/paper

# sequence
all: data_preparation analysis paper

# Run the makefile in src/data_preparation
data_preparation:
	@$(MAKE) -C	$(DATA_PREP)

# Run the makefile in src/analysis 
analysis: data_preparation
	@$(MAKE) -C	$(ANALYSIS)

# Run the makefile in src/paper 
paper: analysis
	@$(MAKE) -C	$(PAPER)

.PHONY: all data_preparation analysis paper clean

# Clean all 
clean:
	@$(MAKE) -C	$(DATA_PREP) clean
	@$(MAKE) -C	$(ANALYSIS) clean
	@$(MAKE) -C	$(PAPER) clean




