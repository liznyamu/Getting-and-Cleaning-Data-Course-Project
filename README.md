# Getting and Cleaning Data Course Project

## Course Project Instructions :
You should create one R script called run_analysis.R that does the following. 
1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names. 
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps to Clean Data
1) Download the ```run_analysis.R``` and place it under your working directory on Rstudio
2) Run the ```run_analysis.R```
  > ```source("run_analysis.R")```
  - the output file ```tidy_data.txt``` will be created on your working directory
  
## Dependecies 
The ```run_analysis.R``` requires ```dpylr``` package . Install the package as: 
  > ```install.packages("dpylr")```
