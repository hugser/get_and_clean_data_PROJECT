#------------ Clear environment
rm(list = ls())

#------------ Load libraries
library(dplyr)

#------------ data directory
data_dir <- "UCI HAR Dataset"


#---------------------------------------------------------------------------------------------------  
#---------------------------------------  Load labels  ---------------------------------------------
#---------------------------------------------------------------------------------------------------
data_features_dir <- paste(".",data_dir,"features.txt",sep = "/")
data_features <- read.table(data_features_dir, sep = "", colClasses = c("NULL", NA), 
                            col.names = c("","features"), header = FALSE)

data_activity_dir <- paste(".",data_dir,"activity_labels.txt",sep = "/")
data_activity <- read.table(data_activity_dir, sep = "", colClasses = c("NULL", NA), 
                            col.names = c("","activity"), header = FALSE)


 #------------------ labels
features_labels <- sub("#","",
    sub("#","_", 
        gsub("##","", 
             gsub("-",".", 
                  gsub("[()]","#", 
                       gsub(",","_",as.vector(data_features$features)))))))     
activity_labels <- as.vector(data_activity$activity)      
                    
#---------------------------------------------------------------------------------------------------  
#---------------------------------------  Load test set  -------------------------------------------
#---------------------------------------------------------------------------------------------------
data_X_test_dir <- paste(".",data_dir,"test/X_test.txt",sep = "/")
X_test <- read.table(data_X_test_dir, sep = "", col.names = features_labels, header = FALSE)

data_y_test_dir <- paste(".",data_dir,"test/y_test.txt",sep = "/")
y_test <- read.table(data_y_test_dir, sep = "", col.names = "activity", header = FALSE)

data_sub_test_dir <- paste(".",data_dir,"test/subject_test.txt",sep = "/")
sub_test <- read.table(data_sub_test_dir, sep = "", col.names = "subject_id", header = FALSE)

#---------------------------------------------------------------------------------------------------  
#---------------------------------------  Load train set  ------------------------------------------
#---------------------------------------------------------------------------------------------------
data_X_train_dir <- paste(".",data_dir,"train/X_train.txt",sep = "/")
X_train <- read.table(data_X_train_dir, sep = "", col.names = features_labels, header = FALSE)

data_y_train_dir <- paste(".",data_dir,"train/y_train.txt",sep = "/")
y_train <- read.table(data_y_train_dir, sep = "", col.names = "activity", header = FALSE)

data_sub_train_dir <- paste(".",data_dir,"train/subject_train.txt",sep = "/")
sub_train <- read.table(data_sub_train_dir, sep = "", col.names = "subject_id", header = FALSE)

#---------------------------------------------------------------------------------------------------  
#-------------------------------  Merge 'test' and 'train' data  -----------------------------------
#---------------------------------------------------------------------------------------------------
X_full <- rbind(X_test, X_train)
y_full <- rbind(y_test, y_train)
sub_full <- rbind(sub_test, sub_train)

#------------- label 'activity' with the description from 'activity_labels.txt'
y_full[] <- apply(y_full,1, function(x) activity_labels[[x]])


#---------------------------------------------------------------------------------------------------  
#------------------------  Select only the mean() and std() of measurements ------------------------
#---------------------------------------------------------------------------------------------------  

#-------------- columns IDs
measurements_mean <- grep("\\.mean$|\\.mean\\.",features_labels)
measurements_std <- grep("\\.std$|\\.std\\.",features_labels)


#------------- build data for mean and std 
measurements <- sort(c(measurements_mean,measurements_std), decreasing = FALSE)
X_meanstd <- select(X_full, features_labels[measurements])


#---------------------------------------------------------------------------------------------------  
#--------------------------------  Merge X_meanstd and y_full  -------------------------------------
#---------------------------------------------------------------------------------------------------  

#------------- Add an id column in order to merge X and y
X_meanstd <- X_meanstd %>% mutate(id = row_number())
y_full <- y_full %>% mutate(id = row_number())
sub_full <- sub_full %>% mutate(id = row_number())

#------------- Merged data.frame (id column removed) 
Xy <- merge(X_meanstd, y_full, by = 'id') %>% merge( sub_full, by = 'id')
Xy <- select(Xy, -'id')


#---------------------------------------------------------------------------------------------------  
#-----------  Group data.frame by subject and activity, and take mean of features  -----------------
#--------------------------------------------------------------------------------------------------- 
Xy_group <- Xy %>% 
                group_by(subject_id,activity) %>% 
                summarise_all(mean) %>% 
                unclass() %>% 
                data.frame(check.names = FALSE, stringsAsFactors = FALSE)


write.table(Xy_group, file = "tidydata.txt", row.name = FALSE, quote = FALSE)

