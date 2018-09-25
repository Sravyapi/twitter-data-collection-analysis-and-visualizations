setwd("/Users/sp/Desktop/DIC")
library(ggplot2)
library(patternplot)
library(RColorBrewer)
#---------------------------------------------------------------------------------
par(mfrow=c(3,2), cex= 0.7, mai= c(0.2,1,0.2,1))

pie_VicB <- read.csv("./pie.csv")[1:2,]
pie_YamaB <- read.csv("./pie.csv")[3:5,]
pie_H3 <- read.csv("./pie.csv")[9:13,]
pie_H1N1 <- read.csv("./pie.csv")[6:8,]
pie_main <- read.csv("./pie2.csv")

labels1 <-pie_VicB$X..of..Sub.type.Total
labels2 <-pie_YamaB$X..of..Sub.type.Total
labels3 <-pie_H3$X..of..Sub.type.Total
labels4 <-pie_H1N1$X..of..Sub.type.Total
labels5 <- pie_main$Cumulative

pie_VicB
pie_YamaB
pie_H3
pie_H1N1
pie_main
pattern.type <- c('vlines')


pielabels <- c("A(H3N2)", "A(H1N1)", "A(subtype unknown)", "B Victoria", "B Yamagata", "B (lineage not determined)" )

pie(pie_main$Cumulative, labels5, border = "black", radius = 1, main = "Influenza Positive Specimens Reported by U.S Public Health Labs", clockwise = TRUE, col = c("red", "orange", "yellow", "darkolivegreen3", "chartreuse3", "darkgreen"))
box(which= "plot", lty = "solid")

pie(pie_H3$Number, labels3, radius=1, main = "Influenza A H3N2", clockwise=TRUE, density=c(16,200,5), col= "red", border = "black")
box(which= "plot", lty = "solid")

pie(pie_H1N1$Number, labels4, radius=1, main = "Influenza A H1N1", clockwise=TRUE, density=16, col= "orange", border = "black")
box(which= "plot", lty = "solid")

pie(pie_VicB$Number, labels1,radius=1, main = "Influenza B Victoria", clockwise=TRUE, density=c(5000, 20), col= "#99CC66", border = "black")
box(which= "plot", lty = "solid")

pie(pie_YamaB$Number, labels2, radius=1,main = "Influenza B Yamagata", clockwise=TRUE, col= "#669933", border = "black")
box(which= "plot", lty = "solid")

par(xpd = TRUE)
legend(2.3, 1, legend=pielabels,bty="n",
       fill=c("red", "orange", "yellow", "darkolivegreen3", "chartreuse3", "darkgreen"))

#--------------------------------------------------------------------------------------------

