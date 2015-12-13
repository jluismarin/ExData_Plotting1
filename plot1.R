## The script bellow writes to disk the plot1.png file which reconstructs ./figure/unnamed-chunk-2.png
## The output is a 480x480 transparent png as required, though the sample is 504x504
## The script does the following steps
##    (1) Downloads and unzips data from  UC Irvine Machine Learning Repository if not yet in working directory
##    (2) Reads txt file to dataset and subsets 2 days data
##    (3) Writes histogram for Global_active_power variable in png graphic device


## Usage:
##  (1) Run the script "plot1.R"



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

## Filter rows for the dates we are working with: 2007-02-01 and 2007-02-02
Dataset <- subset(Dataset, Date %in% c('1/2/2007','2/2/2007'))

## Open png graphic device with right options
png(filename = 'plot1.png', width = 480, height = 480, bg = 'transparent')

## Print graph in png graphic device
hist(Dataset$Global_active_power, main='Global Active Power', xlab = 'Global Active Power (kilowatts)', col = 'red')

## close device
dev.off()
