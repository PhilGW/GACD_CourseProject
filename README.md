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

