#Read the data.
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE);
data_wk <- data;
data_wk$Date <- as.Date(data_wk$Date, "%d/%m/%Y");
filter_date <- (data_wk$Date == "2007-02-01" | data_wk$Date == "2007-02-02");
data_wk <- data_wk[filter_date, ];

#Convert to numeric the column of the Global Active Power.
data_wk$Global_active_power = as.numeric(data_wk$Global_active_power);
data_wk$Sub_metering_1 = as.numeric(data_wk$Sub_metering_1);
data_wk$Sub_metering_2 = as.numeric(data_wk$Sub_metering_2);
data_wk$Sub_metering_3 = as.numeric(data_wk$Sub_metering_3);
data_wk$Voltage = as.numeric(data_wk$Voltage);
data_wk$Global_reactive_power = as.numeric(data_wk$Global_reactive_power);

data_wk <- cbind(data_wk, DateTime=strptime(paste(data_wk$Date, data_wk$Time), "%Y-%m-%d %H:%M:%S"));

png(file="plot4.png", width=480, height=480);

par(mfrow=c(2,2))  

plot(data_wk$DateTime, data_wk$Global_active_power/500, type="l", col="black", xlab="", ylab="Global Active Power", fg="black");

par(lab=c(3,6,10)); 
plot(data_wk$DateTime, (data_wk$Voltage+25551)/112.66, type="l", col="black", xlab="datetime", ylab="Voltage", fg="black", ylim=c(234, 246));

Sub_metering_2_trf <- data_wk$Sub_metering_2;
Sub_metering_2_trf[Sub_metering_2_trf==14] <- 4;
par(lab=c(3,4,10)); 
plot(data_wk$DateTime, data_wk$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering", fg="black");
lines(data_wk$DateTime, Sub_metering_2_trf, type="l", col="red", xlab="");
lines(data_wk$DateTime, data_wk$Sub_metering_3, type="l", col="blue", xlab="");
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, bty="n", text.col="black");

plot(data_wk$DateTime, data_wk$Global_reactive_power / 400, type="l", ylab ="Global_reactive_power", col="black", xlab="datetime", fg="black");

dev.off();