#' @title 
#' k Steps Forward
#'  
#' @description
#' This function predictes the wanted value after k steps.
#' 
#' @usage kStepsForward (Data, Link_id, direction, datetime, predict, steps)
#' 
#' @param Data A data frame with the historical data
#' @param Link_id A character with the id of the road needed
#' @param direction The direction of the road
#' @param datetime The datetime wanted
#' @param predict The value to be predicted
#' @param steps The number of steps
#'  
#' @details 
#' This function returns the predicted value after k steps.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis, Panagiotis Tzenos
#' 
#' @return The predicted value
#' 
#' @seealso \code{\link{loadData}}
#' 
#' @rdname kStepsForward
#' 
#' @importFrom lubridate minute
#' @export

kStepsForward <- function (Data, Link_id, direction, datetime, predict, steps){
  
  if ((predict %in% c("Mean_speed","Entries","Stdev_speed"))== F)
  {stop("Please specify another parameter\n",predict," is not an appropriate value")}
  
  DataLink <- loadDataSpecLink(Link_id, direction, Data)
  
  DataLinkNA <- fillMissingValues(DataLink)
  
  datetime <- as.POSIXct(strptime(datetime,'%Y-%m-%d %H:%M:%S',tz="Europe/Istanbul"))
  minutes <- lubridate::minute(datetime)
  
  Result = matrix(nrow = steps , ncol = 6,dimnames = list(c(1:steps),c("Link_id","direction","exec","step","dt",predict)))
  
  exec_tstamp <-Sys.time();
  
    for (i in 1:(steps)){
    dateSt <- stats::update(datetime , minutes = minutes -15*(steps-i))
    
    DataAll <- fillMissingDates(DataLinkNA, dateSt)
    
    DataList <- loadTrainTest(DataAll, dateSt, predict)
    
    List <- PreProcessingLink(DataList)
    
    #do not retrain on step change
    if (i==1){
      NNOut <- TrainCR(List, predict)    
    }
    
    res <- PredictionCR(List,NNOut,predict)
    
    Result[i,] <- c(Link_id,direction,as.character(exec_tstamp),i,as.character(dateSt),res[1])
    
    DataLinkNA[which(DataLinkNA$Date == dateSt),which(colnames(DataLinkNA)==predict)] = Result[i,6] #next step
  }
  
  return(Result)
}
