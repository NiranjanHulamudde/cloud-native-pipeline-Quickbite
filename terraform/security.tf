# load balancer securty  group
resource "aws_security_group" "lb_sg" {
  name        = "${var.project_name}-lb_sg"
  description = "Allow incoming all traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "allow all traffic"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

  egress {
    description = "allow outgoing traffic"
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
}
tags = {
    Name = "${var.project_name}-lb-sg"
  }
}

# application security group

resource "aws_security_group" "app_sg" {
  name        = "${var.project_name}-app_sg"
  description = "isolate application containers in private subnet"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "allow traffic only from lb"
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
}
  egress {
    description = "Allow outbound traffic via NAT Gateway (to pull Docker Hub image, etc.)"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cider_blocks = ["0.0.0.0/0"]
}
  tags = {
    Name = "${var.project_name}-app-sg"
  }
}


