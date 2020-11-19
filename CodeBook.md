## CodeBook for the variables of the new data set.

In the new tidy data set, the data was filtered, organized, and summarized, after being downloaded from the original source.

Firstly, in the first two columns (variables) are the subject and the activity annotations, respectively. These two columns were added by loading that data and mixing it with the actual datasets.

As stated in the requests, the train and test data sets were put together into a single one, and all the data present is only the data for mean and standard deviation variables.

Moreover, all of the variable names were adapted to have a clearer name. Every variable (aside from subject and activity) has in its name if its in the time or frequency domain, if it is a mean or a standard deviation, and whether it was measured with a gyroscope or an accelerometer. Other details are implied in the name.

Finally, all the observations were grouped and summarized by both subject and activity, and every respective record is the average of all the other instances of that subject-activity combination.
