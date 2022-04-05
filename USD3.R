# Reference: http://www.rdatamining.com/examples/time-series-forecasting

setwd("C:/Users/nhlr/OneDrive - Chevron/Documents/CurrKZT")
#install.packages("readxl") # CRAN version
library("xlsx")

library(readxl)
rates=read_excel("Official_Foreign_Exchange_Rates_NBRK_on_29_12_2018.xls")

## convert into date format
rates$Date <- as.Date(train$Date, "%Y-%m-%d")
str(rates$Date)
range(rates$Date)

rates <- rates[order(rates$Date), ]

## plot time series
plot(rates$Date, rates$USD, type = "l")

head(rates$Date, 20)
years <- format(rates$Date, "%Y")
tab <- table(years)
tab
## number of days per year after removing 2014
mean(tab[1:(length(tab) - 1)])

###Forecasting with ARIMA
source("forecast.R")  ## see code file in section 5
result.arima <- forecastArima(rates, n.ahead = 90)
source("plotForecastResult.R")  ## see code file in section 5
plotForecastResult(result.arima, title = "Exchange rate forecasting with ARIMA")
write.csv(result.arima, file = "Forecasting with ARIMA (2019).csv", row.names = TRUE)

###Forecasting with STL
result.stl <- forecastStl(rates, n.ahead = 90)
plotForecastResult(result.stl, title = "Exchange rate forecasting with STL")
## exchange rate in 2019
result <- subset(result.stl, date >= "2019-01-01")
plotForecastResult(result, title = "Exchange rate forecasting with STL (2019)")
write.csv(result, file = "Forecasting with STL (2019).csv", row.names = TRUE)


