
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



#Fourth graph
png("plot4.png", width=480, height=480)
# setting paramaters of two rows and two columns for four graphs
par(mfrow=c(2,2))
#plot first line plot for global_active_power time series
with(power2,plot(DateTime,Global_active_power, type="l",xlab="",ylab="Global Active Power"))
#plot second line plot of voltage time series
with(power2,plot(DateTime,Voltage, type="l",xlab="datetime",ylab="Voltage"))
#plot third line plot of the three energy meter time series
with(power2,plot(DateTime,Sub_metering_1, type="l",xlab="",ylab="Energy sub metering"))
lines(power2$DateTime, power2$Sub_metering_2, type="l", col="red")
lines(power2$DateTime, power2$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"),bty = "n")
#plot fourth line plot on global reactive power
with(power2,plot(DateTime,Global_reactive_power, type="l",xlab="datetime",ylab="Global_reactive_power"))

dev.off()
