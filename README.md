# planka

Past in your generated `SECRET_KEY`:
```bash
openssl rand -hex 64
```

---

Copy the backup files from the server:
```bash
scp -r ubuntu@192.168.1.116:/home/ubuntu/planka/backups .
```

Restore the backup files:
```bash
scp -r backups ubuntu@192.168.1.144:~
```
