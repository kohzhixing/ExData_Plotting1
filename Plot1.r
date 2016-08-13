
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

##First graph 
png("plot1.png", width=480, height=480)
par(mfrow=c(1,1))
#generate histogram, with red color, x axis range between 0 to 6, with main title, x labels, and x-axis values removed
hist(power2$Global_active_power,col="red",breaks=20,xlim=c(0,6),main="Global Active Power",xlab="Global Active Power (kilowatts)",xaxt = 'n')
#input tick marks along x-axis and input x-axis values 
axis(side=1, at=seq(0,6,2), labels=seq(0,6,2))
dev.off()


