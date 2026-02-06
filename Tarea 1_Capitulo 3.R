x<-3
print(x)
vector_numerico <- c(1, 3, 5, 7)      # vector numérico
vector_texto <- c("a", "b", "c", "d") # vector de texto
vector_logico <- c(TRUE, FALSE, TRUE) # vector lógico / booleano
x <- c(1:100)

x
x <- seq(1,100)

x
x <- seq(from=-12,to=30,by=3)

x
y <- seq(0,1,0.1)

y
z <- seq(by=0.1, to =1, from=0.5)

z
s <- (1:5)

length(s)
#Se define el vector con la variable "x"
x <- c("Muchos", "años" ,"después" ,",", "frente", "al" ,"pelotón")

#Elegir desde el primer hasta el cuarto elemento del objeto "x"
x[1:4]
x <- c(1,2,3,5,8,13,21)

x[3:6]
#Se define el vector "x"
x <- c("Hola", "Bien", "cómo", "!", "estás", ":(", "?")

#Se indica dentro de un nuevo vector que se seleccionen las posiciones 1, 3, 5 y 7 del vector "x". 
x[c(1,3,5,7)]
x<-c(1,2,3,5,8,13,21)

x[c(2, 7, 4)]
#Se define el vector "x"
x <- c(1,2,3,5,8,13,21)

#Dentro del corchete indicamos la posición que se quiere omitir 
x[-4]
x <- c(1,2,3,5,8,13,21)
x[-6] 
x <- c(1,2,3,5,8,13,21)
x[-6] 
x<-c()
x                 # Soy un vector vacío :(
x[1]<- 2
x[2:5]<-c(56,78,90,12)
x                 # Ahora ya no :)

#EJERCICIOS
#1
x <- (-10:10)
any(x=0)
#2
x <- (40:50)
any(x > 30)
#3
x <- (1,1,1,1,1,1)
all(x=x)
#4
x <- (30,40,60,80)
y<-(60,70,80)
all(vector_numerico=60)
#5
x <- (30)
y<-(60)
all(x,y < 10)
#6
x <- (1:10)
all(x<0)
#7
x <- c(30,40,60,80)
y<-c(6,7,8)
any(x<y)
#8
x<- ("8,16,27")
all.equal(x,8)
#9
x <- c(30,40,60,80)
y<-c(6,7,8)
any(x>y)
#EJERCICIO: Calcula el promedio de los números del 1 al 10
#Se define el vector que incluye mil datos
x<-rnorm(1:10)

mean(x) 
#EJERCICIO: FUNCION DE SD Y QUANTILE
x<-rnorm(1:10)

sd(x)

x<-rnorm(1:10)

quantile(x)


x<- rnorm(10000)

hist(x,col="tomato2") #Histograma: grafica la distribución de las frecuencias de los datos 

edades <- c(35,35,70,17,14) #Definimos un vector llamado "edades"
nombres <- c("Jerry","Beth","Rick", "Summer","Morty") #Definimos un vector llamado "edades", del mismo tamaño que "edades"

names(edades) <- nombres #Se nombran los elementos del vector "edades"
edades

#EJERCICIO
mean(edades-35)
edades <- c(35,70,17,14) #Definimos un vector llamado "edades"
nombres <- c("Jerry","Beth", "Summer","Morty") #Definimos un vector llamado "edades", del mismo tamaño que "edades"
Granpa<- c("Rick")

x<- c(35,70,17,14)
any(x> 75,x < 12,x >= 12 & x <= 20 )
