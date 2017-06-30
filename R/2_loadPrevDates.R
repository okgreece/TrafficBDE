##### Specific Dates #####
loadPrevDates <- function(datetime){
  
  print("Getting Previous dates...")  
  
  currentDay <- strptime(as.character(datetime),format='%Y-%m-%d %H:%M:%S', tz="EEST")
  
  # Apply correction of minutes in case the user does not insert a quarter (e.g 00,15,30,45)
  first <- update(currentDay, hours = hour(currentDay), minutes = 00, second = 00)
  second <- update(currentDay, hours = hour(currentDay), minutes = 15, second = 00)
  third <- update(currentDay, hours = hour(currentDay), minutes = 30, second = 00)
  fourth <- update(currentDay, hours = hour(currentDay), minutes = 45, second = 00)
  
  if (currentDay %within% interval(first, second - seconds(1), tz="EEST")){
    minute(currentDay) <- 00
  }else if (currentDay %within% interval(second, third - seconds(1), tz="EEST")){
    minute(currentDay) <- 15
  }else if (currentDay %within% interval(third, fourth - seconds(1), tz="EEST")){
    minute(currentDay) <- 30
  }else{
    minute(currentDay) <- 45
  }
  
  
  # prev.hours <- update(currentDay, hour = hour(currentDay), 
  #                      minute = minute(currentDay), tz="EEST") 
  
  # Find previous quarters
  time <- as.data.frame(currentDay)
  colnames(time) <- "Date"
  
  for (i in 1:8){
    time[i+1,1] <- as.data.frame(currentDay - minutes(x = (i * 15)))
  }
  
  return(time)
  
  
}
