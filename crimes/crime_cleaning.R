#library(tidyverse)
#library(janitor)
#library(lubridate)
#library(skimr)

crimes <- read_csv('data/unprocessed/crimes_2020.csv') %>% 
  clean_names()

skim_without_charts(crimes)

# missingness is not a serious issue other than 2090 that don't have 
# location data. Since there are 205K rows, I'll remove these 2090

crimes <- crimes %>% 
  filter(!is.na(location))

# now missingness isn't an issue
skim_without_charts(crimes)

# variables like case_number, id, block, iucr, district, ward, 
# x_coordinate, y_coordinate, updated_on and location
# aren't useful since they're unique identifiers, redundant, or location
# info that we won't use since we're focused on neighborhoods, so I'll
# remove those variables

crimes <- crimes %>% 
  select(-case_number, -id, -block, -iucr, -district, -ward, 
         -x_coordinate, -y_coordinate, -updated_on,
         -location)

unique(crimes$year)
# since all these crimes were in 2021, I will remove this column
crimes <- crimes %>% 
  select(-year)

unique(crimes$primary_type)

unique(crimes$description)

unique(crimes$fbi_code)

# I likely won't use description since there are so many different crimes,
# but primary_type and possibly fbi_code will be useful

unique(crimes$location_description)

as_tibble(unique(crimes$location_description)) %>% 
  filter(str_detect(value, "BIKE"))
as_tibble(unique(crimes$location_description)) %>% 
  filter(str_detect(value, "BICYCLE"))
as_tibble(unique(crimes$location_description)) %>% 
  filter(str_detect(value, "VEHICLE"))
as_tibble(unique(crimes$location_description)) %>% 
  filter(str_detect(value, "STREET"))

# nothing specifically about bikes or bike lanes

skim_without_charts(crimes)


# date isn't coded ideally so I'll fix that
crimes <- crimes %>% 
  mutate(date = mdy_hms(date))

# I will also make all text lowercase for convenience

crimes <- crimes %>% 
  mutate(primary_type = tolower(primary_type),
         description = tolower(description),
         location_description = tolower(location_description))

skim_without_charts(crimes)

# since there are very few missing values, I will remove all rows
# with missingness
crimes <- crimes %>% 
  filter(!is.na(location_description))

# now the data is processed and there is no missingness,
# so I'll save it for analysis

write_csv(crimes, 'data/processed/crimes_2020.csv')


