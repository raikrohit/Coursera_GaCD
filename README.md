# Coursera_GaCD

 Note:  RStudio helps in building this script because of Golbal Environment tab details about all variables extracted in this package.
 
 ###  Required Packages - dplyr & reshape2

The data anlysis is carried around extract taken from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

A full description of the data is found at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Steps involved in data extraction and preparing tidy data.

Step 1. Extract "TEST" & "TRAINING" data from 3 files

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
 
Step 2. Assign column names (looks at README.TXT & features_info.txt files how they can assigned names)

### Extract the column names(variables) from features.txt
 features <- read.table("UCI HAR Dataset/features.txt")
 names(x_test) <- features$V2
 names(x_train) <- features$V2
 
 names(y_test) <- "activity_id"
 names(y_train) <- "activity_id"
 names(subject_test) <- "volunteer_id"
 names(subject_train) <- "volunteer_id"
 
Step 3. Merge all TEST & TRAINING data by observing its rows(observations) and columns(variables) numbers.

### Merge the data 
 col_merge_test <- cbind(y_test,subject_test) %>% cbind(x_test)
 col_merge_train <- cbind(y_train,subject_train) %>% cbind(x_train)
 test_train <- rbind(col_merge_test, col_merge_train)
 
Step 4. Filter data for mean() and std()

### Filter only mean and standard deviation columns by keeping activity_id and volunteer id intact
 mean_std <- test_train[grepl('activity_id|volunteer_id|mean()|std()',names(test_train))]
 
Step 5. Extract activity names from activity_labels.txt

### Use descriptive activity names to name the activities in the data set
 activity_data <- read.table("UCI HAR Dataset/activity_labels.txt")
 names(activity_data) <- c("activity_id","activity_name")
 
Step 6. Join it with filtered data in step 4
 mean_std_2 <- left_join(activity_data,mean_std)
 
Step 7. Remove duplicate column (activity_id was removed as activity_name was found in mean_std_2)

mean_std_3 <- subset(updated_data2,select=-c(1))

Step 8. Find the group average - "volunteer_id","activity_name

### tidy data set with the average of each variable for each activity and each subject.
 
 var_extract <- melt(mean_std_3,(id.vars=c("volunteer_id","activity_name")))
 mean_extract <- dcast(var_extract, volunteer_id+activity_name ~ variable , mean)
 
 #### add mean as prefix on all columns except volunteer_id and activity_name
 names(mean_extract)[-c(1:2)] <- paste("[Mean of ]" , names(mean_extract)[-c(1:2)] )

Step 9. Extract the tidy data to csv file

#### tidy data
 write.csv(mean_extract, "tidy_data.csv",row.name=FALSE)
 


 
 