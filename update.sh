#!/bin/bash

# Define the source and destination directories

LIST="beherachittaranjan488@gmail.com"  # Recipient email address
DIFF="change.txt"  # File to store git diff output

# Ensure we are on the main branch and tracking remote
git checkout main
git pull origin main

# Change to the destination directory
cd $DEST_DIR

# Capture the changes in change.txt
git diff > "$DIFF"

# Check for changes
if git status | grep -q "working tree clean"; then
  echo "No changes detected - exiting"
  echo "Success3"
else
  git status
  echo "Changes detected, committing"
  
  # Add changes, commit, and push
  git add .
  git commit -m "Update: $(date '+%Y-%m-%d %H:%M:%S')"
  git push origin main
  
  echo "Success4"
  
  # Send an email with the change.txt file as an attachment
  SUBJECT="Git Changes for $(date '+%Y-%m-%d')"
  TO=$LIST  # Email recipient

  # Send the email with the change.txt file attached using sendmail
  echo "Subject: $SUBJECT" > email.txt
  echo "The changes from git diff are attached in the file $DIFF." >> email.txt
  sendmail -v "$TO" < email.txt
  rm email.txt
  
  echo "Email sent with changes attached."
fi
