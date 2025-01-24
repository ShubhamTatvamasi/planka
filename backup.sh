#!/bin/bash

# Define backup file names
DB_BACKUP="planka_db_backup.sql"
USER_AVATARS_BACKUP="user_avatars.tar.gz"
PROJECT_BG_BACKUP="project_background_images.tar.gz"
ATTACHMENTS_BACKUP="attachments.tar.gz"

# PostgreSQL container name
POSTGRES_CONTAINER="postgres"

# Backup directory
BACKUP_DIR="./backups"
mkdir -p $BACKUP_DIR

echo "[$(date)] Starting Planka backup..."

# Backup PostgreSQL database
echo "[$(date)] Backing up PostgreSQL database..."
docker exec -t $POSTGRES_CONTAINER pg_dump -U postgres -d planka > "$BACKUP_DIR/$DB_BACKUP"

# Backup volumes
echo "[$(date)] Backing up user avatars..."
docker run --rm -v user-avatars:/data -v "$BACKUP_DIR:/backup" alpine tar czf "/backup/$USER_AVATARS_BACKUP" -C /data .

echo "[$(date)] Backing up project background images..."
docker run --rm -v project-background-images:/data -v "$BACKUP_DIR:/backup" alpine tar czf "/backup/$PROJECT_BG_BACKUP" -C /data .

echo "[$(date)] Backing up attachments..."
docker run --rm -v attachments:/data -v "$BACKUP_DIR:/backup" alpine tar czf "/backup/$ATTACHMENTS_BACKUP" -C /data .

echo "[$(date)] Backup completed! Files saved in $BACKUP_DIR"
