# DevOps Assessment - Terraform + Database Reliability

## Architecture

Internet
  |
  v
ALB
  |
  v
ECS/Fargate
  |
  v
RDS PostgreSQL

### Components

- VPC with public and private subnets
- Application Load Balancer (ALB)
- ECS Fargate service
- RDS PostgreSQL database
- Security groups restricting database access to ECS only

## Terraform

Structure:

infra/
├── modules/
│   ├── network/
│   ├── ecs/
│   └── rds/
└── envs/
    ├── dev/
    └── prod/

### Validation

terraform fmt -recursive

terraform validate

terraform plan

## Database

PostgreSQL is deployed locally using Docker Compose.

### Tables

- hotel_bookings
- booking_events

### Seed Data

- 100 hotel bookings
- Multiple organizations
- Multiple cities
- Multiple booking statuses
- Booking events

## Query Optimization

Created index:

CREATE INDEX idx_hotel_bookings_city_created_at
ON hotel_bookings(city, created_at);

Reason:

The query filters on city and created_at. The composite index improves lookup performance before aggregation.

## Backup

Script:

scripts/backup.sh

Creates a PostgreSQL database backup.

## Restore

Script:

scripts/restore.sh

Restores the database from backup.