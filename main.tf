terraform {
  required_providers {
    aws = {

      ### CONFIGURAÇÔES DA AWS NESSE BLOCO ####
      source = "hashicorp/aws"
      version = "4.52.0"
    
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = ">= 1.1.0"
  cloud {
    organization = "marcelloale" ### NOME DA SUA ORGANIZATION CRIADA NO TERRAFORM CLOUD ###
  workspaces {
      name = "learn-terraform-github-actions" ### NOME DA SUA WORKSPACE CRIADA NO TERRAFORM CLOUD ###
    }
  }
}

provider "aws" {
  region = "sa-east-1" # REGIAO DA AWS
}

resource "random_pet" "sg" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  
  filter {
      name = "virtualization - type"
      values = ["hvm"]
  }

  owners = ["AWS"]

#### ADICIONE AQUI AS CONFIGURAÇÕES DO BLOCO DATA PARA CAPTURAR O AMI DO UBUNTU NA AWS #####

}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web-sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y &&
              sudo apt install -y nginx
              sudo echo "<html><head><title>Hello World Example</title></head><body><h1>2 Hackthon IREDE via Terraform</h1></body></html>" > /usr/share/nginx/html/index.html
              cat <<EOH > /etc/nginx/sites-available/default
              server {
                  listen 8080;
                  location / {
                      root /usr/share/nginx/html;
                      index index.html;
                  }
              }
              EOH
              service nginx start
              ### INSTALAÇÃO DO SERVIDOR WEB ###
              EOF
}

resource "aws_security_group" "web-sg" {
  name = "${random_pet.sg.id}-sg"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "web-address" {
  value = "${aws_instance.web.public_dns}:8080"
}
