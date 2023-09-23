#!/bin/bash

# Create Vars
max_backups=4
src_path="$HOME/"
dest_path="/mnt/$USER/Backup/$(hostname)"
filter_file_path="/mnt/$USER/Backup/script/filterlist.conf"
date=$(date +%y%m%d)

start=$(date +%s)

# Check if share is mounted
if ! grep -qs "/mnt/$USER" /proc/mounts; then
	echo "/mnt/$USER is not mounted! Please mount first!"
  exit 1;
fi

# Check if Needed folders exist
if [ ! -d $dest_path/latest ]; then
	echo "Erstelle latest-Ordner ..."
	mkdir -p $dest_path/latest
fi

if [ ! -d $dest_path/old ]; then
	echo "Erstelle old-Ordner ..."
	mkdir -p $dest_path/old
fi

if [ ! -d $dest_path/logs ]; then
	echo "Erstelle logs-Ordner ..."
	mkdir -p $dest_path/logs
fi

if [ ! -d $dest_path/old/$date ]; then
	echo "Erstelle Ordner date-Ordner ..."
	mkdir $dest_path/old/$date
fi

# Number of stored Backups
num_backups=$(find "$dest_path/old" -mindepth 1 -maxdepth 1 -type d | wc -l)

# Check if there are to much backups
if [ ! "$num_backups" -le "$max_backups" ]; then

  # Delete latest backups
  while [ "$num_backups" -gt "$max_backups" ]; do
    oldest_backup=$(find "$dest_path/old" -mindepth 1 -maxdepth 1 -type d -printf '%T+ %p\n' | sort | head -n 1 | awk '{print $2}')
    oldest_log=$(find "$dest_path/logs" -mindepth 1 -maxdepth 1 -type d -printf '%T+ %p\n' | sort | head -n 1 | awk '{print $2}')
    echo "Delete $oldest_backup"
    rm -rf "$oldest_backup"
    rm -rf "$oldest_log"
    num_backups=$(find "$dest_path/old" -mindepth 1 -maxdepth 1 -type d | wc -l)
  done
fi

echo "Starte Backup ..."

# Backup
rsync -vablPtU  \
          --stats \
          --info=progress2 \
          --delete \
          --delete-excluded \
          --backup-dir=$dest_path/old/$date \
          --filter "merge $filter_file_path" \
          $src_path $dest_path/latest | tee $dest_path/logs/$date

# Calculate time diff start to end
end=$(date +%s)
diff=$((end - start))
hours=$((diff / 3600))
minutes=$((diff % 3600 / 60))
seconds=$((diff % 60))

printf "\nDas Backup hat %02d:%02d:%02d gedauert.\n" $hours $minutes $seconds | tee -a $dest_path/logs/$date

# Unmount
umount /mnt/$USER
