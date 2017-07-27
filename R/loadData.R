#' @title 
#' Load traffic data
#'  
#' @description
#' This function loads the traffic data.
#' 
#' @usage loadData(path)
#'  
#' @details 
#' This function returns a data frame with the traffic data of the roads of Thessaloniki ordered by the roads.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis
#' 
#' @return 
#' Returns a data frame.
#' 
#'  
#' @rdname loadData
#' 
#' @importFrom RCurl url.exists
#' @importFrom data.table fread
#' 
#' @export
#' 
loadData <- function(path){
  
  stopifnot(file.exists(path)==T | RCurl::url.exists(path)==T)
  
  Data <- data.table::fread(path)
  
  Data <- as.data.frame(Data)
  
  colnames(Data) = c("Link_id", "Direction", "Date", "Min_speed", "Max_speed", "Mean_speed", 
                     "Stdev_speed", "Skewness_speed", "Kurtosis_speed", "Entries", "UniqueEntries")
  
  Data$Date <- as.character(Data$Date)
  Data <- Data[order(as.numeric(Data$Link_id)),]   #order by id
  
  return(Data)
}
