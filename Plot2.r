
# preliminary data downloading and arrangement

setwd( "C:/Users/NUS/Desktop/rdata")
read.table("household_power_consumption.txt", sep=";",stringsAsFactors=F,colClasses="character",header=T)->power
power[power=="?"]<-NA
power[,3:9]<-lapply(power[,3:9],as.numeric)

#concatenation of the Date and Time columns into one column
power$DateTime<-paste(power$Date,power$Time,sep=" ")

# changing of DateTime column into POSIXlt format
strptime(power$DateTime, format="%d/%m/%Y %H:%M:%S")->power$DateTime
a<-c(10,1:9)
power[,a]->power
#extract day information from the DateTime column
power$Day<-weekdays(power$DateTime)
a<-c(11,1:10)
power[,a]->power
subset(power,power$Date=="1/2/2007"|power$Date=="2/2/2007")->power2

#Second graph 
library(dplyr)
# changing of the date from POSIXlt to POSIXct format to facilitate data arrangement
power2$DateTime<-as.POSIXct(power2$DateTime)
power2<-arrange(power2,DateTime)
png("plot2.png", width=480, height=480)
par(mfrow=c(1,1))
#Plotting of line graph
with(power2,plot(DateTime, Global_active_power,type="l", ylab="Global Active Power (kilowatts)",xlab=""))
dev.off()