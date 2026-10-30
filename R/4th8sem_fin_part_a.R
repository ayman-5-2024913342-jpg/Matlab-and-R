regions <- paste0("R", 1:15)
temp <- c(22, 25, 27, 28, 26, 32, 32, 35, 30, 29, 29, 27, 26, 22, 23)
hum <- c(70, 65, 72, 68, 65, 75, NA, 85, 65, 67, 62, 55, 75, 85, 76)
rain <- c(45, 50, 55, 48, 65, NA, 60, 95, 20, 15, 20, 35, 55, 75, 70)

# I) ========================
data_weather <- data.frame(Regions=regions, Temperature=temp, Humidity=hum, Rainfall=rain)
print(data_weather)
str(data_weather)
summary(data_weather)

mean_humidity = mean(data_weather$Humidity, na.rm=TRUE) #Finds the mean for rows with NA 
mean_rainfall = mean(data_weather$Rainfall, na.rm=TRUE)

index_of_na = which(is.na(data_weather$Humidity)) #Finds the index of missing data containing NA
data_weather$Humidity[index_of_na] = 69
print(data_weather)

data_weather$Humidity[(is.na(data_weather$Humidity))] <- mean_humidity
data_weather$Rainfall[(is.na(data_weather$Rainfall))] <- mean_rainfall

print(data_weather)
print("\n")
# II) =======================
data_weather$hightemp <- ifelse(
	data_weather$Temperature > 30,
	"Yes",
	"No"
) 
print(data_weather)

#identify stations that are experiencing extreme heat
extreme_stations = data_weather$Regions[data_weather$hightemp == "Yes"]
print("Stations experiencing extreme weather:")
print(extreme_stations)
non_extreme = data_weather$Regions[data_weather$hightemp == "No"]
print("Percentage of stations not experiencing extreme weather:")
print(length(non_extreme) / length(data_weather$Regions) * 100)

# III) ======================
png("Temperature_histogram.png", width=800, height=650)
hist(
	data_weather$Temperature,
	main = "Distribution of Temperature across Regions",
	xlab = "Temperature (C)",
	ylab = "Frequency",
	col = "lightblue",
	border = "black"
)
dev.off()

png("Bar_plot_of_high_temps.png", width=800, height=650)
barplot(
  table(data_weather$hightemp),
  main = "Regions Experiencing Extreme Heat",
  xlab = "Extreme Heat",
  ylab = "Number of Regions",
  col = c("lightgreen", "salmon")
)
dev.off()

# IV) =======================
png("scatter_plot_humidity_rainfall.png", width=800, height=650)
plot(
  data_weather$Humidity,
  data_weather$Rainfall,
  main = "Humidity vs Rainfall",
  xlab = "Humidity (%)",
  ylab = "Rainfall (mm)",
  pch = 19,
  col = "blue"
)
dev.off()

cor(data_weather$Humidity, data_weather$Rainfall, method="pearson")

# V) ========================
model <- lm(Rainfall ~ Humidity, data = data_weather)
summary(model)
coef(model)

new_data <- data.frame(Humidity = c(40, 60))
predict(model, newdata=new_data)