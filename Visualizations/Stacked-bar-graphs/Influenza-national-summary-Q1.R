library(reshape2)
library(ggplot2)

data<-read.csv("/Users/sp/Desktop/DIC/Influenza_positive_tests_Q1.csv")
data <- melt(data, id.vars=c("Week","Percent.Positive.A","Percent.Positive.B","Total...Tested", "X..Positive"))
bar_plot<-ggplot(data, aes(x=factor(data$Week), y = value, fill =  variable,width=0.8)) + 
  geom_bar(stat="identity",colour="black") +scale_fill_manual(values = c("yellow", "darkgreen") , labels=c("A", "B")) 
bar_plot<-bar_plot+guides(fill=guide_legend(title=NULL)) + theme_classic()

bar_plot<-bar_plot+geom_line(aes(x=factor(data$Week), y=X..Positive*680, group=1, color="black"))
bar_plot<-bar_plot+geom_line(linetype = "dashed",aes(x=factor(data$Week), y=Percent.Positive.A*680, group=1, color="gold"))
bar_plot<-bar_plot+geom_line(linetype = "dotted",aes(x=factor(data$Week), y=Percent.Positive.B*680, group=1, color="darkgreen")) + scale_color_discrete(name = "", labels = c("Percent Positive", "% Positive Flu A", "% Positive Flu B"))
bar_plot<-bar_plot+scale_y_continuous( sec.axis = sec_axis(~ . /680, name="Percent positive"))
bar_plot<-bar_plot+labs(x="Week",  y="Number of positive specimens",title="Influenza Positive Tests Reported to CDC by U.S. Clinical Laboratories,
                        National Summary,2017-2018 Season")+theme_classic()
bar_plot

#https://opensource.com/article/17/6/collecting-and-mapping-twitter-data-using-r