#!/bin/bash

# Define the source and destination directories
SOURCE_DIR="/mnt/cdimage"
DEST_DIR="."

git checkout -t origin/main


time rsync -avz --delete --exclude='.svn/' $SOURCE_DIR/D11/     $DEST_DIR//D12/  
time rsync -avz --delete --exclude='.svn/' $SOURCE_DIR/D12/     $DEST_DIR//D13/  

# Change to the destination directory
cd $DEST_DIR
git diff >> change.txt
# Check for changes and commit them
if $(git status | grep -s -q "working tree clean");then 
  echo No changes detected - exiting
  echo "Success3"
  
else 
  git status 
  git diff >> change.txt
  echo Changes detected committing
  git add .
  git commit -m "Update: $(date '+%Y-%m-%d %H:%M:%S')"
  git push origin main
  echo "Success4"
fi
