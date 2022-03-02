
# load packages -----------------------------------------------------------

library(sf)
library(ggplot2)
library(tidyverse)
library(pointdexter)

# load chicago community data ---------------------------------------------

chicago_community <- st_read(
  'data/Boundaries - Community Areas (current)/geo_export_2099592d-f4d8-46cf-9881-dd554256e0fd.shp'
)
ggplot() + 
  geom_sf(data = chicago_community) + 
  ggtitle("Chicago Boundary Plot (Community)") + 
  coord_sf() +
  theme_minimal()


# gang nations ------------------------------------------------------------

# explore nations 2021
nations_2021 <- read_csv('data/gang_alliance/2021_Gang_Boundaries_and_nations.csv')
nations_2021 %>% 
  mutate(nation = factor(nation, levels = c('People','Folks','None'))) %>% 
  ggplot()+
  geom_bar(aes(x = nation,
               color = nation,
               fill = nation),
           alpha = 0.4)+
  ggtitle('Alliance of Chicago Gangs -- 2021') + 
  theme_minimal()

# read in all gang nations
nations <- read_csv('data/gang_alliance/Gang_nations.csv') %>% 
  mutate(nation = factor(nation, levels = c('People','Folks','None')))


# map gang territories to chicago communities -----------------------------

#################################################################################
## Use the 2021 data as example
## Steps of mapping gnag territories to community:
## 1. Find the latitude and longitude of the centroid of each gang territory
## 2. Use `GetPolygonBoundaries` from the `pointdexter` package to find the 
##    corresponding community base on the location of the centroid
#################################################################################


# community boundaries
data("community_areas_spdf")
# create list of coordinate pair matrices for each community area ----
community.area.boundaries <-
  GetPolygonBoundaries(my.polygon = community_areas_spdf
                       , labels = community_areas_spdf$community)

# turn off the s2 processing
sf::sf_use_s2(FALSE)

gang_boundary_2021 <- 
  st_read(
    "data/2021_Gang_Boundaries/2021_Gang_Boundaries.shp") %>% 
  left_join(nations %>% 
              dplyr::select(GANG_NAME, nation) %>% 
              mutate(nation = factor(nation, levels = c('People','Folks','None'))), 
            by = 'GANG_NAME') %>% 
  st_cast("POLYGON") %>% 
  st_transform(4326) %>% 
  mutate(
    # find the centroid of each gang territory
    centroid = st_centroid(.)$geometry,
    # get the latitude and longitude for centroids
    centroid_lng = st_coordinates(centroid)[,1],
    centroid_lat = st_coordinates(centroid)[,2],
    # find the corresponding community
    community = LabelPointsWithinPolygons(lat = centroid_lat,
                                          lng = centroid_lng,
                                          polygon.boundaries = community.area.boundaries))

