Coursera - Getting and Cleaning Data Project 
Submission by Daniel Paz, August 17, 2019
============================================

This analysis uses the UCI HAR Dataset to generate a tidy dataset to disk for further analysis. The UCI HAR Dataset contains experimental data of subject movement across a variety of domains. Details of the source analysis are contained in this dataset. 

This analysis builds on that data to combine mean and standard deviation data and summarize these variables as averages over subjects and the physical activity performed when the measurements were taken. 

When the contained R script is executed, a TXT file output of data is generated.

Each row in the resulting TXT file dataset represents:
======================================================
- Subject: identified by number from original source data
- Activity: text identifier of the movement performed in the experiment
- Averages of...: averages of each mean and standard deviation value of the source. The names of each variable illustrate the underlying variable from the UCI HAR Dataset and made more readable by expanding abberivations and removing special characters. 

Notes:
======
- The analysis depends on the 'dplyr' package. This package must be available prior to executing the 'run_analysis.R' script

- The dataset is created in the working directory alongside the R script, and is named 'averages.subject_activity.txt'


This dataset includes the following files:
==========================================

- 'README.md'

- 'run_analysis.R':   R code script which preforms the analysis of the source data and generates a tidy dataset in a named file 'averages.subject_activity.txt'

- 'CodeBook.md':  Describes the dataset variables in the resulting file, "averages.subject_activity.txt"

- UCI HAR Dataset/*: The source dataset used in the analysis, containing:
    - 'UCI HAR Dataset/README.txt': Description of the source data, created by the original authors
    - 'UCI HAR Dataset/features_info.txt': Shows information about the variables used on the feature vector.
    - 'UCI HAR Dataset/features.txt': List of all features.
    - 'UCI HAR Dataset/activity_labels.txt': Links the class labels with their activity name.
    - 'UCI HAR Dataset/train/X_train.txt': Training set.
    - 'UCI HAR Dataset/train/y_train.txt': Training labels.
    - 'UCI HAR Dataset/train/subject_train.txt': Identifies the subject who performed each train activity.
    - 'UCI HAR Dataset/test/X_test.txt': Test set.
    - 'UCI HAR Dataset/test/y_test.txt': Test labels.
    - 'UCI HAR Dataset/test/subject_train.txt': Identifies the subject who performed each test activity.



R code to execute and read the data into a variable "tidy_data":
======================================================================
source("run_analysis.R")
tidy_data <- read.table(file = "./averages.subject_activity.txt", header = TRUE, sep = "")


Sources and References:
=======================
Source data set:    
    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
    
Tidy Data by Hadley Wickham:
    http://vita.had.co.nz/papers/tidy-data.pdf
    
Code book reference (2006 American Community Survey data, Idaho state):
    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf