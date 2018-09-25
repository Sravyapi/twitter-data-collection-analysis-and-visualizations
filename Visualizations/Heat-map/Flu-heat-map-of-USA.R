library(ggplot2)
library(dplyr)
setwd("/Users/sp/Desktop/DIC")
heatmap_data<-read.csv(file = "StateDataforMap_2017-18week4.csv", sep = ",")[ ,1:2]
#heatmap_data
heatmap_data$region=tolower(heatmap_data$region)
merged_dataframes<-merge(map_data("state"),heatmap_data, by="region")
p <- ggplot()
p <- p + geom_polygon(data=merged_dataframes, aes(x=long, y=lat, group = group, fill=merged_dataframes$ACTIVITY),colour="Black",lwd=.2) 
p<-p+scale_fill_continuous(low = "green", high = "red2", space = "Lab",na.value = "black", guide="colorbar")
p <- p + theme_bw()  + labs(fill = "ILI Activity Level" ,title = "2017-18 Influenza Season Week 4 ending Jan 27,2018", x="", y="")
p + scale_y_continuous(breaks=c()) + scale_x_continuous(breaks=c()) + theme(panel.border =  element_blank())
