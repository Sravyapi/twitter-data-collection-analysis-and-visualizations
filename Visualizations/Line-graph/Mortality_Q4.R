setwd("/Users/sp/Desktop/DIC")
Mortality<-read.csv(file = "Mortality.csv", sep = ",")[ ,1:5]
plot(c(1:length(Mortality$Week)), Mortality$Percent.of.Deaths.Due.to.Pneumonia.and.Influenza,xlab='MMWR Week',cex.lab=0.8,ylab='% of All Deaths Due to P&I',type="l", main='Pneumonia and Influenza Mortality from
     the National Center for Health Statistics Mortality Survilence System',font.main=1,
     col="red",bty="n",xaxt="n",lwd=2,ylim = c(4,12))
lines( Mortality$Threshold,type="l", col="black",lwd=2)
lines( Mortality$Expected ,type="l", col="black",lwd=2)
labels_Years = c(seq(2013,2018))
labels_Years_At = c(1,25,80,130,180,226)
axis(1, at=labels_Years_At ,col="black",labels=labels_Years, tck='-0.01',las=0)
labels_Weeks = c("40","50")
labels_Weeks = c(labels_Weeks,seq(10,50, by = 10),seq(10,50, by = 10),seq(10,50, by = 10),seq(10,50, by = 10))
lables_Weeks_AT = c(1,11,seq(23,63,by =10),seq(75,115,by =10),seq(127,167,by =10),seq(179,219,by =10))
axis(1, at=lables_Weeks_AT, col="white",col.ticks="white",
     col.axis="black",line=1,las=1,labels=labels_Weeks,tck='0', cex.axis = .825)
mtext("Data through the week ending January 27,2018, as of February 15,2018", 3,line=0,cex=.8) 
