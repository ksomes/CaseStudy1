

#Read in the beers.csv and set to data frame
Beers <- read.csv("Beers.csv", header = TRUE, sep = ",")


#Read in the Breweries.csv and set to data frame
Breweries <- read.csv("Breweries.csv", header = TRUE, sep = ",")

#add equivalent name to Beers data frame for merge
Beers$Brew_ID <- Beers$Brewery_id


#Merge the data frames
dataset_merge <- merge(Breweries,Beers, by="Brew_ID",all=TRUE)

#Top 6 observations from merged file
Top6 <- head(dataset_merge,6)

#Bottome 6 observations from merged file
Bottom6 <- tail(dataset_merge)

#Rename columns 
names(dataset_merge) <- c("Brew_ID","Company_Name","City","State","Beer_Name","Beer_ID","ABV","IBU", "Brew_ID","Beer_Style","OUnces")
Top10 <- head(dataset_merge)

#Get NA count from each column

ExamineNA <- function(column){
    
                  testNA <- sum(is.na(dataset_merge[column]))
                  
                  print (column)
                  print (testNA)
                }
  
  
 
for (x in names(dataset_merge)){ ExamineNA(x)}


#find number of breweries in state
library(plyr)

BreweryState <- count(dataset_merge,"State")

#Plot of Breweries per State
library(ggplot2)

b1 <- ggplot(BreweryState, aes(x=reorder(BreweryState$State,-BreweryState$freq), y=BreweryState$freq, fill=BreweryState$State)) +
  
geom_bar(stat="identity") + labs(title ="Breweries in States", x= "States", y="Number of Breweries", fill="States") + theme(text = element_text(size=7),axis.text.x = element_text(angle=90, hjust=1))

b1

#Compute the median alcohol content and international bitterness unit for each state. Plot a bar chart to compare. 
library(psych)
ABV_St <- describeBy(dataset_merge$ABV, dataset_merge$State, mat=T)
IBU_St <- describeBy(dataset_merge$IBU, dataset_merge$State, mat=T)

#bar plot of Median Alcohol by volumne
ABV_plot <- ggplot(ABV_St, aes(x=reorder(ABV_St$group,-ABV_St$median), y=ABV_St$median, fill=ABV_St$group1)) +
  geom_bar(stat="identity") + labs(title ="Median Alcohol by Volume in States", x= "States", y="ABV", fill="States") + theme(text = element_text(size=9),axis.text.x = element_text(angle=90, hjust=1))

#bar plot of Median IBU in states
IBU_plot <- ggplot(IBU_St, aes(x=reorder(IBU_St$group,-IBU_St$median), y=IBU_St$median, fill=IBU_St$group1)) +
  geom_bar(stat="identity") + labs(title ="Median Intl Bitterness in States", x= "States", y="IBU", fill="States") + theme(text = element_text(size=9),axis.text.x = element_text(angle=90, hjust=1))	 

#Kentucky KY and DC show to be hightes  median ABV
summary(ABV_St)

#max IBU shown to be Maine (ME)
summary(IBU_St)

#merge by group1 (states) for plot
ABV_IBU_merge <- merge(ABV_St,IBU_St, by="group1",all=TRUE)


#scatter plot of ABV and IBU

med_scatter <- ggplot(ABV_IBU_merge, aes(x=ABV_IBU_merge$median.x, y=ABV_IBU_merge$median.y)) + geom_point(color="blue") + labs(title="Median Alcohol by Volume vs International Bitterness",x="Median Alcohol by Volume", y = "Median Intl Bitterness")+   theme_classic()  

#scatter w/ regression line
med_scat_reg <- ggplot(ABV_IBU_merge, aes(x=ABV_IBU_merge$median.x, y=ABV_IBU_merge$median.y)) + geom_point(color="blue") + labs(title="Median Alcohol by Volume vs International Bitterness",x="Median Alcohol by Volume", y = "Median Intl Bitterness")+   theme_classic() + stat_ellipse() + geom_smooth(method=lm)


#point bplot by state
med_plot_by_state <- ggplot(ABV_IBU_merge, aes(x = ABV_IBU_merge$group)) + 
  geom_point(aes(y = ABV_IBU_merge$median.x *1000), colour="blue") + 
  geom_point(aes(y = ABV_IBU_merge$median.y), colour = "red") + 
  ylab(label="Alcohol by volume and Intl Bitterness") + 
  xlab("States") + theme(text = element_text(size=9),axis.text.x = element_text(angle=90, hjust=1)) + ggtitle("Median Alcohol by volume(Blue) x 1000 and International Bitterness(Red) by State")

#R standard for comparison
plot(dataset_merge$ABV, dataset_merge$IBU, main="Alcohol by Vol vs Bitterness", xlab="ABV", ylab="IBU")

#summary stats on ABV
summary(dataset_merge$ABV)

summary(ABV_St)

