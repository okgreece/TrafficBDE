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

Train <- function(List, predict, linear){
  
  # Check if the inputs are correct
 #stopifnot(any(is.numeric(k) | is.logical(linear) | any(colnames(trainset) == predict)) == T)
  
  trainset = List[[1]]
  Min = List[[3]][names(List[[3]])==predict]
  Max = List[[4]][names(List[[4]])==predict]
  
  # Setting seeds to reproduce the examples
  mySeeds = as.list(numeric(0))
  set.seed(1)
  for(i in 1:11){ 
    mySeeds[i] = list(sample(100,28))
  }
  
  StartTime = Sys.time() 
  
  n = names(trainset)
  
  f <- as.formula(paste(predict, paste("~"), paste(n[!n %in% predict], collapse = " + ")))
  
  # training phase and CV
  #NNgrid = expand.grid(layer1 = c(3,4,5),layer2 = c(3,4,5),layer3 = c(3,4,5))
  
  #for (j in 1:nrow(NNgrid)){
    
   # nn[[j]] <- crossValidation(trainset, k, f, NNgrid[j,], linear, Min, Max)
    
    #if(j>1)
    #{
     # if(mean(nn[[j]][[1]]) > mean(nn[[j-1]][[1]])){NNout = nn[[j-1]][[2]]}
    #}
    
  #}
  
  NNOut<-neuralnet::neuralnet(f, trainset, hidden = c(4,5,3),
                         rep = 10, err.fct = "sse", linear.output = linear)
  print("Training Completed.")
  
  EndTime = Sys.time()
  TimeTaken = EndTime - StartTime
  print(paste("Time taken for training: ",TimeTaken,""))
  
  return(NNOut)
}
