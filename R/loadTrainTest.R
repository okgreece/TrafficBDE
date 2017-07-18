#' @title 
#' Load Train and Test Data
#'  
#' @description
#' This function returns a list with the train and test data.
#' 
#' @usage loadTrainTest(Data, datetime)
#' 
#' @param Data The historical data
#' @param datetime The date time the user wants to predict
#'  
#' @details 
#' This function returns a list with the train and test data that will be used for train and prediction.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis
#' 
#' @return A list with the following components:
#' 
#' \itemize{
#' \item trainsData The trainData for the model
#' \item testsData The testData to be predict
#'  
#' @seealso
#' 
#' @rdname loadTrainTest
#' 
#' @import
#' @export

loadTrainTest <- function (Data, datetime)
{
  # Check if the datetime exist
  stopifnot(any(Data$Date == datetime) == TRUE)
  
  Data2 = data.frame (
    Data$Date[2:nrow(Data)],
    Data$Min_speed[1:(nrow(Data)-1)],
    Data$Max_speed[1:(nrow(Data)-1)],
    Data$Mean_speed[2:nrow(Data)],
    Data$Stdev_speed[1:(nrow(Data)-1)],
    Data$Skewness_speed[1:(nrow(Data)-1)],
    Data$Kurtosis_speed[1:(nrow(Data)-1)],
    Data$Entries[1:(nrow(Data)-1)],
    Data$UniqueEntries[1:(nrow(Data)-1)]
  )
  colnames(Data2) = c("Date", "Min_speed", "Max_speed", "Mean_speed", "Stdev_speed", 
                      "Skewness_speed", "Kurtosis_speed", "Entries", "UniqueEntries")
  
  datetime <- strptime(as.character(datetime),format='%Y-%m-%d %H:%M:%S', tz="Europe/Istanbul")
  
  Data2$Date <- as.POSIXct(strptime(as.character(Data2$Date),format='%Y-%m-%d %H:%M:%S', 
                                    tz="Europe/Istanbul"))
  
  Data2[,-1] <- as.data.frame(apply(Data2[,-1],2,as.character))
  Data2[,-1] <- as.data.frame(apply(Data2[,-1],2,as.numeric))
  
  trainData <- Data2[which(Data2$Date < datetime),]
  testData <- Data2[which(Data2$Date == datetime),]
  
  DataList = list(trainData = trainData, testData = testData)
}
