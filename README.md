# planka

Generate a secret key:
```bash
echo "SECRET_KEY=$(openssl rand -hex 64)" > .env
```

---

### Backup

Take a backup of the database and volumes:
```bash
./backup.sh
```

Copy the backup files from the server to local:
```bash
scp -r ubuntu@192.168.1.116:/home/ubuntu/planka/backups .
```

Copy files from local to new server:
```bash
scp -r backups ubuntu@192.168.1.144:~
```

### Restore

Start the postgres container:
```bash
docker-compose up postgres -d
```

Restore the backup:
```bash
./restore.sh
```
