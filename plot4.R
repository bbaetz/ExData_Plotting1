# Download the file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "household_power_consumption.zip"
download.file(fileUrl, destfile = file, method="curl")
unzip(file)

library(data.table)

# Read in the data
data <- fread("household_power_consumption.txt", sep = ";", na.strings = "?")

# filter (before formatting; its faster)
data <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

# Format
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Output to png
png("plot4.png", width=480, height=480)

# Graph
# Set up 2x2 grid
par(mfrow = c(2,2))

# Graph 1
plot(data$Global_active_power~data$DateTime, type="l", xlab = "", ylab="Global Active Power", main="")

# Graph 2
plot(data$Voltage~data$DateTime, type="l", xlab = "datetime", ylab="Voltage", main="")

# Graph 3
plot(data$Sub_metering_1~data$DateTime, type="l", xlab = "", ylab="Energy sub metering", main="")
lines(data$Sub_metering_2~data$DateTime, col="red")
lines(data$Sub_metering_3~data$DateTime, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, bty="n")

# Graph 4
plot(data$Global_reactive_power~data$DateTime, type="l", xlab = "datetime", ylab = "Global_reactive_power", main="")

dev.off()