#' @title 
#' Train
#'  
#' @description
#' This function trains the model.
#' 
#' @usage TrainCR(List,predict)
#' 
#' @param List A list with the following components: trainset, testset, Min, Max
#' @param predict The value to be predicted
#'  
#' @details 
#' This function returns the trained model.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis
#' 
#' @return The train model
#' 
#' @seealso \code{\link{PreProcessingLink}}
#' 
#' @rdname TrainCR
#' 
#' @examples 
#' \dontrun{
#' SpecLink <- loadDataSpecLink("163204843","1", X163204843_1)
#' x <- fillMissingValues(SpecLink)
#' datetime <- "2017-01-27 14:00:00" 
#' newData <- fillMissingDates (x, datetime)
#' DataList <- loadTrainTest (newData, datetime, "Mean_speed")
#' List <- PreProcessingLink(DataList)
#' NNout <- TrainCR (List,"Mean_speed")}
#' 
#' @importFrom caret trainControl
#' @importFrom caret train
#' @export

TrainCR <-function(List, predict){
  
  trainset = List[[1]]
  stopifnot(any(colnames(trainset) == predict) == T)
  
  # Setting seeds to reproduce the examples
  mySeeds = as.list(numeric(0))
  set.seed(1)
  for(i in 1:11){ 
    mySeeds[i] = list(sample(100,28))
  }
  
  StartTime = Sys.time() 
  
  n = names(trainset)
  f <- stats::as.formula(paste(predict, paste("~"), paste(n[!n %in% predict], collapse = " + ")))
  
  # training phase
  cat("Training...\n")
  fitControl = caret::trainControl(method = "cv",verboseIter = T,seeds = mySeeds) 
  NNgrid = expand.grid(layer1 = c(4,5),layer2 = c(3,4),layer3 = c(4))
  
  NNOut = caret::train(f, data = trainset,method = "neuralnet", 
                       trControl = fitControl, tuneGrid = NNgrid, linear.output = TRUE,
                       na.action = stats::na.exclude)
  
  
  cat("Training Completed.\n")
  
  EndTime = Sys.time()
  TimeTaken = EndTime - StartTime
  cat("\nTime taken for training: ",TimeTaken)
  
  return(NNOut)
}
