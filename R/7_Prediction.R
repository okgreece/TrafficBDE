#' @title 
#' Prediction
#'  
#' @description
#' This function predicts the average speed of the road.
#' 
#' @usage PredictionCR(List,NNOut)
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
#' @rdname PredictionCR
#' 
#' @import
#' @export

PredictionCR <- function(List,NNOut,predict){
  print("Predicting Average Speed for the Next Quarter...")
  # Prediction phase
  Min = List[[3]]
  Max = List[[4]]

  testset = List[[2]]
  
  llll=list()
  for(i in 1:8)  eval(parse(text=paste("llll[[",i,"]]=(testset[,",i,"] - Min[",i,"])/(Max[",i,"] - Min[",i,"] )")))
  
  
  a=as.data.frame(t(unlist(llll)))
  names(a)=c("Min_speed", "Max_speed", "Mean_speed", 
             "Stdev_speed", "Skewness_speed", "Kurtosis_speed", "Entries", "UniqueEntries")
  
  NNOut.predict = predict(NNOut,a[,-3])
  
  Min = List[[3]][names(List[[3]])==predict]
  Max = List[[4]][names(List[[4]])==predict]
  # Denormalize values and calculate the RMSE
  Predictions = NNOut.predict*(Max - Min) + Min

  Observations = testset$Mean_speed
  
  NNOut.predict = as.data.frame(NNOut.predict)
  
  RMSE <- sqrt(mean((Observations - Predictions)^2))
  print(paste("RMSE error",RMSE,""))
  
  result = list(Predictions,Observations,RMSE)
  
  return(result)
}