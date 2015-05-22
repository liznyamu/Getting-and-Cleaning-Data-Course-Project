message("********************************************************")
message("Getting and Cleaning Data Course Project")
message("********************************************************")
message("Downloading Test Data .........")
## Download the test data
# file url in use - with untidy data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# if directory "data" is not existing , create it
if(!dir.exists("data")){dir.create("data")}

# download the file
# with reference to  :http://rpubs.com/thoughtfulbloke/downloadtips
require(downloader)
download(url = fileUrl, destfile = "data/untidyData.zip")

message("- Download At -")
message("Date : ", Sys.Date() ) ; message("Time : ", Sys.time())
message("********************************************************")

message("Unziping Test Data .........")
# unzip file
unzip(zipfile <- "data/untidyData.zip", exdir = "data/")

message("********************************************************")
message("Removing 'Inertial Signals' Files ")
# remove files not required for analysis (to mitigate any confusion during cleaning data)
# in reference to : https://class.coursera.org/getdata-014/forum/thread?thread_id=30
# unlink() "Inertial" directories  - under test and train directories
unlink("data/UCI HAR Dataset/test/Inertial Signals/", recursive = T, force = T)
unlink("data/UCI HAR Dataset/train/Inertial Signals/", recursive = T, force = T)

message("********************************************************")
message("Loading and Merging Test and Train Data ......")
## Load data into R and Merge test and train data

# read in the test data into R
subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt")
x_test <- read.table("data/UCI HAR Dataset/test/X_test.txt", colClasses = "numeric")


# cbind test data - cbind subject_test to y_test to x_test
test <- cbind(subject_test, y_test)
test <- cbind(test, x_test) # dim(test) ## [1] 2947  563

# read in the train data into R
subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt")
x_train <- read.table("data/UCI HAR Dataset/train/X_train.txt", colClasses = "numeric")

# cbind train data - cbind subject_train to y_train to x_train
train <- cbind(subject_train, y_train)
train <- cbind(train, x_train)

#rbind test and train
untidy_data <- rbind(test, train)

# add column names
features <- read.table("data/UCI HAR Dataset/features.txt", stringsAsFactors = F)
colnames(untidy_data) <- c("subjectID", "activityID", features$V2) 

message("********************************************************")
message("Extracting Mean and Standard Deviations .........")
## Extracts only the measurements on the mean and standard deviation for each measurement. 

# Using : grep() for columns with mean() or std() (and not including meanFreq())
  # plus the subjectID and activityID 
# with reference to :- http://stackoverflow.com/questions/7227976/using-grep-in-r-to-find-strings-as-whole-words-but-not-strings-as-part-of-words
col_mean_std <- c(1, 2, grep("std\\b(\\b)" , colnames(untidy_data)) 
                  ,grep("mean\\b(\\b)" , colnames(untidy_data)) )

untidy_mean_std <- untidy_data[, col_mean_std]

message("********************************************************")
message("Merging Test Data with Activity Labels .........")
## Use descriptive activity names to name the activities in the data set
  # merge with the activity labels
activity_labels <- read.table("data/UCI HAR Dataset/activity_labels.txt"
                              , stringsAsFactors = F, )
untidy_c_labels <- merge(activity_labels, untidy_mean_std, 
                         by.x = "V1", by.y = "activityID")

message("********************************************************")
message("Re-Labeling Column Names with Descriptive Names .........")

## Appropriately labels the data set with descriptive variable names.

# rename columns from activity_labels dataset
names(untidy_c_labels)[c(1, 2)] <- c("activityID", "activityLabel") 

# function to re-label column names
# with reference to the documentation on features_info.txt
relabel <- function(columnNames){
  
  #a) columns starting with 't' change to denote "time"
  columnNames <- gsub("^t", "time", columnNames)
  
  #b) columns starting with 'f' change to denote "frequency"
  columnNames <- gsub("^f", "frequency", columnNames)
  
  #c) remove repetition "BodyBody" in some columns to "Body"
  columnNames <- gsub("BodyBody", "Body", columnNames)
  
  #d) remove heifens and brackets
  columnNames <- gsub("\\-mean\\(\\)", "Mean", columnNames)
  columnNames <- gsub("\\-mean\\(\\)\\-", "Mean", columnNames)
  columnNames <- gsub("\\-std\\(\\)", "Std", columnNames)
  columnNames <- gsub("\\-std\\(\\)\\-", "Std", columnNames)
 
}

names(untidy_c_labels) <- relabel(names(untidy_c_labels))

message("********************************************************")
message("Finalizing Cleaning Data ......")

## From the data set in step 4, creates a second, independent tidy data set with the
  #average of each variable for each activity and each subject
suppressWarnings(require(dplyr))
tidy_data <- untidy_c_labels

# use the group_by and summarise_each actions to achieve above
tidy_data <- (tidy_data %>% 
                group_by(subjectID, activityLabel) %>%
                summarise_each(funs(mean)) )

## write out the above data.frame
write.table(tidy_data,"tidy_data.txt",sep=" ",row.name=FALSE)

message("********************************************************")
message("Data Cleaning Completed")
message("********************************************************")