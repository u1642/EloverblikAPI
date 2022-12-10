# EloverblikAPI

This code is my first time using R to call an API. This code is for home usage, the code is no where near production ready.

Please note that data are written as they are imported, this mean that time and date is GMT.
I will improve the scripts over time, but this is the first version.

## How to use:
First you need to create a refresh token.
Read the manual Documentation/Eloverblik - Adgang til egne data via API-kald.pdf it explains how to get the token.

Rename the file ImportMeterData/eloverblikParam.template.R file to downloadDate/eloverblikParam.R

Edit ImportMeterData/eloverblikParam.R and add meter number and yout token
- meter <- "Insert your meter number here"
- refreshtoken <- "Inserte your refreshtoken here"

Run the script ImportMeterData/ImportMeterDataAPI.R
Data will now be imported and stored:
- Data Frame called observation
- Stored in a file called Date/observation.RDS

Best regards
Henrik
 
