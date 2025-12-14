resource "tls_private_key" "linux_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "linux_key" {
  key_name   = "linux-key"
  public_key = tls_private_key.linux_key.public_key_openssh
}
