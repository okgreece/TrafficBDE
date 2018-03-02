#' @title 
#' PreProcessing second model
#'  
#' @description
#' This function processes the data.
#' 
#' @usage PreProcessingLink(DataList)
#' 
#' @param DataList A list with the following components: trainData, testData, 
#' trainDataWide, cormat
#'  
#' @details 
#' This function returns as a list object the parameters needed to train the model and predict.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis
#' 
#' @return A list with the following components:
#' 
#' \itemize{
#' \item trainset The trainset for the model
#' \item testset The testset to be predict
#' \item Minimum The min values of each column of the initial dataset
#' \item Maximum The max values of each column of the initial dataset
#' }
#' 
#' @rdname PreProcessingLink
#' 
#' @examples 
#' SpecLink <- loadDataSpecLink("163204843","1", X163204843_1)
#' x <- fillMissingValues(SpecLink)
#' datetime <- "2017-01-27 14:00:00" 
#' newData <- fillMissingDates (x, datetime)
#' DataList <- loadTrainTest (newData, datetime, "Mean_speed")
#' List <- PreProcessingLink(DataList)
#' 
#' @export

PreProcessingLink <- function(DataList){
  
  trainData <- as.data.frame(DataList[[1]])
  names(trainData)<- names(DataList[[1]])
  
  testData <- as.data.frame(DataList[[2]])
  names(testData) <- names(DataList[[2]])
  
  trainset <- trainData[,2:ncol(trainData)] 
  rownames(trainset) <- as.character(trainData$Date)
  
  # Create the testset
  testset <- testData[,2:ncol(testData)] 
  rownames(testset) <- as.character(testData$Date)
  
  
  scl <- function(x){ (x - min(x))/(max(x) - min(x)) }
  
  Min = apply(trainset,2,min)
  Max = apply(trainset,2,max)
  
  normalData = as.data.frame(apply(trainset,2,scl))
  
  trainDataScaled = normalData
  
  List = list(trainset = as.data.frame(trainDataScaled),
              testset = as.data.frame(testset), minimum = Min, maximum = Max)
  return(List)
}
