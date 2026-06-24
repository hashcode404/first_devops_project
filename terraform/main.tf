resource "aws_ecr_repository" "frontend" {
  name = "frontend"
}

resource "aws_ecr_repository" "backend" {
  name = "backend"
}

resource "aws_key_pair" "devops_key" {
  key_name   = "first-devops-project"
  public_key = file("/home/pranav/.ssh/id_ed25519.pub")
}

resource "aws_security_group" "app_sg" {

  name = "first-devops-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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


resource "aws_instance" "app_server" {

  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  key_name             = aws_key_pair.devops_key.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name


  vpc_security_group_ids = [
    aws_security_group.app_sg.id
  ]

  tags = {
    Name = "first-devops-server"
  }
}

