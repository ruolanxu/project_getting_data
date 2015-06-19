# Course Project - README

## Introduction

The purpose of this project is to clean the dataset using an R script and produce a tidy dataset that can be used for future analysis.

## Requirements

Your have to have R (version 3.0.2 or higher) and the dpylr package installed.


## File Description

The submission includes:

- `CodeBook.md` - A code book that describes the tidy dataset
- `run_analysis.R`  - The R script to perform data cleaning
- `tidy_data.txt` - The tidy dataset that is the output from running the script


## The Analysis

### Input data

The input data is the [UCI Human Activity Recognition dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The webpage contains a detailed description of how the data was collected from the experiments. The README file in the data package further describes what data each file contains.

To reproduce the cleaning process, first download the [data](https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip) and decompress the package. 

#### Location of input data

The script assumes that the `UCI HAR Dataset` folder is in the same directory as the code. If you prefer to put the data somewhere else, please change the value of `dir` here:

```r
## Replace the dataset directory if it's not in the git folder
dir <- "./UCI HAR Dataset/"
```

#### Setting up working directory

Also, make sure that you've set the working directory as the git folder:
``` r
setwd("where_your_code_is")
```



### The data-cleaning script

According to the project description, the cleaning follows the 5 steps as follows. You don't need to read this part to run the code. You can also read the code comments to know what's going on in each step. 

**NB**: Temporary objects produced in the process are removed from the workspace in order to save memory. If you want to view these datasets, just remove the `rm` lines.

#### 1. Merges the training and the test sets to create one data set

In this step, all the training and testing data is read from the dataset. It includes:

- Training/Testing data in _X_train/test.txt_
- Training/Testing subject list in _subject_train/test.txt_
- Training/Testing activity labels in _y_train/test.txt_
- List of features in _features.txt_

The following work is done to create one dataset `data`:

- The training and testing data are combined
- Subjects and activity labels are added as columns
- Features are given as column names

#### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

In this step, only the columns with "mean" and "std" in the column names are extracted. The new datasets is stored in `data_new` and it contains 79 features.

#### 3. Uses descriptive activity names to name the activities in the data set

In this step the values in the activity column are replaced by the names of the activities (originally numbers 1~6).

The activity names are read from _activity_labels.txt_.

#### 4. Appropriately labels the data set with descriptive variable names

Actually this step is already done in Step 1 when the data is first read.

#### 5. Create the tidy data set with the average of each variable for each activity and each subject

This step calculates the mean of each variable based on grouping by _subject_ and _activity_. It's achieved by using the dplyr package.

The tidy dataset is stored in `data_out` and it's in the tbl format. You can easily see what's in it without printing everything:

```r
> data_out
Source: local data frame [180 x 81]
Groups: subject

   subject           activity tBodyAcc.mean...X tBodyAcc.mean...Y tBodyAcc.mean...Z tBodyAcc.std...X tBodyAcc.std...Y
1        1             LAYING         0.2215982      -0.040513953        -0.1132036      -0.92805647     -0.836827406
2        1            SITTING         0.2612376      -0.001308288        -0.1045442      -0.97722901     -0.922618642
3        1           STANDING         0.2789176      -0.016137590        -0.1106018      -0.99575990     -0.973190056
4        1            WALKING         0.2773308      -0.017383819        -0.1111481      -0.28374026      0.114461337
5        1 WALKING_DOWNSTAIRS         0.2891883      -0.009918505        -0.1075662       0.03003534     -0.031935943
6        1   WALKING_UPSTAIRS         0.2554617      -0.023953149        -0.0973020      -0.35470803     -0.002320265
7        2             LAYING         0.2813734      -0.018158740        -0.1072456      -0.97405946     -0.980277399
8        2            SITTING         0.2770874      -0.015687994        -0.1092183      -0.98682228     -0.950704499
9        2           STANDING         0.2779115      -0.018420827        -0.1059085      -0.98727189     -0.957304989
10       2            WALKING         0.2764266      -0.018594920        -0.1055004      -0.42364284     -0.078091253
..     ...                ...               ...               ...               ...              ...              ...
Variables not shown: tBodyAcc.std...Z (dbl), tGravityAcc.mean...X (dbl), tGravityAcc.mean...Y (dbl),
  tGravityAcc.mean...Z (dbl), tGravityAcc.std...X (dbl), tGravityAcc.std...Y (dbl), tGravityAcc.std...Z (dbl),
  tBodyAccJerk.mean...X (dbl), tBodyAccJerk.mean...Y (dbl), tBodyAccJerk.mean...Z (dbl), tBodyAccJerk.std...X (dbl),
  tBodyAccJerk.std...Y (dbl), tBodyAccJerk.std...Z (dbl), tBodyGyro.mean...X (dbl), tBodyGyro.mean...Y (dbl),
  tBodyGyro.mean...Z (dbl), tBodyGyro.std...X (dbl), tBodyGyro.std...Y (dbl), tBodyGyro.std...Z (dbl),
  tBodyGyroJerk.mean...X (dbl), tBodyGyroJerk.mean...Y (dbl), tBodyGyroJerk.mean...Z (dbl), tBodyGyroJerk.std...X
  (dbl), tBodyGyroJerk.std...Y (dbl), tBodyGyroJerk.std...Z (dbl), tBodyAccMag.mean.. (dbl), tBodyAccMag.std.. (dbl),
  tGravityAccMag.mean.. (dbl), tGravityAccMag.std.. (dbl), tBodyAccJerkMag.mean.. (dbl), tBodyAccJerkMag.std.. (dbl),
  tBodyGyroMag.mean.. (dbl), tBodyGyroMag.std.. (dbl), tBodyGyroJerkMag.mean.. (dbl), tBodyGyroJerkMag.std.. (dbl),
  fBodyAcc.mean...X (dbl), fBodyAcc.mean...Y (dbl), fBodyAcc.mean...Z (dbl), fBodyAcc.std...X (dbl), fBodyAcc.std...Y
  (dbl), fBodyAcc.std...Z (dbl), fBodyAcc.meanFreq...X (dbl), fBodyAcc.meanFreq...Y (dbl), fBodyAcc.meanFreq...Z (dbl),
  fBodyAccJerk.mean...X (dbl), fBodyAccJerk.mean...Y (dbl), fBodyAccJerk.mean...Z (dbl), fBodyAccJerk.std...X (dbl),
  fBodyAccJerk.std...Y (dbl), fBodyAccJerk.std...Z (dbl), fBodyAccJerk.meanFreq...X (dbl), fBodyAccJerk.meanFreq...Y
  (dbl), fBodyAccJerk.meanFreq...Z (dbl), fBodyGyro.mean...X (dbl), fBodyGyro.mean...Y (dbl), fBodyGyro.mean...Z (dbl),
  fBodyGyro.std...X (dbl), fBodyGyro.std...Y (dbl), fBodyGyro.std...Z (dbl), fBodyGyro.meanFreq...X (dbl),
  fBodyGyro.meanFreq...Y (dbl), fBodyGyro.meanFreq...Z (dbl), fBodyAccMag.mean.. (dbl), fBodyAccMag.std.. (dbl),
  fBodyAccMag.meanFreq.. (dbl), fBodyBodyAccJerkMag.mean.. (dbl), fBodyBodyAccJerkMag.std.. (dbl),
  fBodyBodyAccJerkMag.meanFreq.. (dbl), fBodyBodyGyroMag.mean.. (dbl), fBodyBodyGyroMag.std.. (dbl),
  fBodyBodyGyroMag.meanFreq.. (dbl), fBodyBodyGyroJerkMag.mean.. (dbl), fBodyBodyGyroJerkMag.std.. (dbl),
  fBodyBodyGyroJerkMag.meanFreq.. (dbl)
```

### Output

`data_out` is printed to `output.txt`. You can use this command to read it into object `data` in R:

```r
data <- read.table("./output.txt", header = TRUE)
View(data)
```

 