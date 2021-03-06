##read the *.txt file and specify: that columns are separated by ";", no valid columns are 
## represented by ?, and do not transform string data in factor
data<-read.table("household_power_consumption.txt", sep=";",header=TRUE, na.strings="?",stringsAsFactors=FALSE)
##Transform classes of columns Date  and Time into date and time instead of character 
data$Date<-strptime(paste(data[,"Date"],data[,"Time"]), "%d/%m/%Y %H:%M:%S")

##Subset the data frame in another with data that I am going to use.
data_sub<-subset(data, Date>=as.POSIXlt("2007-02-01")&Date<as.POSIXlt("2007-02-03"))
##I had to use the next line, because I am Spanish and the days of the week came as "Jueves, Viernes, Sabado"
Sys.setlocale("LC_TIME", "English")
## Represent the plot
plot(data_sub$Date,data_sub$Global_active_power,type="l", xlab="", ylab="Global Active Power (kilowatts)", main="")
##save the plot into a png file. I have specified the width and the height
##but is not necesary because, by default it saves it as a 480x480 px file
dev.copy(png,file="plot2.png",width=480,height=480)
dev.off()
