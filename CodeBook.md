# Introduction

The script 'run_analysis.R' perform 5 steps required below: 
 
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

These are the steps to complete this project.

# Script flow

 1. Merging training and test sets. It is assumed that the data set file structure lies in the same directory as this script.
    1. The training set is merged using cbind() to bind data to subject.
    2. The test set is merged using cbind() to bind data to subject.
 2. Then we rbind both data sets (rbind())
 3. After that we properly add two column names "Subject" and "Activiy" as these columns were added previously on the merge operation
 4. Then we extract only the measurements on the mean and standard deviation for each measurement.
 5. Correct names for activities are now inserted.
 6. Change columns names to a more descriptives ones.
 7. And finally an independent tidy data set with the average of each variable for each activity and each subject is created.

# Variables

## xTrain, yTrain, subjectTrain, trainingDataSet
   These variables are related to generating the training data set: trainingDataSet <- cbind(cbind(xTrain, subjectTrain), yTrain)

## xTest, yTest, subjectTest, testDataSet
   These variables are related to generating the test data set: testDataSet <- cbind(cbind(xTest, subjectTest), yTest)

## sensorDataSet
   This is the training and test data set merged: sensorDataSet <- rbind(trainingDataSet, testDataSet)

## matches, meanPlusStd
   Here we get only the mean and std deviation from sensorDataSet to matches and subSet sensorDataSet to create meanPlusStd

## activitiesLabels
   activitiesLabels stores all labels from activity_labels.txt and then we insert the correct label per activity

## averageResultSet 
   This is the final result set that is obtained using ddply to summarize the average as required by step 5: ddply(meanPlusStd, .(Activity), function(x) colMeans(x[, 1:66]))
