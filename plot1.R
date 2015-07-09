# Script to download, unzip and create plot1 of courseproject1 from Courseras' Exploratory Data course

# Check if file is present, if not download file to current working directory
if(!file.exists("EPC.zip")){
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile = "EPC.zip")
}

# unzip and subset data to lines which begin with 1-Feb-2007 OR 2-Feb-2007
EPC <- read.table(unz("./EPC.zip","household_power_consumption.txt"),
                  header = TRUE, sep = ";", na.strings = "?",
                  stringsAsFactors = FALSE)
subEPC <- EPC[EPC$Date == "1/2/2007" | EPC$Date == "2/2/2007", ]

# plot1
hist(subEPC$Global_active_power, col = "red", axes=F,xlim = c(0,6),
     ylim = c(0,1200), breaks = 11, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
axis(side=1, at=seq(0,6, by=2), labels=seq(0,6, by=2))
axis(side=2, at=seq(0,1200, by=200), labels=seq(0,1200, by=200))

# save plot to png file
dev.copy(png, file = "plot1.png", width=480, height=480)
dev.off()
