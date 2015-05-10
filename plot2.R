## My system lenguage setting is polish, so in the bottom of plots are
## shortcuts of polish weekdays !!!

## Downloading & loading data into R
# If you're using windows & downloading file doesn't working, just
# delete ', method = "curl"'. It should work then.
temp <- tempfile()
download.file(paste0("https://d396qusza40orc.cloudfront.net/", 
                     "exdata%2Fdata%2Fhousehold_power_consumption.zip"),
              temp, method = "curl")
data <- read.table(unz(temp, "household_power_consumption.txt"),
                   sep = ";", na.strings = "?", skip = 1,
                   col.names = c("Date", "Time", "Global_active_power",
                                 "Global_reactive_power", "Voltage",
                                 "Global_intensity", "Sub_metering_1",
                                 "Sub_metering_2", "Sub_metering_3"))
unlink(temp)

## Processing Data
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- data[data$Date == as.Date("2007-02-01")
             |data$Date == as.Date("2007-02-02"),]
data$DateTime <- paste(as.character(data[,"Date"]), as.character(data[, "Time"]))
data$DateTime <- strptime(data$DateTime, "%Y-%m-%d %H:%M:%S")

## Plotting
png(filename = "plot2.png")
with(data, plot(DateTime, Global_active_power, type = "l", xlab = NA,
                ylab = "Global Active Power (kilowatts)"))
dev.off()