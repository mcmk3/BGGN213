
# Mirte Kuijpers 
# A59010989

###################
### Week 4 R Basics
###################

# 2. Simple Calculations
5 + 3
5 - 3
5*3
5/3

# 3. Object Assignment

x <- 3*4

this_is_a_really_long_name <- 2.5  

r_rocks <- 2 ^ 3  

rrocks # r does not recognize this, as it requires precision

R_rocks # r does not recognize this, as it is case sensitive

# 4. Calling Functions

seq(1, 10)

seq(1,10, by=2)  

example(seq)

date()

help(log)
?log

help.search("cross tabulate")
??"cross tabulate"

example(log)

# Vectors, Vectorization, and Indexing

length(3.1) 

x <- c(56, 95.3, 0.4)
x

y <- c(3.2, 1.1, 0.2)
y

x+y

x/y

sqrt(x)

round(sqrt(x), 3)

log(x)/2 + 1

x <- c(56, 95.3, 0.4)
x[2]

x[1]

x[4]

x[3] <- 0.5

# Reproducibility

sessionInfo()


















###################
### Week 4 "Hands On" labs (Screencast video)
###################

#vectors
x <- 1:5

x

x <- 1:50

x

x <- 1:5

x + 100

x + c(100, 1, 1, 1, 100)

x + c(100, 1)

x + c(100, 1, 100, 1, 100)

y <-  c("alice", "chandra", "eva")

y + 100

z <- c("alice", "chandra", 100, 1)

z

z + 100

z <- c(TRUE, FALSE, TRUE)

z + 100

z + 1

z + 0

grades <- c(8, 10, 6, 9)

grades >= 7

sum(grades > 7)

sum(grades < 7)

grades <- c(alice=8, jim=10, elisa=6)

grades

grades > 7

sum(grades > 7)

sum(grades)

top_students <- grades > 7

sum(top_students)

mean(grades)

sort(grades)

sort(grades, decreasing = TRUE)

# Dataframes
d <- data.frame(nums=1:5, chars=c("a", "b", "c", "d", "e"))

letters

letters[1:5]

d <- data.frame(nums=1:5, chars=letters[1:5])

nrow(d)

ncol(d)

dim(d)

d

d$chars #also could have used d[,2] or d[,"chars"]

d[4,2]

d[4,]

sum(d$nums)

d[-4,]

#functions

x <- 1:50

plot(x, sin(x))

?plot

plot(x, sin(x), type = "l")

plot(x, sin(x), type = "l", col="blue")

plot(x, sin(x), type = "l", col="blue", lwd=3)

plot(x, sin(x), type = "l", col="blue", lwd=3, xlab="My label")










