# Install n2khab from https://inbo.github.io/n2khab/
# install.packages("n2khab", repos = c(inbo = "https://inbo.r-universe.dev",
#                                      CRAN = "https://cloud.r-project.org"))
# Install tidyverse to get ggplot for graph
# install.packages("tidyverse")

# Load packages
library(n2khab)
library(dplyr)
library(ggplot2)

####################

# Import functions from external source
source("functions_exercise.R")

# Import variable definition from configuration file
source("config_exercise.R")

####################

# Task 1

# Subset sample belonging to the first version
samples_v1 <- subset_by_scheme_water(version_number_val = version_1,
                                scheme_val = scheme_input,
                                hydr_class_val = hydr_class_input)

# Task 2

# Subset sample belonging to the second version
samples_v2 <- subset_by_scheme_water(version_number_val = version_2,
                                scheme_val = scheme_input,
                                hydr_class_val = hydr_class_input)

# Get unique grts_address values per stratum in the two required versions
unique_grts_v1 <- get_unique_locations(sample_subset = samples_v1)
unique_grts_v2 <- get_unique_locations(sample_subset = samples_v2)

# Order stratum by name in both sample versions
ordered_unique_grts_v1 <- arrange(unique_grts_v1, stratum)
ordered_unique_grts_v2 <- arrange(unique_grts_v2, stratum)

# Merge the two version datasets
ordered_unique_grts_merged = bind_rows(
    ordered_unique_grts_v1 %>% select(stratum = stratum, unique = unique) %>% mutate(version = version_1),
    ordered_unique_grts_v2 %>% select(stratum = stratum, unique = unique) %>% mutate(version = version_2) )

# Make graph to compare grts_address between the two versions
plot_grts_comparison <- ggplot(
    data = ordered_unique_grts_merged,
    mapping = aes(x = stratum, y = unique, color = version)
) +
    geom_point() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    labs(color = "Version", x = "Type", y = "Unique locations")

# Save plot
ggsave(plot = plot_grts_comparison, filename = "sample_location_comparison.pdf",
       width = 15, height = 10, units = "cm")
