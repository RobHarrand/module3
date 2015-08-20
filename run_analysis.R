#Coursera module 3 assignment
#Created on 20-08-15
#Created by RH


library(dplyr) #Load the dplyr library

#Merges the training and the test sets to create one data set
#------------------------------------------------------------

train = read.table("UCI HAR Dataset\\train\\X_train.txt") #Read in the training X data
train_lab = read.table("UCI HAR Dataset\\train\\Y_train.txt") #Read in the training Y data

test = read.table("UCI HAR Dataset\\test\\X_test.txt") #Read in the testing X data
test_lab = read.table("UCI HAR Dataset\\test\\Y_test.txt") #Read in the testing Y data

features = read.table("UCI HAR Dataset\\features.txt") #Read in the features
activities = read.table("UCI HAR Dataset\\activity_labels.txt") #Read in the activities

subjects_train = read.table("UCI HAR Dataset\\train\\subject_train.txt") #Read in the training subjects
subjects_test = read.table("UCI HAR Dataset\\test\\subject_test.txt") #Read in the testing subjects

train_merged = cbind(train_lab, train) #Merge the X and Y training data-frames
train_merged = cbind(subjects_train, train_merged) #Merge the training data-frame with the subjects

#Set some column names...
colnames(train_merged)[1] <- "Subject"
colnames(train_merged)[2] <- "Activity"
colnames(activities)[1] <- "Activity"

test_merged = cbind(test_lab, test) #Merge the X and Y testing data-frames
test_merged = cbind(subjects_test, test_merged) #Merge the testing data-frame with the subjects

#Set some column names...
colnames(test_merged)[1] <- "Subject"
colnames(test_merged)[2] <- "Activity"
colnames(activities)[1] <- "Activity"

tidy = rbind(train_merged, test_merged) #Combine the training and test data-frames



#Extracts only the measurements on the mean and standard deviation for each measurement
#--------------------------------------------------------------------------------------

stdMatch = ("std") #Create a pattern match for std
numbers_std = grep(stdMatch, features$V2)

meanMatch = ("mean") #Create a pattern match for mean
numbers_mean = grep(meanMatch, features$V2)

numbers_std = numbers_std + 2 #Increase by 2 to index the correct column
numbers_mean = numbers_mean + 2 #Increase by 2 to index the correct column

initial = c(1,2) #Create this vector to capture the subject and activity columns

#Create the numbers that are needed (means and standard deviations)...
total_numbers = append(initial, numbers_std)
total_numbers = append(total_numbers, numbers_mean)
total_numbers = as.integer(total_numbers)
total_numbers = sort(total_numbers)

tidy = tidy[,total_numbers] #Filter the tidy data-frame to only the required columns



#Appropriately labels the data set with descriptive variable names
#-----------------------------------------------------------------

#Extract the names of the columns for the variables used in the tidy data-frame...
col_numbers = append((numbers_mean-2), (numbers_std-2))
col_numbers = sort(col_numbers)
col_names = features[col_numbers,]

#Don't forget about the first two columns...
newrows = data.frame(c("Subject", "Activity"))
colnames(newrows) = "V2"
col_names[,1] = NULL
col_names = rbind(newrows, col_names)

colnames(tidy) = col_names$V2 #Change the column names to be decriptive as required

#Remove unnecessary data...
rm(train)
rm(train_lab)
rm(train_merged)
#rm(train_merged_act)
rm(test)
rm(test_lab)
rm(test_merged)
#rm(test_merged_act)
rm(activities)
rm(features)
rm(subjects_train)
rm(subjects_test)
rm(col_names)
rm(newrows)
rm(col_numbers)
rm(initial)
rm(meanMatch)
rm(numbers_mean)
rm(numbers_std)
rm(stdMatch)
rm(total_numbers)



#Create a second, independent tidy data set with the average of each variable for each activity and each subject
#---------------------------------------------------------------------------------------------------------------

tidy = arrange(tidy, Subject, Activity) #Arrange the tidy data-frame to be in subject and then activity order

tidy2 = tidy[0,] #Create a new, independent data-frame

#The following while loops create averages from tidy into tidy2, selecting data according to the subject and activity...

c = 3 #Column index
r = 1 #Row index
s = 1 #Subject index
a = 1 #Activity index

while (s < 31) {

  while (a < 7) {
  
    tidy2[r,(c-2)] = s
    tidy2[r,(c-1)] = a

      while (c < 82) {

        tidy2[r,c] = mean(tidy[,(c)][tidy$Subject == s & tidy$Activity == a]) #Create the average
        c = c+1

      }

  c = 3
  a = a+1
  r = r+1

  }
  
c = 3
a = 1
s = s+1

}

#Remove unnecessary data...
rm(c)
rm(a)
rm(r)
rm(s)
rm(tidy)

tidy2[,2] = as.character(tidy2[,2]) #Set the activity column as a character data-type



#Uses descriptive activity names to name the activities in the data set
#----------------------------------------------------------------------

#Change the numbers to decriptions...
tidy2$Activity[tidy2$Activity == '1'] = 'WALKING'
tidy2$Activity[tidy2$Activity == '2'] = 'WALKING_UPSTAIRS'
tidy2$Activity[tidy2$Activity == '3'] = 'WALKING_DOWNSTAIRS'
tidy2$Activity[tidy2$Activity == '4'] = 'SITTING'
tidy2$Activity[tidy2$Activity == '5'] = 'STANDING'
tidy2$Activity[tidy2$Activity == '6'] = 'LAYING'

write.table(tidy2, file = "module3.txt", row.name=FALSE) #Export to text file as required

#-------------------------------------END---------------------------------------------------



 
