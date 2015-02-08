plot4 <- function(){
  
  ## Only if the file household_power_consumption.txt isn't on the working directory
  if(!file.exists("./household_power_consumption.txt")){
    ##downloading the zip file
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./data_file.zip",method="auto")
    
    ##unzip the file
    unzip("./data_file.zip")
  }
  
  
  ##Exctracting only 1/2/2007 and 2/2/2007
  data <- read.csv.sql("./household_power_consumption.txt",sql = 'select * from file where Date = "1/2/2007" OR Date = "2/2/2007"', sep = ";")
  
  ##replacing ? by NA
  data[data == "?"] <- NA
  
  ##creating a new combined variable date + time
  data$datetime<-as.POSIXct(paste(data$Date,data$Time), format="%d/%m/%Y %H:%M:%S")
  
  ##call function png before plot to correct adjusting the plots and legends
  png(file = "plot4.png",width=480,height=480,units="px")
  
  
  ##creating the set of plots
  par(mfrow = c(2,2))
  
  ##creating the plot equivalent to plot2
  plot(data$datetime,data$Global_active_power,xlab="",ylab="Global Active Power",type="l")
  
  ##creating the plot equivalent to Voltage
  plot(data$datetime,data$Voltage,xlab="datetime",ylab="Voltage",type="l")
  
  ##creating the plot equivalent to plot3
  plot(data$datetime,data$Sub_metering_1,xlab="",ylab="Energy sub metering",type="n")
  lines(data$datetime,data$Sub_metering_1,col="black")
  lines(data$datetime,data$Sub_metering_2,col="red")
  lines(data$datetime,data$Sub_metering_3,col="blue")
  legend("topright", lwd =1,cex=1,bty="n", col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  
  ##creating the plot equivalent to Voltage
  plot(data$datetime,data$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")
  
  
  dev.off() 
  
}