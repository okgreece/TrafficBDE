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
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis, Charalampos Bratsas
#' 
#' @return The predicted value
#' 
#' @seealso \code{\link{loadData}}
#' 
#' @rdname kStepsForward
#' 
#' @examples 
#' \dontrun{
#' kStepsForward (X163204843_1, "163204843", "1", "2017-01-27 14:00:00", "Mean_speed", 1)}
#'
#' @importFrom lubridate minute
#' @export

kStepsForward <- function (Data, Link_id, direction, datetime, predict, steps){
  
  if ((predict %in% c("Mean_speed","Entries","Stdev_speed"))== F)
  {stop("Please specify another parameter\n",predict," is not an appropriate value")}
  
  DataLink <- loadDataSpecLink(Link_id, direction, Data)
  
  DataLinkNA <- fillMissingValues(DataLink)
  DataLinkNA <- as.data.frame(DataLinkNA)
  
  datetime <- as.POSIXct(strptime(datetime,'%Y-%m-%d %H:%M:%S',tz="Europe/Istanbul"))
  minutes <- lubridate::minute(datetime)
  
  Result = matrix(nrow = steps , ncol = 3,dimnames = list(c(1:steps),
                                                          c("Predicted", "Real Value", "RMSE")))
  for ( i in 1:(steps)){
    dateSt <- stats::update(datetime , minutes = minutes -15*(steps-i))
    
    DataAll <- fillMissingDates(DataLinkNA, dateSt)
    
    DataList <- loadTrainTest(DataAll, dateSt, predict)
    
    List <- PreProcessingLink(DataList)
    
    NNOut <- TrainCR(List, predict)
    
    
    Result[i,] <- PredictionCR(List,NNOut,predict)
    
    rownames(Result)[i] <- as.character(dateSt)
    
    
    DataLinkNA[which(DataLinkNA$Date == dateSt),which(colnames(DataLinkNA)==predict)] <- Result[i,1] #next step
    
  }
  return(Result)
}