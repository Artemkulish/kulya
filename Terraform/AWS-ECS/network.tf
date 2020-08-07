resource "aws_vpc" "kulya" {
    cidr_block = var.cidr_block
    
    tags = {
        Name   = "Homework"
    }
}

resource "aws_subnet" "public" {
    vpc_id     = aws_vpc.kulya.id 
    cidr_block = "10.0.0.0/28"

    tags = {
      Name   = "Public-subnet"
    }
}

resource "aws_subnet" "private" {
    vpc_id     = aws_vpc.kulya.id 
    cidr_block = "10.0.0.16/28"

    tags = {
      Name   = "Private-subnet"
    }
}

resource "aws_internet_gateway" "kulya" {
  vpc_id = aws_vpc.kulya.id
}

resource "aws_eip" "kulya" {
  vpc        = true
  depends_on = [aws_internet_gateway.kulya]
}

resource "aws_nat_gateway" "kulya" {
  allocation_id = aws_eip.kulya.id
  subnet_id     = aws_subnet.private.id

  tags = {
    Name = "NAT for private subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.kulya.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kulya.id
  }

  tags = {
    Name = "Public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.kulya.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.kulya.id
  }

  tags = {
    Name = "Private"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "load_balancer" {
  name        = "ECS_ALB"
  description = "Open 80, 443 ports and outbound traffic"
  vpc_id      = aws_vpc.kulya.id

  ingress {
    from_port   = var.http
    to_port     = var.http
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = var.https
    to_port     = var.https
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ECS" {
  name        = "ECS"
  description = "Allow inbound access from the ALB only"
  vpc_id      = aws_vpc.kulya.id

  ingress {
    from_port       = var.https
    to_port         = var.https
    protocol        = "tcp"
    security_groups = [aws_security_group.load_balancer.id]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
