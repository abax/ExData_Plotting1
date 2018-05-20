# Read in the data and extract only a subset
data <- read.csv2("household_power_consumption.txt")
dlow <- strptime("2007-02-01","%Y-%m-%d")
dhigh <- strptime("2007-02-02","%Y-%m-%d")
data$rdate = strptime(data$Date, format="%d/%m/%Y")
data <- subset(data, rdate >= dlow & rdate <= dhigh)

# Sub metering levels are factors; coerce to numeric
data$sm1 <- as.numeric(levels(data$Sub_metering_1))[data$Sub_metering_1]
data$sm2 <- as.numeric(levels(data$Sub_metering_2))[data$Sub_metering_2]
data$sm3 <- as.numeric(levels(data$Sub_metering_3))[data$Sub_metering_3]

# Convert some timestamps
data$tstamp <- strptime(paste(data$Date, data$Time),format="%d/%m/%Y %H:%M:%S")

# And now plot
png("plot3.png", height=480, width=480)
with(data, plot(tstamp, sm1, type="l",xlab="",ylab="Energy sub metering"))
with(data, lines(tstamp, sm2, col="red", type="l",xlab="",ylab="Energy sub metering"))
with(data, lines(tstamp, sm3, col="blue", type="l",xlab="",ylab="Energy sub metering"))
legend("topright", "groups", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=c(1,1,1), bty="y")
dev.off()
