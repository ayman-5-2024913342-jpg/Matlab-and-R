#PART I ===========================================
Regions <- paste0("R", 1:15)
Temperature <- c(22, 25, 27, 28, 26, 32, 32, 35, 30, 29, 28, 27, 26, 22, 23)
Humidity <- c(70, 65, 72, 68, 65, 75, NA, 85, 65, 67, 62, 55, 75, 85, 76)
Rainfall <- c(45, 50, 55, 48, 65, NA, 60, 95, 20, 15, 20, 35, 55, 75, 70)

#Create Data Frame, Display Structure and Summary
data_weather = data.frame(Regions=Regions, Temperature=Temperature, Humidity=Humidity, Rainfall=Rainfall)
str(data_weather)
summary(data_weather)

#Identify Missing Observations
data_weather$Regions[which(is.na(data_weather$Humidity))]
data_weather$Regions[which(is.na(data_weather$Rainfall))]

#Replace Missing data 
mean_humidity <- mean(data_weather$Humidity, na.rm=TRUE)
mean_rainfall <- mean(data_weather$Rainfall, na.rm=TRUE)

data_weather$Humidity[which(is.na(data_weather$Humidity))] = mean_humidity
data_weather$Rainfall[which(is.na(data_weather$Rainfall))] = mean_rainfall

stations <- paste0("S", 1:10)
temp <- c(20, 25, 27, 28, 26, 32, 32, 35, 30, 29)
hum <- c(65, 65, 72, 68, 65, 75, 70, 85, 65, 67)
rain <- c(55, 50, 55, 48, 65, 64, 60, 95, 20, 15)
wind <- c(10, 12, 8, 15, 7, 9, 16, 6, 8, 11)

weather_data <- data.frame(Stations=stations, Temperature=temp, Humidity=hum, Rainfall=rain, Wind=wind)

PCA <- prcomp(weather_data[,-1], scale=TRUE)
summary(PCA)

pc1_explains <- (1.511)^2 / 4 * 100
pc2_explains <- (0.9765)^2 / 4 * 100

PC1 <- PCA$x[,1]
PC2 <- PCA$x[,2]

cor(PC1, PC2)

R <-cor(weather_data[,-1])
eig <- eigen(R)
eig