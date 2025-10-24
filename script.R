# Supprimer un objet de l'environnement
#rm()

# Exporter une représentation graphique
#ggsave("./export/*NOM*.png", plot = z, width = 10, height = 8)

# Expoter au format CSV
#write.csv(data, "./bpe_culture_rouen.csv", row.names = FALSE)

# Installer les packages
#install.packages("arrow","dplyr", "ggplot2", "readr")
#install.packages("sf")

# Charger les packages
library(arrow)
library(dplyr)
library(ggplot2)
library(readr)
library(sf)

# Définir le répertoire de travail
setwd("C:/Users/antoi/Desktop/SIGplusplus")

# Importer les données depuis un fichier au format Parquet
#BPE24 <- arrow::read_parquet("./BPE24.parquet")

# Afficher les noms de colonnes avec leur position
#data.frame(Position = 1:ncol(BPE24), Nom = colnames(BPE24))

# Charger le fichier CSV contenant le codes des communes de la métropole de Rouen
#CODCOM <- read.csv("./comMetroRouen.csv", header = FALSE, sep = ";", stringsAsFactors = FALSE)

# Transformer le fichier CSV en valeurs 
#CODCOM <- as.vector(as.matrix(CODCOM))

# Vérifier
#head(CODCOM, n = 3)

# Filtrer les équipements de la métropole de Rouen
#equip_rouen <- filter(BPE24, CODPOS %in% CODCOM)

# Afficher le nombre de lignes avec au moins une coordonnée manquante
#sum(is.na(equip_rouen$LONGITUDE) | is.na(equip_rouen$LATITUDE))

# Supprimer les entités sans coordonnées
#equip_rouen_clean <- equip_rouen %>% filter(!is.na(LONGITUDE) & !is.na(LATITUDE))

# Transformer en objet spatial
#equip_rouen_sf <- st_as_sf(equip_rouen_clean,coords = c("LONGITUDE", "LATITUDE"), crs = 4326)

# Filtrer tout les équipements culturels 
#equip_culture <- equip_rouen[equip_rouen$DOM == "F", ]

# Exporter au format l'objet au fromat au format CSV
#write.table(equip_culture, "./export/equip_culture_metro.csv", sep = ";", row.names = FALSE, dec = ".")

# Importer le CSV des équipements cultures 
data <- read.csv("./export/equip_culture_metro.csv", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# Aperçu des données
glimpse(data[, 1:5])

# Filtrer les équipements culturels
#data <- data[!grepl("^F1", data$TYPEQU), ]

