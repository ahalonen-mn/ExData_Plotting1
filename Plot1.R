#Load and prepare the data
library(tidyverse)

df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?"
                , colClasses = c('character','character','numeric','numeric','numeric'
                                 ,'numeric','numeric','numeric','numeric'))

df$Date <- as.Date(df$Date, "%d/%m/%Y")

df2 <- filter(df,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
df2$DateTime <- paste(df2$Date, df2$Time)
df2$DateTime <- as.POSIXct(df2$DateTime)

#Plot the histogram for Global Active Power
png(file="plot1.png", width=480, height=480)
hist(df2$Global_active_power, col = 'red', main = 'Global Active Power', xlab = "Global Active Power (kilowatts)")
dev.off()
