#' @title 
#' Train
#'  
#' @description
#' This function trains the model.
#' 
#' @usage Train(List)
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
#' @rdname Train
#' 
#' @import
#' @export

Train <-function(List){
  
  trainset = List[[1]]
  
  # Setting seeds to reproduce the examples
  mySeeds = as.list(numeric(0))
  set.seed(1)
  for(i in 1:11){ 
    mySeeds[i] = list(sample(100,28))
  }
  
  StartTime = Sys.time() 
  
  n = names(trainset)
  f <- as.formula(paste("Mean_speed ~", paste(n[!n %in% "Mean_speed"], collapse = " + ")))
  # training phase and CV
  print("Training...")
  fitControl = trainControl(method = "cv",verboseIter = T,seeds = mySeeds) 
  NNgrid = expand.grid(layer1 = c(3,4,5),layer2 = c(3,4,5),layer3 = c(3,4,5))
  
  NNOut = train(f, data = trainset,method = "neuralnet", 
                trControl = fitControl, tuneGrid = NNgrid, linear.output = TRUE,
                na.action = na.exclude)
  
  #qq=neuralnet(f,data=trainset,hidden=c(3,4,5),linear.output=T)
  #NNOut = neuralnet(f,data = trainset, hidden = c(6,6), 
  #                  linear.output = TRUE,stepmax = 1e+08)
  
  
  print("Training Completed.")
  
  EndTime = Sys.time()
  TimeTaken = EndTime - StartTime
  print(paste("Time taken for training: ",TimeTaken,""))
  
  return(NNOut)
}
