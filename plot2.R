# Read in the data and extract only a subset
data <- read.csv2("household_power_consumption.txt")
dlow <- strptime("2007-02-01","%Y-%m-%d")
dhigh <- strptime("2007-02-02","%Y-%m-%d")
data$rdate = strptime(data$Date, format="%d/%m/%Y")
data <- subset(data, rdate >= dlow & rdate <= dhigh)

# Global active power is a factor; coerce to numeric
data$gap <- as.numeric(levels(data$Global_active_power))[data$Global_active_power]

# Convert some timestamps
data$tstamp <- strptime(paste(data$Date, data$Time),format="%d/%m/%Y %H:%M:%S")

# And now plot
png("plot2.png", height=480, width=480)
with(data, plot(tstamp, gap, type="l",xlab="",ylab="Global Active Power (kilowatts)"))
dev.off()
