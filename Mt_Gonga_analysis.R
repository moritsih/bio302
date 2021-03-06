
# importing data
library(readxl)
library(tidyverse)
# library(ggplot2)

#### Data import #####
biomass2015 <- 1:4 %>%
  map_dfr(~read_excel(path = "biomass2015.xls", sheet = .x))


'''
for (i in 2:4) {
  biomass2015 <- rbind(biomass2015, read_excel("biomass2015.xls", sheet = i))
}

# view(biomass2015)
'''

#### data cleanup ####

# excluding irrelevant columns
biomass_clean <- biomass2015 %>%
  
  #selecting only relevant columns
  select(c(site, plot, production)) %>%
  
  dplyr::mutate(site = factor(site,
                              levels = c("L", "M", "A", "H"))) %>%
  #excluding NA values
  filter(!is.na(production)) %>%
  
  #grouping by site AND plot
  group_by(site, plot) %>%
  
  #getting sum by plot
  summarise(Total_biomass = sum(production))



#View(biomass_clean)

#### plotting ####

biomass_boxplot <- ggplot(biomass_clean,
                          aes(x = site, 
                              y = Total_biomass)) + geom_boxplot()

print(biomass_boxplot)
