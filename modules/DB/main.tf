# resource "aws_db_instance" "mariadb" {
#   identifier              = "my-mariadb-db"
#   allocated_storage       = 20
#   storage_type            = "gp2"
#   engine                  = "mariadb"
#   engine_version          = "10.4.13"
#   instance_class          = "db.t2.micro"
#   name                    = "mariadb-db-instance"
#   username                = "admin"
#   password                = "password!"
#   parameter_group_name    = "default.mariadb10.4"
#   publicly_accessible     = false
#   skip_final_snapshot     = true
#   backup_retention_period = 7
#   deletion_protection     = false
#   vpc_security_group_ids  = [aws_security_group.mariadb_sg.id]
#   db_subnet_group_name    = aws_db_subnet_group.mariadb_subnet_group.name

#   scaling_configuration {
#     auto_pause               = true
#     max_capacity             = 2
#     min_capacity             = 1
#     seconds_until_auto_pause = 300
#   }
# }

# resource "aws_db_subnet_group" "mariadb_subnet_group" {
#   name       = "mariadb-subnet-group"
#   subnet_ids = [var.PRI_SUB_7_A_ID, var.PRI_SUB_8_B_ID]
# }

# resource "aws_security_group" "mariadb_sg" {
#   name        = "mariadb-security-group"
#   description = "Allow MySQL/Aurora traffic"
#   vpc_id      = var.VPC_ID

#   ingress {
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = [var.PRI_SUB_7_A_ID, var.PRI_SUB_8_B_ID] 
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
