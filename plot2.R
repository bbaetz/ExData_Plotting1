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
data$Global_active_power <- as.numeric(data$Global_active_power)
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Output to png
png("plot2.png", width=480, height=480)

# Graph
plot(data$Global_active_power~data$DateTime, type="l", xlab = "", ylab="Global Active Power (kilowatts)", main="")
dev.off()