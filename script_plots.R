EPC<-read.table("household_power_consumption.txt", sep=";", header=T, na.strings="?")
date<-strptime(EPC$Date, format="%d/%m/%Y")
EPC$Date<-date
sub_EPC<-subset(EPC, Date=="2007-02-01" | Date=="2007-02-02")
sub_EPC<-cbind(sub_EPC, weekday=format(sub_EPC$Date, "%a"))


##plot1
GAP <- sub_EPC$Global_active_power
png("plot1.png", width=480, height=480)
hist(GAP, main="Global Active Power", xlab="Global active power", col="red")
dev.off()

##plot2
GAP <- sub_EPC$Global_active_power
png("plot2.png", width=480, height=480)
datetime <- strptime(paste(sub_EPC$Date, sub_EPC$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 
plot(datetime, GAP, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

##plot3
submeter1<-sub_EPC$Sub_metering_1
submeter2<-sub_EPC$Sub_metering_2
submeter3<-sub_EPC$Sub_metering_3

png("plot3.png", width=480, height=480)
plot(datetime, submeter1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, submeter2, type="l", col="red")
lines(datetime, submeter3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()

##plot4
GRP <- sub_EPC$Global_reactive_power
png("plot3.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
plot(datetime, GAP, type="l", xlab="", ylab="Global Active Power (kilowatts)")
plot(datetime, submeter1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, submeter2, type="l", col="red")
lines(datetime, submeter3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
plot(datetime, voltage, type="l",  ylab="Voltage (volt)", xlab="")
GRP <- sub_EPC$Global_reactive_power
plot(datetime, GRP, type="l", xlab="", ylab="Global Reactive Power (kilowatts)")
dev.off()