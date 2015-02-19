library(plyr)
library(dplyr)
library(tidyr)

## read in test data
test.dt <- read.table("./test/X_test.txt",sep="")
## add activity labels as column v562
test.dt$v562 <- scan("./test/y_test.txt")
## add subject ids as column v563
test.dt$v563 <- scan("./test/subject_test.txt")

## read train data
train.dt <- read.table("./train/X_train.txt",sep="")
## add activity labels as column v562
train.dt$v562 <- scan("./train/y_train.txt")
## add subject ids as column v563
train.dt$v563 <- scan("./train/subject_train.txt")

## merge the test and train data frames
merged.dt <- rbind(test.dt,train.dt)

## create a vector containing the column names
heading.names <- scan("features.txt",what='character')
##  Replace "-" (dash) characters in variable names with "_" (underscore)
heading.names <- gsub("-","_",heading.names)
## Strip out the column numbers and add the activity and subject column names
merged.names <- heading.names[c(FALSE,TRUE)]%>%c("activity","subject")
## insert descriptive column names into the data frame merged.dt
colnames(merged.dt) <- merged.names

## Replace activity number codes with descriptive activity names
merged.dt$activity <- factor(merged.dt$activity,c("1","2","3","4","5","6"),labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
## Make subject numbers into factors
merged.dt$subject <- factor(merged.dt$subject)

## Select the columns numbers with mean, std, activity, and subject in the column name
colToExtract <- grep("Mean|mean|std|activity|subject",names(merged.dt))

## create a data set with only the columns selected above
stepFour.dt <- merged.dt[,colToExtract]

## library(plyr)
# summarize over all numeric columns
tidyData.df <- ddply(stepFour.dt, .(subject, activity), numcolwise(mean))

## Write a text file
write.table(tidyData.df,file="tidyData.txt",row.name=FALSE,sep=",")
