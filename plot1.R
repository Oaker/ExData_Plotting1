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


png(filename = "plot1.png",
    width = 480, height = 480, units = "px",
    pointsize = 12, bg = "white")

hist(dataSub$Global_active_power,main="Global Active Power",col="red",xlab="Global Active Power (kilowatts)",ylim=c(0,1200))

dev.off()
