# Script to download, unzip and create plot3 of courseproject1 from Courseras' Exploratory Data course

# Check if data-file is present, if not download file to current working directory
if(!file.exists("EPC.zip")){
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile = "EPC.zip")
}

# unzip and subset data to lines which begin with 1-Feb-2007 OR 2-Feb-2007
EPC <- read.table(unz("./EPC.zip","household_power_consumption.txt"),
                  header = TRUE, sep = ";", na.strings = "?",
                  stringsAsFactors = FALSE)
subEPC <- EPC[EPC$Date == "1/2/2007" | EPC$Date == "2/2/2007", ] # subset to 1-Feb-2007 and 2-Feb-2007

# plot 3
library(lubridate)
subEPC <- within(subEPC, {timestamp=dmy_hms(paste(subEPC$Date,subEPC$Time))})
plot(Sub_metering_1 ~ timestamp, subEPC, type = "l", xlab="", ylab="Energy sub metering")
lines(Sub_metering_2 ~ timestamp, subEPC, col = "red")
lines(Sub_metering_3 ~ timestamp, subEPC, col = "blue")
legend("topright", lty = c(1,1), col=c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# save plot to png file
dev.copy(png, file = "plot3.png", width=480, height=480)
dev.off()
