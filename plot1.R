# Read in the data and extract only a subset
data <- read.csv2("household_power_consumption.txt")
dlow <- strptime("2007-02-01","%Y-%m-%d")
dhigh <- strptime("2007-02-02","%Y-%m-%d")
data$rdate = strptime(data$Date, format="%d/%m/%Y")
data <- subset(data, rdate >= dlow & rdate <= dhigh)

# Global active power is a factor; coerce to numeric
data$gap <- as.numeric(levels(data$Global_active_power))[data$Global_active_power]

# And now plot

png("plot1.png", height=480, width=480)
hist(data$gap,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()
