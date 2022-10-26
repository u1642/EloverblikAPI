#
# The purpose of this script is to update meterdata trough the Web API
# This script is ment to be run by a task scheduller
#

# Install packages, and load library
list.of.packages <-
  c("tidyverse",
    "lubridate",
    "scales",
    "rsconnect",
    "httr",
    "jsonlite",
    "XML")
new.packages <-
  list.of.packages[!(list.of.packages %in% installed.packages()[, "Package"])]
if (length(new.packages))
  install.packages(new.packages)

lapply(list.of.packages, require, character.only = TRUE)

# Include files
directory <- "ImportMeterData"
source(file = paste(directory, "/eloverblikParam.R", sep = ""))
source(file = paste(directory, "/eloverblikErrorCode.R", sep = ""))
source(file = paste(directory, "/eloverblikFunktions.R", sep = ""))

#
# Do we have a data file, if not create one
#
if (file.exists("observation.RDS")) {
  observation <- readRDS("observation.RDS")
} else if (!exists("observation")) {
  observation <-
    setNames(
      data.frame(matrix(ncol = 6, nrow = 0)),
      c(
        "start",
        "end",
        "position",
        "resolution",
        "out_Quantity.quantity",
        "out_Quantity.quality"
      )
    )
  observation$start <- as.POSIXct(observation$start)
  observation$end <- as.POSIXct(observation$end)
}

# Fetch data with API call
# options(stringsAsFactors = FALSE)

# Set static values
url  <- "https://api.eloverblik.dk"


# # Data_access_Token is needed to request data"
# if (file.exists("M:/GitHub/Secret/last_Data_access_Token.RDS")) {
#   data_access_toke <- readRDS("observation.RDS")
# }
data_access_token <- get_data_access_token(refreshtoken)
# last_Data_access_Token <- c(dat <- data_access_token, date <- today())

# Find the next date to import
if (nrow(observation)) {
  start_date <- max(observation$end)
} else {
  start_date <- as.Date("2012-01-01")
}

end_date <- start_date + days(720)


exitCode = 0
while (exitCode == 0) {
  if (end_date > today()) {
    end_date <- today() + days(1)
    exitCode <- 1
  }
  
  timeseries_data <-
    get_timeseries_data(data_access_token, start_date, end_date, "Hour")
  
  if (timeseries_data$status_code == "200") {
    tsd <- content(timeseries_data)
  } else {
    print("Error recieving data error: ", timeseries_data$status_code)
    if (timeseries_data$status_code == 503) {
      Sys.sleep(60)
    }
  }
  
  listAttributes <-
    attributes(tsd$result[[1]]$MyEnergyData_MarketDocument)
  if ("TimeSeries" %in% listAttributes[["names"]] &&
      length(tsd$result[[1]]$MyEnergyData_MarketDocument$TimeSeries) > 0) {
    period <-
      tsd$result[[1]]$MyEnergyData_MarketDocument$TimeSerie[[1]]$Period
    
    extract_period_observations(period)
  } else {
    print("No more data")
  }
  
  if (nrow(observation) != 0) {
    saveRDS(observation, file = "observation.RDS")
    start_date <- max(observation$end)
  } else {
    start_date <- end_date
  }
  
  end_date <- start_date + days(720)
}