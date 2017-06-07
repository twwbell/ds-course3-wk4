run_analysis <- function() {
        ## Read all required data
        zipfile <- "Dataset.zip"
        list <- unzip(zipfile, list = TRUE)
        
        activity_labels <- read.table(unz(zipfile, list[1, 1]), header = FALSE,
                              sep = "", stringsAsFactors = FALSE)
        features <- read.table(unz(zipfile, list[2, 1]), header = FALSE,
                              sep = "", row.names = 1, stringsAsFactors = FALSE)
        test_subject <- read.table(unz(zipfile, list[16, 1]), header = FALSE,
                              stringsAsFactors = FALSE)
        test_set <- read.table(unz(zipfile, list[17, 1]), header = FALSE,
                              sep = "", na.strings = "N/A", stringsAsFactors = FALSE)
        test_labels <- read.table(unz(zipfile, list[18, 1]), header = FALSE,
                              stringsAsFactors = FALSE)
        train_subject <- read.table(unz(zipfile, list[30, 1]), header = FALSE,
                              stringsAsFactors = FALSE)
        train_set <- read.table(unz(zipfile, list[31, 1]), header = FALSE,
                              sep = "", na.strings = "N/A", stringsAsFactors = FALSE)
        train_labels <- read.table(unz(zipfile, list[32, 1]), header = FALSE,
                              stringsAsFactors = FALSE)


        ## Add activity labels to both sets
        test_labels <- left_join(test_labels, activity_labels, by = c("V1" = "V1"))
        train_labels <- left_join(train_labels, activity_labels, by = c("V1" = "V1"))

        ## Prepare vector with column headers
        data_labels <- c("activity_ID", "activity", "subject", features$V2)

        ## Merge columns test set
        test_merged <- cbind(test_labels, test_subject, test_set)
        colnames(test_merged) <- data_labels

        ## Merge columns training set
        train_merged <- cbind(train_labels, train_subject, train_set)
        colnames(train_merged) <- data_labels

        ## Merge all and remove redundant column
        both_merged <- rbind(test_merged, train_merged)
        both_merged <- subset(both_merged, select = -activity_ID)
        
        ## Select columns for mean and std and convert to numeric
        mean_std_cols <- grep("mean|std", names(both_merged))
        subset <- subset(both_merged, select = c(1,2,mean_std_cols))

        ## Independent tidy data set with the average of each variable 
        ## for each activity and each subject
        subsplit <- split(subset, list(subset$activity, subset$subject))
        mean_set <- lapply(subsplit, function(x) { colMeans(x[3:81]) })
        
        ## Unsplit mean_set, extract activity and improve column names
        mean_matrix <- do.call(rbind, mean_set)
        activity <- sapply(strsplit(rownames(mean_matrix), "\\."), "[", 1)
        subject <- sapply(strsplit(rownames(mean_matrix), "\\."), "[", 2)
        colnames(mean_matrix) <- paste("AvgOf", colnames(mean_matrix), sep = "_")
        
        ## Put it all together and remove redundant row names
        mean_list <- cbind(activity, subject, mean_matrix[,1:ncol(mean_matrix)])
        row.names(mean_list) <- NULL 
        
        ## Write meanlist to file
        write.table(mean_list, "AvgOf_Mean_Std.txt", row.names = FALSE)
}

