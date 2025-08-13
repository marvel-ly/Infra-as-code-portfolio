provider "aws" {
  region = "eu-north-1" 
}

# secuirity group allowing SSH and HTTP

resource "aws_security_group" "devops_sg" {
	name        = "devops-lab-sg"
	description = "Allow SSH and HTTP"
	
	ingress {
	    description = "SSH"
	    from_port   = 22
	    to_port     = 22
	    protocol    = "tcp"
	    cidr_blocks = ["0.0.0.0/0"] # allow from anywhere (for testing)
	}

	 ingress {
            description = "HTTP"
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"] # allow from anywhere (for testing)
        }


	egress {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = ["0.0.0.0/0"] 
        }

}

# key pair

resource "aws_key_pair" "devops_key" {
	
	key_name   = "devops_key"
	public_key = file("~/.ssh/id_rsa.pub")
}

  
# EC2 instance with apache auto-installed			
resource "aws_instance" "devops_server" { 
  ami                    = "ami-08086d47911d52ef0"  # Amazon Linux 2 AMI in eu-north-1 
  instance_type          = "t3.micro"              
  key_name               = aws_key_pair.devops_key.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

user_data = <<-EOF
#!/bin/bash
set -e
yum update -y
yum install -y httpd
systemctl enable --now httpd

mkdir -p /var/www/html

# Write files using heredocs to preserve formatting and quotes
cat > /var/www/html/index.html <<'HTML'
${file("${path.module}/index.html")}
HTML

cat > /var/www/html/styles.css <<'CSS'
${file("${path.module}/styles.css")}
CSS

cat > /var/www/html/app.js <<'JS'
${file("${path.module}/app.js")}
JS

chown apache:apache /var/www/html/*
chmod 0644 /var/www/html/*
EOF

	
  tags = {
    Name = "DevOps-Portfolio" 
  }
}
 
