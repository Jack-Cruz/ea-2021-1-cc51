data <- read.csv("C:/Users/PC/Desktop/GitHub/TA1_Administracion/data/hotel_bookings.csv",
                 header=TRUE, sep=",")

head(data)

names(data)

str(data)

summary(data)

is.na(data$hotel)


#funcion NA

funcion.NA <- function(x){
  sum = 0
  for(i in 1:ncol(x)){
    cntNA <- colSums(is.na(x[i]))
    if(cntNA> 0){
      cat("En la columna ", colnames(x[i]), " total de valore NA", cntNA, "\n")  
    }
  }
}

funcion.NA(data)


#funcion Vacios

function.Vacios <- function(x){
  for(i in 1:ncol(x)){
    cat("En la columna",colnames(x[i]),"total de valores en blanco:",colSums(x[i]==""),"\n")
  }
}

function.Vacios(data)


#outliers
boxplot(data$is_canceled)$out

function.Outliers <- function(x){
  for(i in 1:ncol(x)){
    outliers.values <- boxplot(x[i])$out
    cat("En la columna",colnames(x[i]),"total de valores outliers:", ,"\n")
  }
}

function.Outliers(data)



