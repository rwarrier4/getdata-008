library(dplyr)

#read the test dataset
x_test <- read.table("har/test/X_test.txt")
x_test <- tbl_df(x_test)

#read the test activity data set
y_test <- read.table("har/test/y_test.txt")
y_test <- tbl_df(y_test)

#read the test subject data set 
subject_test <- read.table("har/test/subject_test.txt")
subject_test <- tbl_df(subject_test)

#give meaningful column name for the test subject table
colnames(subject_test) <- c("subject_id")

#read the train dataset
x_train <- read.table("har/train/X_train.txt")
x_train <- tbl_df(x_train)

#read the train activity data set
y_train <- read.table("har/train/y_train.txt")
y_train <- tbl_df(y_train)

#read the train subject data set 
subject_train <- read.table("har/train/subject_train.txt")
subject_train <- tbl_df(subject_train)

#give meaningful column name for the train subject table
colnames(subject_train) <- c("subject_id")

#read the features data set. 
features <- read.table("har/features.txt", stringsAsFactors=FALSE)
features <- tbl_df(features)
colnames(features) <- c("id", "colname")  ##set the colnames to be more meaningful

#short list the number of features(columns) that we are interested in by using the grepl function
features_short <- filter(features, grepl("mean\\(\\)|std\\(\\)", colname))

## we are not really interested in the meanFreq measurement. Dropping those
#features_short <- filter(features_short, !grepl("meanFreq()", colname)) 

## renaming the column names to make it tidy. Otherwise it will give problems down the line
features_short$colname <- gsub("\\()", "", features_short$colname)
features_short$colname <- gsub("\\-", "_", features_short$colname)

#read the activity labels 
activity_labels <- read.table("har/activity_labels.txt", stringsAsFactors=FALSE)
activity_labels <- tbl_df(activity_labels)

#merge the activity Id and activity name data frames for the test and train data sets
y_test <- inner_join(y_test, activity_labels, by = "V1")
y_train <- inner_join(y_train, activity_labels, by = "V1")

#give meaningful names to the activity tables for test and train
colnames(y_test) <- c("activity_id", "activity")
colnames(y_train) <- c("activity_id", "activity")

#select only the column names that we are interested in from the test and train data sets
# to create a narrow data set. Rename the columns to the features that are selected
x_test_narrow <- select(x_test, features_short$id)
x_test_narrow <- tbl_df(x_test_narrow)
colnames(x_test_narrow) <- features_short$colname

x_train_narrow <- select(x_train, features_short$id)
x_train_narrow <- tbl_df(x_train_narrow)
colnames(x_train_narrow) <- features_short$colname

#create the tidy test and train data sets by using the column bind
test_tidy <- cbind(subject_test, y_test, x_test_narrow)
test_tidy <- tbl_df(test_tidy)

train_tidy <- cbind(subject_train, y_train, x_train_narrow)
train_tidy <- tbl_df(train_tidy)

#combine the test and train data sets to create the long data set
tidy_all <- rbind(test_tidy, train_tidy)
tidy_all <- tbl_df(tidy_all)

#group by the subject_id and the activity
sub_act_grp <- group_by(tidy_all, subject_id, activity_id, activity)
#create the summary data frame using the summarise each function of dplyr
sub_act_sum <- summarise_each(sub_act_grp, funs(mean))

#rename the columns of the summary to add a prefix to show that the value is an average 
colnames(sub_act_sum)[4:ncol(sub_act_sum)] <- paste("avg", colnames(sub_act_sum)[4:ncol(sub_act_sum)], sep = "_")

write.table(sub_act_sum, "har/sub_act_sum.txt", row.name=FALSE)

View(sub_act_sum)
