
resource "aws_instance" "dev" {
  ami                    = data.aws_ami.dev-ami.id
  instance_type          = var.instance
  key_name               = aws_key_pair.dev-auth.id
  vpc_security_group_ids = [aws_security_group.dev-sg.id]
  subnet_id              = aws_subnet.dev-public-subnet.id
  user_data              = file("userdata.tpl")
  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "dev"
  }
}