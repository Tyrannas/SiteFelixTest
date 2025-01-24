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
CODE_SRC="$TARGET_DIR/src"

# Créer les dossiers nécessaires
mkdir -p "$CODE_SRC/data"

# Copier les fichiers depuis "to_replace"
TO_REPLACE_FILE="./scripts/resources/to_replace"

if [[ -f "$TO_REPLACE_FILE" ]]; then
  echo "Lecture du fichier to_replace et copie des fichiers..."
  
  while IFS=" " read -r SRC RELATIVE_DEST; do
    if [[ -n "$SRC" && -n "$RELATIVE_DEST" ]]; then
      SRC_PATH="$RESSOURCES/$SRC"
      DEST_PATH="$TARGET_DIR$RELATIVE_DEST"
      
      if [[ "$RELATIVE_DEST" == "/" ]]; then
        DEST_PATH="$TARGET_DIR" # Place le fichier dans TARGET_DIR
      else
        DEST_PATH="$TARGET_DIR$RELATIVE_DEST"
      fi

      # Copier le fichier
      if [[ -f "$SRC_PATH" ]]; then
        cp "$SRC_PATH" "$DEST_PATH" || { echo "Erreur lors de la copie de $SRC_PATH"; exit 1; }
        echo "Copié $SRC_PATH vers $DEST_PATH"
      else
        echo "Fichier source $SRC_PATH introuvable, copie ignorée."
      fi
    fi
  done < "$TO_REPLACE_FILE"
else
  echo "Fichier to_replace introuvable. Veuillez vérifier son emplacement."
  exit 1
fi

# Copier le contenu de ./data dans code/src
echo "Copie du contenu de $DATA_SRC vers $CODE_SRC/data..."
cp -r "$DATA_SRC"/* "$CODE_SRC/data" || { echo "Erreur lors de la copie de $DATA_SRC"; exit 1; }

cat $TARGET_DIR/siteConfig.json

echo "Fichiers copiés avec succès."
