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
par(mfrow=c(2,2), cex=0.5)
with(data_sub,
     {plot(Date,Global_active_power,xlab="",ylab="Global Active Power",type="l")
      plot(Date,Voltage, xlab="datetime", ylab="Voltage",type="l")
      plot(Date,Sub_metering_1,type="l", xlab="", ylab="Energy sub metering", main="",col="black",ps=4)
      lines(Date, Sub_metering_2,type="l",col="red")
      lines(Date, Sub_metering_3,type="l",col="blue")
      legend("topright",lty=1,bty="n",xjust="1",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"))
      plot(Date,Global_reactive_power, xlab="datetime", type="l")
     }
     )
##save the plot into a png file. I have specified the width and the height
##but is not necesary because, by default it saves it as a 480x480 px file
dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()
