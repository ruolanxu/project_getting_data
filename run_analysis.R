# Course project for "Getting and Cleaning Data"
# Written by Effi Xu
# June 2015

rm(list = ls())
## 1. Merges the training and the test sets to create one data set.

# Set data directory and filenames
dir <- "./UCI HAR Dataset/"
f_data_train <- paste(dir, "train/X_train.txt", sep = "")
f_data_test <- paste(dir, "train/X_test.txt", sep = "")
f_subject_train <- paste(dir, "train/subject_train.txt", sep = "")
f_subject_test <- paste(dir, "test/subject_test.txt", sep = "")

# Read features
features <- read.table(paste(dir, "features.txt", sep = ""), col.names = c("number", "feature"))
features <- features[[2]]

# Read the training dataset & subject, combine
raw_data_train <- read.table(f_data_train, header = FALSE, fill = TRUE, col.names = features)
subject_train <- read.table(f_subject_train, header = FALSE)
colnames(subject_train) <- "subject"
data_train <- cbind(subject_train, raw_data_train)
rm(raw_data_train, subject_train)

## 2. Extracts only the measurements on the mean and standard deviation 
##for each measurement. 

## 3. Uses descriptive activity names to name the activities in the data set

## 4.Appropriately labels the data set with descriptive variable names. 


## 5. From the data set in step 4, creates a second, independent tidy data 
## set with the average of each variable for each activity and each subject.