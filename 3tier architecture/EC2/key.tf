#키파일 생성
# Create .pem key file in local
resource "tls_private_key" "TEST" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "TEST" {
  key_name   = "TEST"
  public_key = tls_private_key.TEST.public_key_openssh
}


resource "local_file" "ssh_key" {
  filename = "TEST.pem"
  content = tls_private_key.TEST.private_key_pem
}
