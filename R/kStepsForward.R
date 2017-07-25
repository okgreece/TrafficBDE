#' @title 
#' k Steps Forward
#'  
#' @description
#' This function predictes the wanted value after k steps.
#' 
#' @usage lkStepsForward (steps, Link_id, direction, datetime, predict)
#' 
#' @param steps The number of steps
#' @param Link_id A character with the id of the road needed
#' @param direction The direction of the road
#' @param datetime The datetime wanted
#' @param predict The value to be predicted
#'  
#' @details 
#' This function returns the predicted value after k steps.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis
#' 
#' @return The predicted value
#' 
#' @seealso \code{\link{loadData}}
#' 
#' @rdname kStepsForward
#' 
#' 
#' @export

kStepsForward <- function (steps, Link_id, direction, datetime, predict){
  Data <- loadData()
  
  DataLink <- loadDataSpecLink(Link_id, direction, Data)
  
  DataLinkNA <- fillMissingValues(DataLink)
  DataLinkNA <- na.omit(DataLinkNA)
  
  datetime <- as.POSIXct(strptime(datetime,'%Y-%m-%d %H:%M:%S',tz="Europe/Istanbul"))
  minutes <- lubridate::minute(datetime)
  
  Result = matrix(nrow = steps , ncol = 3,dimnames = list(c(1:steps),
                                                          c("Predicted", "Real Value", "RMSE")))
  
  for (i in 1:(steps)){
    dateSt <- update(datetime , minutes = minutes -15*(steps-i))
    
    DataAll <- fillMissingDates(DataLinkNA, dateSt)
    
    DataList <- loadTrainTest(DataAll, dateSt, predict)
    
    List <- PreProcessingLink(DataList)
    
    NNOut <- TrainCR(List, predict)
    
    
    Result[i,] <- PredictionCR(List,NNOut,predict)
    
    rownames(Result)[i] <- as.character(dateSt)
    
    DataLinkNA[which(DataLinkNA$Date == dateSt),which(colnames(DataLinkNA)==predict)] = Result[i,1] #next step
    
  }
  return(Result)
}