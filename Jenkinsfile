#!/bin/bash

# Define variables
SOURCE_DIR="/mnt/cdimage"
DEST_DIR="."
EMAIL="recipient@example.com" # Replace with recipient email
SUBJECT="Git Diff Report: $(date '+%Y-%m-%d %H:%M:%S')"
CHANGE_FILE="change.txt"

# Step 1: Setup Git and switch to the correct branch
setup_git() {
  echo "Step 1: Setting up Git..."
  pushd . || exit
  git checkout -t origin/main || exit
  echo "Git setup complete."
}

# Step 2: Sync directories
sync_directories() {
  echo "Step 2: Syncing directories..."
  time rsync -avz --delete --exclude='.svn/' "$SOURCE_DIR/D11/" "$DEST_DIR/D11/"
  time rsync -avz --delete --exclude='.svn/' "$SOURCE_DIR/D11/" "$DEST_DIR/D12/"
  time rsync -avz --delete --exclude='.svn/' "$SOURCE_DIR/D12/" "$DEST_DIR/D13/"
  echo "Directory sync complete."
}

# Step 3: Save git status and diff to a file
save_changes_to_file() {
  echo "Step 3: Saving git status and diff to $CHANGE_FILE..."
  cd "$DEST_DIR" || exit
  git status > "$CHANGE_FILE"
  git diff >> "$CHANGE_FILE"
  echo "Git status and diff saved."
}

# Step 4: Commit changes if any
commit_changes() {
  echo "Step 4: Checking for changes..."
  if git status | grep -q "working tree clean"; then
    echo "No changes detected. Skipping commit."
  else
    echo "Changes detected. Committing changes..."
    git add .
    git commit -m "Update: $(date '+%Y-%m-%d %H:%M:%S')"
    git push origin main
    echo "Changes committed and pushed."
  fi
}

# Step 5: Send email with the change.txt file
send_email() {
  echo "Step 5: Sending $CHANGE_FILE via email to $EMAIL..."
  mail -s "$SUBJECT" "$EMAIL" < "$CHANGE_FILE"
  echo "Email sent to $EMAIL."
}

