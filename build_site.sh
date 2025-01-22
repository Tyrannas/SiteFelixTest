#!/bin/bash

# Définir le repository à cloner et le dossier cible
REPO_URL="https://github.com/CERES-Sorbonne/SiteGenerator.git"
TARGET_DIR="code"

# Cloner le repository
echo "Clonage du repository..."
git clone "$REPO_URL" "$TARGET_DIR" || { echo "Erreur lors du clonage du repository"; exit 1; }

# Chemins des sources et destinations
DATA_SRC="./data"
BANIER_SRC="./scripts/resources/baniere.jpg"
CSS_SRC="./scripts/resources/custom.css"

CODE_SRC="$TARGET_DIR/src"
STYLE_DIR="$CODE_SRC/style"

# Copier les fichiers
echo "Copie des fichiers..."

# Copier le contenu de ./data dans code/src
cp -r "$DATA_SRC"/* "$CODE_SRC/" || { echo "Erreur lors de la copie de $DATA_SRC"; exit 1; }

# Copier baniere.jpg dans code/src
cp "$BANIER_SRC" "$CODE_SRC/" || { echo "Erreur lors de la copie de $BANIER_SRC"; exit 1; }

# Copier custom.css dans code/src/style
cp "$CSS_SRC" "$STYLE_DIR/" || { echo "Erreur lors de la copie de $CSS_SRC"; exit 1; }

echo "Fichiers copiés avec succès."
