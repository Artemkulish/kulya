resource "aws_vpc" "zone_3000" {
    cidr_block = var.cidr_block
    
    tags = {
        Name   = "Homework"
    }
}

resource "aws_subnet" "public" {
    vpc_id     = aws_vpc.zone_3000.id 
    cidr_block = "10.0.0.0/28"

    tags = {
      Name   = "Public-subnet"
    }
}

resource "aws_subnet" "private" {
    vpc_id     = aws_vpc.zone_3000.id 
    cidr_block = "10.0.0.16/28"

    tags = {
      Name   = "Private-subnet"
    }
}

resource "aws_internet_gateway" "zone_3000" {
  vpc_id = aws_vpc.zone_3000.id
}

resource "aws_eip" "zone_3000" {
  vpc        = true
  depends_on = [aws_internet_gateway.zone_3000]
}

resource "aws_nat_gateway" "zone_3000" {
  allocation_id = aws_eip.zone_3000.id
  subnet_id     = aws_subnet.private.id

  tags = {
    Name = "NAT for private subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.zone_3000.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.zone_3000.id
  }

  tags = {
    Name = "Public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.zone_3000.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.zone_3000.id
  }

  tags = {
    Name = "Private"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "Zone3000" {
  name        = "Allow traffic"
  description = "Open 22, 80, 443 ports, allow ICMP traffic"
  vpc_id      = aws_vpc.zone_3000.id

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

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}