#' @title 
#' Load traffic data
#'  
#' @description
#' This function loads traffic data and transforms the na values that might exist.
#' 
#' @usage loadData()
#' 
#' @param 
#'  
#' @details 
#' This function returns a data frame with ones month traffic data of the roads of Thessaloniki.
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
#' @import
#' @export
#' 
loadData <- function(){
  
  Data = read_delim("~/NewTryWeeklyData/fcd_speed_012017.csv", 
                    "\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)     # read Data
  
  colnames(Data) = c("Link_id", "Direction", "Date", "Min_speed", "Max_speed", "Mean_speed", 
                     "Stdev_speed", "Skewness_speed", "Kurtosis_speed", "Entries", "UniqueEntries")
  
  # Data$Date = strptime(as.character(Data$Date),format='%Y-%m-%d %H:%M:%S', tz="EEST") ## transformation of Dates
  
  Data$Date <- as.character(Data$Date)
  Data <- Data[order(as.numeric(Data$Link_id)),]   #order by id
  
  spl <- split(Data,Data$Link_id)
  
  for (i in 1:length(spl))    # fill na for each id
  {
    for (j in 7:9){
      
      if (sum(!is.na(spl[[i]][j])) >= 2){spl[[i]][j] = na.locf(as.data.frame(spl[[i]][j]))
      }else {spl[[i]][j] <- as.numeric(lapply(spl[[i]][j],mean))}
    }
  }
  
  #if(sum(!is.na(spl[[i]][j])) == 0)
  #{ spl <- spl[-i]
  #i <- i - 1
  #}else 
    
  df <- ldply (spl, data.frame)  # convert list to Data frame
  df <- df[,-1]
  
  return(df)
}
