# A quick example of how to index instead of looping in order to dramatically speed up code

# Create a 4x4 matrix / array of data (four observations, four features)

data <- data.frame(matrix(c(8,4,2,1,3,3,5,3,9,2,1,5,4,1,1,7), nrow=4, ncol=4, byrow=T))
print(data)

# Give each observation a label of 0 or 1

labels <- c(1,0,1,0)

# First demonstration: subset the data using labels, using the "==" operator
# Could use other operators as well.

labelguide <- data[labels==1,]
print(labelguide)

# Note 1: this only prints the observations that match the position where labels was set to 1
# Note 2: the "," here, which is necessary so that R knows to keep the data in row format
# Otherwise, it defaults to reading by columns and returns a flat vector / array
# Still the right numbers, just wrong order and wrong format

#Now generate a vector that we will later populate with some values based on our original data

#datastuff <- matrix(0, 1, 4) #Creates a 1x4 matrix of 0's
datastuff <- replicate(4, 0) #easier when creating a 1xX list of 0 values
print(datastuff)

#Let's say we want to sum all of hte observations that were labeled with a 1.
#Here's how you do that:

datastuff[labels==1] <- rowSums(data[labels==1,])
print(datastuff)

# Note: Again we use the "," to set our axis for rowSums, but do not use a ","
# for the datastuff subset (the comma, again, is roughly equivalent to axis=1 in Python)

# If we want to do an np.prod equivalent, I found a package called matrixStats
# that has a rowProds equivalent. Only trick is that it only works on
# explicitly typed matrices, and we originally created a data frame. Easy enough to fix.

library(matrixStats)

datastuff[labels==0] <- rowProds(as.matrix(data[labels==0,]))
print(datastuff)

# We have now demonstrated how to subset a data matrix by its labels, and then further demonstrated 
# that we can now populate an output based on different computations performed on data based on the 
# label and have the results show up in the right place in our output.

