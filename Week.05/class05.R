
#' ---
#' title: "Week 5 Wednesday - Bioinformatics Class"
#' author: "Mirte Kuijpers"
#' date: "February 2nd, 2022"
#' ---


#In person class, Wednesday 2nd Feb - Data Visualization

plot(1:5)

#ggplot

##set-up
library("ggplot2")

## Use cars data
###########################

###investigate data
head(cars)
str(cars)

###plot data
plot(cars)

####first attempt
ggplot(cars, aes(speed, dist)) +
  geom_point(aes(colour = speed)) +
  labs(title="Speed Versus Stopping Distance of Old Cars", x="Speed (MPH)", y="Stopping Distance (ft") +
  scale_color_continuous(type = "viridis")
  
  #best to put what you can into the aes() of ggplot rather than into the geom_'s -> more consistency, only put things specific to different geom_'s into those

####improve colour scale  
basic <- ggplot(cars, aes(speed, dist)) +
  geom_point(aes(colour = speed), show.legend = FALSE) +
  labs(title="Speed Versus Distance of Old Cars", x="Speed of old car (MPH)", y="Distance traveled by old car (ft)", caption="Dataset: `cars`") +
  scale_colour_gradient(name="Speed", low = "#3182bd", high = "#de2d26", space = "Lab", na.value = "grey50", guide = "colourbar", aesthetics = "colour")

####add a trend line
basic + geom_smooth(method="lm", colour = "grey60", alpha=0.2)

####use the black and white theme as suggested in the tutorial
basic + geom_smooth(method="lm", colour = "grey60", alpha=0.2) + theme_bw()


###########################
#Gene data (next section)
###########################

##get data
url <- "https://bioboot.github.io/bimm143_S20/class-material/up_down_expression.txt"
genes <- read.delim(url)

##observe data
head(genes)
str(genes)

nrow(genes) ###number of genes = 5196
ncol(genes)

colnames(genes)

table(genes$State)

### percentage of genes in each state
round( table(genes$State)/nrow(genes) * 100, 2 )

##plot data
ggplot(genes, aes(Condition1, Condition2, fill=State)) +
  geom_point(pch=21, alpha=0.25) +
  scale_fill_manual( values=c("blue","gray","red") ) +
  labs(title="Gene Expression Changes Upon Drug Treatment", x="Control (no drug)", y="Drug Treatment")


#Section 6 (optional)

##further setup for this section, install commented out as only had to be done the first time
#install.packages("gapminder")
library(gapminder)
library(dplyr)

## Load data 
url <- "https://raw.githubusercontent.com/jennybc/gapminder/master/inst/extdata/gapminder.tsv"

gapminder <- read.delim(url) #read.delim is a function which reads a file in table format and creates a data frame from it

###get only the data for 2007
gapminder_2007 <- gapminder %>% filter(year==2007) #%>% passes the left hand side of the operator to the first argument of the right hand side of the operator

##Begin to plot data
ggplot(gapminder_2007, aes(gdpPercap, lifeExp, color=continent, size=pop)) +
  geom_point(alpha=0.5)

###alternative - colour by pop size
ggplot(gapminder_2007) + 
  aes(x = gdpPercap, y = lifeExp, color = pop) +
  geom_point(alpha=0.8)

###or do size by pop size
ggplot(gapminder_2007) + 
  aes(x = gdpPercap, y = lifeExp, size = pop) +
  geom_point(alpha=0.5)

####but that doesn't work properly, area doesn't scale as it should so use below instead
ggplot(gapminder_2007) + 
  geom_point(aes(x = gdpPercap, y = lifeExp,
                 size = pop), alpha=0.5) + 
  scale_size_area(max_size = 10)

##Actual question
###get 1957 as well
gapminder_1957 <- gapminder %>% filter(year==1957)

##plot
ggplot(gapminder_1957) + 
  geom_point(aes(x = gdpPercap, y = lifeExp,
                 size = pop, colour=continent), alpha=0.7) + 
  scale_size_area(max_size = 15)

##1957 and 2007
gapminder_merge <- rbind(gapminder_1957, gapminder_2007)

ggplot(gapminder_merge) + 
  geom_point(aes(x = gdpPercap, y = lifeExp,
                 size = pop, colour=continent), alpha=0.7) + 
  scale_size_area(max_size = 15) +
  facet_wrap(~year) +
  labs(title="Gapminder Data for 1957 and 2007", x="GDP per capita", y="Life Expentancy", colour="Continent", size="Population")

ggplot(gapminder_merge) + 
  geom_point(aes(x = gdpPercap, y = lifeExp,
                 size = pop, colour=continent), alpha=0.7) + 
  scale_size_area(max_size = 15) +
  facet_wrap(~continent) +
  labs(title="Gapminder Data for 1957 and 2007", x="GDP per capita", y="Life Expentancy", colour="Continent", size="Population")


#Section 7 - (Optional)

##organise data
gapminder_top5 <- gapminder %>% 
  filter(year==2007) %>% 
  arrange(desc(pop)) %>% 
  top_n(5, pop)

gapminder_top5

##plot data - country vs population
ggplot(gapminder_top5) + 
  geom_col(aes(x = country, y = pop, fill = continent)) +
  labs(title = "Gapminder data for 5 largest populations in 2007", x = "Country", y = "Population (millions)")

###Q plot
ggplot(gapminder_top5) +
  geom_col(aes(country, lifeExp, fill = continent)) +
  labs(title = "Gapminder data for 5 largest populations in 2007", x = "Country", y = "Life Expectancy (years)")


ggplot(gapminder_top5) + 
  geom_col(aes(x = country, y = pop, fill = lifeExp)) +
  labs(title = "Gapminder data for 5 largest populations in 2007", x = "Country", y = "Population (millions)")

###Q plot
ggplot(gapminder_top5) +
  geom_col(aes(reorder(country, -pop), pop, fill = gdpPercap)) +
  labs(title = "Gapminder data for 5 largest populations in 2007", x = "Country", y = "Population (Millions)", fill = "GDP per capita")

ggplot(gapminder_top5) +
  geom_col(aes(reorder(country, -pop), pop, fill = country), show.legend = FALSE, col="gray30") +
  labs(title = "Gapminder data for 5 largest populations in 2007", x = "Country", y = "Population (Millions)")

###Flipping bars
str(USArrests)

USArrests$State <- rownames(USArrests)

ggplot(USArrests) +
  geom_col(aes(reorder(State,Murder), Murder)) +
  coord_flip() +
  labs(title = "Murder in the USA", y = "Number of arrests for Murder", x = "State")


ggplot(USArrests) +
  aes(reorder(State,Murder), Murder) +
  geom_point() +
  geom_segment(aes(x=State, 
                   xend=State, 
                   y=0, 
                   yend=Murder), color="blue") +
  coord_flip() +
  labs(title = "Murder in the USA", y = "Number of arrests for Murder", x = "State")

#Section 8 - optional
## first installed gifski and gganimate
## set up
library(gapminder)
library(gifski)
library(gganimate)

##intial plot -> plot GDP per capita against life expentency with size set by population (and correctly scaled with scale_size) and colour set by country
ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  labs(title = "Gapminder data - GDP per capita versus life expectancy for various countries", x = "GDP per capita (unit?)", y = "Life Expectancy (years)")

##same plot faceted by continent
ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  labs(title = "Gapminder data - GDP per capita versus life expectancy for various countries", x = "GDP per capita (unit?)", y = "Life Expectancy (years)") +
  facet_wrap(~continent)


#final plot
ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  #labs(title = "Gapminder data - GDP per capita versus life expectancy for various countries", x = "GDP per capita (unit?)", y = "Life Expectancy (years)") +
  facet_wrap(~continent) +
  #gganimate specific lines
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  shadow_wake(wake_length = 0.1, alpha = FALSE)

#Section 9 - Combining plots (optional)

library(patchwork)

# Setup some example plots 
p1 <- ggplot(mtcars) + geom_point(aes(mpg, disp))
p2 <- ggplot(mtcars) + geom_boxplot(aes(gear, disp, group = gear))
p3 <- ggplot(mtcars) + geom_smooth(aes(disp, qsec))
p4 <- ggplot(mtcars) + geom_bar(aes(carb))

# Use patchwork to combine them here:
(p1 | p2 | p3) /
  p4




sessionInfo()
