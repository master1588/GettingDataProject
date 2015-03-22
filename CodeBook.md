# Getting Data Project - Coursera course #3 in Data Science.

In more detail, it reads in 
* ./train/X_train.txt
* ./train/y_train.txt
* ./train/subject_train.txt
* ./test/X_test.txt
* ./test/y_test.txt
* ./test/subject_test.txt
* activity_labels.txt
* features.txt

In the training data, y_train.txt and subject_train.txt are added as extra columns to the X_train.txt data.
Also in the test data, y_test.txt and subject_test.txt are added as extra columns to the X_test.txt data.
Both of those data sets are combined into a single big data.

Column names are read in from the features.txt.  These are the various measurements like accelerometers and gyro readings.
Columns are filtered out:  only the ones containing "mean" or "std" are kept.

The smaller, filtered data has its columns renamed by using the names from the features.txt.

The activities have the numbers swapped out for the associated names.