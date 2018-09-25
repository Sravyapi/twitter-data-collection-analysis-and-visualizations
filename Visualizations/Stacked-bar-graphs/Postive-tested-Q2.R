setwd("/Users/sp/Desktop/DIC")
library(ggplot2)
library(reshape2)
dfr <- read.csv("./positive2.csv")[,1:8]

df <- melt(dfr, id.vars='Week')
myFactor <- as.numeric(factor(df$Week))
positive_tested<-ggplot(df, aes(x=factor(df$Week), y=value, fill=variable)) + geom_bar(stat='identity', color="black", width = 0.8) + scale_fill_manual(values = c("yellow", "orange", "red", "purple", "darkolivegreen", "darkolivegreen1", "darkolivegreen3"))+theme_classic() + theme(axis.text.x = element_text(face="bold", size = 8, angle=90))+guides(fill=guide_legend(title=NULL))
positive_tested<-positive_tested+labs(x="Week",  y="Number of positive specimens",title="Influenza Positive Tests Reported to CDC by U.S. Public Health
Laboratories,National Summary,2017-2018 Season")
positive_tested