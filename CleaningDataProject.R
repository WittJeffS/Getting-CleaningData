library(plyr)

# Create a new directory if on does not exist and obtain and unzip the data from the URL

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
unzip(zipfile="./data/Dataset.zip",exdir="./data")

#Create data sets for the original data and then merge via rbind()
x_train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("data/UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("data/UCI HAR Dataset/test/Y_test.txt")
subject_test<- read.table("data/UCI HAR Dataset/test/subject_test.txt")
x_data<- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

#Create a features data set that contains the measurement lables associate 
#with the x_data.  Extract only the mean and standard diviation measurements
# and overwrite the x_data set with just these variable.  Use the descriptive
#names for the x_data
features <- read.table("data/UCI HAR Dataset/features.txt")
mean_and_std_features <- grep("-(mean|std)", features[, 2])
x_data <- x_data[, mean_and_std_features]
names(x_data) <- features[mean_and_std_features, 2]

#Create an activity data set that includes the activity lables associated
# with the y_data. Use the descriptive names for the y_data and subject_data.
activities <- read.table("data/UCI HAR Dataset/activity_labels.txt")
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- "activity"
names(subject_data) <- "subject"

#Combine all the data into one data set and create a tidy data set 
# the average of each variable for each activity and each subject. 
#Create a new .txt file reflecting this new tidy dateset.
all_data <- cbind(subject_data, y_data, x_data)
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 3:68]))
write.table(averages_data, "averages_data.txt", row.name=FALSE)
