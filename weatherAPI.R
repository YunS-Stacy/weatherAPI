token <- '5a72a1166e11799404bb400caea62721'
days <- '7'
# fake list
zipList <- c('92373', '92374')

# function to get JSON response from weather API
getJSON <- function (zip) jsonlite::fromJSON(paste('http://api.openweathermap.org/data/2.5/forecast/daily?zip=', zip , '&appid=', token, '&cnt=', days))

# function to get the 7-day weather
getDailyID <- function (res) lapply(c(1:7), function(num) res$list$weather[[num]]$id)

# assemble daily weather data from each zipcode
resList <- lapply(zipList, getJSON)
res <- lapply(resList, getDailyID)
# for colnames, fake names for now
dayList <- list(1, 2, 3, 4, 5, 6, 7)
resCSV <- vapply(resList, getDailyID, dayList)
write.csv(resCSV, file = 'test.csv')
