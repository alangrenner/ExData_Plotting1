#Week 1 Project by Alan Renner - Plot 4
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


##PLOTTING
png("plot4.png", width=480, height=480) #create the device
datetime <- strptime(paste(powerdata$Date, powerdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
Sys.setlocale("LC_TIME", "English") #change the language to English, due to the weekdays shown
#creating a 2x2 plot assemble
par(mfrow=c(2,2))
#first plot
plot(datetime, 
     as.numeric(powerdata$Global_active_power), #variables
     type="l", #uses the lines type
     ylab = "Global Active Power",
     xlab ="")
#second plot
plot(datetime, 
     powerdata$Voltage, 
     type="l", #uses the lines type
     ylab = "Voltage",
     xlab ="datetime")
#third plot
plot(datetime, 
     as.numeric(powerdata$Sub_metering_1), 
     type="l", #uses the lines type
     ylab = "Energy sub metering",
     xlab ="")
lines(datetime, 
      as.numeric(powerdata$Sub_metering_2),
      type="l",
      col="red")
lines(datetime,
      as.numeric(powerdata$Sub_metering_3),
      type="l",
      col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1,lwd = 2, cex=0.7, col=c("black","red","blue"))
#fourth plot
plot(datetime,
     powerdata$Global_reactive_power,
     type="l",
     ylab = "Global_reactive_power")
dev.off() #close the device - found at the WD
