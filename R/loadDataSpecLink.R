#' @title 
#' loadData second model
#'  
#' @description
#' This function loads the data.
#' 
#' @usage loadDataSpecLink <- function(Link_id, direction)
#' 
#' @param Link_id The road that will be predicted
#' @param direction The direction of the road
#'  
#' @details 
#' This function returns a data frame.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis
#' 
#' @return Data frame
#' 
#' @seealso 
#' 
#' @rdname loadDataSpecLink
#' 
#' @import
#' @export

loadDataSpecLink <- function(Link_id, direction){
  
  Data = read_delim("C:/Users/kater/Desktop/fcd_speed_012017.csv", 
                  "\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE)     # read Data
  
  colnames(Data) = c("Link_id", "Direction", "Date", "Min_speed", "Max_speed", "Mean_speed", 
                    "Stdev_speed", "Skewness_speed", "Kurtosis_speed", "Entries", "UniqueEntries")
  
  
  Data$Date <- as.character(Data$Date)
  Data <- Data[order(as.numeric(Data$Link_id)),]   #order by id 
  
  Data2 <- Data[which(Data$Link_id == Link_id & Data$Direction == direction),]
  
  Data2$Skewness_speed[Data2$Entries==2] <- (((Data2$Min_speed[Data2$Entries==2] - Data2$Mean_speed[Data2$Entries==2])^3 +
                                                (Data2$Max_speed[Data2$Entries==2] - Data2$Mean_speed[Data2$Entries==2])^3)/2) / 
    (Data2$Stdev_speed[Data2$Entries==2])^3
  
  
  Data2$Kurtosis_speed[Data2$Entries==2] <- (((Data2$Min_speed[Data2$Entries==2] - Data2$Mean_speed[Data2$Entries==2])^4 +
                                                (Data2$Max_speed[Data2$Entries==2] - Data2$Mean_speed[Data2$Entries==2])^4)/2)/
    ((Data2$Stdev_speed[Data2$Entries==2])^4)
  
  Data2$Kurtosis_speed[Data2$Entries==3] <- (((Data2$Min_speed[Data2$Entries==3] - Data2$Mean_speed[Data2$Entries==3])^4 +
                                                (Data2$Max_speed[Data2$Entries==3] - Data2$Mean_speed[Data2$Entries==3])^4 +
                                                (((3*Data2$Mean_speed[Data2$Entries==3]) - Data2$Min_speed[Data2$Entries==3] -
                                                    Data2$Max_speed[Data2$Entries==3])- Data2$Mean_speed[Data2$Entries==3])^4)/2)/
    ((Data2$Stdev_speed[Data2$Entries==3])^4)
  
  Data2$Stdev_speed[Data2$Entries==1] <- 0
  
  Data2$Skewness_speed[Data2$Min_speed== Data2$Max_speed] <- 0
  
  Data2$Kurtosis_speed[Data2$Min_speed== Data2$Max_speed] <- 3
  Data2=data.frame(
    Data2$Link_id[1:(nrow(Data2)-1)],
    Data2$Direction[1:(nrow(Data2)-1)],
    Data2$Date[2:nrow(Data2)],
    Data2$Min_speed[1:(nrow(Data2)-1)],
    Data2$Max_speed[1:(nrow(Data2)-1)],
    Data2$Mean_speed[2:nrow(Data2)],
    Data2$Stdev_speed[1:(nrow(Data2)-1)],
    Data2$Skewness_speed[1:(nrow(Data2)-1)],
    Data2$Kurtosis_speed[1:(nrow(Data2)-1)],
    Data2$Entries[1:(nrow(Data2)-1)],
    Data2$UniqueEntries[1:(nrow(Data2)-1)]
  )
  colnames(Data2) = c("Link_id", "Direction", "Date", "Min_speed", "Max_speed", "Mean_speed", 
                      "Stdev_speed", "Skewness_speed", "Kurtosis_speed", "Entries", "UniqueEntries")
  return(Data2)
}
