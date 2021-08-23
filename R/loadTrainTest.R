#' @title 
#' Load Train and Test Data
#'  
#' @description
#' This function returns a list with the train and test data.
#' 
#' @usage loadTrainTest(Data, datetime, predict)
#' 
#' @param Data The historical data
#' @param datetime The date time the user wants to predict
#' @param predict The value he user wants to predict must be a column name of the data set
#'  
#' @details 
#' This function returns a list with the train and test data that will be used for train and prediction.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis, Charalampos Bratsas
#' 
#' @return A list with the following components:
#' \itemize{
#' \item trainsData The trainData for the model
#' \item testsData The testData to be predict
#' }
#'  
#' 
#' @rdname loadTrainTest
#' 
#' @examples 
#' SpecLink <- loadDataSpecLink("163204843","1", X163204843_1)
#' x <- fillMissingValues(SpecLink)
#' datetime <- "2017-01-27 14:00:00" 
#' newData <- fillMissingDates (x, datetime)
#' DataList <- loadTrainTest (newData, datetime, "Mean_speed")
#'
#' @export

loadTrainTest <- function (Data, datetime, predict)
{
  # Check if the datetime exist
  stopifnot(any(any(Data$Date == datetime) | any(colnames(Data) == predict)) == TRUE)
  
  Datatest <- subset(Data,select=colnames(Data)[which(colnames(Data)!=predict)])
  DataPredict <- subset(Data,select=colnames(Data)[which(colnames(Data) == predict)])
  
  Data2 = data.frame(Datatest[2:nrow(Data),1],
                     Datatest[1:(nrow(Data)-1),-1],DataPredict[2:nrow(Data),])
  
  colnames(Data2) = c(colnames(Datatest),predict)
  
  datetime <- strptime(as.character(datetime),format='%Y-%m-%d %H:%M:%S', tz="Europe/Istanbul")
  
  Data2$Date <- as.POSIXct(strptime(as.character(Data2$Date),format='%Y-%m-%d %H:%M:%S', 
                                    tz="Europe/Istanbul"))
  
  # Data2[,-1] <- as.data.frame(apply(Data2[,-1],2,as.character))
  # Data2[,-1] <- as.data.frame(apply(Data2[,-1],2,as.numeric))
  
  trainData <- Data2[which(Data2$Date < datetime),]
  testData <- Data2[which(Data2$Date == datetime),]
  
  DataList = list(trainData = trainData, testData = testData)
}
