#' @title 
#' Train
#'  
#' @description
#' This function trains the model.
#' 
#' @usage Train(trainset, predict, k, linear)
#' 
#' @param trainset The set to perfom the k fold cross validation
#' @param predict The element to be predicted
#' @param k The number of folds
#' @param linear logical. If it's TRUE the output will be linear
#'  
#' @details 
#' This function trains the model.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis
#' 
#' @return The model trained
#' 
#' @seealso
#' 
#' @rdname Train
#' 
#' @import
#' @export

Train <- function(trainset, predict, k, linear){
  
  # Check if the inputs are correct
  stopifnot(any(is.numeric(k) | is.logical(linear) | any(colnames(trainset) == predict)) == T)
  
  trainset = trainset
  
  # Setting seeds to reproduce the examples
  mySeeds = as.list(numeric(0))
  set.seed(1)
  for(i in 1:11){ 
    mySeeds[i] = list(sample(100,28))
  }
  
  StartTime = Sys.time() 
  
  n = names(trainset)
  
  if (predict == "Mean_speed"){
    f <- as.formula(paste("Mean_speed ~", paste(n[!n %in% "Mean_speed"], collapse = " + ")))
  }else{
    f <- as.formula(paste("Entries ~", paste(n[!n %in% "Entries"], collapse = " + ")))
  }
  
  # training phase and CV
  NNgrid = expand.grid(layer1 = c(3,4,5),layer2 = c(3,4,5),layer3 = c(3,4,5))
  
  for (j in 1:nrow(NNgrid)){
    
    NNout <- crossValidation(trainset, k, f, NNgrid[j,], linear)
    
  }
  
  print("Training Completed.")
  
  EndTime = Sys.time()
  TimeTaken = EndTime - StartTime
  print(paste("Time taken for training: ",TimeTaken,""))
  
  return(NNOut)
}
