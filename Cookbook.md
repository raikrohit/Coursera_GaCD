# Coursera_GaCD

 Note:  RStudio helps in building this script because of Golbal Environment tab details about all variables extracted in this package.
 
 ###  Required Packages - dplyr & reshape2

The data anlysis is carried around extract taken from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

A full description of the data is found at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The run_analysis.R script does the following:

1. Merges the training and the test sets to create one data set.

The code contains a header  "Extract TEST Data & Extract TRAINING DATA" talks about this step.
** Variables are used with same name as files to avoid any confusion to start.

cbind,rbind were used to combine data frame based on observation and varibales match (note again Rstudio gives quick insight)

2. Extracts only the measurements on the mean and standard deviation for each measurement.

dplyr::grepl was used to filter mean ("mean()") and standard deviation ("std()"). Data was extracted in "mean_std" dataframe.

3. Uses descriptive activity names to name the activities in the data set

activity_labels.txt containes meaningful names of all activities along with their activity id mapping. It was used to map to mean_std with use of left join and data was stored in mean_std2.

4. Appropriately labels the data set with descriptive variable names.

All varibales were labled with each data set creation so no action was required here. Only duplicate column (activity_id was removed as activity_name was found in mean_std_2)

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Data was extracted based on mean of group(activity_name and volunteer_id) and then written to a csv file for presentation