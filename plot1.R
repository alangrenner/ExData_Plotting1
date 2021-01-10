#Week 1 Project by Alan Renner - Plot 1
#10 jan 2021

###Downloading and unzipping the data ====
if(!file.exists("./data")){dir.create("./data")} #creates a dir on wd
fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/Dataset.zip") #download the file
unzip("./data/Dataset.zip", exdir="./data") #unzips the file to the created dir
list.files("./data") 
datafile <- "./data/household_power_consumption.txt"

###Creating the data frame and naming the columns
powerdata <- read.table(datafile, 
                   header=F, #header is set to false due to the skip command below
                   sep=";", 
                   stringsAsFactors=FALSE, 
                   dec=".", 
                   skip = 66637, #skip to the row when 01 feb 2007 starts
                   nrow = 2880)   #end on the row when 02 feb 3007 ends - 2880 minutes later.
headers<- read.table(datafile, 
                     header=F,
                     sep=";",
                     nrow=1)
colnames(powerdata)=headers #sets the name of the columns using the 'headers' created above

###HISTOGRAM
png("plot1.png", width=480, height=480) #create the device
hist(powerdata$Global_active_power, #the variable
     main="Global Active Power", #sets the title
     col = "red", #sets the bar color
     xlab = "Global Active Power (kilowatts)") #sets the label
dev.off() #close the device - found at the WD
