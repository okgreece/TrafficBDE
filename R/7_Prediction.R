#' @title 
#' Prediction
#'  
#' @description
#' This function predicts the average speed of the road.
#' 
#' @usage Prediction(List,NNOut)
#' 
#' @param List A list with the following components: trainset, testset, MinMaxFromScaling
#' @param NNout The train model
#'  
#' @details 
#' This function returns the predicted average speed.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis
#' 
#' @return The predicted average speed of the road
#' 
#' @seealso \code{\link{5_PreProcessing}}, \code{\link{6_Train}}
#' 
#' @rdname Prediction
#' 
#' @import
#' @export

Prediction <- function(List,NNOut){
  print("Predicting Average Speed for the Next Quarter...")
  # Prediction phase
  #subset(testset, select=-c(avgSpeed_Current))
  
  testset = List[[2]]
  MinMaxFromScaling = List[[3]]
  
  #testset = testset[,-c(15,23,31,39,47)]
  #testset = testset[,-c(15)]
  NNOut.predict = predict(NNOut,subset(testset, select=-c(avgSpeed_Current)))
  
  Max = max(MinMaxFromScaling)
  Min = min(MinMaxFromScaling)
  
  # Denormalize values and calculate the RMSE
  Predictions = NNOut.predict*(Max - Min) + Min
  Observations = testset$avgSpeed_Current*(Max - Min) + Min
  RMSE <- sqrt(mean((Observations - Predictions)^2))
  print(paste("RMSE error",RMSE,""))
  
  result = list(Predictions,Observations,RMSE)
  
  return(result)
}
