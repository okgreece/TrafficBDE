#' @title 
#' Load traffic data
#'  
#' @description
#' This function loads the traffic data.
#' 
#' @usage loadData()
#'  
#' @details 
#' This function returns a data frame with the traffic data of the roads of Thessaloniki ordered by the roads.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis
#' 
#' @return 
#' Returns a data frame.
#' 
#' @seealso 
#'  
#' @rdname loadData
#' 
#' @import readr
#' @export
#' 
loadData <- function(){
  
  #Data <- readr::read_delim("~/imet_Links/fcd_speed_012017.csv", 
   #                "\t", escape_double = FALSE, col_names = FALSE, 
    #                 trim_ws = TRUE)
  
  # Data <- "link"
  Data <- as.data.frame(Data)
  colnames(Data) = c("Link_id", "Direction", "Date", "Min_speed", "Max_speed", "Mean_speed", 
                     "Stdev_speed", "Skewness_speed", "Kurtosis_speed", "Entries", "UniqueEntries")
  
  Data$Date <- as.character(Data$Date)
  Data <- Data[order(as.numeric(Data$Link_id)),]   #order by id
  
  return(Data)
}
