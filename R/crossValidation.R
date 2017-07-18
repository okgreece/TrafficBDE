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
#' @return The trained model
#' 
#' @seealso \code{\link{Train}}
#' 
#' @rdname crossValidation
#' 
#' @import
#' @export

crossValidation <- function (trainset, k, f, hidden, linear)
{
  yourData=trainset
  #Randomly shuffle the data
  yourData<-yourData[sample(nrow(yourData)),]
  
  #Create10equallysizefolds
  folds<-cut(seq(1,nrow(yourData)),breaks=k,labels=FALSE)
  
  #Perform fold cross validation
  for(i in 1:k){
    
    testIndexes<-which(folds==i,arr.ind=TRUE)
    testData<-yourData[testIndexes,]
    trainData<-yourData[-testIndexes,]
    
    nn<-neuralnet::neuralnet(f, trainData, hidden = as.numeric(hidden),
                             rep = 10, err.fct = "sse", linear.output = linear)
  }
  
  return(nn)
}