resource "aws_key_pair" "keypair" {
  key_name = "${var.prefix}_key_pair"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits = 4096
}