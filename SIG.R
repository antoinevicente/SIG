# Installer des packages
install.packages("arrow","dplyr", "ggplot2", "readr")

# Charger des packages
library(arrow)
library(dplyr)
library(ggplot2)
library(readr)

# Définir l'espace de travail
setwd("C:/Users/vicenant/Downloads")

# Importer les données un fichier .parquet
BPE24 <- arrow::read_parquet("./BPE24.parquet")

# Importer les données depuis un fichier .csv
#BPE24 <- read_delim("data/BPE24.csv", delim=";")

# Aperçu des données
names(BPE24)
head(BPE24, n=5)

# Supprimer des colonnes
bpe <- BPE24[, -c(18:67)]

# Supprimer un objet
rm(BPE24)

# Analyse globale du contenu
dim(bpe)
nrow(bpe)
ncol(bpe)

# Ouvrir le tableau
#view(bpe)

# Résumé des statistiques descriptives
summary(bpe)

# Comptage des équipements par commune et par type
equipements_com <- bpe %>%
  group_by(DEPCOM, TYPEQU) %>%
  summarise(nb = n(), .groups = "drop")

# Diversité des équipements par commune
diversite <- equipements_com %>%
  group_by(DEPCOM) %>%
  summarise(nb_types = n_distinct(TYPEQU))

# Compter les équipements par type 
equipements_type <- bpe %>%
  count(TYPEQU, sort = TRUE) %>%
  mutate(prop = round(n / sum(n) * 100, 1))

