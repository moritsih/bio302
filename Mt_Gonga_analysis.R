
# importing data
library(readxl)
library(tidyverse)
library(ggplot2)
biomass2015 <- read_excel("biomass2015.xls")
View(biomass2015)


# excluding irrelevant columns
biomass_clean <- biomass2015 %>%
  
  #selecting only relevant columns
  select(plot, production) %>%
  
  #excluding NA values
  filter(!is.na(production)) %>%
  
  #grouping by plot
  group_by(plot) %>%
  
  #getting sum by plot
  summarise(biomass_sum = sum(production))

View(biomass_clean)



biomass_barplot <- ggplot(biomass_clean,
                          aes(x = plot, 
                              y = biomass_sum)) + geom_bar(stat = "identity")

print(biomass_barplot)
