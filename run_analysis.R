## Load required libraries
library(dplyr)
library(reshape2)

## Set working directory
setwd("/Users/rohitrai/Desktop/Rohit/Coursera_GaCD")

## Download the workf file and unzip
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "UCI HAR Dataset.zip", method="curl")
unzip ("UCI HAR Dataset.zip")

## Merge the training and the test sets to create one data set.

### Extract TEST Data ###

 #### Test set
 x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
 
 #### Test label
 y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
 
 #### Subject range who performed the activity
 subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
 
### Extract TRAINING Data ###
 
 #### Training set
 x_train <- read.table("UCI HAR Dataset/train/X_train.txt")  
 
 #### Training label
 y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
 
 #### Subject range who performed the activity
 subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
 
### Extract the column names(variables) from features.txt
 features <- read.table("UCI HAR Dataset/features.txt")
 names(x_test) <- features$V2
 names(x_train) <- features$V2
 
 names(y_test) <- "activity_id"
 names(y_train) <- "activity_id"
 names(subject_test) <- "volunteer_id"
 names(subject_train) <- "volunteer_id"
 
### Merge the data 
 col_merge_test <- cbind(y_test,subject_test) %>% cbind(x_test)
 col_merge_train <- cbind(y_train,subject_train) %>% cbind(x_train)
 test_train <- rbind(col_merge_test, col_merge_train)

### Filter only mean and standard deviation columns by keeping activity_id and volunteer id intact
 mean_std <- test_train[grepl('activity_id|volunteer_id|mean()|std()',names(test_train))]
 
### Use descriptive activity names to name the activities in the data set
 activity_data <- read.table("UCI HAR Dataset/activity_labels.txt")
 names(activity_data) <- c("activity_id","activity_name")
 
 mean_std_2 <- left_join(activity_data,mean_std)
 
### Appropriately labels the data set with descriptive variable names
 #### I think it was taken care in earlier steps itself
 #### Removed activity_id column as activity_name column exist
 mean_std_3 <- subset(updated_data2,select=-c(1))
### tidy data set with the average of each variable for each activity and each subject.
 
 var_extract <- melt(mean_std_3,(id.vars=c("volunteer_id","activity_name")))
 mean_extract <- dcast(var_extract, volunteer_id+activity_name ~ variable , mean)
 
 #### add mean as prefix on all columns except volunteer_id and activity_name
 names(mean_extract)[-c(1:2)] <- paste("[Mean of ]" , names(mean_extract)[-c(1:2)] )
 
 #### tidy data
 write.csv(mean_extract, "tidy_data.csv",row.name=FALSE)
 