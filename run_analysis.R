#Load required packages.
library(dplyr)

#Download the dataset.
if(!file.exists("./data")){dir.create("./data")}
datasetURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(datasetURL,destfile="./data/Dataset.zip",method="curl")

#Unzip the dataset.
if (!file.exists("UCI HAR Dataset")) { 
  unzip(zipfile = "./data/Dataset.zip", exdir = "./data")
}

#Check the downloaded dataset. Get the list of the files
datasetPATH <- file.path("./data", "UCI HAR Dataset")
filesLIST <- list.files(datasetPATH, recursive = TRUE)
filesLIST

#Read data from the required/targeted files; Assign data frames/variables
#Subject Files
subject_test <- read.table(file.path(datasetPATH, "test", "subject_test.txt"), col.names = "subject")
subject_train <- read.table(file.path(datasetPATH, "train", "subject_train.txt"), col.names = "subject")
#Activity Files
activity_labels <- read.table(file.path(datasetPATH, "activity_labels.txt"), col.names = c("code", "activity"))
activity_test <- read.table(file.path(datasetPATH, "test", "Y_test.txt"), col.names = "code")
activity_train <- read.table(file.path(datasetPATH, "train", "Y_train.txt"), col.names = "code")
#Features Files
features_labels <- read.table(file.path(datasetPATH, "features.txt"), col.names = c("n", "functions"))
features_test <- read.table(file.path(datasetPATH, "test", "X_test.txt"), col.names = features_labels$functions)
features_train <- read.table(file.path(datasetPATH, "train", "X_train.txt"), col.names = features_labels$functions)



### 1. MERGES THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET

#Merge by rows
subject_merged <- rbind(subject_train, subject_test)
activity_merged <- rbind(activity_train, activity_test) #Y
features_merged <- rbind(features_train, features_test) #X
#Merge by columns
All_merged <- cbind(subject_merged, activity_merged, features_merged)



### 2. EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT

#Extract (only the mean and std)
TidyData <- All_merged %>% select(subject, code, contains("mean"), contains("std"))



### 3. USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET

TidyData$code <- activity_labels[TidyData$code, 2] #activity_labels from line 24



### 4. APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES

names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))




### 5. FROM THE DATA SET IN STEP 4, CREATE A SECOND, INDEPENDENT TIDY DATA SET 
# WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT

#Final Tidy Data
FinalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

