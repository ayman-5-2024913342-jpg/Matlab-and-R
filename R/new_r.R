#PART I
month = month.name[1:12]
wind_ms = c(12, 15, 20, 18, 25, 30, 28, 22, 19, 14, 10, 8)
rainfall = c(30, 45, 80, 120, 180, 220, 200, 160, 90, 40, 20, 10)
humidity = c(55, 58, 65, 70, 82, 88, 85, 80, 75, 68, 60, 52)

data_monthly = data.frame(Month = month, Wind = wind_ms, Rainfall = rainfall, Humidity = humidity)
print(data_monthly)

#PART II
data_monthly$Wind = data_monthly$Wind * (1000/3600)
print(data_monthly)

#PART III
data_monthly$rain_cat = c("Low", "Medium", "Heavy")
data_monthly$rain_cat = ifelse(data_monthly$Rainfall < 50, "Low", ifelse(data_monthly$Rainfall < 150, "Medium", "Heavy"))
print(data_monthly)