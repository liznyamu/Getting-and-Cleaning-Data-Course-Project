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
The ```run_analysis.R``` requires ```dpylr``` package . Install the package as: ```install.packages("dpylr")```

## Running run_analyis.R
On running the ```run_analysis.R``` the you will see below sampled output :- 

     ********************************************************
     Getting and Cleaning Data Course Project
     ********************************************************
     Downloading Test Data .........
     --2015-05-23 00:40:54--  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
     .
     .
     .
     Saving to: 'data/untidyData.zip'

        0K .......... .......... .......... .......... ..........  0%  271K 3m45s
        50K .......... .......... .......... .......... ..........  0%  274K 3m44s
        100K .......... .......... .......... .......... ..........  0%  278K 3m42s
        150K .......... .......... .......... .......... ..........  0% 7.01M 2m49s
     .
     .
     .

     - Download At -
     Date : 2015-05-23
     Time : 2015-05-23 00:38:53
     ********************************************************
     Unziping Test Data .........
     ********************************************************
     Removing 'Inertial Signals' Files 
     ********************************************************
     Loading and Merging Test and Train Data ......
     ********************************************************
     Extracting Mean and Standard Deviations .........
     ********************************************************
     Merging Test Data with Activity Labels .........
     ********************************************************
     Re-Labeling Column Names with Descriptive Names .........
     ********************************************************
     Finalizing Cleaning Data ......
     ********************************************************
     Data Cleaning Completed
     ********************************************************
