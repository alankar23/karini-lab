resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {Name = "eks-vpc"}

}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {Name = "eks-igw"}
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = data.aws_availability_zones.current.names[0]

  tags = {Name = "eks-public-subnet"}
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = data.aws_availability_zones.current.names[0]

  tags = {Name = "eks-private-subnet"}

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = {Name = "eks-public-rt"}
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "eks_nodes_sg" {
  name        = "eks-node-group-sg"
  description = "Security group for EKS worker nodes"
  vpc_id = aws_vpc.this.id

  # Allow nodes to communicate with each other
  ingress {
    description = "Allow node-to-node communication"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  # Allow all egress traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

   tags = {Name = "eks-nodes-sg"}

}