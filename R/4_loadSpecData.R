loadSpecData <- function(specDates, df){
  
  specDates$Date = as.character(specDates$Date)
  df$Date = as.character(df$Date)
  
  DataReduced = merge(df,specDates,by = "Date")   # keep only specific Dates from Data
  DataReduced = DataReduced[order(DataReduced$Link_id),]
  
  by_LinkID = group_by(DataReduced,Link_id)
  CompleteStreets = summarise(by_LinkID,n = n())
  CompleteStreets = filter(CompleteStreets,n >= 9)   # keep the id which have 9 dates
  CompleteStreets = CompleteStreets$Link_id
  DataReduced = DataReduced[DataReduced$Link_id %in% CompleteStreets,]
  
  # find train and test set
  trainData = DataReduced[DataReduced$Date %in% specDates[-1,],]
  testData = DataReduced[DataReduced$Date %in% specDates[-9,],]
  
  trainDataWide = dcast(trainData,Date ~ Link_id,value.var = "Mean_speed")
  #cormatTrain = cor(trainDataWide[,2:ncol(trainDataWide)])
  #cormatTrain[is.na(cormatTrain)] <- 0
  
  # Order the rows and columns by Link ID 
  DataList = list(trainData = trainData, testData = testData,trainDataWide = trainDataWide) #, cormatTrain = cormatTrain)
  
  return(DataList)
}
