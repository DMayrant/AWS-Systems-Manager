resource "aws_security_group" "ssm_endpoints_sg" {
  name   = "ssm-endpoints-sg"
  vpc_id = aws_vpc.main_vpc.id

  # Allow EC2 instances in the VPC to talk to SSM endpoints
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main_vpc.cidr_block]
  }

  # Allow endpoints to respond
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssm-endpoints-sg"
  }
}
