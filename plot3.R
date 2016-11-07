
##get and clean the dataset
power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
library(dplyr)
power2<-filter(power,Date=="1/2/2007"|Date=="2/2/2007") 
	##get data from the dates 2007-02-01 and 2007-02-02
power2$dateTime = paste(power2$Date, power2$Time, sep=" ")
power2$dateTime <- strptime(x = as.character(power2$dateTime),
       format = "%d/%m/%Y %H:%M") 
		##convert the Date and Time variables to Date/Time classes

power3 <- transform(power2, Global_active_power = as.numeric
	(levels(Global_active_power)[Global_active_power]))
power4 <- transform(power3, Sub_metering_1 = as.numeric
	(levels(Sub_metering_1)[Sub_metering_1]))
power5 <- transform(power4, Sub_metering_2 = as.numeric
	(levels(Sub_metering_2)[Sub_metering_2]))
power6 <- transform(power5, Global_reactive_power = as.numeric
	(levels(Global_reactive_power)[Global_reactive_power]))
power7 <- transform(power6, Voltage = as.numeric
	(levels(Voltage)[Voltage]))
		##convert to numeric vectors

##Construct the plot and save

##Name the plot file as plot3.png
png(file = "plot3.png")

##plot as required
with(power7,plot(dateTime,Sub_metering_1,type="l", col = "black", xlab=" ",
	ylab = "Energy sub metering",ylim = c(0,40)))
with(power7,lines(dateTime,Sub_metering_2,col = "red"))
with(power7,lines(dateTime,Sub_metering_3,col = "blue"))
legend("topright", 
	legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
 	bty = "o",lwd=1, cex=0.8,y.intersp=1.0, col=c("black","red","blue"),
	lty=c(1,1,1))

##Save the file
dev.off()


