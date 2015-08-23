# Data Cleaning Project

## Project Overview
This data cleaning project is focused on cleaning a data set that has been downloaded from the internet.

## R Script
The run_analysis.R script created for this project resides in the repo. It will run the data set specifically assigned for this project.

## Production
The run_analysis.R script will produce a tidy data set for the data used. The file produced will be a tidydata.txt file that will be tab delimited and can be viewed using Excel.

## How Script Works

### Step 1 Merges the training and the test sets to create one data set.
Data is read in by the R script from the files supplied

### Step 2 Extracts only the measurements on the mean and standard deviation for each measurement.
The script only utilizes the measurements mean and standard deviation


### Step 3 Uses descriptive activity names to name the activities in the data set
Each activity was given a descriptive name for the finished data

### Step 4 Appropriately labels the data set with descriptive variable names.
Descriptive variables were assigned to each extracted part of the data set

### Step 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
A second set of independent tidy data was attached to the file
