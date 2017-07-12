#' @title 
#' Separation of the data.
#'  
#' @description
#' This function loads the data for a specific road.
#' 
#' @usage separateData(Data2, datetime)
#' 
#' @param Data A data frame with the initial data
#' @param datetime The time for which the mean speed will be predicted
#'  
#' @details 
#' This function returns as a list object the data for the train and test.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis
#' 
#' @return A list with the following components:
#' 
#' \itemize{
#' \item trainData The trainset for the model
#' \item testData The testset to be predict
#' }
#' 
#' @seealso 
#' 
#' @rdname separateData
#' 
#' @import
#' @export

separateData <- function (Data2, datetime)
{
  #datetime <- "2017-01-14 17:15:00"
  datetime <- strptime(as.character(datetime),format='%Y-%m-%d %H:%M:%S', tz="Europe/Istanbul")
  
  Data2$Date <- as.POSIXct(strptime(as.character(Data2$Date),format='%Y-%m-%d %H:%M:%S', 
                                    tz="Europe/Istanbul"))
  trainData <- Data2[which(Data2$Date < datetime),]
  testData <- Data2[which(Data2$Date == datetime),]
  DataList = list(trainData = trainData, testData = testData)
}
