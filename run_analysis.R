#Load dplyr packege
library(dplyr)

#Download the file
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile="data.zip",method = "curl")

#Unzip the file and change the WD
unzip("data.zip")
setwd(paste(getwd(),"/UCI HAR Dataset",sep=""))

#############################################################
#####                                                  ######
#####         Read general information                 ######
#####                                                  ######
#############################################################

#This file contains the list of all features
features<-read.table("features.txt")

#This file links the class labels with their activity name.
activitylabels<-read.table("activity_labels.txt")

#############################################################
#####                                                  ######
#####                 Read test data                   ######
#####                                                  ######
#############################################################

#This file contains the test labels
test_labels<-read.table("test/y_test.txt")

#This file contains the data from the test
test_data<-read.table("test/X_test.txt")

#Adds to the data the type of data (train or test)
test_data$datatype<-"Test"

#Contains the ID from the subjects who performed the activity (from 1 to 30)
test_subject<-read.table("test/subject_test.txt")


#############################################################
#####                                                  ######
#####                Read train data                   ######
#####                                                  ######
#############################################################

#This file contains the train labels
train_labels<-read.table("train/y_train.txt")

#This file contains the data from the train
train_data<-read.table("train/X_train.txt")

#Adds to the data the type of data (train or test)
train_data$datatype<-"Train"

#Contains the ID from the subjects who performed the activity (from 1 to 30)
train_subject<-read.table("train/subject_train.txt")

#############################################################
#####                                                  ######
#####      Add the column names and marge data         ######
#####                                                  ######
#############################################################

#Join the test data to the labels and subject
test_data_join<-cbind(test_subject,test_labels,test_data)

#Join the train data to he labels and subject
train_data_join<-cbind(train_subject,train_labels,train_data)

#Marge both, test and train data in one object
data<-rbind(test_data_join,train_data_join)

#Creates a new vector with only the names of the features (it changes to character)
features2<-as.character(features[,2])

#Add to the features the subject and label
col_names<-c("subjectid","labelid",features2,"datatype")

#Changes the name of the columns to the col_names vector
names(data)<-col_names

#############################################################
#####                                                  ######
#####                tyding data                       ######
#####                                                  ######
#############################################################


#Change the names of columns in activitylabels
names(activitylabels)<-c("labelid","activity")

#Creates a new DF with the activity label
data_label<-merge(data,activitylabels,by.x="labelid",by.y="labelid",all=TRUE)

#It deletes all duplicated columns
data_filter<-data_label[,!duplicated(names(data_label))]

#It selects columns with mean or std at the end without the dimmension (x,y,z)
#I did this because I just want to get the magnitud of the vector in this table, not 
#the magnitud in each dimension
data_select<-select(data_filter, activity, subjectid, datatype, matches("mean\\(\\)$"), matches("std\\(\\)$"))

#############################################################
#####                                                  ######
#####      Changing variables names                    ######
#####                                                  ######
#############################################################

#I create a new vector with the variables names
variablenames<-names(data_select)

#All to lowercase
variablenames<-tolower(variablenames)

#Reeplaces t for time and f for frequency in the headers
variablenames<-sub("^t","time",variablenames)
variablenames<-sub("^f","frequency",variablenames)

#It deletes the () at the end of the variables
variablenames<-sub("\\(\\)","",variablenames)

#Because I know that all are magnitudes I delete the "MAG" from the variable name
variablenames<-sub("mag-","",variablenames)

#Change the "acc" to "acceleration"
variablenames<-sub("acc","acceleration",variablenames)

#Delete body when it is repeated in the header
variablenames<-sub("bodybody","body",variablenames)

#New copy of the dataset with the new names
data_named<-data_select
names(data_named)<-variablenames

#############################################################
#####                                                  ######
#####                  Grouping By                     ######
#####                                                  ######
#############################################################

#It deletes the column datatype (not used in the analysis) and the it groups by activity and subjectid
data_grouped<- data_named %>% 
                        select(-datatype) %>%
                        group_by(activity,subjectid)

#It calculates the mean to the groups
data_summarize<-summarize_all(data_grouped,funs(mean))

#Now the headers must change because they are a new calculated variable
newnames<-paste("average",names(data_summarize[,3:ncol(data_summarize)]),sep="")
newnames<-c(names(data_summarize[,1:2]),newnames)

#New copy of the dataset with the new names
data_summarize_named<-data_summarize
names(data_summarize_named)<-newnames

#Delete all the unnecesary objects
rm(list=ls()[! ls() %in% c("data_summarize_named","data_named")])

#Write table summarized
setwd("..")
write.table(data_summarize_named,file="data_summarize_named.txt", row.name=FALSE)