##Obtain data

## Check if the cwd contains unziped data archive, otherwise obtain it
if (!file.exists("./UCI HAR Dataset")) {
  ## Check if the cwd contains zip data archive otherwise download it
  myfile <- "./getdata_projectfiles_UCI HAR Dataset.zip"
  if (!file.exists(myfile)) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile = myfile, mode = "wb")
  } 
  
  ## Unzip downloaded file
  unzip(myfile)
}

## Load data
trainx <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainy <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")

testx <- read.table("./UCI HAR Dataset/test/X_test.txt")
testy <- read.table("./UCI HAR Dataset/test/y_test.txt")
testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

features <- read.table("./UCI HAR Dataset/features.txt")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Merge training and test sets
mergedx <- rbind(trainx, testx)
mergedy <- rbind(trainy, testy)
mergedsubject <- rbind(trainsubject, testsubject)

## Assign names to mergedx from features
colnames(mergedx) <- features[,2]

## Select only colums with "mean()" or "std()" in column description
selectedcol <- grep("mean\\(\\)|std\\(\\)", colnames(mergedx))
mergedx <- mergedx[selectedcol]

## Remove dashes and parentheses from names
colnames(mergedx) <- gsub("-|\\(|\\)", "", colnames(mergedx))

## Factor activities and replace numbers with descriptive activities names
mergedactivities <- factor(mergedy[, 1])
levels(mergedactivities) <- activities[, 2]

## Merge all data into one data.frame
alldata <- cbind(activity = mergedactivities, subject = mergedsubject, mergedx)
colnames(alldata) <- c("activity", "subject", colnames(mergedx))

## Calculate average for each activity and each subject
dataaver <- aggregate(alldata[-2:-1], by = list(alldata$activity, alldata$subject), FUN = mean)
colnames(dataaver) <- colnames(alldata)

## Write cleaned data into cleandata.txt in cwd
write.table(dataaver, file = "cleandata.txt", row.names = FALSE)