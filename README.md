TrafficBDE <img src="okfgr.png" align="right" />
================
Aikaterini Chatzopoulou
July 27, 2017

[![Build Status](https://travis-ci.org/okgreece/TrafficBDE.svg?branch=master)](https://travis-ci.org/okgreece/TrafficBDE) [![Pending Pull-Requests](http://githubbadges.herokuapp.com/okgreece/TrafficBDE/pulls.svg)](https://github.com/okgreece/TrafficBDE/pulls) [![Github Issues](http://githubbadges.herokuapp.com/okgreece/TrafficBDE/issues.svg)](https://github.com/okgreece/TrafficBDE/issues) [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) [![packageversion](https://img.shields.io/badge/Package%20version-0.0.0.9000-orange.svg?style=flat-square)](commits/master) [![Licence](https://img.shields.io/badge/licence-GPL--2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.html) [![minimal R version](https://img.shields.io/badge/R%3E%3D-3.1-6666ff.svg)](https://cran.r-project.org/)

Intoduction
===========

This package was created in order to enable the creation of a neural network model, for the needs of a European project. “TrafficBDE” includes functions for properly formulating the data, training the neural network and predicted the wanted variable. This document introduces you to TrafficBDE's basic set of tools.

The user should use only the `loadData` and the `kStepsForward` functions. The first one to load the historical data and the second for the computation of the predicted value.

Install Package
===============

In order to install TrafficBDE, you should use the following code.

    install.packages("devtools")
    devtools::install_github("okgreece/TrafficBDE")

Input
-----

The input dataset of the main function could be a link, a csv, an excel file. There are different parameters that a user could specify and interact with the results. The parameters: "path", "Link\_id", "direction", "datetime", "predict" and "steps" should be defined by the user, to form the dataset. Then an automated process formulates the data in order to provide the prediction of the wanted variable for the desired time and road.

<table>
<caption>A sort description about the inputs.</caption>
<colgroup>
<col width="13%" />
<col width="86%" />
</colgroup>
<thead>
<tr class="header">
<th>Input</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>path</p></td>
<td><p>The path containing the historical data</p></td>
</tr>
<tr class="even">
<td><p>Link_id</p></td>
<td><p>The Link_id of the road</p></td>
</tr>
<tr class="odd">
<td><p>dimension</p></td>
<td><p>The dimension of the road</p></td>
</tr>
<tr class="even">
<td><p>datetime</p></td>
<td><p>The date time for the pediction. The format of the datetime should be '%Y-%m-%d %H:%M:%S'</p></td>
</tr>
<tr class="odd">
<td><p>predict</p></td>
<td><p>The argument to be predicted, appropriate values: &quot;Mean_speed&quot;, &quot;Entries&quot;, &quot;Stdev_speed&quot;</p></td>
</tr>
<tr class="even">
<td><p>steps</p></td>
<td><p>How many steps forward the prediction will be</p></td>
</tr>
</tbody>
</table>

Output
------

The output of this process is a matrix with the predicted and real values and the RMSE. The rows are equal to the steps.

Examples
--------

Simple examples the `kStepsForward` function are provided, in order for the user to understand the use and how to deal with these function.

The sample of the dataset that is being used is available in TrafficBDE package and represents the traffic fload of the road with Link\_id: "163204843", for January 2017.

For another data set to be load run the function `loadData(path)` instead of the lines 74-75.

The first example provides, in one step, the prediction of the Mean speed at 14.00 on 27 Jan. 2017

``` r
library(TrafficBDE)
Data <- data.table::fread("D:/packages/okgreece/TrafficBDE/data/163204843_1.csv")
Data <- as.data.frame(Data[,-1])


kStepsForward(Data = Data, Link_id = "163204843", direction = "1", datetime = "2017-01-27 14:00:00", predict = "Mean_speed", steps = 1)
```

    ## [1] "Training..."

    ## Loading required package: neuralnet

    ## Loading required package: lattice

    ## Loading required package: ggplot2

    ## + Fold01: layer1=4, layer2=3, layer3=4 
    ## - Fold01: layer1=4, layer2=3, layer3=4 
    ## + Fold01: layer1=5, layer2=3, layer3=4 
    ## - Fold01: layer1=5, layer2=3, layer3=4 
    ## + Fold01: layer1=4, layer2=4, layer3=4 
    ## - Fold01: layer1=4, layer2=4, layer3=4 
    ## + Fold01: layer1=5, layer2=4, layer3=4 
    ## - Fold01: layer1=5, layer2=4, layer3=4 
    ## + Fold02: layer1=4, layer2=3, layer3=4 
    ## - Fold02: layer1=4, layer2=3, layer3=4 
    ## + Fold02: layer1=5, layer2=3, layer3=4 
    ## - Fold02: layer1=5, layer2=3, layer3=4 
    ## + Fold02: layer1=4, layer2=4, layer3=4 
    ## - Fold02: layer1=4, layer2=4, layer3=4 
    ## + Fold02: layer1=5, layer2=4, layer3=4 
    ## - Fold02: layer1=5, layer2=4, layer3=4 
    ## + Fold03: layer1=4, layer2=3, layer3=4 
    ## - Fold03: layer1=4, layer2=3, layer3=4 
    ## + Fold03: layer1=5, layer2=3, layer3=4 
    ## - Fold03: layer1=5, layer2=3, layer3=4 
    ## + Fold03: layer1=4, layer2=4, layer3=4 
    ## - Fold03: layer1=4, layer2=4, layer3=4 
    ## + Fold03: layer1=5, layer2=4, layer3=4 
    ## - Fold03: layer1=5, layer2=4, layer3=4 
    ## + Fold04: layer1=4, layer2=3, layer3=4 
    ## - Fold04: layer1=4, layer2=3, layer3=4 
    ## + Fold04: layer1=5, layer2=3, layer3=4 
    ## - Fold04: layer1=5, layer2=3, layer3=4 
    ## + Fold04: layer1=4, layer2=4, layer3=4 
    ## - Fold04: layer1=4, layer2=4, layer3=4 
    ## + Fold04: layer1=5, layer2=4, layer3=4 
    ## - Fold04: layer1=5, layer2=4, layer3=4 
    ## + Fold05: layer1=4, layer2=3, layer3=4 
    ## - Fold05: layer1=4, layer2=3, layer3=4 
    ## + Fold05: layer1=5, layer2=3, layer3=4 
    ## - Fold05: layer1=5, layer2=3, layer3=4 
    ## + Fold05: layer1=4, layer2=4, layer3=4 
    ## - Fold05: layer1=4, layer2=4, layer3=4 
    ## + Fold05: layer1=5, layer2=4, layer3=4 
    ## - Fold05: layer1=5, layer2=4, layer3=4 
    ## + Fold06: layer1=4, layer2=3, layer3=4 
    ## - Fold06: layer1=4, layer2=3, layer3=4 
    ## + Fold06: layer1=5, layer2=3, layer3=4 
    ## - Fold06: layer1=5, layer2=3, layer3=4 
    ## + Fold06: layer1=4, layer2=4, layer3=4 
    ## - Fold06: layer1=4, layer2=4, layer3=4 
    ## + Fold06: layer1=5, layer2=4, layer3=4 
    ## - Fold06: layer1=5, layer2=4, layer3=4 
    ## + Fold07: layer1=4, layer2=3, layer3=4 
    ## - Fold07: layer1=4, layer2=3, layer3=4 
    ## + Fold07: layer1=5, layer2=3, layer3=4 
    ## - Fold07: layer1=5, layer2=3, layer3=4 
    ## + Fold07: layer1=4, layer2=4, layer3=4 
    ## - Fold07: layer1=4, layer2=4, layer3=4 
    ## + Fold07: layer1=5, layer2=4, layer3=4 
    ## - Fold07: layer1=5, layer2=4, layer3=4 
    ## + Fold08: layer1=4, layer2=3, layer3=4 
    ## - Fold08: layer1=4, layer2=3, layer3=4 
    ## + Fold08: layer1=5, layer2=3, layer3=4 
    ## - Fold08: layer1=5, layer2=3, layer3=4 
    ## + Fold08: layer1=4, layer2=4, layer3=4 
    ## - Fold08: layer1=4, layer2=4, layer3=4 
    ## + Fold08: layer1=5, layer2=4, layer3=4 
    ## - Fold08: layer1=5, layer2=4, layer3=4 
    ## + Fold09: layer1=4, layer2=3, layer3=4 
    ## - Fold09: layer1=4, layer2=3, layer3=4 
    ## + Fold09: layer1=5, layer2=3, layer3=4 
    ## - Fold09: layer1=5, layer2=3, layer3=4 
    ## + Fold09: layer1=4, layer2=4, layer3=4 
    ## - Fold09: layer1=4, layer2=4, layer3=4 
    ## + Fold09: layer1=5, layer2=4, layer3=4 
    ## - Fold09: layer1=5, layer2=4, layer3=4 
    ## + Fold10: layer1=4, layer2=3, layer3=4 
    ## - Fold10: layer1=4, layer2=3, layer3=4 
    ## + Fold10: layer1=5, layer2=3, layer3=4 
    ## - Fold10: layer1=5, layer2=3, layer3=4 
    ## + Fold10: layer1=4, layer2=4, layer3=4 
    ## - Fold10: layer1=4, layer2=4, layer3=4 
    ## + Fold10: layer1=5, layer2=4, layer3=4 
    ## - Fold10: layer1=5, layer2=4, layer3=4 
    ## Aggregating results
    ## Selecting tuning parameters
    ## Fitting layer1 = 4, layer2 = 4, layer3 = 4 on full training set
    ## [1] "Training Completed."
    ## [1] "Time taken for training:  2.70883105198542 "
    ## [1] "Predicting Average Speed for the Next Quarter..."
    ## [1] "RMSE error 10.3615078681489 "

    ##                       Predicted Real Value        RMSE
    ## 2017-01-27 14:00:00 39.36150787         29 10.36150787

The second example provides, in one step, the prediction of the Entries at 20.00 on 15 Jan. 2017

    ## [1] "Training..."
    ## + Fold01: layer1=4, layer2=3, layer3=4 
    ## - Fold01: layer1=4, layer2=3, layer3=4 
    ## + Fold01: layer1=5, layer2=3, layer3=4 
    ## - Fold01: layer1=5, layer2=3, layer3=4 
    ## + Fold01: layer1=4, layer2=4, layer3=4 
    ## - Fold01: layer1=4, layer2=4, layer3=4 
    ## + Fold01: layer1=5, layer2=4, layer3=4 
    ## - Fold01: layer1=5, layer2=4, layer3=4 
    ## + Fold02: layer1=4, layer2=3, layer3=4 
    ## - Fold02: layer1=4, layer2=3, layer3=4 
    ## + Fold02: layer1=5, layer2=3, layer3=4 
    ## - Fold02: layer1=5, layer2=3, layer3=4 
    ## + Fold02: layer1=4, layer2=4, layer3=4 
    ## - Fold02: layer1=4, layer2=4, layer3=4 
    ## + Fold02: layer1=5, layer2=4, layer3=4 
    ## - Fold02: layer1=5, layer2=4, layer3=4 
    ## + Fold03: layer1=4, layer2=3, layer3=4 
    ## - Fold03: layer1=4, layer2=3, layer3=4 
    ## + Fold03: layer1=5, layer2=3, layer3=4 
    ## - Fold03: layer1=5, layer2=3, layer3=4 
    ## + Fold03: layer1=4, layer2=4, layer3=4 
    ## - Fold03: layer1=4, layer2=4, layer3=4 
    ## + Fold03: layer1=5, layer2=4, layer3=4 
    ## - Fold03: layer1=5, layer2=4, layer3=4 
    ## + Fold04: layer1=4, layer2=3, layer3=4 
    ## - Fold04: layer1=4, layer2=3, layer3=4 
    ## + Fold04: layer1=5, layer2=3, layer3=4 
    ## - Fold04: layer1=5, layer2=3, layer3=4 
    ## + Fold04: layer1=4, layer2=4, layer3=4 
    ## - Fold04: layer1=4, layer2=4, layer3=4 
    ## + Fold04: layer1=5, layer2=4, layer3=4 
    ## - Fold04: layer1=5, layer2=4, layer3=4 
    ## + Fold05: layer1=4, layer2=3, layer3=4 
    ## - Fold05: layer1=4, layer2=3, layer3=4 
    ## + Fold05: layer1=5, layer2=3, layer3=4 
    ## - Fold05: layer1=5, layer2=3, layer3=4 
    ## + Fold05: layer1=4, layer2=4, layer3=4 
    ## - Fold05: layer1=4, layer2=4, layer3=4 
    ## + Fold05: layer1=5, layer2=4, layer3=4 
    ## - Fold05: layer1=5, layer2=4, layer3=4 
    ## + Fold06: layer1=4, layer2=3, layer3=4 
    ## - Fold06: layer1=4, layer2=3, layer3=4 
    ## + Fold06: layer1=5, layer2=3, layer3=4 
    ## - Fold06: layer1=5, layer2=3, layer3=4 
    ## + Fold06: layer1=4, layer2=4, layer3=4 
    ## - Fold06: layer1=4, layer2=4, layer3=4 
    ## + Fold06: layer1=5, layer2=4, layer3=4 
    ## - Fold06: layer1=5, layer2=4, layer3=4 
    ## + Fold07: layer1=4, layer2=3, layer3=4 
    ## - Fold07: layer1=4, layer2=3, layer3=4 
    ## + Fold07: layer1=5, layer2=3, layer3=4 
    ## - Fold07: layer1=5, layer2=3, layer3=4 
    ## + Fold07: layer1=4, layer2=4, layer3=4 
    ## - Fold07: layer1=4, layer2=4, layer3=4 
    ## + Fold07: layer1=5, layer2=4, layer3=4 
    ## - Fold07: layer1=5, layer2=4, layer3=4 
    ## + Fold08: layer1=4, layer2=3, layer3=4 
    ## - Fold08: layer1=4, layer2=3, layer3=4 
    ## + Fold08: layer1=5, layer2=3, layer3=4 
    ## - Fold08: layer1=5, layer2=3, layer3=4 
    ## + Fold08: layer1=4, layer2=4, layer3=4 
    ## - Fold08: layer1=4, layer2=4, layer3=4 
    ## + Fold08: layer1=5, layer2=4, layer3=4 
    ## - Fold08: layer1=5, layer2=4, layer3=4 
    ## + Fold09: layer1=4, layer2=3, layer3=4 
    ## - Fold09: layer1=4, layer2=3, layer3=4 
    ## + Fold09: layer1=5, layer2=3, layer3=4 
    ## - Fold09: layer1=5, layer2=3, layer3=4 
    ## + Fold09: layer1=4, layer2=4, layer3=4 
    ## - Fold09: layer1=4, layer2=4, layer3=4 
    ## + Fold09: layer1=5, layer2=4, layer3=4 
    ## - Fold09: layer1=5, layer2=4, layer3=4 
    ## + Fold10: layer1=4, layer2=3, layer3=4 
    ## - Fold10: layer1=4, layer2=3, layer3=4 
    ## + Fold10: layer1=5, layer2=3, layer3=4 
    ## - Fold10: layer1=5, layer2=3, layer3=4 
    ## + Fold10: layer1=4, layer2=4, layer3=4 
    ## - Fold10: layer1=4, layer2=4, layer3=4 
    ## + Fold10: layer1=5, layer2=4, layer3=4 
    ## - Fold10: layer1=5, layer2=4, layer3=4 
    ## Aggregating results
    ## Selecting tuning parameters
    ## Fitting layer1 = 5, layer2 = 4, layer3 = 4 on full training set
    ## [1] "Training Completed."
    ## [1] "Time taken for training:  1.62528608242671 "
    ## [1] "Predicting Average Speed for the Next Quarter..."
    ## [1] "RMSE error 0.0110939034959423 "

    ##                       Predicted Real Value         RMSE
    ## 2017-01-15 20:00:00 1.011093903          1 0.0110939035

Github:
=======

-   <https://github.com/okgreece/TrafficBDE> <img src="okfgr.png" align="right" />
