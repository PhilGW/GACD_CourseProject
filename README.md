# Getting and Cleaning Data Course Project
##Course Project for Getting and Cleaning Data

This data analysis makes use of data obtained from a Samsung smartphone accelerometer, available from the UC-Irvine Machine Learning Depository at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data include accelerometer readings created while 30 subjects performed each of 5 tasks.

Data are available for download at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The analysis is performed by a single script, 'run_analysis.R'.  
However, the following must be done prior to running the script:
* The top-level directory from the above download, "UCI HAR Dataset", must be located in the working directory.
* The packages 'plyr' and 'reshape2' must be installed (they will be loaded by the script using the library() function).

Once these are in place, the analysis can be started by running the script 'run_analysis.R'.

###Data summary construction:
The following steps are used to 

1. The "test set" of accelerometer data is read in from the file "UCI HAR Dataset/test/X_test.txt"
2. The "activity codes" describing which activity is being performed are read from the file "UCI HAR Dataset/test/y_test.txt" and appended as an additional column
3. The "subject codes" describing which subject is being recorded are read from the file "UCI HAR Dataset/test/subject_test.txt" and appended as an additional column
4. The "train set" of accelerometer data is read in from the file "UCI HAR dataset/train/X_train.txt"
5. The "activity codes" describing which activity is being performed are read from the file "UCI HAR Dataset/train/y_train.txt" and appended as an additional column
6. The "subject codes" describing which subject is being recorded are read from the file "UCI HAR Dataset/train/subject_train.txt" and appended as an additional column
7. The test-set rows and train-set rows are combined into a single data frame
8. The column names obtained from "UCI HAR Dataset/features.txt" are assigned to the data, along with headings for "activity" (1-5) and "subject_ID" (1-30).
9. A new data frame, "edata", is constructed for only those columns containing the words "mean" or "stdev"
10. Activity and subject_id are made into factors.

This data frame is used to summarize the results of the accelerometer readings.  The summary uses melt() and dcast() to list the average of each accelerometer category by subject_id and activity type.  This is saved as the file ExerciseDataSummary.txt

The output of the script is included in the repo as 'ExerciseDataSummary.txt'.
Details on the variable names and units can be found in the GACD_Codebook markdown file.



