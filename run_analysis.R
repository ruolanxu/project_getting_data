# Course project for "Getting and Cleaning Data"
# Written by Effi Xu
# June 2015


library(dplyr)

rm(list = ls())
## 1. Merges the training and the test sets to create one data set.

# Set data directory and filenames
dir <- "./UCI HAR Dataset/"
f_data_train <- paste(dir, "train/X_train.txt", sep = "")
f_activity_train <- paste(dir, "train/y_train.txt", sep = "")
f_subject_train <- paste(dir, "train/subject_train.txt", sep = "")

f_data_test <- paste(dir, "test/X_test.txt", sep = "")
f_activity_test <- paste(dir, "test/y_test.txt", sep = "")
f_subject_test <- paste(dir, "test/subject_test.txt", sep = "")

# Read features
features <- read.table(paste(dir, "features.txt", sep = ""), 
                       col.names = c("number", "feature"))
features <- features[[2]]

# Read the training dataset & activity & subject, combine them
raw_data_train <- read.table(f_data_train, header = FALSE, 
                             fill = TRUE, col.names = features)
activity_train <- read.table(f_activity_train, header = FALSE)
subject_train <- read.table(f_subject_train, header = FALSE)
colnames(activity_train) <- "activity"
colnames(subject_train) <- "subject"

data_train <- cbind(subject_train, activity_train, raw_data_train)
rm(raw_data_train, activity_train, subject_train)

# Read the testing dataset & subject, combine them
raw_data_test <- read.table(f_data_test, header = FALSE, 
                            fill = TRUE, col.names = features)
activity_test <- read.table(f_activity_test, header = FALSE)
subject_test <- read.table(f_subject_test, header = FALSE)
colnames(activity_test) <- "activity"
colnames(subject_test) <- "subject"

data_test <- cbind(subject_test, activity_test, raw_data_test)
rm(raw_data_test, activity_test, subject_test)

# merge the training and testing dataset into one
data <- rbind(data_train, data_test)
rm(data_train, data_test)


## 2. Extracts only the measurements on the mean and standard deviation 
## for each measurement. 

# convert 'data_new' to tbl format
idx <- grepl("mean", colnames(data)) | 
  grepl("std", colnames(data)) | 
  grepl("subject", colnames(data)) |
  grepl("activity", colnames(data))
data_new <- data[, idx]
# rm(data)

## 3. Uses descriptive activity names to name the activities in the data set

# Read descriptive activiey names
list_activity <- read.table(paste(dir, "activity_labels.txt", sep = ""), 
                            col.names = c("label", "activity"), stringsAsFactors = FALSE)

# replace activity number with activity name
# activity_name <- function(n) {
#   return(list_activity[n,2])
# }
# data_new$activity <- sapply(data_new$activity, activity_name)

data_new$activity <- list_activity[data_new$activity, 2]


## 4.Appropriately labels the data set with descriptive variable names. 

# Already done so in Step 1


## 5. From the data set in step 4, creates a second, independent tidy data 
## set with the average of each variable for each activity and each subject.

# using dplyr package to calculate the mean of variables based on groups
data_out <- tbl_df(data_new) %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

# write the data