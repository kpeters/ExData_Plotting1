# Script to download, unzip and create plot2 of courseproject1 from Courseras' Exploratory Data course

# Check if data-file is present, if not download file to current working directory
if(!file.exists("EPC.zip")){
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile = "EPC.zip")
}

## unzip and subset data to lines which begin with 1-Feb-2007 OR 2-Feb-2007
EPC <- read.table(unz("./EPC.zip","household_power_consumption.txt"),
                  header = TRUE, sep = ";", na.strings = "?",
                  stringsAsFactors = FALSE)
subEPC <- EPC[EPC$Date == "1/2/2007" | EPC$Date == "2/2/2007", ] # subset to 1-Feb-2007 and 2-Feb-2007


# plot2
library(lubridate)
a <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME","English") 
subEPC <- within(subEPC, {timestamp=dmy_hms(paste(subEPC$Date,subEPC$Time))})
plot(Global_active_power ~ timestamp, subEPC, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
Sys.setlocale("LC_TIME", a)

# save plot to png file
dev.copy(png, file = "plot2.png", width=480, height=480)
dev.off()
