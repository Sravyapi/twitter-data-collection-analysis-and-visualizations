setwd("/Users/sp/Desktop/DIC/") #set working directory
library(sp)
library(maps)
library(maptools)
library(stringi)
library(data.table)
library(twitteR)
library(plyr)
library(ggmap)
library(ggplot2)
library(dplyr)

FindStateInfo <- function(pointsDF) {
  states <- map('state', fill=TRUE, col="transparent", plot=FALSE)
  IDs <- sapply(strsplit(states$names, ":"), function(x) x[1])
  states_sp <- map2SpatialPolygons(states, IDs=IDs,proj4string=CRS("+proj=longlat +datum=WGS84"))
  pointsSP <- SpatialPoints(pointsDF, proj4string=CRS("+proj=longlat +datum=WGS84"))
  indices <- over(pointsSP, states_sp)
  State_name <- sapply(states_sp@polygons, function(x) x@ID)
  State_name[indices]
}

searchTerm <- "ache" #keyword
searchResults <- searchTwitter(searchTerm, n = 500)  # Gather Tweets 
tweetFrame <- twListToDF(searchResults)  # Convert to a nice dF
tweetFrame$keyword <- searchTerm #append keyword
userInfo <- lookupUsers(tweetFrame$screenName,includeNA=TRUE)  # Batch lookup of user info
userFrame <- twListToDF(userInfo)  # Convert to a nice dF
tweetFrame$tweetLocation <- userFrame$location #extract user location into tweetframe
tweetFrame$tweetLocation[tweetFrame$tweetLocation == ""] <- NA #put NA where location is blank space
userFrame$location <- stri_encode(userFrame$location, "", "UTF-8") #to handle non alphabetic characters
Locations <- geocode(userFrame$location[]) #find lat and long details
tweetFrame$lon <- Locations$lon #Add actual location info from geocode to tweetFrame
tweetFrame$lat <- Locations$lat
Locations <- Locations[complete.cases(Locations), ] #remove NA rows
tweetFrame<-tweetFrame[complete.cases(tweetFrame$lon),] #remove NA rows
tweetFrame <- tweetFrame[tweetFrame$lon > -161.75583 & tweetFrame$lon< -68.01197, ] #filter tweets outside USA
tweetFrame <- tweetFrame[tweetFrame$lat > 25 & tweetFrame$lat< 49, ] 
Locations <- Locations[Locations$lon > -161.75583 & Locations$lon< -68.01197, ] 
Locations <- Locations[Locations$lat > 25 & Locations$lat< 49, ] #locations is a DF with onlt lat-long values
tweetFrame$region<-FindStateInfo(Locations) #find state info based on lattitude and longitude info
write.table(tweetFrame,file="./tweetFrame.csv", sep = ",",append = T,col.names = !file.exists("./tweetFrame.csv"))
appended_tweetFrame<-read.csv("tweetFrame.csv",header=TRUE,row.names = NULL) #appending tweets from each run
statecount<-aggregate(text ~ region, appended_tweetFrame, function(x) length(unique(x))) #finding no. of tweets from each state
write.table(statecount,file="./statecount.csv", sep = ",")
merged_statecount<-join(map_data("state"),statecount, by = "region") #USA map info+tweet data
write.table(merged_statecount,file="./merged_statecount.csv", sep = ",") #plotting info
p <- ggplot(merged_statecount)
p<-p+geom_map( map = map_data("state"), aes(map_id = merged_statecount$region,fill = merged_statecount$text),colour = "black") +coord_map() +  labs(fill = "Tweets" ,title = "Twitter Data", x="", y="")
p<-p+expand_limits(x = map_data("state")$long, y = map_data("state")$lat)+ theme_bw() 
p<-p+scale_fill_continuous(low= "cyan", high="blue3",  space = "Lab",na.value="white",guide="colorbar")
p<-p+theme(panel.border =  element_blank())
p
#https://stackoverflow.com/questions/8751497/latitude-longitude-coordinates-to-state-code-in-r
