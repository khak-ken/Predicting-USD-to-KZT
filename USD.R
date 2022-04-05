#install.packages("readxl") # CRAN version
library("xlsx")

library(readxl)
train=read_excel("Official_Foreign_Exchange_Rates_NBRK_on_29_12_2018.xls")
test=read_excel("2019 data USD.xlsx")



library(randomForest) 
# Perform training: 
fit = randomForest(USD ~ ., data=train, ntree=100,importance=TRUE) 


Prediction <- predict(fit, test)

submit<-data.frame(Date = test$Date, USD = Prediction)
write.csv(submit, file = "USD Prediction.csv", row.names = FALSE)

