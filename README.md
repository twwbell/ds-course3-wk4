# Getting and Cleaning Data Course Project
This project is part of the Johns Hopkins Data Science program on Coursera. The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.

This repository contains:
* The original data set
* A script: run_analysis.R; which tidies the data and produces an independent data set
* An independent data set: AvgOf_Mean_Std.txt; with the average of each variable for each activity and each subject
* A Codebook, describing all the variables in the new data set
* This README, describing the contents of the repositories and the steps to reproduce the analysis


## Original data set
Abstract of the original data set: Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Source of the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

From the data set the following files have been used for analysis in this project:
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

### Attribution source
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws


## Analysis
The R script called run_analysis.R that does the following:
1.Merges the training and the test sets to create one data set.
** Read all required data
** Add activity labels with descriptions to both sets using left_join (test and training)
** Prepare vector with column headers using activity, subject and features (variables)
** Merge columns on both sets (test and training)
** Bind test and training and remove activity IDs
1.Extracts only the measurements on the mean and standard deviation for each measurement.
** Subset columns for mean and std using grep and convert to numeric
1. Uses descriptive activity names to name the activities in the data set
** See step 1
1. Appropriately labels the data set with descriptive variable names
** See step 1
1. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
** Split subset into list for each activity and subject combination
** Calculate average for for each activity and each subject using colMeans
** Unsplit mean_set, extract activity and improve column names
** Put it all together and remove redundant row names
** Write meanlist to file

## Independent data set
AvgOf_Mean_Std.txt is an independent tidy data set with the average of each variable for each activity and each subject.

Codebook.md is a codebook describing all the variables in the new data set. This codebook was rendered using the codebook() function of the memisc package (version 0.99.8) from CRAN.

# Script to easily read my data set
address <- "https://raw.githubusercontent.com/twwbell/ds-course3-wk4/master/AvgOf_Mean_Std.txt"
address <- sub("^https", "http", address)
data <- read.table(url(address), header = TRUE) 
View(data)
