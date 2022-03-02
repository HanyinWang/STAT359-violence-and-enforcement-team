# Chicago gang data for Divvy bike application

## Data source
- Data for gang boundaries are obtained from the [Police Department GIS Data](https://gis.chicagopolice.org/search?categories=) as part of the  [Chicago Police Department CLEARMap database](https://gis.chicagopolice.org/), provided by the Office of Public Safety Administration (OPSA). The data are updated annually. Availabble in the dataset are the data from 2007 to 2021, except for 2013 and 2020.
- The [2021_Gang_Boundaries_and_nations.csv](https://github.com/HanyinWang/STAT359-violence-and-enforcement-team/blob/main/gang/data/gang_alliance/2021_Gang_Boundaries_and_nations.csv) and [Gang_nations.csv](https://github.com/HanyinWang/STAT359-violence-and-enforcement-team/blob/main/gang/data/gang_alliance/Gang_nations.csv) datasets provides the alliances of each gang (people nation and folks nation).

## How to use the data
1. Download the [gang boundary data](https://gis.chicagopolice.org/search?categories=&q=gang) from OPSA portal. Put the folders with the shape files of each year into the [data](https://github.com/HanyinWang/STAT359-violence-and-enforcement-team/tree/main/gang/data) folder.
2. The [gang_clean.R](https://github.com/HanyinWang/STAT359-violence-and-enforcement-team/blob/main/gang/gang_clean.R) code provides the following samples:
  - Merging the alliance of each gang (people or folks) with corresponding boundary data
  - Map the centroid of each gang territory to Chicago community areas


## Merged datasets
Chicago gang boundary data mapped to each community for 2007 to 2021 (except for 2013 and 2020) can be found in the [merged_data](https://github.com/HanyinWang/STAT359-violence-and-enforcement-team/tree/main/gang/data/merged_data) folder.

## Demonstration of using the data
A preliminary analysis using the data can be found [here](https://github.com/HanyinWang/STAT359-violence-and-enforcement-team/blob/main/gang/EDA.html). (Please note: the divvy_2021.csv data used in this analysis is from another source (link pending))
