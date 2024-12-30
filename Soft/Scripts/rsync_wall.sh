#!/bin/bash

# Variables
theme=$1
REPO_URL="gluon:/home/suman/Dibyendu/config/ARCH_Backup/bspwm/rices/$theme/walls/*"
LOCAL_DIR="/home/dm/Pictures/BSPWalls/"
PREFIX=$theme


# Retrieve files using rsync and store the list of retrieved files
RETRIEVED_FILES=$(rsync --list-only $REPO_URL | grep -v "drw" | awk '{print $5}')
rsync -avz --progress $REPO_URL $LOCAL_DIR 
# Append prefix to the filenames of the retrieved files
for file in $RETRIEVED_FILES; do
    if [ -f "${LOCAL_DIR}${file}" ]; then
        mv "${LOCAL_DIR}${file}" "${LOCAL_DIR}${PREFIX}$(basename "$file")"
    fi
done

echo "Files retrieved and prefixed successfully."
