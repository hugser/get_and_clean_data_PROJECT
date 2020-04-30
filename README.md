# Get and Clean Data -- Project

> This repository contains the data and ___R___ script requested for the 
`Peer-graded Assignment` on the Johns Hopkins University course `Getting and Cleaning Data`

This repository contains: 
   - The `UCI HAR Dataset`. Folder containing both _train_, _test_ data sets and .txt 
   files containg labels of features and activities.
   - The script `run_analysis.R`. Performs the data cleaning.
   - The data file _tidydata.txt_. Containing the data in a tidy form, explained below.
   - The _CODEBOOK.md_. Contains information on the manuipulation performed on the original data. 
   
## Description of `run_analysis.R` script

The `run_analysis.R` will do the following manipulations:
  - Clears the global enviroment and loads _dplyr_ package;
  - Loads the _features.txt_ and _activity_labels.txt_, manipulate some of the labels and save them in vectors varibles. 
  For this step `gsub` was used in a nexted way, as several manipulations where need in order to make the labels 
  clean and tidy. (see [CODEBOOK](https://github.com/hugser/get_and_clean_data_PROJECT/blob/master/CODEBOOK.md) for the final layout);
  - Loads the _test_ and _train_ sets (X, y and subject), using the above vectors for the `col.names` option;
  - Merges both _test_ and _train_ into a _full_ data.frame;
  - Replaces the `y_full` data.frame values by their corresponding activity (found in _activity_labels.txt_);
  - Extracts only the measurements on the mean and standard deviation for each measurement. 
  This takes into account only the original names that had `mean()` or `std()`. In this step, `grep` was used with the 
  regular expression `"\\.mean$|\\.mean\\."`, and similar to _std_;
  - Merged the full data set for _X_, _y_ and _sub_, with only the measurements on the mean and standard deviation;
  - Grouped by subject and activity and aplied the `mean` for each variable;
  - Saved the tidy data into the file `tidydata.txt` using `write.table`.
  
A sneak peek to the `tidydata.txt` can be seen below

```R
   subject_id           activity tBodyAcc.mean.X tBodyAcc.mean.Y tBodyAcc.mean.Z tBodyAcc.std.X
1           1             LAYING       0.2215982    -0.040513953      -0.1132036    -0.92805647
2           1            SITTING       0.2612376    -0.001308288      -0.1045442    -0.97722901
3           1           STANDING       0.2789176    -0.016137590      -0.1106018    -0.99575990
4           1            WALKING       0.2773308    -0.017383819      -0.1111481    -0.28374026
5           1 WALKING_DOWNSTAIRS       0.2891883    -0.009918505      -0.1075662     0.03003534
6           1   WALKING_UPSTAIRS       0.2554617    -0.023953149      -0.0973020    -0.35470803
7           2             LAYING       0.2813734    -0.018158740      -0.1072456    -0.97405946
8           2            SITTING       0.2770874    -0.015687994      -0.1092183    -0.98682228
9           2           STANDING       0.2779115    -0.018420827      -0.1059085    -0.98727189
10          2            WALKING       0.2764266    -0.018594920      -0.1055004    -0.42364284
11          2 WALKING_DOWNSTAIRS       0.2776153    -0.022661416      -0.1168129     0.04636668
12          2   WALKING_UPSTAIRS       0.2471648    -0.021412113      -0.1525139    -0.30437641
```
