#Read the data.
#data <- read.table("household_power_consumption.txt", sep=";", header=TRUE);
data_wk <- data;
data_wk$Date <- as.Date(data_wk$Date, "%d/%m/%Y");
filter_date <- (data_wk$Date == "2007-02-01" | data_wk$Date == "2007-02-02");
data_wk <- data_wk[filter_date, ];

#Convert to numeric the column of the Global Active Power.
data_wk$Global_active_power = as.numeric(data_wk$Global_active_power);
data_wk$Sub_metering_1 = as.numeric(data_wk$Sub_metering_1);
data_wk$Sub_metering_2 = as.numeric(data_wk$Sub_metering_2);
data_wk$Sub_metering_3 = as.numeric(data_wk$Sub_metering_3);
data_wk <- cbind(data_wk, DateTime=strptime(paste(data_wk$Date, data_wk$Time), "%Y-%m-%d %H:%M:%S"));

#Export to png.

#Plot 1.
png(file="plot1.png", width=480, height=480);
hist(data_wk$Global_active_power / 500, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red", breaks=14);
dev.off();
