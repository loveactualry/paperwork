#################### PREPARING DATA #####################
#Import dataset (CHANGE PATHNAME FOR YOUR COMPUTER
dtall <- read.csv("/Users/Ian/Downloads/dtall.csv")

#Show structure of dataset and variable classes (type of variable)
str(dtall)

#Change ?쏿cc??variable to factor class and check again
dtall$acc <- as.factor(dtall$acc)
str(dtall)



#################### RANDOMIZED, EQUALLY PARSED DATASETS #####################
#Group into acc=0 and acc=1 groups and check number of rows
data0 <- dtall[dtall$acc == "0",]; nrow(data0)
data1 <- dtall[dtall$acc == "1",]; nrow(data1)

#Create index of random rows to use for training and test sets
index0 <- sample(seq_len(nrow(data0)), size = 400); length(index0)
index1 <- sample(seq_len(nrow(data1)), size = 400); length(index1)

#Randomized rows from data0 for training set and unused rows for test set
train_data0 <- data0[index0, ] ; nrow(train_data0) #data0 training data
test_data0 <- data0[-index0, ]; nrow(test_data0) #data0 test data

#Randomized rows from data1 for training set and unused rows for test set
train_data1 <- data1[index1, ]; nrow(train_data1) #data1 training data
test_data1 <- data1[-index1, ]; nrow(test_data1) #data1 test data

#Combining data for final training and test sets
Train <- rbind(train_data0, train_data1); nrow(Train) #Final training set
Test <- rbind(test_data0, test_data1); nrow(Test) #Final test set



#################### CREATING DOUBLE-LOOP #####################
#Set training set as outputdataframe
output <- Train

#Create empty list variables to store data in loop
id <- list()
Practice <- list()

#j is test dataset row
 for (j in 1:200){

#i is training dataset row
    for (i in 1:800){

#Practice is temporary list data of Training row(i) - Test row(j)
    Practice[[i]] <- Train[i,c(3:10)]-Test[j,c(3:10)]
    }

#for each test row, save the original rowname of the test set
 id[[j]] <- rownames(Test[j,])

#adding data from each iteration of j
 oldoutput <- output

#change ?쁏ractice??data from list to dataframe type
 output <- data.frame(matrix(unlist(Practice), ncol=8, byrow=TRUE))

#change column names to be (TEST.ROW.NUMBER_VARIABLE.NAME)
 colnames(output) <- paste(id[[j]], colnames(Practice[[i]][1:8]), sep="_")

#Add new output of j to full dataset so far until finished
 output <- cbind(oldoutput, output)}

#Save results (CHANGE PATHNAME FOR YOUR COMPUTER)
write.csv(output, "/Users/Ian/Desktop/HyojunResult.csv")
