#!/bin/bash

# Define the source and destination directories
SOURCE_DIR="/mnt/cdimage"
DEST_DIR="."
LIST= "beherachittaranjan488@gmail.com"

# Ensure we are on the main branch and tracking remote
git checkout main
git pull origin main

# Synchronize directories with rsync
time rsync -avz --delete --exclude='.svn/' $SOURCE_DIR/D11/ $DEST_DIR/D12/
time rsync -avz --delete --exclude='.svn/' $SOURCE_DIR/D12/ $DEST_DIR/D13/

# Change to the destination directory
cd $DEST_DIR

# Check for changes
if git status | grep -q "working tree clean"; then
  echo "No changes detected - exiting"
  echo "Success3"
else
  git status
  git diff >> change.txt
  echo "Changes detected, committing"
  
  # Add changes, commit, and push
  git add .
  git commit -m "Update: $(date '+%Y-%m-%d %H:%M:%S')"
  git push origin main
  
  echo "Success4"
  
  # Send an email with the change.txt file as an attachment
  SUBJECT="Git Changes for $(date '+%Y-%m-%d')"
  TO= $LIST
  FROM= $LIST

  # Use mail command to send the email with the change.txt file attached
  echo "The changes from git diff are attached in the file change.txt." | mail -s "$SUBJECT" -a change.txt "$TO"
  
  echo "Email sent with changes attached."
fi
