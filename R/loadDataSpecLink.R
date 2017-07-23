#' @title 
#' Load data for a specific road of Thessaloniki
#'  
#' @description
#' This function extracts the data of one road of Thessaloniki.
#' 
#' @usage loadDataSpecLink(Link_id, direction, Data)
#' 
#' @param Link_id A character with the id of the road needed
#' @param direction The direction of the road
#' @param Data The historical data of the roads of Thessaloniki
#'  
#' @details 
#' This function returns the predicted average speed.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis
#' 
#' @return A data frame with the data of a specific road
#' 
#' @seealso \code{\link{3_loadData}}
#' 
#' @rdname loadDataSpecLink
#' 
#' @import
#' @export

loadDataSpecLink <- function(Link_id, direction, Data){
  
  # Check if the Link_id and the direction exist
  stopifnot(any (any(Data$Link_id == Link_id) | any(Data$Direction == direction)) == TRUE)
  
  Data$Date <- strptime(as.character(Data$Date),format='%Y-%m-%d %H:%M:%S', tz="Europe/Istanbul")
  Data <- Data[order(as.numeric(Data$Link_id)),]   #order by id 
  
  DataSpecLink <- Data[which(Data$Link_id == Link_id & Data$Direction == direction),]
  
  return(DataSpecLink)
}
