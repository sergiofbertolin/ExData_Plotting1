plot2 <- function(){
  
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
  
  ##creating the plot
  plot(data$datetime,data$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type="l")
  dev.copy(png, file = "plot2.png",width=480,height=480)
  dev.off() 
  
}