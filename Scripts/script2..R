data <- read.csv("C:/Users/PC/Desktop/GitHub/TA1_Administracion/data/hotel_bookings.csv",
                 header=TRUE, sep=",")



#tabla 1: clientes en cada hotel por año

ClientesPorHotel=table(data$hotel,data$arrival_date_year)

barplot(ClientesPorHotel,
        main="Cantidad de clientes hospedados en cada hotel por año",
        col=c("red","blue"),legend=c("City hotel","Resort hotel"),
        xlab = ("año"),ylab = ("Número de clientes"),args.legend = list(x = "topright",inset = c(- 0.05, -0.25)))

# El hotel de tipo ciudad es el más concurrido que el de tipo resort
# durante los 3 años





#tabla 2: numero de cancelaciones por año
canceladosPorAnio=table(data$is_canceled,data$arrival_date_year)

#1: cancelado 0: no cancelado
barplot(canceladosPorAnio,
        main="Cantidad de reservas canceladas y no canceladas por año",
        col=c("red","blue"),legend=c("no cancelado","cancelado"),
        xlab = ("Año"),ylab = ("Número de reservas"),args.legend = list(x = "topright",inset = c(- 0.05, -0.25)))

#cancelados
sum(data$is_canceled)

#no cancelados
sum(data$is_canceled == 0)

summary(factor(data$is_canceled))

#En el año 2016 fue el año con más turistas, pero a la vez fue el año con más cancellados
# ademàs, si el numero de reservas crece las cancelaciones tambien crece






#Tabla 3: Distribución de clientes que vienen solo entre adultos y con menores de edad por hotel

menores <- data$babies + data$children > 0
summary(menores)

menoresDeEdad = table(menores, data$hotel)

barplot(menoresDeEdad,
        main="Distribución de clientes que vienen solo adultos y con menores de edad por hotel",
        col=c("red","blue"),legend=c("Solo adultos", "Con menores de edad"),
        xlab = ("Tipo de hotel"),ylab = ("Número de reservas"),args.legend = list(x = "topright",inset = c(- 0.05, -0.25)))


pais.origen <- table(data$country)
(pais.origen)