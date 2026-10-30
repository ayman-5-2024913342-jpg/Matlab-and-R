rainfall <- c(42,38,55,73,95,120,140,130,110,80,60,52,45,40,42,55,74,94,125,145,132,110,82,65)
rain_ts <- ts(rainfall, start=c(2023, 1), frequency=12)

print(rain_ts)
#======== Visualize The Data ============
plot(rain_ts, main="Rainfall time series", xlab="Year", ylab="Rainfall (mm)")

library(tseries)
print("Original Adf Test")
adf.test(rain_ts)

#======== Remove Trend ==================
time_index <- 1:length(rain_ts)
trend_model <- lm(rain_ts ~ time_index)
summary(trend_model)

rain_detrend <- residuals(trend_model)
acf(rain_detrend, main="ACF: Detrended Rainfall Series")
adf.test(rain_detrend)

#========== Differencing (1st, 2nd, 3rd)================

#First Order
rain_diff1 <- diff(rain_ts)
acf(rain_diff1, main="ACF: 1st Difference")
adf.test(rain_diff1)


#Second Order
rain_diff2 <- diff(rain_diff1)
acf(rain_diff2, main="ACF: 2nd Difference")
adf.test(rain_diff2)

#Third Order
rain_diff3 <- diff(rain_diff2)
acf(rain_diff3, main="ACF: 3nd Difference")
adf.test(rain_diff3)

#======== Logarithimic Transform ===================
