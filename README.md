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

## My script ``run_analysis.R`` - what does it do?

### Reads names for the 561 columns
from the file `UCI HAR Dataset/features.txt`. Here are the first few rows:
```
1 tBodyAcc-mean()-X
2 tBodyAcc-mean()-Y
3 tBodyAcc-mean()-Z
4 tBodyAcc-std()-X
5 tBodyAcc-std()-Y
6 tBodyAcc-std()-Z
...
```
It is necessary to read the column names from this `features.txt` file because the files `X_train.txt` and `X_test.txt` do not have column headings.

### Reads names of the six activities
from the file `UCI HAR Dataset/activity_labels.txt`:
```
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING
```

### Reads the training data set

#### Assigns the column names obtained earlier
`read.table("X_train.txt", col.names = features)`

#### Reads subjects
from the file `train/subject_train.txt`

#### Reads activities & converts from numbers 1-6 to descriptive labels
Reads activities from the file `train/y_train.txt`. Converts activities vector from an integer 1-6 to the text labels "WALKING", "WALKING-UPSTAIRS", etc. that were obtained earlier. This is accomplished by converting the activities vector into a factor:
`factor(y_train_df$activity, levels = activity_levels, labels = activity_labels)`

#### Make a data table containing the original 561 columns plus two new columns
The two columns added were subject and activity, as these were originally stored separately. The addition of these two columns was accomplished using the `mutate` function of the `dplyr` package.

### Reads the test data set
All data processing steps that were performed for the training set were repeated for the test set.

### Merge the training and test data sets into a single combined data set
`combined_data <- bind_rows(train, test)`

### Extracts only the measurements on the mean and standard deviation for each measurement
I accomplished this by selecting only the columns whose names contain "-mean()" or "-std()". I found it necessary to use `grep()` on the feature names obtained earlier from the file `features.txt` to obtain a list of columns to select. If I instead tried to use, for example, `contains("-mean()")` within `select()` I found that no columns were selected. This is because the feature names contain characters like `-` and `()` which are not allowed as column/variable names in R; thus R converted these characters to "." when assinging the 561 feature names from features.txt to column names.

#### 68 columns left in the reduced data set
There were 33 columns whose names contained `-mean()` and 33 columns whose names contained `-std()`. So I kept those 66 columns plus the columns for activity and subject. Here are the first few column names:
```
activity
subject
tBodyAcc.mean...X
tBodyAcc.mean...Y
tBodyAcc.mean...Z
tBodyAcc.std...X
tBodyAcc.std...Y
tBodyAcc.std...Z
...
```
Note that in `features.txt` the original names were `tBodyAcc-mean()-X`, etc., but R has automatically converted `-` and `()` into dots to create valid column names.

### Calculate averages of each variable for each activity and subject
Accomplished using `dplyr`'s `group_by()` function to group the data by activity and subject. Then used the `summarize_each()` function to calculate the average (mean) of each of the 66 columns for each activity-subject pair. This resulted in a new data set with 68 columns (activity, subject, and 66 more columns containing the averages) and 180 rows (6 activities x 30 subjects = 180).

#### Output file
My script `run_analysis.R` produces the output file `averages.txt`, which is a data file with 68 columns and 1 header row followed by 180 data rows. Can be read into R using `read.table("averages.txt", header = TRUE)`.
