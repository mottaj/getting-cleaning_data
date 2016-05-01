library(dplyr)


## Save names of folders

project_dir <- "~/Dropbox/Coursera/DataScience/3_GettingAndCleaningData/project"
setwd(project_dir)

setwd("./UCI HAR Dataset")
data_dir <- getwd()

setwd(data_dir)
setwd("./train")
train_dir <- getwd()

setwd(data_dir)
setwd("./test")
test_dir <- getwd()


## Read names of the 561 features

setwd(data_dir)
features <- read.table("features.txt", stringsAsFactors = FALSE)
features <- features[ , 2]


## Read names of the 6 activities

setwd(data_dir)
activity_labels_df <- read.table("activity_labels.txt", stringsAsFactors = FALSE)
activity_levels <- activity_labels_df[ , 1]
activity_labels <- activity_labels_df[ , 2]
remove(activity_labels_df)


## Read training data

setwd(train_dir)

## Meets Requirement 4:
##   Appropriately labels the data set with descriptive variable names.
X_train_df <- read.table("X_train.txt", col.names = features)
X_train <- tbl_df(X_train_df)
remove(X_train_df)

subject_train_df <- read.table("subject_train.txt", col.names = "subject")
subject_train <- factor(subject_train_df$subject, levels = 1:30)
remove(subject_train_df)

y_train_df <- read.table("y_train.txt", col.names = "activity")
## Meets Requirement 3:
##   Uses descriptive activity names to name the activities in the data set
activity_train <- factor(y_train_df$activity, levels = activity_levels, labels = activity_labels)
remove(y_train_df)

train <- mutate(X_train, subject = subject_train, activity = activity_train)
remove(X_train, subject_train, activity_train)


## Read test data

setwd(test_dir)

## Meets Requirement 4:
##   Appropriately labels the data set with descriptive variable names.
X_test_df <- read.table("X_test.txt", col.names = features)
X_test <- tbl_df(X_test_df)
remove(X_test_df)

subject_test_df <- read.table("subject_test.txt", col.names = "subject")
subject_test <- factor(subject_test_df$subject, levels = 1:30)
remove(subject_test_df)

y_test_df <- read.table("y_test.txt", col.names = "activity")
## Meets Requirement 3:
##   Uses descriptive activity names to name the activities in the data set.
activity_test <- factor(y_test_df$activity, levels = activity_levels, labels = activity_labels)
remove(y_test_df)

test <- mutate(X_test, subject = subject_test, activity = activity_test)
remove(X_test, subject_test, activity_test)


## Meets Requirement 1:
##   Merges the training and the test sets to create one data set.
combined_data <- bind_rows(train, test)
remove(train, test)


## Meets Requirement 2:
##   Extracts only the measurements on the mean and standard deviation for each measurement.
##     [Select only the columns whose names contain "-mean()" or "-std()".]
mean_columns <- grep("-mean()", features, fixed = TRUE)
std_columns <- grep("-std()", features, fixed = TRUE)
columns_to_keep <- sort( c(mean_columns, std_columns) )


## Meets Requirement 5:
##   creates a second, independent tidy data set with the average of each variable for each activity and each subject.
my_data_set <- combined_data %>%
    select(activity, subject, columns_to_keep) %>%
    group_by(activity, subject) %>%
    summarize_each("mean")

setwd(project_dir)
write.table(my_data_set, file = "./averages.txt", row.names = FALSE)
