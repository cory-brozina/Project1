
#Loading the test set first: x and y, features and subjects

X_test <- read.table("C:/Grad Classes/DataScience/Getting and Cleaning Data/Project1/UCI HAR Dataset/test/X_test.txt", quote="\"", stringsAsFactors=FALSE)
y_test <- read.table("C:/Grad Classes/DataScience/Getting and Cleaning Data/Project1/UCI HAR Dataset/test/y_test.txt", quote="\"", stringsAsFactors=FALSE)
features <- read.table("C:/Grad Classes/DataScience/Getting and Cleaning Data/Project1/UCI HAR Dataset/features.txt", quote="\"")
subject_test <- read.table("C:/Grad Classes/DataScience/Getting and Cleaning Data/Project1/UCI HAR Dataset/test/subject_test.txt", quote="\"", stringsAsFactors=FALSE)

# Combine the features to the X_test so that X_test has correct column labels
features1 <- as.character(features$V2)
colnames(X_test) <- c(features1)

# Change the column label for subject_test and y_test and combine it with the X_test data
colnames(subject_test) <- c("Subject")
colnames(y_test) <- c("Activity")
X_test <- cbind(subject_test,y_test,X_test)

#Loading the train set files now: x,y, and subject
subject_train <- read.table("C:/Grad Classes/DataScience/Getting and Cleaning Data/Project1/UCI HAR Dataset/train/subject_train.txt", quote="\"", stringsAsFactors=FALSE)
X_train <- read.table("C:/Grad Classes/DataScience/Getting and Cleaning Data/Project1/UCI HAR Dataset/train/X_train.txt", quote="\"", stringsAsFactors=FALSE)
y_train <- read.table("C:/Grad Classes/DataScience/Getting and Cleaning Data/Project1/UCI HAR Dataset/train/y_train.txt", quote="\"", stringsAsFactors=FALSE)

# Combine the features to the X_train so that X_train has correct column labels
colnames(X_train) <- c(features1)

# Change the column label for subject_train and y_train and combine it with the X_train data
colnames(subject_train) <- c("Subject")
colnames(y_train) <- c("Activity")
X_train <- cbind(subject_train,y_train,X_train)

#Now we can combine the test set and the train set into one data set
all.activity <- rbind(X_test,X_train)

#Reducing X_test data set down to just the means/std reported
means <- all.activity[,grep("mean()",names(all.activity))]
std <- all.activity[,grep("std()",names(all.activity))]
subjects.activity <- all.activity[1:2]
activity.mean.std <- cbind(subjects.activity,means,std)

#Now let's name all the Activity labels for that column instead of having numbers
activity.mean.std$Activity <- factor(all.activity$Activity,levels=c(1,2,3,4,5,6),labels=c("Walking","Walking_Upstairs","Walking_Downstairs","Sitting","Standing","Laying"))

#Obtaining averages across variables by Subject and Activity
activity.mean.std$Subject <- as.factor(activity.mean.std$Subject)
aggdata <- aggregate(activity.mean.std,by=list(activity.mean.std$Subject,activity.mean.std$Activity),FUN=mean,na.rm=TRUE)

#Saving the new data set, aggdata, to a text file on your computer
write.table(aggdata,"C:/Grad Classes/DataScience/Getting and Cleaning Data/Project1/aggdata.txt")



