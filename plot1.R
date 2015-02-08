plot1 <- function(){
  
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
  
  ##creating the plot
  hist(data$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
  dev.copy(png, file = "plot1.png",width=480,height=480)
  dev.off() 
  
}
