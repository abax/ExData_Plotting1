# Read in the data and extract only a subset
data <- read.csv2("household_power_consumption.txt")
dlow <- strptime("2007-02-01","%Y-%m-%d")
dhigh <- strptime("2007-02-02","%Y-%m-%d")
data$rdate = strptime(data$Date, format="%d/%m/%Y")
data <- subset(data, rdate >= dlow & rdate <= dhigh)

# Global (re)-active power is a factor; coerce to numeric
data$gap <- as.numeric(levels(data$Global_active_power))[data$Global_active_power]
data$grp <- as.numeric(levels(data$Global_reactive_power))[data$Global_reactive_power]

# Sub metering levels are factors; coerce to numeric
data$sm1 <- as.numeric(levels(data$Sub_metering_1))[data$Sub_metering_1]
data$sm2 <- as.numeric(levels(data$Sub_metering_2))[data$Sub_metering_2]
data$sm3 <- as.numeric(levels(data$Sub_metering_3))[data$Sub_metering_3]

# Voltage levels are factors; coerce to numeric
data$v <- as.numeric(levels(data$Voltage))[data$Voltage]

# Convert some timestamps
data$tstamp <- strptime(paste(data$Date, data$Time),format="%d/%m/%Y %H:%M:%S")

# And now plot
png("plot4.png", height=480, width=480)
par(mfrow=c(2,2))

# plot Global Active Power
with(data, plot(tstamp, gap, type="l",xlab="",ylab="Global Active Power (kilowatts)"))

# plot Voltage
with(data, plot(tstamp, v, type="l",xlab="datetime",ylab="Voltage"))

# plot Sub Metering
with(data, plot(tstamp, sm1, type="l",xlab="",ylab="Energy sub metering"))
with(data, lines(tstamp, sm2, col="red", type="l",xlab=""))
with(data, lines(tstamp, sm3, col="blue", type="l",xlab=""))
legend("topright", "groups", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=c(1,1,1), bty="y")

# plot reactive power
with(data, plot(tstamp, grp, type="l",xlab="datetime",ylab="Global_reactive_power"))

dev.off()
