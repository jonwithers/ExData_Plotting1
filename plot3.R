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

#Plot 3:
png(filename = "plot3.png", width = 480, height = 480)
with(data, plot(datetime, Sub_metering_1, type = "n", 
                ylab = "Energy sub metering", xlab = ""))
points(data$datetime, data$Sub_metering_1, type = "l")
points(data$datetime, data$Sub_metering_2, type = "l", col = "red")
points(data$datetime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)
dev.off()
