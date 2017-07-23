#' @title 
#' Train
#'  
#' @description
#' This function trains the model.
#' 
#' @usage TrainCR(List)
#' 
#' @param List A list with the following components: trainset, testset, MinMaxFromScaling
#'  
#' @details 
#' This function returns the trained model.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis
#' 
#' @return The train model
#' 
#' @seealso \code{\link{5_PreProcessing}}
#' 
#' @rdname TrainCR
#' 
#' @import
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
  f <- as.formula(paste(predict, paste("~"), paste(n[!n %in% predict], collapse = " + ")))
  
  # training phase
  print("Training...")
  fitControl = caret::trainControl(method = "cv",verboseIter = T,seeds = mySeeds) 
  NNgrid = expand.grid(layer1 = c(5,6,7,8,9),layer2 = c(0),layer3 = c(0))
  
  NNOut = caret::train(f, data = trainset,method = "neuralnet", 
                trControl = fitControl, tuneGrid = NNgrid, linear.output = TRUE,
                na.action = na.exclude)
  
  
  print("Training Completed.")
  
  EndTime = Sys.time()
  TimeTaken = EndTime - StartTime
  print(paste("Time taken for training: ",TimeTaken,""))
  
  return(NNOut)
}
