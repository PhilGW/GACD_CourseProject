#This script combines the files in the UCI HAR Dataset to create a data frame
# containing all of the activity, subject, and accelerometer data from both
# the test and training sets, and then summarizes the accelerometer data across
# subjects and activities.

run_analysis <- function() {
     #Load necessary libraries:
     library(plyr)
     library(reshape2)
     
     coln <- read.table("./UCI HAR Dataset/features.txt")  #Get column names from features.txt
     
     #Read in and align "test" data:
     testset <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE, stringsAsFactors = FALSE)
     testrows <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, stringsAsFactors = FALSE)
     testsubj <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, stringsAsFactors = FALSE)
     testset <- cbind(testsubj, testrows, testset)
     
     #Read in and align "train" data
     trainset <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE, stringsAsFactors = FALSE)
     trainrows <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, stringsAsFactors = FALSE)
     trainsubj <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, stringsAsFactors = FALSE)
     trainset <- cbind(trainsubj, trainrows, trainset)
     
     alldata <- rbind(trainset, testset) #Combine both training and test sets into one data frame
     names(alldata) <- c("subject_id", "activity", as.character(coln$V2) )  #Assign names from features.txt to the dataset
    
     # Narrow down to the names of interest:
     noi <- grepl("mean", names(alldata), ignore.case=TRUE) | grepl("std", names(alldata), ignore.case=TRUE) | names(alldata)=="activity" | names(alldata)=="subject_id"
     edata <- alldata[noi]
     
     #Clarify names by moving "Mean_of_" or "StDev_of_" to front of name:
     n <- names(edata)
     for (i in 1:length(n)) {
          if (grepl("-mean()", n[i])) { 
               n[i] <- as.character(paste("MeanOf",n[i], sep="")  )
               n[i] <- gsub("-mean()", "" , n[i])
          } 
          if (grepl("-std()", n[i])) { 
               n[i] <- as.character(paste("StDevOf",n[i], sep="")  )
               n[i] <- gsub("-std()", "" , n[i] )#ignore.case=TRUE)
          }
          # Improve readability:
          n[i] <- gsub("\\(","", n[i])
          n[i] <- gsub("\\)","", n[i])
          n[i] <- gsub("\\,","", n[i])
          n[i] <- gsub("\\-","_", n[i])
          n[i] <- gsub("angle","angle_", n[i])
     }
     
     names(edata) <- n #Retitle all fields
     #Retitle the activities based on key:
     edata$activity <- gsub("1","WALKING",edata$activity)
     edata$activity <- gsub("2","WALKING_UPSTAIRS",edata$activity)
     edata$activity <- gsub("3","WALKING_DOWNSTAIRS",edata$activity)
     edata$activity <- gsub("4","SITTING",edata$activity)
     edata$activity <- gsub("5","STANDING",edata$activity)
     edata$activity <- gsub("6","LAYING",edata$activity)
     
     #Make activity and subject_id factors:
     edata$subject_id <- as.factor(edata$subject_id)
     edata$activity <- as.factor(edata$activity)
     
     #Create summary by melting and dcast
     d <- melt(edata, id=c("subject_id", "activity"))
     emeans <- dcast(d, subject_id + activity ~ ..., mean)
     n2 <- names(emeans)
     
     #Since these are averages, label them with a Means_ before each title:
     for (i in 3:length(n2)) {n2[i] <- paste0("Mean_", n2[i]) }
     names(emeans) <- n2
          
     #Write Summary to file:
     write.table(emeans, "ExerciseDataSummary.txt",row.names = FALSE)
}

