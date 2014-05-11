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
png("plot2.png", height=480, width=480)

#Global active power plot
plot(house_power_consumption$DateTime, 
     house_power_consumption$Global_active_power,,pch=NA, 
     xlab="", 
     ylab="Global Active Power (kilowatts)")
lines(house_power_consumption$DateTime, house_power_consumption$Global_active_power)

#Close the device
dev.off()