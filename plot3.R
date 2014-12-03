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
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Output to png
png("plot3.png", width=480, height=480)

# Graph
plot(data$Sub_metering_1~data$DateTime, type="l", xlab = "", ylab="Energy sub metering", main="")
lines(data$Sub_metering_2~data$DateTime, col="red")
lines(data$Sub_metering_3~data$DateTime, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)
dev.off()