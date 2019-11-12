# README

This README explain the transformation and analysis done to the Human Activity Recognition Using Smartphones Dataset.

## Script explained
In this section, the script called "run_analysis.R" will be explained systematically.

### Setting up the script
Firstly, it is needed to select the working directory. Then, is it possible to install and load the dplyr package. This can be done running the following command.

```sh
install.packages("dplyr")
library(dplyr)
```

### Downloading and reading data
The data is compressed in a zip file located in the following [website]("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"). This url is stored in a object called "fileurl" and the it is downloaded using the following command.

```sh
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile="data.zip",method = "curl")
```
Once the file has been downloaded it is possible to unzip the file and then change the working directory to the new folder.

```sh
unzip("data.zip")
setwd(paste(getwd(),"/UCI HAR Dataset",sep=""))
```

Now it is possible to load all the needed data using the following command.

```sh
#This file contains the test labels
test_labels<-read.table("test/y_test.txt")

#This file contains the data from the test
test_data<-read.table("test/X_test.txt")

#Adds to the data the type of data (train or test)
test_data$datatype<-"Test"

#Contains the ID from the subjects who performed the activity (from 1 to 30)
test_subject<-read.table("test/subject_test.txt")

#This file contains the train labels
train_labels<-read.table("train/y_train.txt")

#This file contains the data from the train
train_data<-read.table("train/X_train.txt")

#Adds to the data the type of data (train or test)
train_data$datatype<-"Train"

#Contains the ID from the subjects who performed the activity (from 1 to 30)
train_subject<-read.table("train/subject_train.txt")
```

### Adding columns names and marging data
The main data is splitted in three files (subject, labels and experiment data). Therefore, two new datasets are created, which have all the information in only one object.

```sh
#Join the test data to the labels and subject
test_data_join<-cbind(test_subject,test_labels,test_data)

#Join the train data to he labels and subject
train_data_join<-cbind(train_subject,train_labels,train_data)
```

Then the two datasets can be merged.
```sh
data<-rbind(test_data_join,train_data_join)
```

Now that all the data is in one object, the names can be changed. To accomplish that, the variables names are extracted from the features data (second column). Thi information is stored in the object "features2" as characters. Consequently, an object called "col_names" is created combining the column names.

```sh
#Creates a new vector with only the names of the features (it changes to character)
features2<-as.character(features[,2])

#Add to the features the subject and label
col_names<-c("subjectid","labelid",features2,"datatype")

#Changes the name of the columns to the col_names vector
names(data)<-col_names
```
### Joining and selecting columns
With the purpose of executing a Join (merge) command, the column names of the dataset "activitylabels" must be changed to match to the "data" dataset column names. Now the data is stored in an object called "data_label".

```sh
#Change the names of columns in activitylabels
names(activitylabels)<-c("labelid","activity")

#Creates a new DF with the activity label
data_label<-merge(data,activitylabels,by.x="labelid",by.y="labelid",all=TRUE)
```
The next objective is to extract only the measurements on the mean and standard deviation for each measurement. In this case, it was decided that only measurement of magnitude will be extracted (not selecting x-y-z components). Before selecting the columns, no duplicated column must exists.

In the select function, columns which match "mean()" or "std()" at the end are selected. The new dataset is stored in the object "data_select"

```sh
#It deletes all duplicated columns
data_filter<-data_label[,!duplicated(names(data_label))]

data_select<-select(data_filter, activity, subjectid, datatype, matches("mean\\(\\)$"), matches("std\\(\\)$"))
```
### Changing names
The following functions change the names of the dataset to a tidy form. For this reason, it will remove any uppercase and replace any abbreviation for the full name.

Firstly, it will convert all letters to lower case, and then it will replace the "t" and "f" at the beginning of the name for "time" and "frequency" respectively.

```sh
#I create a new vector with the variables names
variablenames<-names(data_select)

#All to lowercase
variablenames<-tolower(variablenames)

#Reeplace t for time and f for frequency in the headers
variablenames<-sub("^t","time",variablenames)
variablenames<-sub("^f","frequency",variablenames)
```

Secondly, the function will remove the parenthesis at the end because they do not have meaning. After that, it will remove the word "MAG" because all the variables are magnitudes, therefore it is not necessary to emphasize that fact. To conclude, it will change "acc" for "acceleration" and remove a repeated word "bodybody".

```sh
#Because I know that all are magnitudes I delete the "MAG" from the variable name
variablenames<-sub("mag-","",variablenames)

#Change the "acc" to "acceleration"
variablenames<-sub("acc","acceleration",variablenames)

#Delete body when it is repeated in the header
variablenames<-sub("bodybody","body",variablenames)

#New copy of the dataset with the new names
data_named<-data_select
names(data_named)<-variablenames
```

Finally, a new dataset "data_named" is created with the new variable names.

### Grouping and summarizing data
The variable (column) "datatype" is not necessary for this analysis, therefore, it is discarded. Then the dataset is grouped by "activity" and "subjectid". Finally, the mean is calculated for every variable in the groups.

```sh
#It deletes the column datatype (not used in the analysis) and the it groups by activity and subjectid
data_grouped<- data_named %>% 
                        select(-datatype) %>%
                        group_by(activity,subjectid)

#It calculates the mean to the groups
data_summarize<-summarize_all(data_grouped,funs(mean))
```

Due to the fact that the variables changes its meaning (they are the meaning of the group now), the names are changed, putting the word "average" at the beginning. The dataset summarized with the new column names is stored in an object called "data_summarize_named"

```sh
#Now the headers must change because they are a new calculated variable
newnames<-paste("average",names(data_summarize[,3:ncol(data_summarize)]),sep="")
newnames<-c(names(data_summarize[,1:2]),newnames)

#New copy of the dataset with the new names
data_summarize_named<-data_summarize
names(data_summarize_named)<-newnames
```

Finally, all unnecessary objects are deleted and a file with the dataset is stored in the original working directory as "data_summarize_named.txt"

```sh
#Delete all the unnecesary objects
rm(list=ls()[! ls() %in% c("data_summarize_named","data_named")])

#Write table summarized
setwd("..")
write.table(data_summarize_named,file="data_summarize_named.txt", row.name=FALSE)
```

## Reading summarized data
Use the following command to read the file with the dataset in R. You must store the file in your working directory.

```sh
data <- read.table(file_path, header = TRUE)
View(data)
```

## Variable names explanation

Read the file CODEBOOK.md located in the GITHUB repo.


