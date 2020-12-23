# Peer-graded Assignment: Getting and Cleaning Data Course Project

This repository is created as a requirement in Getting and Cleaning Data Course. It has the instructions on how to run analysis on the `Human Activity Recognition` dataset.

## Dataset
[Human Activity Recognition Using Smartphones](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Analysis Files
  - `CodeBook.md` is a code book that describes the variables, the data, and the transformations I performed to prepare, clean up, and tidy the data

  - `run_analysis.R` is an R script that performs the data preparation and then followed by the 5 steps required as described in the course project’s definition. The 5 required steps are as follows:
    - Merges the training and the test sets to create one data set.
    - Extracts only the measurements on the mean and standard deviation for each measurement.
    - Uses descriptive activity names to name the activities in the data set
    - Appropriately labels the data set with descriptive variable names.
    - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

  - `FinalData.txt` is the final data in *.txt* format after going through all the sequences described above.