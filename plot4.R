#This script loads a dataframe and creates the plot4.png histogram
#set the colClasses for the data set
myColClasses<-c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
#Read it all in, just because I can
allpower<-read.table("household_power_consumption.txt",header=TRUE,sep=";",colClasses=myColClasses,na.strings="?")
#extract the period of interest
somepower<-allpower[allpower$Date=="1/7/2007" | allpower$Date=="2/7/2007",]
#combine the Date and Time factor columns into a single datetime column of type POSIXlt (making the assumption that Date/Time are in GMT timezone)
datetime<-strptime(paste(somepower$Date,somepower$Time), format="%d/%m/%Y %H:%M:%S", tz="GMT")
#replace the two columns with the new combined column
somepower<-cbind(datetime,somepower[,3:9])
#set the graphics device
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
# Set up the plot device to hold four different plots populating the first column and then the second
par(mfcol=c(2,2))
# plot the Global Active Power chart
with(somepower, plot(datetime,Global_active_power, xlab="", ylab="Global Active Power", type="n"))
with(somepower, lines(datetime,Global_active_power))
# plot the sub metering chart
with(somepower, plot(datetime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(somepower, lines(datetime,Sub_metering_1, col="black"))
with(somepower, lines(datetime,Sub_metering_2, col="red"))
with(somepower, lines(datetime,Sub_metering_3, col="blue"))
with(somepower, legend(x="topright",y=NULL,c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=0.5, lty=c(1,1,1), lwd=c(2.5,2.5,2.5),col=c("black","blue","red")))
#plot the Voltage chart
with(somepower, plot(datetime,Voltage, type="n"))
with(somepower, lines(datetime,Voltage))
#plot the Global Reactive Power chart
with(somepower, plot(datetime,Global_reactive_power, type="n"))
with(somepower, lines(datetime,Global_reactive_power))
#turn off the png graphics device
dev.off()
