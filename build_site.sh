#!/bin/bash

# Définir le repository à cloner et le dossier cible
REPO_URL="https://github.com/CERES-Sorbonne/SiteGenerator.git"
TARGET_DIR="code"

# Cloner le repository
echo "Clonage du repository..."
git clone "$REPO_URL" "$TARGET_DIR" || { echo "Erreur lors du clonage du repository"; exit 1; }

# Chemins des sources
DATA_SRC="./data"
RESSOURCES="./scripts/resources"

# Créer les dossiers nécessaires
mkdir -p "$TARGET_DIR/src/data"

# Copier les fichiers depuis "to_replace"
TO_REPLACE_FILE="./to_replace"

if [[ -f "$TO_REPLACE_FILE" ]]; then
  echo "Lecture du fichier to_replace et copie des fichiers..."
  
  while IFS=" " read -r SRC DEST_PATH; do
    # Ignorer les lignes vides ou mal formatées
    if [[ -z "$SRC" || -z "$DEST_PATH" ]]; then
      echo "Ligne vide ou mal formatée dans to_replace : '$SRC $DEST_PATH'"
      continue
    fi

    SRC_PATH="$RESSOURCES/$SRC"
    
    # Créer le dossier de destination s'il n'existe pas
    mkdir -p "$(dirname "$DEST_PATH")"
    
    # Copier le fichier
    if [[ -f "$SRC_PATH" ]]; then
      cp "$SRC_PATH" "$DEST_PATH" || { echo "Erreur lors de la copie de $SRC_PATH"; exit 1; }
      echo "Copié $SRC_PATH vers $DEST_PATH"
    else
      echo "Fichier source $SRC_PATH introuvable, copie ignorée."
    fi
  done < "$TO_REPLACE_FILE"
else
  echo "Fichier to_replace introuvable. Veuillez vérifier son emplacement."
  exit 1
fi

# Copier le contenu de ./data dans code/src/data
echo "Copie du contenu de $DATA_SRC vers $TARGET_DIR/src/data..."
cp -r "$DATA_SRC"/* "$TARGET_DIR/src/data" || { echo "Erreur lors de la copie de $DATA_SRC"; exit 1; }

echo "Fichiers copiés avec succès."
