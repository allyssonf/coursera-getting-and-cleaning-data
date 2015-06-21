

# 1st - Merging training and test sets. It is assumed that the data set file structure lies in the same
#       directory as this script.

xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

trainingDataSet <- cbind(cbind(xTrain, subjectTrain), yTrain)

xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

testDataSet <- cbind(cbind(xTest, subjectTest), yTest)

# Data Merged!
sensorDataSet <- rbind(trainingDataSet, testDataSet)

featuresNames <- read.table("./UCI HAR Dataset/features.txt", colClasses = c("character"))

# Appropriated labeling
names(sensorDataSet) <-  c(featuresNames$V2, "Subject", "Activity")

# 2nd - Extract only the measurements on the mean and standard deviation for each measurement. Searching 
#       for activity id to use descriptive activity names in the data set (#3)
matches <- grep("(Activity|((mean|std)\\(\\)))", names(sensorDataSet))

# Result set
meanPlusStd <- sensorDataSet[, matches]

# 3rd - Correct names for activities
activitiesLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Insert correct label for activiy accordingly (activity was the last inserted column)
meanPlusStd$Activity <- activitiesLabels[meanPlusStd[,length(meanPlusStd)],2]

# 4th - Lets appropriately labels the data set with descriptive variable names. Here it is not clear in
#       the statement if we shall apply descriptive variable names to merged data set or mean and std 
#       deviation data set. It will be used mean and std dev data set.

names(meanPlusStd) <- gsub("^t", "Time ", names(meanPlusStd))
names(meanPlusStd) <- gsub("^f", "Frequency ", names(meanPlusStd))
names(meanPlusStd) <- gsub("-mean\\(\\)", "Mean ", names(meanPlusStd))
names(meanPlusStd) <- gsub("-std\\(\\)", "StdDev ", names(meanPlusStd))
names(meanPlusStd) <- gsub("-", " ", names(meanPlusStd))
names(meanPlusStd) <- gsub("Acc", " Acceleration ", names(meanPlusStd))
names(meanPlusStd) <- gsub("Gyro", " Gyroscope ", names(meanPlusStd))
names(meanPlusStd) <- gsub("BodyBody", "Body", names(meanPlusStd))

# 5th - Lets creates a second, independent tidy data set with the
#       average of each variable for each activity and each subject.

# Firts, lets load the proper library!
library(plyr)

# Calculate the average as requested, by Activity. That's why we ommit last column (activity itself).
averageResultSet <- ddply(meanPlusStd, .(Activity), function(x) colMeans(x[, 1:66]))

# And now, write to file.
write.table(averageResultSet, "./averages_tidy_data_set.txt", row.name=FALSE)

