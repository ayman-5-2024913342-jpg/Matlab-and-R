temp = c(19.2,21.1,25.0,28.4,29.6,29.1,28.7,28.9,28.3,27.0,24.0,20.8)
length(temp)

temp.ts = ts(temp, start=c(2025, 1), frequency=12)
temp.ts

plot(temp.ts, xlab="year", ylab="Temperature", main="monthly average temperature")
temp1 = temp+0.2
temp1

temp2 = c(temp,temp1)
length(temp2)

temp2.ts = ts(temp2, start=c(2025, 1), frequency=12)
temp2.ts

plot(temp2.ts, xlab="year", ylab="Temperature", main="monthly average temperature")

date = c("2025-01-01","2025-02-01","2025-03-01","2025-04-01","2025-05-01","2025-06-01"
,"2025-07-01","2025-08-01","2025-09-01","2025-10-01","2025-11-01","2025-12-01")
date
Dates = as.Date(date,format="%Y-%m-%d")
Dates

library(zoo)
ma3 = rollmean(temp2.ts,k=3,align="center")
ma3
	
d = decompose(temp2.ts)
d
plot(d)

plot(temp2.ts, xlab="year", ylab="Temperature", main="monthly average temperature (3-months moving)")
lines(ma3,col="red")

data = AirPassengers
data
is.ts(data)

d1 = decompose(data)
d1
plot(d1)

acf(data)

acf(temp2.ts)

library(tseries)
adf.test(data)

#remove trend

time_index <- 1:length(temp.ts)
trend_model <- lm(temp.ts ~ time_index)
summary(trend_model)
detrend <- residuals(trend_model)
acf(detrend)
adf.test(detrend)

#First Order Difference
temp.ts1<-diff(temp2.ts)
acf(temp.ts1)
adf.test(temp.ts1)

#Second Order Difference
temp.ts2<-diff(temp.ts1)
acf(temp.ts2)
adf.test(temp.ts2)

#Third Order Difference
temp.ts3<-diff(temp.ts2)
acf(temp.ts3)
adf.test(temp.ts3)
