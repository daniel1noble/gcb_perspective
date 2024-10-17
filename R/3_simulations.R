################################################################
# Title: Analysis of thermal performance curves for metabolism between plants and animals
# Date: `r Sys.Date()`
# Authors:  Daniel Noble and Dani Way
# Description: Getting some simulations together.
################################################################

# Load libraries
	pacman::p_load(tidyverse, ggplot2, ggpubr, gridExtra, grid, ggplotify, cowplot, ggridges, ggthemes, scales, ggridges, ggforce, latex2exp, viridis)

# Set seed
	set.seed(123)

# Parameters
        n =  30                         # Number of individuals
   ind_sd = 0.5						    # Among individual variation
      opt =  35  						# Thermal optima of performance curve
  breadth =   9 + rnorm(n, 0, ind_sd)   # Thermal breadth of performance curve
     rate = -15 + rnorm(n, 0, ind_sd)   # Rate of performance increase with temperature
     temp = seq(10, 45, 0.1)            # Temperature range
amplitude =  9                          # Maximum performance of performance curve

# Simulate data. Note that we can make max performance a function of the breadth, i.e., a trad-off between breadth and max performance, by creating an amplitude parameter that multiplies the asymmetric performance curve to adjust p-max 

	per <- list()
	for(i in 1:length(breadth)){
	   amplitude_ind <- amplitude/breadth[[i]]
			     perf <- amplitude_ind*exp(-(temp-opt)^2/(amplitude_ind*breadth[[i]]^2))*pnorm(rate[[i]]*(temp-opt)/breadth[[i]])
			per[[i]] <- data.frame(temp = temp, perf = perf)
	}

# Create a data frame for plotting.
	
	    sim_data <- plyr::ldply(per)
	sim_data$ind <- as.character(rep(1:n, each = length(temp)))

# Plot the simulated performance curves of the 30 individuals 
	ggplot(sim_data, aes(x = temp, y = perf)) + 
			geom_line(aes(color = ind)) + 
			theme_classic() + 
			labs(y = "Physiological Rate", x = TeX("Temperature ($^\\circ$C)"), color = "Individual", title = "Thermal Breadth & Rate")
