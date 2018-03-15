# Coursera_GaCD

 Note:  RStudio helps in building this script because of Golbal Environment tab details about all varibales extracted in this package.
 
 ###  Required Packages - dplyr & reshape2

The data anlysis is carried around extract taken from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

A full description of the data is found at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The run_analysis.R script does the following:

1. Merges the training and the test sets to create one data set.

The code contains a header  "Extract TEST Data & Extract TRAINING DATA" talks about this step.
** Variables are used with same name as files to avoid any confusion to start.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

dplyr::grepl was used to filter mean ("mean()") and standard deviation ("std()").

3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.