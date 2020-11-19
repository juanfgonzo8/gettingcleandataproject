# The directory for the data is created
if(!file.exists("./data")) {dir.create("./data")}
# The dataset file is downloaded
if(!file.exists("./data/Dataset.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                  destfile = "./data/Dataset.zip", method = "curl")
}

# The variable names are uploaded
features <- read.table(unz("./data/Dataset.zip", "UCI HAR Dataset/features.txt"))[, 2]
# The posistions of the means and st. dev. are gathered
meanNstd <- grepl("mean()", features) | grepl("std()", features)

# The dataset is loaded, with only the mean and std variables
xtrain <- read.table(unz("./data/Dataset.zip", "UCI HAR Dataset/train/X_train.txt"),
                     colClasses = "numeric")[, meanNstd]
xtest <- read.table(unz("./data/Dataset.zip", "UCI HAR Dataset/test/X_test.txt"),
                    colClasses = "numeric")[, meanNstd]
# The two datasets are put together
data <- rbind(xtrain, xtest)

# The labels for the variables are subset
varlabels <- features[meanNstd]
# Changes are made to the variable names so they are clearer
varlabels <- gsub("-", "_", varlabels)
varlabels <- gsub("\\()", "", varlabels)
varlabels <- gsub("Acc", "Accelerometer", varlabels)
varlabels <- gsub("Gyro", "Gyroscope", varlabels)
varlabels <- gsub("Mag", "Magnitude", varlabels)
varlabels <- gsub("^t", "time_", varlabels)
varlabels <- gsub("^f", "freq_", varlabels)
# The variable names are added to the variable
names(data) <- varlabels

# The annotations of the activities are loaded.
ytrain <- read.table(unz("./data/Dataset.zip", "UCI HAR Dataset/train/y_train.txt"))
ytest <- read.table(unz("./data/Dataset.zip", "UCI HAR Dataset/test/y_test.txt"))
# The two annotation sets are put together
activity <- rbind(ytrain, ytest)

# The activities are labeled with significant names
act_labels <- read.table(unz("./data/Dataset.zip", "UCI HAR Dataset/activity_labels.txt"))
activity <- factor(activity[, 1], levels = act_labels[, 1], labels = tolower(act_labels[, 2]))

# The name of the annotation vector is changed
names(activity) <- "activity"

# The activity annotations are bound to the data set.
data <- cbind(activity, data)

# The subject data is loaded.
subjtrain <- read.table(unz("./data/Dataset.zip", "UCI HAR Dataset/train/subject_train.txt"))
subjtest <- read.table(unz("./data/Dataset.zip", "UCI HAR Dataset/test/subject_test.txt"))
# The two annotation sets are put together
subject <- rbind(subjtrain, subjtest)

# The name of the vector is changed
names(subject) <- "subject"

# The subject information is bound to the data set.
data <- cbind(subject, data)

# The dplyr library is loaded
library(dplyr)

# The data is grouped by activity and subject
data <- group_by(data, activity, subject)

# The mean is calculated for every pair of subject and activity
tidy_data  <- summarise_all(data, mean)

write.table(tidy_data, file = "data/tidy_data.txt", row.names = FALSE)