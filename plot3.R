

## Download and unzip data in ./data directory if not downloaded yet

DownloadURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
LocalZipPath <- './data/household_power_consumption.zip'
LocalCsvPath <- './data/household_power_consumption.txt'

if(!dir.exists('./data/')) dir.create('./data/')
if(!file.exists(LocalZipPath)) download.file(DownloadURL, destfile = LocalZipPath)
if(!file.exists(basename(LocalCsvPath))) unzip(LocalZipPath, basename(LocalCsvPath), exdir = './data/')


## Read dataset
Dataset <- read.csv2(LocalCsvPath, na.strings='?', dec = ".", colClasses=c('Date'='character', 'Time'='character'))

## Filter Dataset to dates we are working with
Dataset <- subset(Dataset, Date %in% c('1/2/2007','2/2/2007'))

## Calculate DateTime
Dataset$DateTime <- strptime(paste0(Dataset$Date, ' ',Dataset$Time), '%d/%m/%Y %H:%M:%S')


png(filename = 'plot3.png', width = 480, height = 480, bg = 'transparent')

## Print graph in device
plot(Dataset$DateTime, Dataset$Sub_metering_1, ylab = 'Energy sub metering', type='l', xlab = '')
lines(Dataset$DateTime, Dataset$Sub_metering_2, col='red')
lines(Dataset$DateTime, Dataset$Sub_metering_3, col='blue')
legend("topright", col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty = 1)

## close device
dev.off()
