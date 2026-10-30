# I) =================================
rainfall <- c(42,38,55,73,95,120,140,130,110,80,60,52,45,40,42,55,74,94,125,145,132,110,82,65)

rain_ts <- ts(rainfall, start=c(2023, 1), frequency=12)

print(rain_ts)

png("Rainfeall_time_series.png", width=800, height=600)
plot(
	rain_ts,
	main="Rainfall Time Series",
	xlab="Year",
	ylab="Rainfall (mm)",
	col="blue",
	type="o"
)
dev.off()

library(forecast)

rain_ma <- ma(rain_ts, order = 3)

png("Rainfall_ma.png", width=600, height=600)
plot(
	rain_ts,
	main = "rainfall moving average",
	xlab = "Year",
	ylab = "Rainfall (mm)",
	col = "blue"
)

lines(rain_ma, col = "red", lwd = 2)

legend(
	"topleft",
	legend = c("Original Rainfall", "3-Month Moving Average"), 
	col = c("blue", "red"),
	lty = 1,
	lwd = 2
)
dev.off()

png("acf_monthly_rainfall.png", width=600, height=600)
acf(
	rain_ts,
	main = "Act of Monthly Rainfall"
)
dev.off()

# III) ======================
rain_decom <- decompose(rain_ts, type = "multiplicative")

png("Rainfall decomp.png", width=600, height=600)
plot(rain_decom)
dev.off()

trend_component <- rain_decom$trend
seasonal_component <- rain_decom$seasonal
random_component <- rain_decom$random

print(trend_component)
print(seasonal_component)
print(random_component)

# IV) =======================
library(tseries)
library(zoo)

adf.test(rain_ts)

# V) ========================
rain_diff <- diff(rain_ts)

png("First-Differenced Monthly Rainfall.png", width=800, height=800)
plot(
	rain_diff,
	main = "First-Differenced Monthly Rainfalll",
	xlab = "Year",
	ylab = "Change in Rainfall (mm)",
	col = "blue",
	type = "o"
)
adf.test(rain_diff)
dev.off()

dates <- as.Date(as.yearmon(time(rain_diff)))

png("First-Differenced_Monthly_Rainfall_with_month_names.png", width = 800, height = 800)

plot(
  rain_diff,
  main = "First-Differenced Monthly Rainfall",
  xlab = "Month",
  ylab = "Change in Rainfall (mm)",
  col = "blue",
  type = "o",
  xaxt = "n"
)

axis(
  side = 1,
  at = time(rain_diff),
  labels = format(dates, "%b %y"),
  las = 2 
)

dev.off()

adf.test(rain_diff)



