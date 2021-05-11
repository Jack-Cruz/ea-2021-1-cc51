data = read.csv('../data/hotel_bookings_miss.csv', sep=";")

#install.packages("openxlsx")
#library(openxlsx)
#data = read.xlsx('../data/hotel_bookings_miss.xlsx')

head(data)
names(data)
str(data)
names(data)
summary(data)
View(data)

print(paste("TOTAL DE NA's ", sum(is.na(data)), sep=" = "))

#NA
funcion.NA <- function(x){
  sum = 0
  for(i in 1:ncol(x)){
    cntNA <- colSums(is.na(x[i]))
    if(cntNA> 0){
      cat("Hay", cntNA, "\tvalores NA en la columna ", colnames(x[i]), "\n")
    }
  }
}

funcion.NA(data)

#ENCONTRAR OUTLIERS EN ...
n <- names(data)

for (i in n[c(3, 8:12, 17:19, 22, 26, 30)]) {
  boxplot(data[i], main=i)
  print(i)
}

#Outliers
fix_outliers <- function(x, removeNA = TRUE){
  quantiles <- quantile(x, c(0.05, 0.95), na.rm = removeNA)
  x[x < quantiles[1]] <- mean(x, na.rm = removeNA)
  x[x > quantiles[2]] <- median(x, na.rm = removeNA)
  x
}

sinOutliersLeadTime<-fix_outliers(data$lead_time)
sinOutliersWeekNights<-fix_outliers(data$stays_in_week_nights)
sinOuliersWeekendNights<-fix_outliers(data$stays_in_weekend_nights)
par(mfrow=c(1,2))
boxplot(data$lead_time,main="Lead time con outliers")
boxplot(sinOutliersLeadTime,main="Lead time sin outliers")
boxplot(data$stays_in_week_nights,main="week nights con outliers")
boxplot(sinOutliersWeekNights,main="week nights sin outliers")
boxplot(data$stays_in_weekend_nights,main="weekend nights con outliers")
boxplot(sinOuliersWeekendNights,main="weekend nights con outliers")


comparar.outliers = function(x_col) {
  sinOutliers<-fix_outliers(x_col)
  par(mfrow=c(1,2))
  boxplot(x_col,main="Con outliers")
  boxplot(sinOutliers,main="Sin outliers")
}

#limpiar el data set
data$lead_time <-fix_outliers(data$lead_time)
data$stays_in_week_nights<-fix_outliers(data$stays_in_week_nights)
data$stays_in_weekend_nights<-fix_outliers(data$stays_in_weekend_nights)
data$adults<-fix_outliers(data$adults)
data$children<-fix_outliers(data$children)
data$babies<-fix_outliers(data$babies)
data$is_repeated_guest<-fix_outliers(data$is_repeated_guest)
data$previous_cancellations<-fix_outliers(data$previous_cancellations)
data$previous_bookings_not_canceled<-fix_outliers(data$previous_bookings_not_canceled)
data$booking_changes<-fix_outliers(data$booking_changes)
data$days_in_waiting_list<-fix_outliers(data$days_in_waiting_list)
data$total_of_special_requests<-fix_outliers(data$total_of_special_requests)

#media
media.valor <- function (x){
  x <- ifelse(is.na(x), mean(x, na.rm = TRUE), x)
  x
}
# random
rand.valor <- function(x){
  faltantes <- is.na(x)
  tot.faltantes <- sum(faltantes)
  x.obs <- x[!faltantes]
  valorado <- x
  valorado[faltantes] <- sample(x.obs, tot.faltantes, replace = TRUE)
  return (valorado)
}

data$lead_time <- media.valor(data[ ,3])
data$arrival_date_year <- media.valor(data[,4])
data$arrival_date_week_number <- media.valor(data[ ,6])
data$arrival_date_day_of_month <- media.valor(data[ ,7])
data$stays_in_weekend_nights <- media.valor(data[, 8])
data$stays_in_week_nights <- media.valor(data[, 9])
data$adults <- media.valor(data[ ,10])
data$children <- media.valor(data[ ,11])
data$babies <- media.valor(data[ ,12])
data$days_in_waiting_list <- media.valor(data[,26])

# exportar .csv
write.csv(data,'../data/hotel_bookings_cleaned.csv', na="NA",row.names=TRUE)


