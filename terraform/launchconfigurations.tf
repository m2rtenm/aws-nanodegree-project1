data "aws_ami" "packer_ami" {
  most_recent = true
  filter {
    name = "name"
    values = [ "packer*" ]
  }
}

resource "aws_instance" "bastion" {
  ami = data.aws_ami.packer_ami.image_id
  instance_type = var.instance_type
  key_name = aws_key_pair.keypair.key_name
  associate_public_ip_address = false
  security_groups = [ aws_security_group.ec2.id ]
  subnet_id = aws_subnet.public-subnet-1.id
  tags = {
    Name = "Bastion"
  }
}

resource "aws_launch_configuration" "ec2" {
  name = "${var.prefix}-instances-lc"
  image_id = data.aws_ami.packer_ami.image_id
  instance_type = var.instance_type
  security_groups = [ aws_security_group.ec2.id ]
  key_name = aws_key_pair.keypair.key_name
  associate_public_ip_address = false
  user_data = <<-EOL
  #!/bin/bash -xe
  sudo apt update -y
  sudo apt -y install docker
  sudo service docker start
  sudo usermod -a -G docker ec2-user
  sudo chmod 666 /var/run/docker.sock
  docker pull nginx
  docker tag nginx my-nginx
  docker run --rm --name nginx-server -d -p 80:80 -t my-nginx
  EOL
  depends_on = [ aws_nat_gateway.ngw ]
}