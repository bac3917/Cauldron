
RBH <- read.csv("C:/bac/RBH Shop Stats.csv")
RBH<-RBH[1:15,]
names(RBH) <- make.names(names(RBH), unique=TRUE)
RBH$SUPP.HRS<-RBH$SUPP.HRS..RBH.non.shop..non.event.
RBH$start= paste0(substr(RBH$DATE.MM.DD, 1, regexpr('-', RBH$DATE.MM.DD)-2),"/18")
RBH$end= paste0(substr(RBH$DATE.MM.DD, regexpr('-', RBH$DATE.MM.DD)+2,33),"/18")

library(lubridate);library(ggplot2)
RBH$start<-mdy(RBH$start)

#one plot at a time
library(ggrepel)
ggplot(RBH, aes(x=start, y=cumsum(BIKES.ISSUED))) + 
        geom_line() + geom_point() +theme_bw() 
gg<-ggplot(RBH, aes(x=start, y=(X..Vols))) + ylab("Number of Vols")+xlab("Date")+
        geom_line() + geom_point() +theme_bw() +ggtitle("Number of Vols by Week")

gg+geom_label_repel(aes(label=RBH$Location),size=2)

# multiple lines; reshape
temp<-RBH[ ,c("start","BIKES.FIXED","BIKES.ISSUED","Helmets.Issued",
              "BULK.BIKES.Donated.to.RBH")]
temp2<-RBH[ ,c("start","VOL.HRS","NUM.VOLS","PREP.HRS","SUPP.HRS")]
library(reshape2)
temp<-melt(temp,id.vars = "start")
temp2<-melt(temp2,id.vars = "start")

# use plyr to calculate cumsum per group of x
require(plyr)
DF.t <- ddply(temp, .(variable), transform, cy = cumsum(value))
DF.t2 <- ddply(temp2, .(variable), transform, cy = cumsum(value))

# plot
require(ggplot2)
ggplot(DF.t, aes(x=start, y=cy, colour=variable, group=variable)) + 
        geom_line(size=1.13)+
        xlab("Date")+ylab("Cumulative Total")+
        ggtitle("Fig. 1: Bikes Fixed and Issued")+
        theme_bw()

ggplot(DF.t2, aes(x=start, y=cy, colour=variable, group=variable)) + 
        geom_line(size=1.13)+
        xlab("Date")+ylab("Cumulative Total")+
        ggtitle("Fig. 2: Volunteer Hours")+
        theme_bw()
