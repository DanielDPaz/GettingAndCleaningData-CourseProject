library(dplyr)

setwd(".")
filePath.train <- "./UCI HAR Dataset/train/X_train.txt"
filePath.train_subjects <- "./UCI HAR Dataset/train/subject_train.txt"
filePath.train_label <- "./UCI HAR Dataset/train/y_train.txt"

filePath.test <- "./UCI HAR Dataset/test/X_test.txt"
filePath.test_subjects <- "./UCI HAR Dataset/test/subject_test.txt"
filePath.test_label <- "./UCI HAR Dataset/test/y_test.txt"

filePath.features <- "./UCI HAR Dataset/features.txt"
filePath.activity_labels <- "./UCI HAR Dataset/activity_labels.txt"

# Prepare headers from features data file
features <- read.table(filePath.features, 
                              header = FALSE, 
                              sep ="", 
                              col.names = c("Row", "Label"))
format.features <- 
    function(labels) {
        #Replace special characters
        f <- gsub("\\-|(\\(\\))", "\\.", labels)
        f <- gsub("\\.{1,}", "\\.", f)
        f <- gsub("\\.$", "", f)
        #Replace prefix abbreviations
        f <- sub("^t", "time", f);
        f <- sub("^f", "frequency", f);
        #Replace abbreviations
        f <- sub("Acc", "Accelerometer", f)
        f <- sub("Mag", "Magnitude", f)
        f <- sub("Gyro", "Gyroscope", f)
        f
    }

feature.headers <- sapply(features$Label, format.features)

# Prepare activity data labels from data 
activities <- read.table(filePath.activity_labels,
                         col.names = c("ActivityCode", "Activity"))

activities.train <- merge(activities, 
                          read.table(filePath.train_label,
                                     col.names = c("ActivityCode")), 
                          by.x = "ActivityCode", 
                          by.y = "ActivityCode")

activities.test <- merge(activities, 
                          read.table(filePath.test_label,
                                     col.names = c("ActivityCode")), 
                          by.x = "ActivityCode", 
                          by.y = "ActivityCode")

# CBind Subjects, Activities and wide data set, 
# then combine the train and test data sets
dt.train <- cbind(read.table(filePath.train_subjects,
                             col.names = c("Subject")),
                  list(Activity = activities.train$Activity),
                  read.table(filePath.train,
                             col.names = feature.headers))

dt.test <- cbind(read.table(filePath.test_subjects,
                            col.names = c("Subject")),
                 list(Activity = activities.test$Activity),
                 read.table(filePath.test, 
                            col.names = feature.headers))

dt <- rbind(dt.train, dt.test)

#Extract mean and standard deviation variables
tidydata <- tbl_df(dt[,c(TRUE, TRUE, grepl("(mean\\(\\))|(std\\(\\))", features$Label))])

#Clean the environment
rm(dt.test,dt.train,activities,activities.train,activities.test,features,feature.headers)

#Build tidy data set of averages across subjects and activites
tidydata <- tidydata %>%
    group_by(Subject, Activity) %>%
    summarize(
        Avg.timeBodyAccelerometer.mean.X = mean((timeBodyAccelerometer.mean.X)),
        Avg.timeBodyAccelerometer.mean.Y = mean((timeBodyAccelerometer.mean.Y)),
        Avg.timeBodyAccelerometer.mean.Z = mean((timeBodyAccelerometer.mean.Z)),
        Avg.timeBodyAccelerometer.std.X = mean((timeBodyAccelerometer.std.X)),
        Avg.timeBodyAccelerometer.std.Y = mean((timeBodyAccelerometer.std.Y)),
        Avg.timeBodyAccelerometer.std.Z = mean((timeBodyAccelerometer.std.Z)),
        Avg.timeGravityAccelerometer.mean.X = mean((timeGravityAccelerometer.mean.X)),
        Avg.timeGravityAccelerometer.mean.Y = mean((timeGravityAccelerometer.mean.Y)),
        Avg.timeGravityAccelerometer.mean.Z = mean((timeGravityAccelerometer.mean.Z)),
        Avg.timeGravityAccelerometer.std.X = mean((timeGravityAccelerometer.std.X)),
        Avg.timeGravityAccelerometer.std.Y = mean((timeGravityAccelerometer.std.Y)),
        Avg.timeGravityAccelerometer.std.Z = mean((timeGravityAccelerometer.std.Z)),
        Avg.timeBodyAccelerometerJerk.mean.X = mean((timeBodyAccelerometerJerk.mean.X)),
        Avg.timeBodyAccelerometerJerk.mean.Y = mean((timeBodyAccelerometerJerk.mean.Y)),
        Avg.timeBodyAccelerometerJerk.mean.Z = mean((timeBodyAccelerometerJerk.mean.Z)),
        Avg.timeBodyAccelerometerJerk.std.X = mean((timeBodyAccelerometerJerk.std.X)),
        Avg.timeBodyAccelerometerJerk.std.Y = mean((timeBodyAccelerometerJerk.std.Y)),
        Avg.timeBodyAccelerometerJerk.std.Z = mean((timeBodyAccelerometerJerk.std.Z)),
        Avg.timeBodyGyroscope.mean.X = mean((timeBodyGyroscope.mean.X)),
        Avg.timeBodyGyroscope.mean.Y = mean((timeBodyGyroscope.mean.Y)),
        Avg.timeBodyGyroscope.mean.Z = mean((timeBodyGyroscope.mean.Z)),
        Avg.timeBodyGyroscope.std.X = mean((timeBodyGyroscope.std.X)),
        Avg.timeBodyGyroscope.std.Y = mean((timeBodyGyroscope.std.Y)),
        Avg.timeBodyGyroscope.std.Z = mean((timeBodyGyroscope.std.Z)),
        Avg.timeBodyGyroscopeJerk.mean.X = mean((timeBodyGyroscopeJerk.mean.X)),
        Avg.timeBodyGyroscopeJerk.mean.Y = mean((timeBodyGyroscopeJerk.mean.Y)),
        Avg.timeBodyGyroscopeJerk.mean.Z = mean((timeBodyGyroscopeJerk.mean.Z)),
        Avg.timeBodyGyroscopeJerk.std.X = mean((timeBodyGyroscopeJerk.std.X)),
        Avg.timeBodyGyroscopeJerk.std.Y = mean((timeBodyGyroscopeJerk.std.Y)),
        Avg.timeBodyGyroscopeJerk.std.Z = mean((timeBodyGyroscopeJerk.std.Z)),
        Avg.timeBodyAccelerometerMagnitude.mean = mean((timeBodyAccelerometerMagnitude.mean)),
        Avg.timeBodyAccelerometerMagnitude.std = mean((timeBodyAccelerometerMagnitude.std)),
        Avg.timeGravityAccelerometerMagnitude.mean = mean((timeGravityAccelerometerMagnitude.mean)),
        Avg.timeGravityAccelerometerMagnitude.std = mean((timeGravityAccelerometerMagnitude.std)),
        Avg.timeBodyAccelerometerJerkMagnitude.mean = mean((timeBodyAccelerometerJerkMagnitude.mean)),
        Avg.timeBodyAccelerometerJerkMagnitude.std = mean((timeBodyAccelerometerJerkMagnitude.std)),
        Avg.timeBodyGyroscopeMagnitude.mean = mean((timeBodyGyroscopeMagnitude.mean)),
        Avg.timeBodyGyroscopeMagnitude.std = mean((timeBodyGyroscopeMagnitude.std)),
        Avg.timeBodyGyroscopeJerkMagnitude.mean = mean((timeBodyGyroscopeJerkMagnitude.mean)),
        Avg.timeBodyGyroscopeJerkMagnitude.std = mean((timeBodyGyroscopeJerkMagnitude.std)),
        Avg.frequencyBodyAccelerometer.mean.X = mean((frequencyBodyAccelerometer.mean.X)),
        Avg.frequencyBodyAccelerometer.mean.Y = mean((frequencyBodyAccelerometer.mean.Y)),
        Avg.frequencyBodyAccelerometer.mean.Z = mean((frequencyBodyAccelerometer.mean.Z)),
        Avg.frequencyBodyAccelerometer.std.X = mean((frequencyBodyAccelerometer.std.X)),
        Avg.frequencyBodyAccelerometer.std.Y = mean((frequencyBodyAccelerometer.std.Y)),
        Avg.frequencyBodyAccelerometer.std.Z = mean((frequencyBodyAccelerometer.std.Z)),
        Avg.frequencyBodyAccelerometerJerk.mean.X = mean((frequencyBodyAccelerometerJerk.mean.X)),
        Avg.frequencyBodyAccelerometerJerk.mean.Y = mean((frequencyBodyAccelerometerJerk.mean.Y)),
        Avg.frequencyBodyAccelerometerJerk.mean.Z = mean((frequencyBodyAccelerometerJerk.mean.Z)),
        Avg.frequencyBodyAccelerometerJerk.std.X = mean((frequencyBodyAccelerometerJerk.std.X)),
        Avg.frequencyBodyAccelerometerJerk.std.Y = mean((frequencyBodyAccelerometerJerk.std.Y)),
        Avg.frequencyBodyAccelerometerJerk.std.Z = mean((frequencyBodyAccelerometerJerk.std.Z)),
        Avg.frequencyBodyGyroscope.mean.X = mean((frequencyBodyGyroscope.mean.X)),
        Avg.frequencyBodyGyroscope.mean.Y = mean((frequencyBodyGyroscope.mean.Y)),
        Avg.frequencyBodyGyroscope.mean.Z = mean((frequencyBodyGyroscope.mean.Z)),
        Avg.frequencyBodyGyroscope.std.X = mean((frequencyBodyGyroscope.std.X)),
        Avg.frequencyBodyGyroscope.std.Y = mean((frequencyBodyGyroscope.std.Y)),
        Avg.frequencyBodyGyroscope.std.Z = mean((frequencyBodyGyroscope.std.Z)),
        Avg.frequencyBodyAccelerometerMagnitude.mean = mean((frequencyBodyAccelerometerMagnitude.mean)),
        Avg.frequencyBodyAccelerometerMagnitude.std = mean((frequencyBodyAccelerometerMagnitude.std)),
        Avg.frequencyBodyBodyAccelerometerJerkMagnitude.mean = mean((frequencyBodyBodyAccelerometerJerkMagnitude.mean)),
        Avg.frequencyBodyBodyAccelerometerJerkMagnitude.std = mean((frequencyBodyBodyAccelerometerJerkMagnitude.std)),
        Avg.frequencyBodyBodyGyroscopeMagnitude.mean = mean((frequencyBodyBodyGyroscopeMagnitude.mean)),
        Avg.frequencyBodyBodyGyroscopeMagnitude.std = mean((frequencyBodyBodyGyroscopeMagnitude.std)),
        Avg.frequencyBodyBodyGyroscopeJerkMagnitude.mean = mean((frequencyBodyBodyGyroscopeJerkMagnitude.mean)),
        Avg.frequencyBodyBodyGyroscopeJerkMagnitude.std = mean((frequencyBodyBodyGyroscopeJerkMagnitude.std))
    ) 

write.table(tidydata, file="averages.subject_activity.txt", row.name = FALSE)