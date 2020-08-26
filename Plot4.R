#Load and prepare the data

library(tidyverse)
library(ggplot2)

df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?"
                 , colClasses = c('character','character','numeric','numeric','numeric'
                                  ,'numeric','numeric','numeric','numeric'))

df$Date <- as.Date(df$Date, "%d/%m/%Y")

df2 <- filter(df,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
df2$DateTime <- paste(df2$Date, df2$Time)
df2$DateTime <- as.POSIXct(df2$DateTime)

#Plot the four graphs
png(file="plot4.png", width=480, height=480)
attach(mtcars)
par(mfrow=c(2,2))
plot(df2$Global_active_power ~ df2$DateTime, type="l", ylab="Global Active Power", xlab="")
plot(df2$Voltage ~ df2$DateTime, type="l", ylab = "Voltage", xlab = "datetime")
plot(df2$Sub_metering_1 ~ df2$DateTime, type="l", ylab="Energy Sub Metering", xlab="")
lines(df2$Sub_metering_2 ~ df2$DateTime, type = "l", col = "red")
lines(df2$Sub_metering_3 ~ df2$DateTime, type = "l", col = "blue")
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(df2$Global_reactive_power ~ df2$DateTime, type="l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()
