# setwd("D:/Fan/Study/Freshman/Coursera/Getting Data/Project")
# Step 1
# Merge the training and the test sets to create one data set.
train<-read.table('./data/train/X_train.txt')
trainlabel<-read.table("./data/train/y_train.txt")
trainsubject <- read.table("./data/train/subject_train.txt")
test<- read.table("./data/test/X_test.txt")
testlabel <- read.table("./data/test/y_test.txt") 
testsubject <- read.table("./data/test/subject_test.txt")
data<-rbind(train, test)
datalabel<-rbind(trainlabel, testlabel)
datasubject<-rbind(trainsubject, testsubject)
names(datasubject)<-"Subject"

# Step 2
# Extract only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("./data/features.txt")
meanstd<-grep("-(mean|std)\\(\\)", features[, 2])
data<-data[, meanstd]
names(data)<-features[meanstd,2]

# Step 3
# Use descriptive activity names to name the activities in the data set
activity <- read.table("./data/activity_labels.txt")
datalabel[, 1] <- activity[datalabel[, 1], 2]
colnames(datalabel)[1]<-"activity"

# Step 4
# Appropriately label the data set with descriptive variable names. 
# Save the tidy data set into a text file.
finaldata<-cbind(datasubject, datalabel, data)
write.table(finaldata, "data.txt", row.names=FALSE)

# Step 5
# Create a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
finaldatamean<- finaldata %>% group_by(Subject, activity) %>% summarise_each(funs(mean), 3:68)
write.table(finaldatamean, "data_mean.txt", row.name=FALSE)
