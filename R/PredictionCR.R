#' @title 
#' Prediction
#'  
#' @description
#' This function predicts the average speed of the road.
#' 
#' @usage PredictionCR(List,NNOut,predict)
#' 
#' @param List A list with the following components: trainset, testset, MinMaxFromScaling
#' @param NNOut The train model
#' @param predict The value to be predicted
#'  
#' @details 
#' This function returns the predicted average speed.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis, Charalampos Bratsas
#' 
#' @return The predicted average speed of the road
#' 
#' @seealso \code{\link{PreProcessingLink}}, \code{\link{TrainCR}}
#' 
#' @rdname PredictionCR
#' 
#' @examples 
#' \dontrun{
#' SpecLink <- loadDataSpecLink("163204843","1", X163204843_1)
#' x <- fillMissingValues(SpecLink)
#' datetime <- "2017-01-27 14:00:00" 
#' newData <- fillMissingDates (x, datetime)
#' DataList <- loadTrainTest (newData, datetime, "Mean_speed")
#' List <- PreProcessingLink(DataList)
#' NNOut <- TrainCR (List,"Mean_speed")
#' predicted <- PredictionCR(List,NNOut,"Mean_speed")}
#' 
#' @export

PredictionCR <- function(List,NNOut,predict){
  cat("\nPredicting",predict,"for the Next Quarter...\n")
  # Prediction phase
  Min = List[[3]]
  Max = List[[4]]
  
  testset = List[[2]]
  
  llll=list()
  for(i in 1:8)  eval(parse(text=paste("llll[[",i,"]]=(testset[,",i,"] - Min[",i,"])/(Max[",i,"] - Min[",i,"] )")))
  
  
  a=as.data.frame(t(unlist(llll)))
  names(a)=names(testset)
  
  a <- subset(a,select=colnames(a)[which(colnames(a)!=predict)])
  NNOut.predict = stats::predict(NNOut,a)
  
  Min = List[[3]][names(List[[3]])==predict]
  Max = List[[4]][names(List[[4]])==predict]
  # Denormalize values and calculate the RMSE
  Predictions = NNOut.predict*(Max - Min) + Min
  
  Observations = testset[,which(colnames(testset)==predict)]
  
  NNOut.predict = as.data.frame(NNOut.predict)
  
  RMSE <- sqrt(mean((Observations - Predictions)^2))
  
  result = as.numeric(c(Predictions,
                        Observations,
                        RMSE))
  
  return(result)
}