# run_analysis.R

#====================================================================
#   Get the TRAINING data and build a complete set.
#   Include activity labels and subject numbers.
#====================================================================
trainData <- read.table("./train/X_train.txt")           # 7352 x 561
trainLabels <- read.table("./train/y_train.txt")         # 7352 x 1
trainSubject <- read.table("./train/subject_train.txt")  # 7352 x 1

#  Add columns for the Activity labels and Subject number.
trainCombined <- cbind(trainData, trainLabels, trainSubject)

#====================================================================
#   Get the TEST data and build a complete set.
#   Include activity labels and subject numbers.
#====================================================================
testData <- read.table("./test/X_test.txt")              # 2947 x 561
testLabels <- read.table("./test/y_test.txt")            # 2947 x 1
testSubject <- read.table("./test/subject_test.txt")     # 2947 x 1

#  Add columns for the Activity labels and Subject number.
testCombined <- cbind(testData, testLabels, testSubject)

#====================================================================
#   Read in the mapping between activity number and activity names.
#   Read in the features:  the types of measurements, include the names.
#====================================================================
activityLabels <- read.table("activity_labels.txt")      # 6 x 2
features <- read.table("features.txt")                   # 561 x 2

#  Find measurements having "mean" or "std" in their title.
goodFeatures <- grep("mean|std", features[,2], ignore.case=TRUE)

#====================================================================
#   Part 1.
#   Merges the training and the test sets to create one data set.
#====================================================================
bigData <- rbind(trainCombined, testCombined)            # 10299 x 563

#====================================================================
#   Part 2.
#   Extracts only the measurements on the mean and standard deviation
#   for each measurement.
#====================================================================
#  Only select the columns having names with "mean" or "std",
#  Also, include the Activity label (562) and Subject number (563).
goodData <- bigData[,c(goodFeatures, 562, 563)]

#====================================================================
#   Part 3.
#   Uses descriptive activity names to name the activities in the
#   data set.
#====================================================================
#  Exchange the Activity number for the Activity name.
goodData$V1.1 <- factor(goodData$V1.1,
                        levels=activityLabels[,1],
                        labels=activityLabels[,2])

#====================================================================
#   Part 4.
#   Appropriately labels the data set with descriptive variable names.
#====================================================================
#  Get the actual names for the Activities.
#  Just get ones with "mean" and "std".
someNames <- subset(features,
                    grepl("mean|std", V2, ignore.case=TRUE),
                    select=c(V2))

#  All names have unwanted numbers and white space before the name.
#  Get rid of the unwanted numbers and white space, just keep the name.
goodNames <- sub("[0-9]+ +", "", someNames$V2)

#  Rename all columns.
names(goodData) <- c(goodNames, "Activities", "Subject")

# dim(goodData) == 10299 x 88

