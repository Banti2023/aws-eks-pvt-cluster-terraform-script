resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "eks-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.public_subnet_cidr
  availability_zone = "ap-south-1a"
}
