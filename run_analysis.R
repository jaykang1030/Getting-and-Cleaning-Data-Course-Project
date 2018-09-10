library(dplyr)
filename <- "dataset.zip"
## Download and unzip the dataset:
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method = "curl")
}  
if (!file.exists("UCI HAR Dataset")) {unzip(filename)}
# all variable list
features_list <- read.table("UCI HAR Dataset/features.txt",
                            col.names = c("No","features"))

# all activity list
activity_list <- read.table("UCI HAR Dataset/activity_labels.txt", 
                            col.names = c("label","activity"))

# input train X,y data
X_train <- read.table("UCI HAR Dataset/X_train.txt",
                      col.names = features_list$features)
y_train <- read.table("UCI HAR Dataset/y_train.txt",
                      col.names = "activity")
subject_train <- read.table("UCI HAR Dataset/subject_train.txt",
                            col.names = "subject")
train <- cbind(subject_train, X_train, y_train)

# deal with test data
X_test <- read.table("UCI HAR Dataset/X_test.txt",
                     col.names = features_list$features)
y_test <- read.table("UCI HAR Dataset/y_test.txt",
                     col.names = "activity")
subject_test <- read.table("UCI HAR Dataset/subject_test.txt",
                           col.names = "subject")
test <- cbind(subject_test, X_test, y_test)

# combine test and train
full_data <- rbind(train, test)

# select the column containing mean or std
data_mean_std <- select(full_data, contains("mean"),contains("std"))

# add subject to mean std data
data_mean_std$subject <- as.factor(full_data$subject)

# add acitivity to mean std data with descripitive names
data_mean_std$activity <- factor(full_data$activity,
                                 levels = activity_list[,1],
                                 labels = as.character(activity_list[,2]))

# wirte table 
write.table(data_mean_std,file = "data_MeanStd.txt",
            row.names = FALSE)

# group data from average data by subject and acitivity 
# should be 180 rows. all 30 subjects experience all 6 acitivities 
avg_data <- data_mean_std %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))