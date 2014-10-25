==================================================================
Average of the Human Activity Recognition Dataset Variables for each subject and activity
Version 1.0
==================================================================
Reghu Warrier
==================================================================

The data for the analysis was downloaded from the following url. Please read the License info at the bottom for details on the use this dataset

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Transformed the data as follows:
======================================
1. For the test and train data sets, do the following
	- read the dataset
	- read the activity data set
	- read the subject data set 
	- update the column names for the  subject table
2. read the features data set and update the column names to more meaningful names
3. short list the number of features(columns) that we are interested in by using the grepl function
4. rename the column names to make it tidy. Otherwise it will give problems down the line
5. read the activity labels 
6. merge the activity Id and activity name data frames for the test and train data sets
7. give meaningful names to the activity tables for test and train
8. select only the column names that we are interested in from the test and train data sets to create a narrow data set. Rename the columns to the features that are selected
9. create the tidy test and train data sets by using the column bind
10. combine the test and train data sets to create the long data set
11. group by the subject_id and the activity and create the summary data to calculate the average of each of the variables
12. rename the columns of the summary data set and add a prefix to show that the value is an average 
 

For each record it is provided:
======================================
- An identifier of the subject who carried out the experiment.
- An identifier of the activity carried out out by the subject
- The activity label corresponding to the activity_id
- average of the 66 variables that measured the mean and std deviation of the movement of the subject

The dataset includes the following files:
=========================================

- 'README.txt'
- run_analysis.R - The code that creates the summary data set
- Code book that describes the variables in the data set. 

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
