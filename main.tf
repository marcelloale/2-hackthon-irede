terraform {
  required_providers {
    aws = {

      ### CONFIGURAÇÔES DA AWS NESSE BLOCO ####
    
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = ">= 1.1.0"
  cloud {
    organization = "#############################" ### NOME DA SUA ORGANIZATION CRIADA NO TERRAFORM CLOUD ###
  workspaces {
      name = "############################" ### NOME DA SUA WORKSPACE CRIADA NO TERRAFORM CLOUD ###
    }
  }
}

provider "aws" {
  region = "##########" # REGIAO DA AWS
}

resource "random_pet" "sg" {}

data "aws_ami" "ubuntu" {
  most_recent = true

#### ADICIONE AQUI AS CONFIGURAÇÕES DO BLOCO DATA PARA CAPTURAR O AMI DO UBUNTU NA AWS #####

}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web-sg.id]

  user_data = <<-EOF
              #!/bin/bash
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
