#!/bin/bash

mkdir -p backups

docker exec postgres_db pg_dump \
-U admin \
-d bookingdb > backups/backup.sql

echo "Backup completed"