#' @title 
#' Cross Validation
#'  
#' @description
#' This function performs k fold cross validation.
#' 
#' @usage crossValidation(trainset, k, f, hidden, linear)
#' 
#' @param trainset The set to perfom the k fold cross validation
#' @param k The number of folds
#' @param f The formula to train the model
#' @param hidden A vector with the number of nodes to each layer
#' @param linear logical. If it's TRUE the output will be linear
#'  
#' @details 
#' This function returns the trained model.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis
#' 
#' @return A list with the following components:
#' 
#' \itemize{
#' \item cv.error The cross validation error
#' \item nn The train model
#' }
#' 
#' @seealso \code{\link{Train}}
#' 
#' @rdname crossValidation
#' 
#' @import
#' @export

crossValidation <- function (trainset, k, f, hidden, linear, Min, Max) ### Consider add parameter for Scaling or not the input data
{
  # Check if the inputs are correct
  stopifnot(any(is.numeric(k) | is.logical(linear)) == T)
  
  data=trainset
  #Randomly shuffle the data
  data<-data[sample(nrow(data)),]
  
  #Create10equallysizefolds
  folds<-cut(seq(1,nrow(data)),breaks=k,labels=FALSE)
  
  
  cv.error=matrix(nrow = k,ncol = 1) # ncol = number of errors you want to calculate, e.g. if you want to calculate RMSE use ncol=1
  
  #Perform fold cross validation
  for(i in 1:k){
    
    
    testIndexes<-which(folds==i,arr.ind=TRUE)
    testData<-data[testIndexes,]
    trainData<-data[-testIndexes,]
    
    nn<-neuralnet::neuralnet(f, trainData, hidden = unname(unlist(hidden)),
                             rep = 10, err.fct = "sse", linear.output = linear)
    
    
    preds.scaled <- neuralnet::compute(nn, testData[,1:5])
    
    unscaled <- function(x){x*(Max - Min) + Min}
    
    Test.unscaled <- unscaled(testData)
    Predicted.unscaled <- unscaled(preds.scaled$net.result)
    
    cv.error[i,] = sqrt(mean((Test.unscaled$Mean_speed - Predicted.unscaled)^2))
  }
  
  nn <- list(cv.error,nn)
  return(nn) 
}
