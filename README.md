This repo is to fulfil the requirements for module 3 of the Coursera data-science specialisation ('Gathering and Cleaning Data')

All manipulation and tranformations for this module are done with the script 'run_analysis.R'

The script does the following...

1) Loads the training and test data from the UCI HAR Dataset (in the working directory)
2) Loads the features, activity and subject data
3) Sets column names appropriately
4) Merges the training and testing data-sets
5) Searches for all the references to 'mean' or 'std'
6) Selects these columns out of the combined data-set and discrards the rest
7) Takes the variable names from the 'features' data-frame and applies them to the tidy data-set
8) Creates a new data-frame and calculates averages for each of the mean and std variables, on a subject and activity basis
9) Gives the activities descriptive names
10) Exports the data as a text file
