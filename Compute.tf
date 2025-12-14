
resource "aws_instance" "private_linux" {
  subnet_id              = aws_subnet.private_subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.ssm_endpoints_sg.id]
  ami                    = "ami-068c0051b15cdb816"
  instance_type          = var.ec2_instance_type
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  count                  = 1

  tags = {
    Name = "Private Instance"
  }
}
