################################################################
# Title: Analysis of thermal performance curves for metabolism between plants and animals
# Date: `r Sys.Date()`
# Authors:  Daniel Noble and Dani Way
################################################################

# Load libraries
	pacman::p_load(tidyverse, ggplot2, ggpubr, gridExtra, grid, ggplotify, cowplot, ggridges, ggthemes, scales, ggridges, ggforce)

# Load data
	plants <- read.csv("data/plants.csv")
	str(plants)

# Plotting data. Some notes. Why are some species only numbers? What are units of Respiration?
		plants %>%
			ggplot(aes(x = Temp, y = R)) +
			geom_point() + 
			geom_smooth(method = "loess", se = FALSE) + facet_wrap(~Species) +
			theme_classic() +
			theme(legend.position = "none") +
			labs(x = "Temperature (°C)", y = "Respiration (units?)")

# Lets just subset a select number of species to look at some performance curves a little more closely.
		set.seed(123)
		sample_plants <- sample(plants$Species, 10)
		
		plants %>%
			filter(Species %in% sample_plants) %>%
			ggplot(aes(x = Temp, y = R, color = Species)) +
			geom_point() + facet_wrap(~Species) +
			geom_smooth(method = "loess", se = FALSE) +
			theme_classic() +
			labs(x = "Temperature (°C)", y = "Respiration (units?)")
