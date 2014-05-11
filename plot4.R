# file name
filename<-"household_power_consumption.txt"

#read the data using read.table
house_power_consumption<-read.table(filename,sep=";", header=T, colClasses = c('character', 'character', 'numeric',
                                    'numeric', 'numeric', 'numeric','numeric', 'numeric', 'numeric'),na.strings='?')

#convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions
house_power_consumption$DateTime <- strptime(paste(house_power_consumption$Date, house_power_consumption$Time), 
                                             "%d/%m/%Y %H:%M:%S")

#Subset the two day data
house_power_consumption <- subset(house_power_consumption,as.Date(DateTime) >= as.Date("2007-02-01") & 
                                    as.Date(DateTime) <= as.Date("2007-02-02"))

#specify the width and height
png("plot4.png", height=480, width=480)

#Specify the no of graphs
par(mfrow=c(2,2))

#Global Active Power Plot
plot(house_power_consumption$DateTime, 
     house_power_consumption$Global_active_power, 
     pch=NA, 
     xlab="", 
     ylab="Global Active Power")
lines(house_power_consumption$DateTime, house_power_consumption$Global_active_power)

#Voltage Plot
plot(house_power_consumption$DateTime, house_power_consumption$Voltage, ylab="Voltage", xlab="datetime", pch=NA)
lines(house_power_consumption$DateTime, house_power_consumption$Voltage)

#Energy sub metering
plot(house_power_consumption$DateTime, 
     house_power_consumption$Sub_metering_1, 
     pch=NA, 
     xlab="", 
     ylab="Energy sub metering")
lines(house_power_consumption$DateTime, house_power_consumption$Sub_metering_1)
lines(house_power_consumption$DateTime, house_power_consumption$Sub_metering_2, col='red')
lines(house_power_consumption$DateTime, house_power_consumption$Sub_metering_3, col='blue')
legend('topright', 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1),
       col = c('black', 'red', 'blue'),
       bty = 'n')

#Global_reactive_power
with(house_power_consumption, plot(DateTime, Global_reactive_power, xlab='datetime', pch=NA))
with(house_power_consumption, lines(DateTime, Global_reactive_power))

#Close the device
dev.off()