#### Train
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
  f <- as.formula(paste("avgSpeed_Current ~", paste(n[!n %in% "avgSpeed_Current"], collapse = " + ")))
  # training phase and CV
  print("Training...")
  fitControl = trainControl(method = "cv",verboseIter = T,seeds = mySeeds) 
  NNgrid = expand.grid(layer1 = c(4,5,6,7,8,9,10),layer2 = c(3,4,5,6),layer3 = 0)
  NNOut = train(f, data = trainset,method = "neuralnet", 
                trControl = fitControl, tuneGrid = NNgrid, linear.output = TRUE)
  
  #NNOut = neuralnet(f,data = trainset, hidden = c(6,6), 
  #                  linear.output = TRUE,stepmax = 1e+08)
  
  
  print("Training Completed.")
  
  EndTime = Sys.time()
  TimeTaken = EndTime - StartTime
  print(paste("Time taken for training: ",TimeTaken,""))
  
  return(NNOut)
}
