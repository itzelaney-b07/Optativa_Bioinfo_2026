# Cargamos lo que usaremos en todo el tutorial
library(dplyr)
library(readr)
library(ggplot2)
library(tidyr)
#Vincular el dataset
url_tinto  <- "https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv"
url_blanco <- "https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-white.csv"

vino_tinto  <- read_delim(url_tinto,  delim = ";", show_col_types = FALSE)
vino_blanco <- read_delim(url_blanco, delim = ";", show_col_types = FALSE)

# Añadimos columna "tipo" para identificarlos al unirlos
vino_tinto  <- mutate(vino_tinto,  tipo = "tinto")
vino_blanco <- mutate(vino_blanco, tipo = "blanco")

# bind_rows() apila las dos tablas (como pegar una encima de la otra)
vinos <- bind_rows(vino_tinto, vino_blanco)

glimpse(vinos)

#leer el rawdata
salud <- read_csv("01_RawData/dataset_categorical_NA.csv", show_col_types = FALSE)

glimpse(salud)
#CONTROL SHIFT M MAYUSCULA
vinos %>% 
  filter(tipo == "tinto") %>% 
  filter(quality >= 7) %>% 
  select(tipo, quality, alcohol) %>% 
  arrange(desc(alcohol)) %>% 
  head(8)
# DPLYR: mismo resultado, más claro
filter(vinos, quality == 9)
# Quedarnos solo con vinos tintos
filter(vinos, tipo == "tinto")

filter(salud,BMI>30& BMI<80)%>% 
  filter(Weight>39)

filter(vinos,quality >= 9)


salud |>
  filter(Age>= 20)%>% 
  filter(BMI>=30)%>% 
  filter(BloodPressure>=14 | Cholesterol>=80)

#Cuando quieres filtrar por varios valores de la misma columna, %in% es tu amigo
# Vinos de calidad 8 o 9
filter(vinos, quality %in% c(8, 9)) |>
  select(tipo, quality, alcohol) |>
  head(8)

# Participantes de zona urbana o suburbana
filter(salud, ResidenceType %in% c("Urbano", "Suburbano")) |>
  count(ResidenceType)
#Rangos
# Vinos con pH entre 3.0 y 3.1 (incluyendo los extremos)
filter(vinos, between(quality, 5, 8)) |>
  select(tipo, pH, quality) |>
  head(6)

# Participantes sin dato de edad O menores de 30
filter(salud, is.na(SmokingStatus))%>% 
count()

#EJERCICIOS
filter(vinos=="blanco")%>%
  filter(quality <= 5)%>%
count()

vinos%>%
  filter(alcohol>mean(vinos$alcohol))
  
salud%>%
  filter(SmokingStatus=="Ex-fumadora",ResidenceType=="Urbano")%>%
  count()


salud |>
  filter(StressLevel > 80) |>
  count(SmokingStatus, sort = TRUE)
vinos <- bind_rows(vino_tinto, vino_blanco)
vinos%>%
  select(where(is.character))

vinos%>%
  select(contains("acid"))

salud%>%
  select(ID,Age,(contains("Circunference")),
         cintura=WaistCircumference)
salud%>%
  filter(ResidenceType=="Rural")%>%
select(ID,Age,BMI,SmokingStatus)

vinos%>%
  select(pH,quality,tipo) %>%
  arrange(desc(pH)) %>%
  head(10)

salud%>%
 select(Glucose)%>%
  arrange(desc(Glucose))%>%
select(id,age,SmokingStatus)
head(5)

vinos%>%
  filter(tipo == "blanco") |>
  select(tipo, quality, `volatile acidity`) |>
  arrange(desc(quality), `volatile acidity`) |>
  head(10)

salud |>
mutate(riesgo_cardio = (BloodPressure + Cholesterol) / 2) |>
select(ID, BloodPressure, Cholesterol, riesgo_cardio) |>
head(7)

# Guardamos el dataset de vinos con columnas nuevas
vinos <- vinos |>
  mutate(
    calidad_alta   = ifelse(quality >= 7, "Sí", "No"),
    alcohol_c      = alcohol - mean(alcohol, na.rm = TRUE),
    proporcion_so2 = `free sulfur dioxide` / `total sulfur dioxide`
  )

vinos |>
  select(tipo, quality, calidad_alta, alcohol, alcohol_c, proporcion_so2) |>
  head(5)
  
vinos <- vinos |>
  mutate(azucar_alta = ifelse(`residual sugar` > 10, "Sí", "No"))

vinos |>
  group_by(tipo, azucar_alta) |>
  summarise(n = n(), .groups = "drop")
#Le pregunté a gemini que hace drop

# Clasificamos la calidad de los vinos en tres niveles
vinos <- vinos |>
  mutate(
    categoria = case_when(
      quality <= 4 ~ "Baja",
      quality <= 6 ~ "Media",
      quality <= 8 ~ "Alta",
      TRUE         ~ "Excepcional"   # TRUE actúa como "else"
    )
  )

vinos |>
  count(tipo, categoria) |>
  arrange(tipo, categoria)

#EJERCICIOS
#1. Crea una nueva columna en vinos que se llame nivel_alcohol que clasifique así: - Menos de 10%: "Bajo" · Entre 10% y 12%: "Medio" · Más de 12%: "Alto"
#Pista: usa case_when()
vinos %>%
  mutate(
    alcohol_nivel= case_when(
      is.na(alcohol) ~ "Sin dato",
      alcohol < 10    ~ "Bajo",
     alcohol < 12   ~ "Medio",
      alcohol>12~ "Alto"
      )
    ) %>%  arrange(alcohol_nivel) %>% 
  select(tipo,alcohol_nivel)


      
    
# En salud, crea una columna grupo_edad que clasifique a los participantes en:
#Menos de 30: "Joven" · Entre 30–50: "Adulto" · Más de 50: "Mayor"
#Recuerda manejar los NA como primera condición.
 
salud <-read_csv("../01_RawData/dataset_categorical_NA.csv",show_col_types = FALSE) 
#Use gemini para este comando porque ya no me leia los datos

salud <- salud |>
  mutate(
    grupo_edad = case_when(
    is.na(Age)~ "No data", 
    Age < 30 ~ "Joven", 
    Age > 30, Age < 50 ~ "Adulto",
    Age > 50 ~ "Mayor",
        count(salud,grupo_edad, sort = TRUE))   
  )
#3. Crea una columna fumador_activo en salud que sea TRUE si el participante fuma actualmente (SmokingStatus == "Fuma"), FALSE en caso contrario
salud <- salud |>
  mutate(fumador_activo=ifelse(SmokingStatus== "Fuma","True","False"))
count(salud,SmokingStatus,fumador_activo)


# DPLYR: mismo resultado, más organizado y extendible
vinos |>
  summarise(
    n               = n(),
    media_alcohol   = round(mean(alcohol), 2),
    mediana_alcohol = median(alcohol),
    sd_alcohol      = round(sd(alcohol), 2),
    min_calidad     = min(quality),
    max_calidad     = max(quality)
  )
# DPLYR: más claro y fácilmente extendible a más estadísticos
vinos |>
  group_by(tipo) |>
  summarise(
    n             = n(),
    calidad_media = round(mean(quality), 2),
    alcohol_medio = round(mean(alcohol), 2),
    ph_medio      = round(mean(pH), 2),
    .groups       = "drop"    # importante: siempre añadir para limpiar los grupos
  )
# Indicadores clínicos por estatus de tabaquismo y tipo de residencia
salud |>
  filter(!is.na(SmokingStatus), !is.na(ResidenceType)) |>
  group_by(SmokingStatus, ResidenceType) |>
  summarise(
    n             = n(),
    media_imc     = round(mean(BMI, na.rm = TRUE), 1),
    media_colest  = round(mean(Cholesterol, na.rm = TRUE), 1),
    .groups       = "drop"
  ) |>
  arrange(SmokingStatus, ResidenceType)


#1. Calcula el promedio de alcohol, pH y calidad para cada combinación de tipo y categoria de vino
vinos <- vinos |>
  mutate(
    categoria = case_when(
      quality <= 4 ~ "Baja",
      quality <= 6 ~ "Media",
      quality <= 8 ~ "Alta",
      TRUE         ~ "Excepcional") %>%   
  summarise(
    n = n(),
    media_pH = round(mean(pH,na.rm = TRUE),1),
    media_calidad= round(mean(quality,na.rm = TRUE),1),
    media_alcohol= round(mean(alcohol,na.rm = TRUE),1),
    )) |>
  arrange(tipo)

#¿Qué estado civil del dataset salud tiene el nivel de estrés más alto en promedio? Muestra el top 3
salud %>% 
  filter(!is.na(MaritalStatus)) %>% 
  group_by(MaritalStatus) %>% 
  summarise(
  n = n(),
  media_StressLevel=(round(mean(StressLevel,na.rm = TRUE),1)),
  .groups              = "drop"
  ) |>
  arrange(desc(media_StressLevel))

#Calcula el promedio de glucosa y colesterol por estatus de tabaquismo en salud
salud %>% 
  filter(!is.na(SmokingStatus)) %>% 
  group_by(SmokingStatus) %>% 
  summarise(
    n = n(),
    media_Glucose=(round(mean(Glucose,na.rm = TRUE),1)),
    media_Cholesterol=(round(mean(Cholesterol,na.rm = TRUE),1)),
    .groups              = "drop"
  ) |>
  arrange(media_Glucose,media_Cholesterol)

#4. Desafío: ¿En qué combinación de EducationLevel y ResidenceType se observa
#el mayor BMI promedio en salud? Muestra el top 5.
salud %>% 
  salud |>
  filter(!is.na(EducationLevel), !is.na(ResidenceType)) |>
  group_by(EducationLevel, ResidenceType) |>
  summarise(
    n             = n(),
    media_imc     = round(mean(BMI, na.rm = TRUE), 1),
    .groups       = "drop"
  ) |>
  arrange(EducationLevel, ResidenceType)

# Tabla 1: registros individuales
detalle_individual <- salud |>
  select(ID, SmokingStatus, ResidenceType, Age, BMI, Cholesterol)

# Tabla 2: resumen de indicadores por tipo de residencia
resumen_zona <- salud |>
  group_by(ResidenceType) |>
  summarise(
    imc_promedio_zona        = round(mean(BMI, na.rm = TRUE), 1),
    colesterol_promedio_zona = round(mean(Cholesterol, na.rm = TRUE), 1),
    n_en_zona                = n(),
    .groups                  = "drop"
  )

resumen_zona

# Unimos: para cada participante, agregamos el contexto de su zona
detalle_con_contexto <- detalle_individual |>
  left_join(resumen_zona, by = "ResidenceType")

# Ahora podemos calcular cuánto se aleja cada participante del promedio de su zona
detalle_con_contexto |>
  mutate(diferencia_imc = round(BMI - imc_promedio_zona, 2)) |>
  filter(!is.na(diferencia_imc)) |>
  select(ID, ResidenceType, BMI, imc_promedio_zona, diferencia_imc) |>
  arrange(desc(diferencia_imc)) |>
  head(8)

# anti_join: ¿hay participantes sin zona de residencia registrada?
sin_zona <- salud |> filter(is.na(ResidenceType)) |> select(ID)
anti_join(salud |> select(ID, ResidenceType), resumen_zona, by = "ResidenceType") |> head(5)


#1. Construye una tabla resumen_educacion con el BMI promedio y nivel de estrés promedio por EducationLevel.
#Luego usa left_join() para agregarla al dataset salud. ¿Cuántas filas tiene el resultado?

#Tabla resumen_educación
resumen_educacion <- salud |>
  group_by(EducationLevel) %>% 
  summarise(
    n= n(),
    BMI_promedio = round(mean(BMI,na.rm = TRUE), 1),
    Stress_promedio = round(mean(StressLevel,na.rm = TRUE),1),
    .groups                  = "drop"
  )
resumen_educacion
  
full_join(salud,resumen_educacion)
#20 × 29

#2. ¿Existen niveles educativos en resumen_educacion que no aparezcan en salud? Usa anti_join() para verificarlo
anti_join(resumen_educacion,salud, by= "EducationLevel")
# tibble 0x4 ℹ 4 variables: EducationLevel <chr>, n <int>, BMI_promedio <dbl>, Stress_promedio <dbl>

#Usando left_join(), combina salud con resumen_zona y luego muestra el BMI promedio
#por ResidenceType, comparándolo con el imc_promedio_zona calculado en el resumen

left_join(resumen_zona,salud, by= "ResidenceType")
group_by(ResidenceType) %>% 
 summarise(
   media_BMIound = round(mean(BMI,na.rm = TRUE),1),
   imc_zona       = first(imc_promedio_zona),
   .groups        = "drop"
 )
            
#Ejercicio Integrador Final
  
#A) ¿Cuál es el promedio de calidad de los vinos blancos de categoría “Alta” 
#o “Excepcional”, agrupado por nivel de alcohol (nivel_alcohol)?            
            
vinos %>%
    filter(tipo=="blanco",categoria %in% c("Alta", "Excepcional")) %>% 
    mutate (
      nivel_alcohol = case_when(
        alcohol < 10  ~ "Bajo",
        alcohol <= 12 ~ "Medio",
        TRUE          ~ "Alto"
      )
    )
  
    group_by(nivel_alcohol) %>% 
      summarise(
        n = n(),
        calidad_media = round(mean(quality), 2),
        .groups       = "drop"
      ) |>
      arrange(desc(calidad_media))
      
    #  En el dataset salud, ¿qué 5 participantes tienen la mayor diferencia 
    #entre su BMI y el BMI promedio de su grupo educativo? Muestra su ID, nivel
    #educativo, BMI individual y la diferencia.
      
    salud %>% 
      filter(!is.na(EducationLevel), !is.na(BMI)) %>% 
      group_by(EducationLevel) %>% 
      mutate(
        BMI_mean  = round(mean(BMI, na.rm = TRUE), 1),
        diferencia_BMI = round(abs(BMI - BMI_mean), 1),
      ) |>
      ungroup() |>
      slice_max(diferencia_BMI, n=5) %>% 
      select(ID, EducationLevel, BMI, BMI_mean)       
          
            
            
            
            
            
            
            
            
            
            
            
            
            
          
