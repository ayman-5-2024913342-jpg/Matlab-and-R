Day <- 1:10
Temp <- c(30, 32, 29, 33, 28, 31, 34, 27, 30, 32)
Hum <- c(80, 78, 85, 75, 88, 82, 72, 90, 84, 79)
Rain <- c(12, 8, 20, 5, 25, 15, 3, 30, 18, 10)
Wind <- c(10, 12, 8, 15, 7, 9, 16, 6, 8, 11)  

data=data.frame(Temperature=Temp,Humidity=Hum,Rainfall=Rain,Wind=Wind)

cor(data)

PCA <- prcomp(data,scale=TRUE)
biplot(PCA)

PC1 = 0.49*Temp - 0.5*Hum + -0.5*Rain + 0.49*Wind
PC2 = -0.41*Temp - 0.040*Hum  -0.42*Rain + 0.80*Wind

cor(PC1, PC2)

#From this analysis we can see that pc1 can explain 90% of the total dataset
#and pc2 can explain 10%, they both can explain 90% of the total dataset

########FACTOR ANAL


#########CORRELATION TESTING
# Install the package if it's not already installed on your machine
##install.packages("psych")

# Load the library
library(psych)

# Now run Bartlett's test again
cortest.bartlett(cor(data), n = nrow(data))

##Finding number of factor 
R <- cor(data)
eig <- eigen(R)
eig