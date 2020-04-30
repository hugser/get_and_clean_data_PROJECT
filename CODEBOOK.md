# CODE BOOK
> Here I describe the data and the manipulations done on the raw data extracted from `UCI HAR Dataset` 

## Data Manipulations

<ins>Several Manipulations were performed on the raw data:</ins>
  - _features.txt_ content was manipulated such that the final labels would not contain `()`, `,` or `-`. 
  But instead `.` and `_`.  For example:
     - `tBodyAcc-mean()-X` is modefined to `tBodyAcc.mean.X`, and 
     - `tBodyAcc-arCoeff()-X,1` is modified to `tBodyAcc.arCoeff.X_1`;
  - The _X_ were loaded using the above labels for the columns. Both _X_ and _y_
 sets for the _train_ and _test_ data were merged using `rbing`, i.e _train_ data.frame was appended to the _test_ one; 
  - The full _y_ data.frame values were replaced by their discripion found in _activity_labels.txt_. See [here](#identifiers); 
  - Selected only the data.frame columns that corresponded `mean()` and `std()` for each measurement. See the list of the final features [here](#features);
  - Merged the data.frames _X_, _y_ and subject performing the experiment;
  - Grouped the data.frame by subject id and activity and computed the mean for each variable.
 
## Identifiers

  - subject_id: Identifies the subject. Range from 1 to 30. 
  - activity: Describes the subject activity. The identification is:
    ```R
    1 -> WALKING
    2 -> WALKING_UPSTAIRS
    3 -> WALKING_DOWNSTAIRS
    4 -> SITTING
    5 -> STANDING
    6 -> LAYING
    ```
 
## Features

Type of signal recorded during the subjects activities. Onlythe the `mean()` and `std()` are represented:
  
```R
tBodyAcc.mean.X
tBodyAcc.mean.Y
tBodyAcc.mean.Z
tBodyAcc.std.X
tBodyAcc.std.Y
tBodyAcc.std.Z
tGravityAcc.mean.X
tGravityAcc.mean.Y
tGravityAcc.mean.Z
tGravityAcc.std.X
tGravityAcc.std.Y
tGravityAcc.std.Z
tBodyAccJerk.mean.X
tBodyAccJerk.mean.Y
tBodyAccJerk.mean.Z
tBodyAccJerk.std.X
tBodyAccJerk.std.Y
tBodyAccJerk.std.Z
tBodyGyro.mean.X
tBodyGyro.mean.Y
tBodyGyro.mean.Z
tBodyGyro.std.X
tBodyGyro.std.Y
tBodyGyro.std.Z
tBodyGyroJerk.mean.X
tBodyGyroJerk.mean.Y
tBodyGyroJerk.mean.Z
tBodyGyroJerk.std.X
tBodyGyroJerk.std.Y
tBodyGyroJerk.std.Z
tBodyAccMag.mean
tBodyAccMag.std
tGravityAccMag.mean
tGravityAccMag.std
tBodyAccJerkMag.mean
tBodyAccJerkMag.std
tBodyGyroMag.mean
tBodyGyroMag.std
tBodyGyroJerkMag.mean
tBodyGyroJerkMag.std
fBodyAcc.mean.X
fBodyAcc.mean.Y
fBodyAcc.mean.Z
fBodyAcc.std.X
fBodyAcc.std.Y
fBodyAcc.std.Z
fBodyAccJerk.mean.X
fBodyAccJerk.mean.Y
fBodyAccJerk.mean.Z
fBodyAccJerk.std.X
fBodyAccJerk.std.Y
fBodyAccJerk.std.Z
fBodyGyro.mean.X
fBodyGyro.mean.Y
fBodyGyro.mean.Z
fBodyGyro.std.X
fBodyGyro.std.Y
fBodyGyro.std.Z
fBodyAccMag.mean
fBodyAccMag.std
fBodyBodyAccJerkMag.mean
fBodyBodyAccJerkMag.std
fBodyBodyGyroMag.mean
fBodyBodyGyroMag.std
fBodyBodyGyroJerkMag.mean
fBodyBodyGyroJerkMag.std
```
