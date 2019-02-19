

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
#names(dataset_merge <- c("Brew_ID","Company_Name","City","State","Beer_Name","Beer_ID","ABV","Brew_ID","Beer_Style","OUnces"))

#Get NA count from each column

sum(is.na(dataset_merge$Brew_ID))
#[1] 0
sum(is.na(dataset_merge$Name.x))
#[1] 0
sum(is.na(dataset_merge$City))
#[1] 0
sum(is.na(dataset_merge$State))
#[1] 0
sum(is.na(dataset_merge$Name.y))
#[1] 0
sum(is.na(dataset_merge$Beer_ID))
#[1] 0
sum(is.na(dataset_merge$ABV))
#[1] 62
sum(is.na(dataset_merge$IBU))
#[1] 1005
sum(is.na(dataset_merge$Brewery_id))
#[1] 0
sum(is.na(dataset_merge$Style))
#[1] 0
sum(is.na(dataset_merge$Ounces))
#[1] 0




