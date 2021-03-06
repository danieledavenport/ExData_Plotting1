#This script loads a dataframe and creates the plot2.png histogram
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
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
# plot the line chart
with(somepower, plot(datetime,Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="n"))
with(somepower, lines(datetime,Global_active_power))
#turn off the png graphics device
dev.off()