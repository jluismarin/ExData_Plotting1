## The script bellow writes to disk the plot2.png file which reconstructs ./figure/unnamed-chunk-3.png
## The output is a 480x480 transparent png as required, though the sample is 504x504
## The script does the following steps
##    (1) Downloads and unzips data from  UC Irvine Machine Learning Repository if not yet in working directory
##    (2) Reads txt file to dataset and subsets 2 days data
##    (3) Calculates a new DateTime variable from Data and Time
##    (4) Writes plot for Global_active_power vs DateTime in png graphic device


## Usage:
##  (1) Run the script "plot2.R"

## Download and unzip data from repository to ./data/ directory if not downloaded yet
## This code is common for the four files of the assignment

DownloadURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
LocalZipPath <- './data/household_power_consumption.zip'
LocalCsvPath <- './data/household_power_consumption.txt'

if(!dir.exists('./data/')) dir.create('./data/')
if(!file.exists(LocalZipPath)) download.file(DownloadURL, destfile = LocalZipPath)
if(!file.exists(basename(LocalCsvPath))) unzip(LocalZipPath, basename(LocalCsvPath), exdir = './data/')


## Read txt file to dataset with 2,075,259 rows and 9 columns
Dataset <- read.csv2(LocalCsvPath, na.strings='?', dec = ".", colClasses=c('Date'='character', 'Time'='character'))

## Filter Dataset to dates we are working with
Dataset <- subset(Dataset, Date %in% c('1/2/2007','2/2/2007'))

## Calculate DateTime from Date and Time variables and add to new variable in dataset
Dataset$DateTime <- strptime(paste0(Dataset$Date, ' ',Dataset$Time), '%d/%m/%Y %H:%M:%S')

## Open png graphic device with right options
png(filename = 'plot2.png', width = 480, height = 480, bg = 'transparent')

## Print graph in screen device
plot(Dataset$DateTime, Dataset$Global_active_power, ylab = 'Global Active Power (kilowatts)', type='l', xlab = '')

## close device
dev.off()
