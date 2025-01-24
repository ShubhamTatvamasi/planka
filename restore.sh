#!/bin/bash

# Backup directory
BACKUP_DIR="./backups"

# File names
DB_RESTORE="planka_db_backup.sql"
USER_AVATARS_RESTORE="user_avatars.tar.gz"
PROJECT_BG_RESTORE="project_background_images.tar.gz"
ATTACHMENTS_RESTORE="attachments.tar.gz"

# PostgreSQL container name
POSTGRES_CONTAINER="postgres"

echo "[$(date)] Starting Planka restore..."

# Restore PostgreSQL database
if [ -f "$BACKUP_DIR/$DB_RESTORE" ]; then
  echo "[$(date)] Restoring PostgreSQL database..."
  cat "$BACKUP_DIR/$DB_RESTORE" | docker exec -i $POSTGRES_CONTAINER psql -U postgres -d planka
else
  echo "[$(date)] Database backup file not found!"
fi

# Restore volumes
if [ -f "$BACKUP_DIR/$USER_AVATARS_RESTORE" ]; then
  echo "[$(date)] Restoring user avatars..."
  docker run --rm -v user-avatars:/data -v "$BACKUP_DIR:/backup" alpine tar xzf "/backup/$USER_AVATARS_RESTORE" -C /data
else
  echo "[$(date)] User avatars backup file not found!"
fi

if [ -f "$BACKUP_DIR/$PROJECT_BG_RESTORE" ]; then
  echo "[$(date)] Restoring project background images..."
  docker run --rm -v project-background-images:/data -v "$BACKUP_DIR:/backup" alpine tar xzf "/backup/$PROJECT_BG_RESTORE" -C /data
else
  echo "[$(date)] Project background images backup file not found!"
fi

if [ -f "$BACKUP_DIR/$ATTACHMENTS_RESTORE" ]; then
  echo "[$(date)] Restoring attachments..."
  docker run --rm -v attachments:/data -v "$BACKUP_DIR:/backup" alpine tar xzf "/backup/$ATTACHMENTS_RESTORE" -C /data
else
  echo "[$(date)] Attachments backup file not found!"
fi

echo "[$(date)] Restore completed!"
