station_id <- c(1,2,3,4,5)
station_id
station_id <- 1:5

station_name <- c("A", "B", "C", "D", "E")
station_name

temp <- c(25,27,28,26,30)
rain_fall <- c(100, 120, 110, 90, 80)

data = data.frame(Station_ID=station_id, Station_name=station_name, Temperature=temp, rain=rain_fall)

data$station_id_scale <- rep("Nominal",5)

data

data$sum_temp_rain = data$Temperature + data$rain

data

mean(data$Temperature)
summary(data$sum_temp_rain)
summary(data$Temperature)

#this is a comment