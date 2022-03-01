This is a data exploration of Chicago Crimes 2021 dataset which I retrieved from the Chicago Data Portal (Source: https://data.cityofchicago.org/Public-Safety/Crimes-2021/dwme-t96c).
I did not include this data in the data folder, so to use these scripts, you must export it as a CSV from the source provided.

First, I cleaned the data with the crimes_cleaning.R script, where I mainly removed unnecessary variables and removed missing values.

The crimes_exec_sum.Rmd is an example of how the data can be used to explore relationships between crimes and Divvy bike lanes as well as demographic information. The bikes and
communities are Shape files that also came from Chicago Data Portal, and they are included in the data folder. neighborhood_info.xlsx came from manipulating US Census Bureau data.
