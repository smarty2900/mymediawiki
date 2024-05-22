# Creating VPC 
resource "aws_vpc" "myvpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "myvpc"
  }
}

# Creating Subnet
resource "aws_subnet" "mysubnet" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone
  tags = {
    Name = "mysubnet"
  }
}

# Creating Internet Gateway
resource "aws_internet_gateway" "myinternetgateway" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "myinternetgateway"
  }
}

# Creating Route table to route traffic to specific subnet
resource "aws_route_table" "myroutetable" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myinternetgateway.id
  }

  tags = {
    Name = "myroutetable"
  }
}

# Mapping route table to subnet
resource "aws_route_table_association" "routeassoc" {
  subnet_id      = aws_subnet.mysubnet.id
  route_table_id = aws_route_table.myroutetable.id
}

# Security Group for our application
resource "aws_security_group" "mysecuritygroup" {
  name   = "mysecuritygroup"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
   ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Terraform-SG"
  }
}

# Creating EC2 Instances
resource "aws_instance" "myec2instances" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.mysubnet.id
  vpc_security_group_ids      = [aws_security_group.mysecuritygroup.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 10
  }

  tags = {
    Name = "my-application"
  }

  lifecycle {
    create_before_destroy = true
  }

  # Running ansible from our machine to the managed node
  provisioner "local-exec" {
    command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u centos --private-key ./${var.key_name}.pem -i '${aws_instance.myec2instances.public_ip},' ${var.ansible_playbook}"
  }
}
