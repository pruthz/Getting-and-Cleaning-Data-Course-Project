---
title: "CodeBook"
author: "Paola Ruth Zapanta"
date: "12/23/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

The **run_analysis.R** script performs the necessary data preparation and the five (5) steps that were required in the Course Project's definition.

## Preparations

- Loaded required package.
- Dataset downloaded and extracted under the folder called `UCI HAR Dataset` inside 'data' folder.
- Reading data from the required files and assigned each data to `variables`.
  - test/subject_test.txt to `subject_test` : 2947 obs. of  1 variable
  - train/subject_train.txt to `subject_train` : 7352 obs. of  1 variable
  - activity_labels.txt to `activity_labels` : 6 obs. of  2 variables
  - test/Y_test.txt to `activity_test` : 2947 obs. of  1 variable
  - train/Y_train.txt to `activity_train` : 7352 obs. of  1 variable
  - features.txt to `features_labels` : 561 obs. of  2 variables
  - test/X_test.txt to `features_test` : 2947 obs. of  561 variables
  - train/X_train.txt to `features_train` : 7352 obs. of  561 variables
  

## Required Steps as described in the Course Project's Definition

### 1. MERGED THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET
  - `subject_merged` (10299 obs. of  1 variable) created by merging `subject_train` and `subject_test` using **rbind()** function.
  - `activity_merged` (10299 obs. of  1 variable) created by merging `activity_train` and `activity_test` using **rbind()** function.
  - `features_merged` (10299 obs. of  561 variables) created by merging `features_train` and `features_test` using **rbind()** function.
  - `All_merged` (10299 obs. of  563 variables) created by merging `subject_merged`, `activity_merged`, and `features_merged` using **cbind()** function.
  
### 2. EXTRACTED (ONLY) THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
  -`TidyData` (10299 obs. of  88 variables) created by subsetting `All_merged`, selecting only the following columns: subject, code, and measurements containing *mean* and *std*.

### 3. USED DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
  - Values in `code` column of the `TidyData` replaced with corresponding activity in `activity_labels` variable (that was assigned during the Preparation stage).

### 4. APPROPRIATELY LABELED THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
  - All columns with name starting with `t` replaced by `Time`.    
  - All columns with name starting with `f` replaced by `Frequency`.
  - Second column of `TidyData` named as `activity`.
  - All `Acc` in column's name replaced by `Accelerometer`.
  - All `Gyro` in column's name replaced by `Gyroscope`.
  - All `BodyBody` in column's name replaced by `Body`.
  - All `Mag` in column's name replaced by `Magnitude`.
  - All `tBody` in column's name replaced by `TimeBody`.
  - All `-mean()` in column's name replaced by `Mean`.
  - All `-std()` in column's name replaced by `STD`.
  - All `-freq()` in column's name replaced by `Frequency`.
  - All `angle` in column's name replaced by `Angle`.
  - All `gravity` in column's name replaced by `Gravity`.
  
### 5. CREATE A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
  - `FinalData` (180 rows x 88 columns) created by summarizing `TidyData` taking the average / means of each variable for each activity and each subject, after grouping it by `subject` and `activity`. 
  - Exported `FinalData` into `FinalData.txt` file using **write.table()** function.