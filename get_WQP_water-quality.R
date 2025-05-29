
################################################################################
# Direct water quality data download from the Water Quality Portal. 
# 
# Lily Conrad
# last update: 5/29/2025
#
# Data citation: 
# Water Quality Portal. Washington (DC): National Water Quality Monitoring Council, 
# United States Geological Survey (USGS), Environmental Protection Agency (EPA); 
# 2021. https://doi.org/10.5066/P9QRKUVJ.
################################################################################

# To get started, provide the user inputs below following the outlined format.


### User inputs ----------------------------------------------------------------

# Enter the eight digit HUC that you'd like to download data for. If you want to
# look at multiple HUCs, separate them by a comma inside the parentheses. 
huc <- c(17010305, 17010301)

# Enter the start date (mm-dd-yyyy) for your period of interest.
start <- "01-01-2015"

# Enter the end date (mm-dd-yyyy) for your period of interest.
end <- "12-31-2024"

# Enter your parameter(s) of interest. If you would like to list multiple, 
# follow the format outlined below. If you aren't sure what exact word to type,
# Check the Characteristic list available for selection on the WQP website. 
characteristicName <- c("Temperature", "Phosphorus", "Copper", "Microcystin")

# Enter your username (the name at the beginning of your computer's file explorer
# path) in quotations.
my_name <- "jdoe"


# Now that you've entered the values above, click on "Source" and watch
# your console for errors. If the script ran successfully, there will be a new
# Excel file in your Downloads folder. 


################################################################################
#                                 START
################################################################################

### Load packages and data -----------------------------------------------------

my_packages <- c("dplyr", "openxlsx", "dataRetrieval")
install.packages(my_packages, repos = "http://cran.rstudio.com")

library(dplyr)
library(openxlsx)
library(dataRetrieval)


### Retrieve water quality data ------------------------------------------------

# Data query.            
rawdat <- readWQPdata(huc = huc,
                      startDate = start,
                      endDate = end,
                      characteristicName = characteristicName,
                      service = "ResultWQX3") # set to beta version of WQP (3.0) to get all USGS data

# Remove QC and non-surface water samples
wq.dat <- rawdat %>%
  filter(Activity_MediaSubdivision == "Surface water",
         grepl("Routine", Activity_TypeCode)) 

# Save the data to excel. This will save the file in your downloads folder
# Adjust the file path if you'd like it to save somewhere else.
write.xlsx(wq.dat, paste0("C:/Users/", my_name,"/Downloads/",Sys.Date(),"_WQP_download.xlsx"))


################################################################################
#                                 END
################################################################################
