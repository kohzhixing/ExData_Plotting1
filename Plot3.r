
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


#Third graph
png("plot3.png", width=480, height=480)
#plotting a line graph with sub_metering_1 time graph
with(power2,plot(DateTime,Sub_metering_1, type="l",xlab="",ylab="Energy sub metering"))
# addition of lines for sub)metering_2 and sub_metering_3 time series to the line graph
lines(power2$DateTime, power2$Sub_metering_2, type="l", col="red")
lines(power2$DateTime, power2$Sub_metering_3, type="l", col="blue")
#adding of legend to the graph and formatting line type and line width.
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()


