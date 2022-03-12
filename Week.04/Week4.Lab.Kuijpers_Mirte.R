
# Mirte Kuijpers
# A59010989
# 27/01/2022

# R script as in lab for week 4


# input vector
x <- 1:50

#add date to the report
print(paste("The following plot was created on", date()))

# plot the vector data against its sine
plot(x, sin(x), type = "l", col="blue", lwd=3, xlab="Input Data", main="My Example Graph")

