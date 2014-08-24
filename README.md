# README

This file describes the procedure of tidying course project data

## Obtain data
First check, whether there already is directory UCI HAR Dataset. If not, provided script run\_analysis.R checks if there is already downloaded the data archive. If not, run\_analysis.R downloads it. Then script unzips the archive in cwd.

## Load and check data
Data from

* X\_train
* y\_train
* subject\_train
* X\_test
* y\_test
* subject\_test

are loaded each into appropriate data.frame.
Also features.txt is loaded.

At this moment I have checked if there are some NAs and if the dimensions of these structures correspond - this was done only once manually, it is not contained in the script. Dimensions correspond and there are no NAs.

## Merge training and test sets
Script merges corresponding train and test values - X, y and subject separately by rbind function into data.frames

* mergedx
* mergedy
* mergedsubject

## Assign names to merged x from features
Use names stored in variable features to assign column names to data.frame mergedx

## Select only colums with "mean()" or "std()" in column description
According to objectives and structure of the features, we want to select only variables containing "mean()" or "std()" in the name. Function grep was used for this purpose to select appropriate column indices.

## Remove dashes and parentheses from names
For simpler and a little bit shorter variable names dashes and parentheses were removed from variable names

## Factor activities and replace numbers with descriptive activities names
Activity numers in variable mergedy were factorized and factors 1-6 were replaced by descriptive names.

## Merge all data into one data.frame
For easier data manipulation all numerical data, activities and subject numers were merged into one data.frame

## Calculate average for each activity and each subject
Average for each variable for each activity and subject was calculated using aggregate function - in the resulting data.frame "dataaver" every row contains averages of every variable for given activity and subject (described in first two columns).
There are more possible ways of arranging cleaned data, but this one is my favorite as it is well arranged and intuitive

## Write cleaned data into cleandata.txt in cwd
result is written into cleandata.txt - this file was uploaded on coursera.
.