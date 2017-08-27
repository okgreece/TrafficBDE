#' @title 
#' k Steps Forward
#'  
#' @description
#' This function predictes the wanted value after k steps.
#' 
#' @usage kStepsForward (Data, Link_id, direction, datetime, predict, steps)
#' 
#' @param Data A data frame with the historical data
#' @param Link_id A character with the id of the road needed
#' @param direction The direction of the road
#' @param datetime The datetime wanted
#' @param predict The value to be predicted
#' @param steps The number of steps
#'  
#' @details 
#' This function returns the predicted value after k steps.
#' 
#' @author Aikaterini Chatzopoulou, Kleanthis Koupidis
#' 
#' @return The predicted value
#' 
#' @seealso \code{\link{loadData}}
#' 
#' @rdname kStepsForward
#' 
#' @importFrom lubridate minute
#' @export

kStepsForward <- function (Data, Link_id, direction, datetime, predict, steps){
  
  if ((predict %in% c("Mean_speed","Entries","Stdev_speed"))== F)
  {stop("Please specify another parameter\n",predict," is not an appropriate value")}
  
  DataLink <- loadDataSpecLink(Link_id, direction, Data)
  
  DataLinkNA <- fillMissingValues(DataLink)
  
  datetime <- as.POSIXct(strptime(datetime,'%Y-%m-%d %H:%M:%S',tz="Europe/Istanbul"))
  minutes <- lubridate::minute(datetime)
  
  Result = matrix(nrow = steps , ncol = 3,dimnames = list(c(1:steps),
                                                          c("Predicted", "Real Value", "RMSE")))
  
  for (i in 1:(steps)){
    dateSt <- stats::update(datetime , minutes = minutes -15*(steps-i))
    
    DataAll <- fillMissingDates(DataLinkNA, dateSt)
    
    DataList <- loadTrainTest(DataAll, dateSt, predict)
    
    List <- PreProcessingLink(DataList)
    
     # Load model for current link (if exists)
    print("Trying to load model...")  
    
    NNOut <- try(readRDS(file.path("models",paste("model_",Link_id,"_",direction,"_",predict,"_",i,".rds",sep=""))),silent = TRUE)
    
    if (class(NNOut) == "try-warning" || class(NNOut) == "try-error") {
      print("Could not find model. Will create it now...")  
      NNOut <- TrainCR(List, predict)    
      print("Saving model...")      
      # Throws error if cannot save model
      savNNOut <- try(saveRDS(NNOut,file.path("models",paste("model_",Link_id,"_",direction,"_",predict,"_",i,".rds",sep=""))), silent=TRUE)    
      if (class(savNNOut) == "try-warning" || class(savNNOut) == "try-error") {
        print("Could not save model.")  
      }    
      else{
        print("OK")  
      }      
    }
    else{
      print("OK");
    }
    
    
    Result[i,] <- PredictionCR(List,NNOut,predict)
    
    rownames(Result)[i] <- as.character(dateSt)
    
    DataLinkNA[which(DataLinkNA$Date == dateSt),which(colnames(DataLinkNA)==predict)] = Result[i,1] #next step
    
  }
  return(Result)
}
