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

# Output to png
png("plot1.png", width=480, height=480)

# Graph
hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()