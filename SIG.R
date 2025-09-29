# Exporter une sortie
#ggsave("./export/*NOM*.png", plot = z, width = 10, height = 8)

# Installer des packages
install.packages("arrow","dplyr", "ggplot2", "readr")
install.packages("sf")

# Charger des packages
library(arrow)
library(dplyr)
library(ggplot2)
library(readr)
library(sf)

# Définir le répertoire de travail
setwd("C:/Users/antoi/Desktop/SIG")

# Importer les données depuis un fichier .parquet
BPE24 <- arrow::read_parquet("./BPE24.parquet")

# Importer les données depuis un fichier .csv
#BPE24 <- read_delim("data/BPE24.csv", delim=";")

# Aperçu des données
head(BPE24, n = 5)

# Afficher les noms de colonnes avec leur position
data.frame(Position = 1:ncol(BPE24), Nom = colnames(BPE24))

# Supprimer les départements d'outre-mer
bpe <- BPE24[!BPE24$DEP %in% c("971", "972", "973", "974", "976"), ]

# Supprimer un objet
#rm(BPE24)

# Ouvrir le tableau
#View(bpe)

# Analyse globale du contenu
dim(bpe)

# Nombre total de lignes
total_lignes <- nrow(bpe)

# Résumé des statistiques descriptives
summary(bpe)

# Nombre de NA par colonne
colSums(is.na(bpe))

# Compter combien de lignes sans coordonnées
cat(
  "Nombre de lignes supprimées sans coordonnées :",
  nb_na <- bpe %>% filter(is.na(LONGITUDE) | is.na(LATITUDE)) %>% nrow(),
  "\n")

# Supprimer les lignes sans coordonnées
bpe <- bpe %>%
  filter(!is.na(LONGITUDE) & !is.na(LATITUDE))

# Transformer en objet spatial
bpe_sf <- st_as_sf(bpe, coords = c("LONGITUDE", "LATITUDE"), crs = 4326)

# Lignes supprimées
cat("Pourcentage de lignes supprimées :", round(nb_na / total_lignes * 100, 2), "%\n")

# Supprimer des colonnes par position
bpe[, -c(18:67)]

# --------------------------------

# Compter des équipements par commune et par type
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


