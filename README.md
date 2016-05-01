# getting_cleaning_data

My student project for my class on Coursera on Getting and Cleaning Data.

## Source data

The source data for this project is the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

### R script for downloading source data

In this repo you will find my `download_data.R` script for downloading the source data. The script downloads the .zip file, extracts the files contained within, and then deletes the .zip file. After running the script, you should find within your working directory a subdirectory called `UCI HAR Dataset` which contains the source data.

Before running this script, you will need to edit this line to choose a working folder for this project on your computer:
```
setwd("~/Dropbox/Coursera/DataScience/3_GettingAndCleaningData/project")
```
I found I needed to include `method = "curl"` as a parameter to `download.file()` to get the download to work properly on my Mac. For a different OS, you may need to omit or modify `method`.


### Brief description of source data

The source data set contains 561 columns (i.e., variables or "features"); these are quantities that were calculated from the accelerometer and gyroscope data recorded by smartphones worn by 30 individuals ("subjects"). Rather than having one large data set, the data was split into two groups, a training set and a test set, with the training set having data from a randomly chosen 70% (21) of the subjects and the test set having data from the other 30% (9) of the subjects. These two data sets are stored within the `train` and `test` subfolders of `UCI HAR Dataset`. The training set (`train/X_train.txt`) contains 7,352 rows of data, and the test set (`train/X_train.txt`) contains 2,947 rows of data. Each row of data corresponds to a single observation of a single subject peforming a single activity.

#### Subjects

Thirty individuals labeled 1 through 30. The subjects for the 7,352 rows of the training set are given as a column vector in the file `train/subject_train.txt`. The subjects for the 2,947 rows of the test set are given as a column vector in the file `test/subject_test.txt`.

#### Activities

Six possible physical activities that were performed by the subjects. The activities are denoted by numbers 1 through 6. The activities for the 7,352 rows of the training set are given as a column vector in the file `train/y_train.txt`. The activities for the 2,947 rows of the test set are given as a column vector in the file `test/y_test.txt`.
```
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING
```
