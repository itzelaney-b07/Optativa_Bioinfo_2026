# Matrices de ejemplo
matriz1 <- matrix(1:6, nrow = 2)
matriz2 <- matrix(7:12, nrow = 2)

# Unir matrices por renglones
matriz_unida <- rbind(matriz1, matriz2)
matriz_unida
View(matriz_unida)
#Unir matrices por columnas
# Unir matrices por columnas
matriz_unida_columnas <- cbind(matriz1, matriz2)
matriz_unida_columnas




#EJERCICIOS 19/02
MatrizA <- matrix(c(1,2,3,4,6,7,6,7,5), nrow=3, ncol=3) 
MatrizB <- matrix(c(2,4,6,8,2,4,6,7,8), nrow=3, ncol=3)
MatrizA + MatrizB

MatrizC <- matrix(c(1,2,3,4,6,7), nrow=2, ncol=3) 
MatrizD <- matrix(c(2,4,6,7,8,9), nrow=3, ncol=4)
MatrizC %*% MatrizD

MatrizE <- matrix(c(2,4,6,7,8,9,5,8), nrow=4, ncol=4)
det(MatrizE)

MatrizE <- matrix(sample(1:45,25), nrow=5, ncol=5)
MatrizF <- matrix(sample(1:45,25), nrow=5, ncol=5)
MatrizF[3,]
MatrizF[,2]
Expresion_genica <- matrix(sample(1:30,24), nrow=6, ncol=4)
rownames<-c("gen1","gen2","gen3","gen4","gen5","gen6")
colnames<-c("con1","cond2","con3","cond4")
apply(Expresion_genica,1,mean)

#Data Frames
# Cepa, Medio, TasaCrecimiento, Temperatura
#Llena el data.frame con datos aleatorios para 10 cepas en 3 medios diferentes y 4 temperaturas distintas.

resistencia <- data.frame(
  cepa = c("Cepa1:Cepa5"),
  antibiotico = c("ant1","ant2","ant2","ant4","ant5"),
  resistencia = sample(0:1,5, replace = TRUE))
(resistencia)

cultivo<-data.frame(cepa=paste("cepa",1:10),
                    medio=sample(paste("medio",1:3),10,replace = TRUE),
                    tasa_crecimiento=runif(10,0.1,1.0),
                    temperatura=sample(20:40,10,replace = TRUE)
)