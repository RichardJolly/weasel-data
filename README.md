run_analysis.R

Program requirement:

 Create a R script called run_analysis.R that does the following with a data set obtained from “https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip”:
 1.	Merges the training and the test sets to create one data set.
 2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
 3.	Uses descriptive activity names to name the activities in the data set
 4.	Appropriately labels the data set with descriptive variable names. 
 5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Program description:

run_analysis.R reads a test data set “X_test.txt” into the data table “test.dt” which has 561  columns. The columns are named V1 – V561. 

The activity label for each observation of a test subject is contained in the file, “y_test.txt”. run_analysis.R  scans “y_test.txt” into the “test.dt” data table as column v562. Similarly, the subject IDs for each observation, contained in the file “subject_test.txt,” are scanned into “test.dt” as column V563.

The same process is repeated for the training data set. The activity label for each observation of a training subject is contained in the file, “y_train.txt”. run_analysis.R  scans “y_train.txt” into the “train.dt” data table as column v562. Similarly, the subject IDs for each observation, contained in the file “subject_train.txt,” are scanned into “train.dt” as column V563

run_analysis.R merges the test and train data tables into one table using rbind. The new data table is named “merged.dt”.

The column headers V1 through V563 have no descriptive relation to the data. However, the experiment's authors provided descriptive variable names in a file named “features.txt”.  

Some persons may suggest making the variable names even more readable. I did not to do this based on the following information: 
The “features_info.txt” file included with the raw data set indicated that the data was derived from “accelerometer and gyroscope 3-axial raw signals”. Per Google's Android Developers Web Site page: http://developer.android.com/reference/android/hardware/SensorEvent.html
and the Android Developers blogspot page:
http://android-developers.blogspot.com/2010/09/one-screen-turn-deserves-another.html
accelerometer/gyroscope sensor raw data XYZ axis reference is dependent on the phones physical orientation.  The authors did not indicate the orientation of the phone during the experiment, however, on the web page http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones provided by Coursera there is a link to a YouTube video of one of the actual subjects being tested. The video shows that the Samsung phone was in the horizontal position when attached to the subject, therefore, the raw X-axis data indicates vertical measures. The video further revealed that the phone's Y-axis was not facing forward or laterally, but rather at an approximate 45 degree angle to the direction the subject was facing. With the Y/Z axis not aligned to an ordinary person's perception of a subject's motion, general labels such as forward/lateral seemed irrelevant and misleading. I chose to retain the variable labels supplied by the experiment's authors. 

So, run_analysis.R scans the elements from the “features,txt” file into a vector, “heading.names”. All dashes in the variable names are replaced with underscores. The dash replacement is not required for this program to function, but R functions sometimes have problems with dashes in names. In the interest of tidy data for future users of the output from this program, the dashes are removed. The column names, activity and subject, are appended to the vector “heading.names”, and the vector is renamed “merged.names”. Colnames is used to merge “merged.names” to “merged.dt” resulting in a data table with descriptive column names.

The activity and subject columns are coerced into factors to assist with grouping by subject and activity.

run_analysis.R greps for any column name containing “mean”, “Mean”, “std”, “activity”, and “subject”. The result is placed in the vector colToExtract.  colToExtract is used to subset “merged.dt” into ”stepFour.dt”. “stepFour.dt” contains only columns with measures of  mean and standard deviation plus the activity and subject columns.

Now there exists a data table that contains all of the required data (stepFour.dt). 

run_analysis.R groups and summarizes “stepFour.dt” by subject and activity creating a data frame “tidyData.df”.

The final line of code writes out a comma delimited text file version of “tidyData.df” as “tidyData.txt”.
