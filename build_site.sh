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
INTRO_SRC="./scripts/resources/introduction.jsx"

CODE_SRC="$TARGET_DIR/src"

# Copier les fichiers
echo "Copie des fichiers..."

mkdir -p "$CODE_SRC/data"

# Copier le contenu de ./data dans code/src
cp -r "$DATA_SRC"/* "$CODE_SRC/data" || { echo "Erreur lors de la copie de $DATA_SRC"; exit 1; }

# Copier baniere.jpg dans code/src
cp "$BANIER_SRC" "$CODE_SRC/images" || { echo "Erreur lors de la copie de $BANIER_SRC"; exit 1; }

# Copier custom.css dans code/src/style
cp "$CSS_SRC" "$CODE_SRC/style" || { echo "Erreur lors de la copie de $CSS_SRC"; exit 1; }

cp "$INTRO_SRC" "$CODE_SRC/components" || { echo "Erreur lors de la copie de $INTRO_SRC"; exit 1; }

echo "Fichiers copiés avec succès."