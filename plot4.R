###
# Reading in the data: A quick look at the file shows that the relevant lines are 66638:69517
# and that the NA character is '?'. To save time and memory, the data is read using 
# read.table with parameters, and the colnames are read using a nested read.table. 
# . The Date column is converted to Date.
file <- "household_power_consumption.txt"
data <- read.table(file, sep = ";", na.strings = "?", skip = 66637, nrows = 2879, 
                   col.names = colnames(read.table(file, sep = ";", na.strings = "?", 
                                                   header = TRUE, nrows = 1, 
                                                   stringsAsFactors = FALSE)))
datetime <- as.POSIXlt(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data <- cbind(data, datetime)

#Plot 4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(data, plot(datetime, Global_active_power, type = "l", 
                ylab = "Global Active Power (kilowatts)", xlab = ""))

with(data, plot(datetime, Voltage, type = "l",
                ylab = "Voltage", xlab = "datetime"))

with(data, plot(datetime, Sub_metering_1, type = "n",
                ylab = "Energy sub metering", xlab = ""))
points(data$datetime, data$Sub_metering_1, type = "l")
points(data$datetime, data$Sub_metering_2, type = "l", col = "red")
points(data$datetime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, bty = "n")

with(data, plot(datetime, Global_reactive_power, type = "l"))

dev.off()