#PART I
station <- paste0("S", 1:10) 
humidity <- c(70, NA, 72, 68, 65, 75, 74, 85, 65, 67)
rainfall <- c(45, 50, 55, 48, 65, NA, 60, 95, 20, 15)

weather_data <- data.frame(Station = station, Humidity = humidity, Rainfall = rainfall)

str(weather_data)
summary(weather_data)

which(is.na(weather_data$Humidity))
which(is.na(weather_data$Rainfall))

#PART II

mean_humidity <- mean(weather_data$Humidity, na.rm=TRUE)
mean_rainfall <- mean(weather_data$Rainfall, na.rm=TRUE)


weather_data$Humidity[which(is.na(weather_data$Humidity))] <- mean_humidity
weather_data$Rainfall[which(is.na(weather_data$Rainfall))] <- mean_rainfall

print(weather_data)

#PART III

weather_data$Extreme <- ifelse(weather_data$Rainfall > 80, "YES", "NO")
extreme_stations = weather_data$Station[weather_data$Extreme == "YES"]
print(extreme_stations)

normal_stations = weather_data$Station[weather_data$Extreme == "NO"]
n1 = length(normal_stations)
e1 = length(extreme_stations)
percentage_of_stations_w_extreme_rainfall = e1 / n1 * 100
print(percentage_of_stations_w_extreme_rainfall)

#PART IV
sorted_weather <- weather_data[order(weather_data$Rainfall, decreasing=TRUE), ]
print(sorted_weather)