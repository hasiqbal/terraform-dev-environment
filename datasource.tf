data "aws_ami" "dev-ami" {
  owners      = var.ami
  most_recent = true

  filter {
    name   = "name"
    values = var.ami-filter
  }

}