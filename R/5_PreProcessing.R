#' @title 
#' PreProcessing
#'  
#' @description
#' This function processes the data.
#' 
#' @usage PreProcessing(DataList)
#' 
#' @param DataList A list with the following components: trainData, testData, 
#' trainDataWide, cormat
#'  
#' @details 
#' This function returns as a list object the parameters needed to train the model and predict.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis
#' 
#' @return A list with the following components:
#' 
#' \itemize{
#' \item trainset The trainset for the model
#' \item testset The testset to be predict
#' \item MinMaxFromScaling The min and max values of the initial dataset
#' }
#' 
#' @seealso \code{\link{4_loadSpecData}}
#' 
#' @rdname PreProcessing
#' 
#' @import
#' @export

PreProcessing <- function(DataList){
  
  trainData <- as.data.frame(DataList[1])
  names(trainData)<- c("Date", "Link_id", "Direction", "Min_speed", "Max_speed", "Mean_speed", 
                       "Stdev_speed", "Skewness_speed", "Kurtosis_speed", "Entries", "UniqueEntries")
  
  testData <- as.data.frame(DataList[2])
  names(testData) <- c("Date", "Link_id", "Direction", "Min_speed", "Max_speed", "Mean_speed", 
                        "Stdev_speed", "Skewness_speed", "Kurtosis_speed", "Entries", "UniqueEntries")
  
  # Bind the train and test data in order to normalize them between [0,1]
  bindedData = rbind(trainData,testData)
  dataForScale = data.frame(Avg_Speed = bindedData$Mean_speed,
                            Entries = bindedData$Entries,Stdev_speed = bindedData$Stdev_speed,
                            Skewness_speed = bindedData$Skewness_speed,Kurtosis_speed = bindedData$Kurtosis_speed)
  
  preProc = preProcess(dataForScale,method = "range")
  MinMaxFromScaling = preProc$ranges[,1]
  DataScaled = predict(preProc,dataForScale)
  
  # Split back the normalized data in train and test set
  trainDataScaled = DataScaled[1:nrow(trainData),]
  testDataScaled = DataScaled[(nrow(trainData) + 1):nrow(DataScaled),]
  
  # Apply principal component analysis in the correlation data frame. Extract the 
  # PC's that explain the 95% of the variability and then normalized then between [0,1]
  #correlation = DataList[[4]]
  #preProc2 = preProcess(correlation,method = "pca")
  #pcaCor = predict(preProc2,correlation)
  #pcaVector = as.data.frame(as.vector(pcaCor))
  #preProc3 = preProcess(pcaVector,method = "range")
  #pcaScaled = predict(preProc3,pcaVector)
  #pca = matrix(data.matrix(pcaScaled),nrow = nrow(pcaCor),ncol = ncol(pcaCor))
  
  # Create the trainset
  #trainset <- as.data.frame(pca)
  trainset <- as.data.frame(matrix(data=0, nrow = length(unique(trainData$Link_id))))  
  #for (i in 1:ncol(trainset)) colnames(trainset)[i]=paste0("m",i)
  #rownames(trainset) <- rownames(correlation)
  rownames(trainset) <- unique(trainData$Link_id)
  colnames(trainset) <- "avgSpeed_Current"
  # Insert values in AvgSpeed and Entries columns
  i<-1
  for(k in 1:nrow(trainset))
  {
    
    trainset$avgSpeed_105[k] <- trainDataScaled$Avg_Speed[i]
    trainset$avgSpeed_90[k] <- trainDataScaled$Avg_Speed[i+1]
    trainset$avgSpeed_75[k] <- trainDataScaled$Avg_Speed[i+2]
    trainset$avgSpeed_60[k] <- trainDataScaled$Avg_Speed[i+3]
    trainset$avgSpeed_45[k] <- trainDataScaled$Avg_Speed[i+4]
    trainset$avgSpeed_30[k] <- trainDataScaled$Avg_Speed[i+5]
    trainset$avgSpeed_15[k] <- trainDataScaled$Avg_Speed[i+6]
    trainset$avgSpeed_Current[k] <- trainDataScaled$Avg_Speed[i+7]
    
    trainset$entries_105[k] <- trainDataScaled$Entries[i]
    trainset$entries_90[k] <- trainDataScaled$Entries[i+1]
    trainset$entries_75[k] <- trainDataScaled$Entries[i+2]
    trainset$entries_60[k] <- trainDataScaled$Entries[i+3]
    trainset$entries_45[k] <- trainDataScaled$Entries[i+4]
    trainset$entries_30[k] <- trainDataScaled$Entries[i+5]
    trainset$entries_15[k] <- trainDataScaled$Entries[i+6]
    trainset$entries_Current[k] <- trainDataScaled$Entries[i+7]
    
    trainset$Stdev_speed_105[k] <- trainDataScaled$Stdev_speed[i]
    trainset$Stdev_speed_90[k] <- trainDataScaled$Stdev_speed[i+1]
    trainset$Stdev_speed_75[k] <- trainDataScaled$Stdev_speed[i+2]
    trainset$Stdev_speed_60[k] <- trainDataScaled$Stdev_speed[i+3]
    trainset$Stdev_speed_45[k] <- trainDataScaled$Stdev_speed[i+4]
    trainset$Stdev_speed_30[k] <- trainDataScaled$Stdev_speed[i+5]
    trainset$Stdev_speed_15[k] <- trainDataScaled$Stdev_speed[i+6]
    trainset$Stdev_speed_Current[k] <- trainDataScaled$Stdev_speed[i+7]
    
    trainset$Skewness_speed_105[k] <- trainDataScaled$Skewness_speed[i]
    trainset$Skewness_speed_90[k] <- trainDataScaled$Skewness_speed[i+1]
    trainset$Skewness_speed_75[k] <- trainDataScaled$Skewness_speed[i+2]
    trainset$Skewness_speed_60[k] <- trainDataScaled$Skewness_speed[i+3]
    trainset$Skewness_speed_45[k] <- trainDataScaled$Skewness_speed[i+4]
    trainset$Skewness_speed_30[k] <- trainDataScaled$Skewness_speed[i+5]
    trainset$Skewness_speed_15[k] <- trainDataScaled$Skewness_speed[i+6]
    trainset$Skewness_speed_Current[k] <- trainDataScaled$Skewness_speed[i+7]
    
    trainset$Kurtosis_speed_105[k] <- trainDataScaled$Kurtosis_speed[i]
    trainset$Kurtosis_speed_90[k] <- trainDataScaled$Kurtosis_speed[i+1]
    trainset$Kurtosis_speed_75[k] <- trainDataScaled$Kurtosis_speed[i+2]
    trainset$Kurtosis_speed_60[k] <- trainDataScaled$Kurtosis_speed[i+3]
    trainset$Kurtosis_speed_45[k] <- trainDataScaled$Kurtosis_speed[i+4]
    trainset$Kurtosis_speed_30[k] <- trainDataScaled$Kurtosis_speed[i+5]
    trainset$Kurtosis_speed_15[k] <- trainDataScaled$Kurtosis_speed[i+6]
    trainset$Kurtosis_speed_Current[k] <- trainDataScaled$Kurtosis_speed[i+7]
    
    i <- i+8
  }
  
  # Create the trainset
  #testset <- as.data.frame(pca)
  #for (i in 1:ncol(testset)) colnames(testset)[i]=paste0("m",i)
  #rownames(testset) <- rownames(correlation)
  
  testset <- as.data.frame(matrix(data=0, nrow = length(unique(testData$Link_id))))  
  #for (i in 1:ncol(trainset)) colnames(trainset)[i]=paste0("m",i)
  #rownames(trainset) <- rownames(correlation)
  rownames(testset) <- unique(testData$Link_id)
  colnames(testset) <- "avgSpeed_Current"
  
  # Insert values in AvgSpeed and Entries columns
  i<-1
  for(k in 1:nrow(testset))
  {
    
    testset$avgSpeed_105[k] <- testDataScaled$Avg_Speed[i]
    testset$avgSpeed_90[k] <- testDataScaled$Avg_Speed[i+1]
    testset$avgSpeed_75[k] <- testDataScaled$Avg_Speed[i+2]
    testset$avgSpeed_60[k] <- testDataScaled$Avg_Speed[i+3]
    testset$avgSpeed_45[k] <- testDataScaled$Avg_Speed[i+4]
    testset$avgSpeed_30[k] <- testDataScaled$Avg_Speed[i+5]
    testset$avgSpeed_15[k] <- testDataScaled$Avg_Speed[i+6]
    testset$avgSpeed_Current[k] <- testDataScaled$Avg_Speed[i+7]
    
    testset$entries_105[k] <- testDataScaled$Entries[i]
    testset$entries_90[k] <- testDataScaled$Entries[i+1]
    testset$entries_75[k] <- testDataScaled$Entries[i+2]
    testset$entries_60[k] <- testDataScaled$Entries[i+3]
    testset$entries_45[k] <- testDataScaled$Entries[i+4]
    testset$entries_30[k] <- testDataScaled$Entries[i+5]
    testset$entries_15[k] <- testDataScaled$Entries[i+6]
    testset$entries_Current[k] <- testDataScaled$Entries[i+7]
    
    testset$Stdev_speed_105[k] <- testDataScaled$Stdev_speed[i]
    testset$Stdev_speed_90[k] <- testDataScaled$Stdev_speed[i+1]
    testset$Stdev_speed_75[k] <- testDataScaled$Stdev_speed[i+2]
    testset$Stdev_speed_60[k] <- testDataScaled$Stdev_speed[i+3]
    testset$Stdev_speed_45[k] <- testDataScaled$Stdev_speed[i+4]
    testset$Stdev_speed_30[k] <- testDataScaled$Stdev_speed[i+5]
    testset$Stdev_speed_15[k] <- testDataScaled$Stdev_speed[i+6]
    testset$Stdev_speed_Current[k] <- testDataScaled$Stdev_speed[i+7]
    
    testset$Skewness_speed_105[k] <- testDataScaled$Skewness_speed[i]
    testset$Skewness_speed_90[k] <- testDataScaled$Skewness_speed[i+1]
    testset$Skewness_speed_75[k] <- testDataScaled$Skewness_speed[i+2]
    testset$Skewness_speed_60[k] <- testDataScaled$Skewness_speed[i+3]
    testset$Skewness_speed_45[k] <- testDataScaled$Skewness_speed[i+4]
    testset$Skewness_speed_30[k] <- testDataScaled$Skewness_speed[i+5]
    testset$Skewness_speed_15[k] <- testDataScaled$Skewness_speed[i+6]
    testset$Skewness_speed_Current[k] <- testDataScaled$Skewness_speed[i+7]
    
    testset$Kurtosis_speed_105[k] <- testDataScaled$Kurtosis_speed[i]
    testset$Kurtosis_speed_90[k] <- testDataScaled$Kurtosis_speed[i+1]
    testset$Kurtosis_speed_75[k] <- testDataScaled$Kurtosis_speed[i+2]
    testset$Kurtosis_speed_60[k] <- testDataScaled$Kurtosis_speed[i+3]
    testset$Kurtosis_speed_45[k] <- testDataScaled$Kurtosis_speed[i+4]
    testset$Kurtosis_speed_30[k] <- testDataScaled$Kurtosis_speed[i+5]
    testset$Kurtosis_speed_15[k] <- testDataScaled$Kurtosis_speed[i+6]
    testset$Kurtosis_speed_Current[k] <- testDataScaled$Kurtosis_speed[i+7]
    
    i <- i+8
  }
  
  List = list(trainset = trainset, testset = testset, MinMaxFromScaling = MinMaxFromScaling)
  
  return(List)
}
