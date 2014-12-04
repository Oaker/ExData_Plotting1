print("start")
f<-download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","power.zip")
dataPower<-read.table(unz("power.zip", "household_power_consumption.txt"), 
                      header=T, sep=";", na.strings="?",
                      colClasses = c("character",
                                     "character",
                                     "numeric",
                                     "numeric",
                                     "numeric",
                                     "numeric",
                                     "numeric",
                                     "numeric",
                                     "numeric"),
                      strip.white = TRUE)
print("ok")

dataPower[,"pt"]<-as.POSIXct(paste(dataPower[,1],dataPower[,2]),format="%d/%m/%Y %H:%M:%S")
dataSub<-subset(dataPower,(pt>=strptime("2007-02-01","%Y-%m-%d")&(pt<strptime("2007-02-03","%Y-%m-%d"))))


png(filename = "plot4.png", width = 480, height = 480, units = "px",     pointsize = 12, bg = "white")
par(mfrow=c(2,2))
par(mar=c(4,4,1,1))
plot(dataSub$pt,dataSub$Global_active_power, type="l",main="",ylab="Global Active Power",xlab="",col="black", ylim=c(0,6))

plot(dataSub$pt,dataSub$Voltage, type="l",main="",ylab="Voltage",xlab="datetime",col="black",ylim=c(234,246))


plot(dataSub$pt,dataSub$Sub_metering_1, type="l",main="",ylab="Energy sub metering",xlab="",col="black")
points(dataSub$pt,dataSub$Sub_metering_1,type="l", col="black")
points(dataSub$pt,dataSub$Sub_metering_3,type="l", col="blue")
points(dataSub$pt,dataSub$Sub_metering_2,type="l", col="red")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)

plot(dataSub$pt,dataSub$Global_reactive_power, type="l",main="",ylab="Global_rective_power", xlab="datetime",col="black", ylim=c(0,0.5))

dev.off()



