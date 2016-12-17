#Introduction
The script run_analysis.R is associated with the class project in the Coursera Data Science - Getting and Cleaning Data.  The script downloads and unzips data from a website into a new folder. At this point transformation of the data begine via the following steps:

1) Merges the training and the test sets to create one data set, using the rbind() function. 

2) Then it extracts only the measurements on the mean and standard deviation for each measurement, using the grep() function.

3) Next, columns are given descriptive names, which come from the features.txt file

4) Appropriately activity labels are substituted by associating the values 1:6 with those from that activity_labels.txt files.

5) All the data sets are then combined using the cbind() function

6) The PLYR package ddply() function is then called to generate the column means.

5) Finally, the script creates a new tidy data set with the average of each variable for each activity and each subject, which is named average_data.txt

#Variables

x_train, y_train, x_test, y_test, subject_train and subject_test contain the original data from the downloaded files.

x_data, y_data and subject_data merge the previous datasets to further analysis.

features contains the descriptive measurement names for the x_data dataset, whereas mean_and_std_features is a numeric vector including only the mean and standard diviation columns of the features data set.

activities contains the descriptive activity names for the y_data dataset.

all_data merges x_data, y_data and subject_data datasets.

averages_data contains the relevant averages using the ddply() from the plyr package to apply colMeans().

Finally, the tidy data set is stored in a new average_data.txt file
