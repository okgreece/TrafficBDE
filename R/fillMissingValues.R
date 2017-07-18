#' @title 
#' Fill Missing Values
#'  
#' @description
#' This function fills the missing values from the data.
#' 
#' @usage fillMissingValues(Data)
#' 
#' @param Data The historical data of the roads of Thessaloniki
#'  
#' @details 
#' This function returns a data frame without missing values.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis
#' 
#' @return A data frame with all the historical data without missing values
#' 
#' @seealso
#' 
#' @rdname fillMissingValues
#' 
#' @import
#' @export

fillMissingValues <- function(Data){
  
  # Check if there are na or null values
  stopifnot(any(is.na(Data) | is.null(Data)) == T)
  
  Data$Skewness_speed[Data$Entries==2] <- (((Data$Min_speed[Data$Entries==2] - Data$Mean_speed[Data$Entries==2])^3 +
                                              (Data$Max_speed[Data$Entries==2] - Data$Mean_speed[Data$Entries==2])^3)/2) / 
    (Data$Stdev_speed[Data$Entries==2])^3
  
  
  Data$Kurtosis_speed[Data$Entries==2] <- (((Data$Min_speed[Data$Entries==2] - Data$Mean_speed[Data$Entries==2])^4 +
                                              (Data$Max_speed[Data$Entries==2] - Data$Mean_speed[Data$Entries==2])^4)/2)/
    ((Data$Stdev_speed[Data$Entries==2])^4)
  
  Data$Kurtosis_speed[Data$Entries==3] <- (((Data$Min_speed[Data$Entries==3] - Data$Mean_speed[Data$Entries==3])^4 +
                                              (Data$Max_speed[Data$Entries==3] - Data$Mean_speed[Data$Entries==3])^4 +
                                              (((3*Data$Mean_speed[Data$Entries==3]) - Data$Min_speed[Data$Entries==3] -
                                                  Data$Max_speed[Data$Entries==3])- Data$Mean_speed[Data$Entries==3])^4)/2)/
    ((Data$Stdev_speed[Data$Entries==3])^4)
  
  Data$Stdev_speed[Data$Entries==1] <- 0
  
  Data$Skewness_speed[Data$Min_speed== Data$Max_speed] <- 0
  
  Data$Kurtosis_speed[Data$Min_speed== Data$Max_speed] <- 3
  
  return(Data)
}
