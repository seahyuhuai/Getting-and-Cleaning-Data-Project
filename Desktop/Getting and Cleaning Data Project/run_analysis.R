column_names <- read.table("./features.txt")
activity_names <- read.table("./activity_labels.txt")

test <- read.table("./test/X_test.txt", col.names = column_names[,2])
testSubject <- read.table("./test/subject_test.txt", col.names = "subject")
test_testLabel <- read.table("./test/y_test.txt", col.names = "testLabel")
test_combined <- cbind(testSubject,test_testLabel,test)
test_combined$activity <- activity_names[test_combined$testLabel,2]

train <- read.table("./train/x_train.txt", col.names = column_names[,2])
trainSubject <- read.table("./train/subject_train.txt", col.names = "subject")
train_testLabel <- read.table("./train/y_train.txt", col.names = "testLabel")
train_combined <- cbind(trainSubject,train_testLabel,train)
train_combined$activity <- activity_names[train_combined$testLabel,2]

master <- rbind(test_combined, train_combined)

library(reshape2)
long_skinny <- melt(master, id=c("subject", "activity"), measure.vars=c("tBodyAcc.mean...X",
                                                                        "tBodyAcc.mean...Y", "tBodyAcc.mean...Z", "tBodyAcc.std...X", "tBodyAcc.std...Y", "tBodyAcc.std...Z", 
                                                                        "tGravityAcc.mean...X", "tGravityAcc.mean...Y", "tGravityAcc.mean...Z", "tGravityAcc.std...X", 
                                                                        "tGravityAcc.std...Y", "tGravityAcc.std...Z"))

wide <- dcast(long_skinny, activity + subject ~ variable, mean)

names(wide) <- c("Activity", "Test_Subject", "Avg_TimeBodyAccelerationMean_XAxis", 
                 "Avg_TimeBodyAccelerationMean_YAxis", "Avg_TimeBodyAccelerationMean_ZAxis", 
                 "Avg_TimeBodyAccelerationStdDev_XAxis", "Avg_TimeBodyAccelerationStdDev_YAxis", 
                 "Avg_TimeBodyAccelerationStdDev_ZAxis", "Avg_TimeGravityAccelerationMean_XAxis", 
                 "Avg_TimeGravityAccelerationMean_YAxis", "Avg_TimeGravityAccelerationMean_ZAxis", 
                 "Avg_TimeGravityAccelerationStdDev_XAxis", "Avg_TimeGravityAccelerationStdDev_YAxis", 
                 "Avg_TimeGravityAccelerationStdDev_ZAxis")

write.table(wide, "./wide.txt", sep="\t")