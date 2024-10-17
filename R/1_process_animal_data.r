################################################################
# Data processing
# Author: Daniel Noble and Dani Way
# Date: 2020-06-01
# Description: This script loads the animal data and filters and processes it for the rest metabolic rate analysis
################################################################

# Load libraries
	pacman::p_load(tidyverse, ggplot2, ggpubr, gridExtra, grid, ggplotify, cowplot, ggridges, ggthemes, scales, ggridges, ggforce)

# Load data
	animals <- read.csv("data/animals_long.csv")    %>% 
			   filter(trait_category == "rest_MR" &
			   		  habitat == "t")

# Save the data
	write.csv(animals, "output/data/animals.csv")
