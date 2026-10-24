resource "aws_db_subnet_group" "this" {
  name = "tripare-db-subnet"

  subnet_ids = [var.subnet_id]
}

resource "aws_db_instance" "postgres" {
  identifier = "tripare-db"

  engine = "postgres"

  instance_class = var.db_instance_class

  allocated_storage = 20

  username = "postgres"
  password = "Password123!"

  publicly_accessible = false

  backup_retention_period = var.backup_retention_period

  deletion_protection = var.deletion_protection

  db_subnet_group_name = aws_db_subnet_group.this.name

  vpc_security_group_ids = [
    var.security_group_id
  ]

  skip_final_snapshot = true
}