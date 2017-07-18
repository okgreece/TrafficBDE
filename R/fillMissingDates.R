#' @title 
#' Fill Missing Dates
#'  
#' @description
#' This function fills the missing dates from the data.
#' 
#' @usage fillMissingDates(Data, datetime)
#' 
#' @param Data The historical data
#' @param datetime The datetime wanted
#'  
#' @details 
#' This function returns a data frame without missing dates.
#' 
#' @author Aikaterini Chatzopoulou
#' 
#' @return A data frame with all the historical data between the first date and the date wanted. 
#' 
#' @seealso
#' 
#' @rdname fillMissingDates
#' 
#' @import
#' @export

fillMissingDates <- function(Data, datetime){
  
  ts <- seq.POSIXt(min(Data$Date), 
                   strptime(datetime,'%Y-%m-%d %H:%M:%S',tz="Europe/Istanbul"), 
                   by="15 min")
  
  ts <- seq.POSIXt(min(Data$Date), as.POSIXlt(datetime), by="15 min")
  ts <- format.POSIXct(ts,'%Y-%m-%d %H:%M:%S')
  
  df <- data.frame(Date=ts)
  df$Date <- as.POSIXct(strptime(as.character(df$Date),format='%Y-%m-%d %H:%M:%S', 
                                 tz="Europe/Istanbul"))
  df$Date <- as.POSIXct(df$Date)
  Data$Date <- as.POSIXct(Data$Date)
  
  data_with_missing_times <- full_join(df,Data, by="Date")
  data_with_missing_times <- data_with_missing_times[,-c(2,3)]
  
  data_with_missing_times <- na.locf(data_with_missing_times)
  
  return(data_with_missing_times)
}