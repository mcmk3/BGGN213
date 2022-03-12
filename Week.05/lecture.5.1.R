
#lecture 5.1 Why Visualize Data?


x <- rnorm(1000)

mean(x)
sd(x)

summary(x)

boxplot(x)

hist(x)
rug(x)

#lecture 5.3 ggplot

library("ggplot2")

View(mpg)

## displ and hwy

ggplot(data=mpg) +
  aes(x=displ, y=hwy) +
  geom_point() +
  geom_smooth() +
  labs(title="My title", subtitle="My subtitle")

ggplot(data=mpg) +
  aes(x=displ, y=hwy, colour=class, shape=as.factor(cyl)) +
  geom_point() 


ggplot(data=mpg) +
  aes(x=displ, y=hwy, colour=class) +
  geom_point() +
  facet_wrap(~cyl)
  
# lecture 6.1
  
add <- function(x, y=1){
  x + y
}

add(x=4)  

add(x=4, y=10)

add(4)

add(4, 20)

add(c(1, 2, 5, 10), y=10)
add(c(1, 2, 5, 10), y="string")

## Our 2nd function rescale()

rescale <- function(x){
  rng <- range(x)
  (x  - rng[1])/(rng[2] - rng[1])
}

rescale(1:10)

rescale(c(1, NA, 4, 10, 20))
range(c(1, NA, 4, 10, 20))

range(c(1, NA, 4, 10, 20), na.rm = TRUE)

###fix the NA issue
rescale01 <- function(x){
  rng <- range(x, na.rm = TRUE)
  (x  - rng[1])/(rng[2] - rng[1])
}

rescale01(c(1, NA, 4, 10, 20))


rescale01 <- function(x, na.rm=TRUE){
  rng <- range(x, na.rm = na.rm)
  (x  - rng[1])/(rng[2] - rng[1])
}




