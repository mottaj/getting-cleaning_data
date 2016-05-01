## Download .zip file and unzip data

setwd("~/Dropbox/Coursera/DataScience/3_GettingAndCleaningData/project")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./UCI_HAR_Dataset.zip", method = "curl")
unzip("./UCI_HAR_Dataset.zip", exdir = ".")
unlink("./UCI_HAR_Dataset.zip")