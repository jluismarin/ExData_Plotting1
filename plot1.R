

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

## Print graph in screen device
hist(Dataset$Global_active_power, main='Global Active Power', xlab = 'Global Active Power (kilowatts)', col = 'red')
  
## Write png file
dev.copy(png, file = 'plot1.png')
dev.off()
