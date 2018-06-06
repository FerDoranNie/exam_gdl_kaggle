library(data.table)

library(magrittr)

library(rjson)




# Cargando datos ----------------------------------------------------------
setwd("~/Documentos/personales/examen_gdl/")

## Archivo Json
japonLocalidades <- fromJSON(file="challenge_ds/translations.json")


## CSV's
localidades <- read.csv("challenge_ds/prefecture_locations.csv", header = TRUE)

lista_usuarios <- read.csv("challenge_ds/user_list.csv",
                           header = TRUE)

cupon_area <- read.csv("challenge_ds/coupon_area_train.csv", header = TRUE)


cupon_detalle <- fread("challenge_ds/coupon_detail_train.csv",
                          header = TRUE)

cupon_lista <- read.csv("challenge_ds/coupon_list_train.csv",
                       header = TRUE)

cupon_visita <- fread("challenge_ds/coupon_visit_train.csv", 
                    header = TRUE)



# Manipulacion ------------------------------------------------------------
japones <- as.character(names(japonLocalidades))
ingles  <- as.character(unname(japonLocalidades))
japonLocalidades <- data.frame(localidad.japones = japones,
                               localidad.ingles=ingles)


localidades <- merge(localidades, japonLocalidades, 
                     by.x="PREF_NAME", by.y="localidad.japones") %>% 
  data.table

lista_usuarios <- merge(lista_usuarios, japonLocalidades, 
                     by.x="PREF_NAME", by.y="localidad.japones", 
      all.x = TRUE) %>% 
  data.table %>% 
  .[, localidad.ingles := ifelse(is.na(localidad.ingles), "prefect_unknow",
                                 localidad.ingles)]

cupon_area <- merge(cupon_area, japonLocalidades, 
                     by.x="PREF_NAME", by.y="localidad.japones", 
      all.x = TRUE) %>% 
  data.table %>% 
  .[, localidad.ingles := ifelse(is.na(localidad.ingles), "prefect_unknow",
                                 localidad.ingles)]



cupon_area %>%  head
cupon_lista %>%  head
cupon_detalle %>%  head
cupon_visita %>%  head


cupon_lista$GENRE_NAME %>%  unique %>%  length

cupon_detalle$SMALL_AREA_NAME %in% localidades$PREF_NAME
cupon_lista$small_area_name %in% localidades$PREF_NAME





# Exploratorios -----------------------------------------------------------





# Modelos -----------------------------------------------------------------















