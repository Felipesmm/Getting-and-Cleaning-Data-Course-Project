# CODEBOOK SUMMARIZE EXPERIMENTS DATA 

The data provided is the same as Human Activity Recognition Using Smartphones Dataset [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
The file that contains the data is called data_summarize_named.txt and it is located in the GITHUB repo.

## Variables
- activity
    - Class: Factor
    - Description: Activity performed by the volunteer in the experiment
    - Levels:
        - LAYING
        - SITTING
        - STANDING
        - WALKING
        - WALKING_DOWNSTAIRS
        - WALKING_UPSTAIRS
- subjectid
    - Class: Integer
    - Description: Each row identifies the subject who performed the activity. Its range is from 1 to 30.
- averagetimebodyaccelerationmean
    - Class: Numeric
    - Description: Average of the mean of time domain signal magnitude for body acceleration signal. The group averaged correspond to the activity and subjectid in the row.
- averagetimegravityaccelerationmean
    - Class: Numeric 
    - Description: Average of the mean of time domain signal magnitude for gravity acceleration signal. The group averaged correspond to the activity and subjectid in the row.
- averagetimebodyaccelerationjerkmean
    - Class: Numeric
    - Description: Average of the mean of the time to obtain the Jerk signal for body acceleration signal. The group averaged correspond to the activity and subjectid in the row.
- averagetimebodygyromean
    - Class: Numeric
    - Description: Average of the mean of time domain signal magnitude for body gyroscope signal. The group averaged correspond to the activity and subjectid in the row.
- averagetimebodygyrojerkmean
    - Class: Numeric
    - Description: Average of the mean of the time to obtain the Jerk signal for body gyroscope signal. The group averaged correspond to the activity and subjectid in the row.
- averagefrequencybodyaccelerationmean
    - Class: Numeric
    - Description: Average of the mean of the frequency domain signal magnitude for body acceleration signal. The group averaged correspond to the activity and subjectid in the row.
- averagefrequencybodyaccelerationjerkmean
    - Class: Numeric
    - Description: Average of the mean of the frecuency to obtain the Jerk signal for body acceleration signal. The group averaged correspond to the activity and subjectid in the row.
- averagefrequencybodygyromean
    - Class: Numeric
    - Description: Average of the mean of the frequency domain signal magnitude for body gyroscope signal. The group averaged correspond to the activity and subjectid in the row.
- averagefrequencybodygyrojerkmean
    - Class: Numeric
    - Description: Average of the mean of the frecuency to obtain the Jerk signal for body gyroscope signal. The group averaged correspond to the activity and subjectid in the row.
- averagetimebodyaccelerationstd
    - Class: Numeric
    - Description: Average of the standard deviation of time domain signal magnitude for body acceleration signal. The group averaged correspond to the activity and subjectid in the row.
- averagetimegravityaccelerationstd
    - Class: Numeric
    - Description: Average of the standard deviation of time domain signal magnitude for gravity acceleration signal. The group averaged correspond to the activity and subjectid in the row.
- averagetimebodyaccelerationjerkstd
    - Class: Numeric
    - Description: Average of the standard deviation of the time to obtain the Jerk signal for body acceleration signal. The group averaged correspond to the activity and subjectid in the row.
- averagetimebodygyrostd
    - Class: Numeric
    - Description: Average of the standard deviation of time domain signal magnitude for body gyroscope signal. The group averaged correspond to the activity and subjectid in the row.
- averagetimebodygyrojerkstd
    - Class: Numeric
    - Description: Average of the standard deviation of the time to obtain the Jerk signal for body gyroscope signal. The group averaged correspond to the activity and subjectid in the row.
- averagefrequencybodyaccelerationstd
    - Class: Numeric
    - Description: Average of the standard deviation of the frequency domain signal magnitude for body acceleration signal. The group averaged correspond to the activity and subjectid in the row.
- averagefrequencybodyaccelerationjerkstd
    - Class: Numeric
    - Description: Average of the standard deviation of the frecuency to obtain the Jerk signal for body acceleration signal. The group averaged correspond to the activity and subjectid in the row.
- averagefrequencybodygyrostd
    - Class: Numeric
    - Description: Average of the standard deviation of the frequency domain signal magnitude for body gyroscope signal. The group averaged correspond to the activity and subjectid in the row.
- averagefrequencybodygyrojerkstd
    - Class: Numeric
    - Description: Average of the standard deviation of the frecuency to obtain the Jerk signal for body gyroscope signal. The group averaged correspond to the activity and subjectid in the row.

## Aditional Information

For additional information visit the [website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).