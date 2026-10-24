#!/bin/bash

docker exec -i postgres_db psql \
-U admin \
-d bookingdb < backups/backup.sql

echo "Restore completed"