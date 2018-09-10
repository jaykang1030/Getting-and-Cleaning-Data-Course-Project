# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Download the dataset if it does not already exist in the working directory
2. Load the feature and activity info
3. Loads both the X, y, subjeft train set and column bind into train data set
4. Loads both the X, y, subjeft test set and column bind into test data set
5. Merges the two datasets into full data set
6. select the columns that contain `mean` and `std` from full data set
7. Add subject columnn to MeanStd data set as factor
8. Add descriptive activity column to MeanStd dataset as character
9. write the MeanStd dataset into txt file called `data_MeanStd.txt`
10. from MeanStd dataset, extract all data mean of all features group by subject and activity 
