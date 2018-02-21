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

# Plot 2:
png(filename = "plot2.png", width = 480, height = 480)
with(data, plot(datetime, Global_active_power, type = "l", 
                ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()