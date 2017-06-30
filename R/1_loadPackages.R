loadPackages <- function() {  
  
  # Install Packages
  if("parallel" %in% rownames(installed.packages()) == FALSE) {install.packages("parallel")}
  if("doParallel" %in% rownames(installed.packages()) == FALSE) {install.packages("doParallel")}
  if("lubridate" %in% rownames(installed.packages()) == FALSE) {install.packages("lubridate")}
  if("data.table" %in% rownames(installed.packages()) == FALSE) {install.packages("data.table")}
  if("plyr" %in% rownames(installed.packages()) == FALSE) {install.packages("plyr")}
  if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")}
  if("caret" %in% rownames(installed.packages()) == FALSE) {install.packages("caret")}
  if("neuralnet" %in% rownames(installed.packages()) == FALSE) {install.packages("neuralnet")}
  if("readr" %in% rownames(installed.packages()) == FALSE) {install.packages("readr")}
  if("imputeTS" %in% rownames(installed.packages()) == FALSE) {install.packages("imputeTS")}
  
  # Load packages
  library(parallel)
  library(doParallel)
  library(lubridate)
  library(data.table)
  library(plyr)
  library(dplyr)
  library(caret)
  library(neuralnet)
  library(readr)
  library(imputeTS)
  
  print("Libraries loaded.") 
}
