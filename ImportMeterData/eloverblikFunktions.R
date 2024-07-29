# Function used in Eloverblik importing from API


# Retrive data_access_token
get_data_access_token <- function(refreshtoken) {
  token <- refreshtoken
  path <- "/customerapi/api/token"
  data_access_token_time <- Sys.time()
  raw_data_access_token <-
    GET(
      url = url,
      path = path,
      accept_json() ,
      add_headers(Authorization = paste("Bearer ", token))
    )
  fromJSON(rawToChar(raw_data_access_token$content))$result
}

# This function is not finished yet
get_metering_point <- function(data_access_token) {
  path <-
    "/customerapi/api/meteringpoints/meteringpoints?includeAll=true"
  GET(
    url = url,
    path = path,
    accept_json(),
    add_headers(Authorization = paste("Bearer ", data_access_token))
  )
}

get_timeseries_data <-
  function(data_access_token ,
           dateFrom,
           dateTo,
           aggregation) {
    path <- "/customerapi/api/meterdata/gettimeseries/"
    
    dateFrom    <- dateFrom
    dateTo      <- dateTo
    aggregation <- aggregation
    timeseries_data <- data.frame(dateFrom, dateTo, aggregation)
    meter_jason <-
      toJSON(list(meteringPoints = list(meteringPoint = "571313174114382355")))
    
    meter_data_url <-
      paste(
        url,
        path,
        timeseries_data$dateFrom,
        "/",
        timeseries_data$dateTo,
        "/",
        timeseries_data$aggregation,
        sep = ""
      )
    
    POST(
      url = meter_data_url,
      content_type_json(),
      accept_json(),
      add_headers(Authorization = paste("Bearer ", data_access_token)),
      body = meter_jason,
      encode = "json"
    )
  }

# DataExtraction

# Extract observations for the requested time span
extract_period_observations <- function(period) {
  for (d in period) {
    start_date <-
      with_tz(as.POSIXct(d$timeInterval$start, format = "%Y-%m-%dT%H:%M:%OSZ", tz = "UTC"),
              tz = "Europe/Copenhagen")
    end_date <-
      with_tz(as.POSIXct(d$timeInterval$end, format = "%Y-%m-%dT%H:%M:%OSZ", tz = "UTC"),
              tz = "Europe/Copenhagen")
    resolution <- d$resolution
    
    for (p in d$Point) {
      point_observation <-
        data.frame(
          start_date,
          end_date,
          p$position,
          resolution,
          p$out_Quantity.quantity,
          p$out_Quantity.quality
        )
      # We are adding data to an data frame outside the function
      observation[nrow(observation) + 1,] <<- point_observation
    }
  }
}
