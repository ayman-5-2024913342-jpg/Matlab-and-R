#================PART I==================================
setwd("D:/ayman/R")

my_data <- read.table("data.txt", header = FALSE, skip = 1, sep = "")
colnames(my_data) <- c("Month", "Humidity", "Wind_Speed_kmh", "Rainfall_mm")
print(my_data)

#================PART II==================================
my_data$Wind_ms <- my_data$Wind_Speed_kmh * (5/18)
print(my_data)

#================PART III=================================
my_data$rain_cat <- ifelse(my_data$Rainfall_mm <= 50, "low",
                           ifelse(my_data$Rainfall_mm <= 150, "medium", "heavy"))

my_data$rain_cat <- factor(my_data$rain_cat, 
                           levels = c("low", "medium", "heavy"), 
                           ordered = TRUE)
print(my_data)

#================PART IV=================================
plot(my_data$Wind_ms, type = "b", col = "blue", pch = 16,
     main = "Wind Speed", 
     xlab = "Index", ylab = "Speed (ms)")

rain_counts <- table(my_data$rain_cat)
barplot(rain_counts, col = c("lightblue", "dodgerblue", "darkblue"),
        main = "Count of Months per Rain Category",
        xlab = "Rain Category", ylab = "Number of Months")

#================PART V=================================
# Create a cross-table of Month vs Rain Category
rain_by_month <- table(my_data$Month, my_data$rain_cat)

# Print the table to the console
print(rain_by_month)
#================PART VI=================================
plot(my_data$rain_cat)


#=============================NEW STUFFS=============================================

par(mfrow = c(4, 1))


my_data$rain_cat1 <- ifelse(my_data$Rainfall_mm <= 50, 1,
                            ifelse(my_data$Rainfall_mm <= 150, 2, 3))
rain_counts <- table(my_data$rain_cat1)
barplot(rain_counts, col = c("lightblue", "dodgerblue", "darkblue"),
        main = "Count of Months per Rain Category",
        xlab = "Number of Months", ylab = "Rain Category", horiz = TRUE)

boxplot(my_data$Rainfall_mm, col = "red", main = "Box Plot of Rainfall", 
        horizontal = TRUE, xlab = "Rainfall (mm)")

plot(my_data$Humidity, my_data$Rainfall_mm, pch = NA, col = "blue",
     main = "Humidity vs Rainfall", xlab = "Humidity", ylab = "Rainfall (mm)")

text(my_data$Humidity, my_data$Rainfall_mm, labels = "pointer", col = "black", cex = 1)

cor(my_data$Rainfall_mm, my_data$Humidity)

model <- lm(my_data$Rainfall_mm ~ my_data$Humidity)
model

abline(model, col="red")
summary(model)