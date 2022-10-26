# EloverblikAPI
 

First you need to create a refresh token.
Read the manual Documentation/Eloverblik - Adgang til egne data via API-kald.pdf it explains how to get the token.

Rename the file ImportMeterData/eloverblikParam.template.R file to downloadDate/eloverblikParam.R

Edit ImportMeterData/eloverblikParam.R and add meter number and yout token

meter <- "Insert your meter number here"
refreshtoken <- "Inserte your template here"

Run the script ImportMeterData/ImportMeterDataAPI.R
Data will now be imported and stored in a file called
