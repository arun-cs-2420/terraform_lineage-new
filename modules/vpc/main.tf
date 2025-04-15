data "aws_availability_zones" "tf_availability_zones" {
  state = "available"
}
locals {
  common_tags             = var.tags
  public_route_cidr_block = "0.0.0.0/0"
}

resource "aws_vpc" "tf_vpc" {
  enable_dns_support   = true
  enable_dns_hostnames = true
  cidr_block           = var.network_cidr
  tags = merge(
    local.common_tags, {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-networking-VPC"}
  )
}

resource "aws_internet_gateway" "tf_igw" {
  vpc_id = aws_vpc.tf_vpc.id
  tags   = merge(
    local.common_tags, {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-networking-igw"}
  )
}

resource "aws_subnet" "tf_subnet_public_01" {
  vpc_id            = aws_vpc.tf_vpc.id
  cidr_block        = var.subnet_cidr["SUBNET_01"]
  availability_zone = data.aws_availability_zones.tf_availability_zones.names[0]
  tags = merge(
    local.common_tags, {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-networking-Public-Subnet-01"}
  )
}

resource "aws_subnet" "tf_subnet_public_02" {
  vpc_id            = aws_vpc.tf_vpc.id
  cidr_block        = var.subnet_cidr["SUBNET_02"]
  availability_zone = data.aws_availability_zones.tf_availability_zones.names[1]
  tags = merge(
    local.common_tags, {"Name"= "${var.project_name}-${var.project_region}-${var.project_environment}-networking-Public-Subnet-02"}
  )
}

resource "aws_route_table" "tf_rtb_public_01" {
  vpc_id = aws_vpc.tf_vpc.id
 
  route {
    cidr_block = local.public_route_cidr_block
    gateway_id = aws_internet_gateway.tf_igw.id
}
  tags = merge(
    local.common_tags, {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-networking-Public-route-table"}
  )

}

resource "aws_route_table" "tf_rtb_public_02" {
  vpc_id = aws_vpc.tf_vpc.id
  route {
    cidr_block = local.public_route_cidr_block
    gateway_id = aws_internet_gateway.tf_igw.id

  }
    tags = merge(
    local.common_tags, {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-Networking-Public-route-table"}
  )
}
resource "aws_route_table_association" "tf_rta_subnet_public_01" {
  subnet_id      = aws_subnet.tf_subnet_public_01.id
  route_table_id = aws_route_table.tf_rtb_public_01.id
}

resource "aws_route_table_association" "tf_rta_subnet_public_02" {
  subnet_id      = aws_subnet.tf_subnet_public_02.id
  route_table_id = aws_route_table.tf_rtb_public_02.id
}
//subnet for rds without internet access

# --- Private Subnet 3 ---
resource "aws_subnet"  "tf_subnet_private_03" {
 vpc_id                  = aws_vpc.tf_vpc.id
  map_public_ip_on_launch = false
  cidr_block              = var.subnet_cidr["SUBNET_05"]
  availability_zone       = data.aws_availability_zones.tf_availability_zones.names[0]
  tags = merge(
    local.common_tags, {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-networking-Private-Subnet-01"}
  )
}
 
# --- Private Subnet 4 ---
resource "aws_subnet"  "tf_subnet_private_04" {
 vpc_id                  = aws_vpc.tf_vpc.id
  map_public_ip_on_launch = false
  cidr_block              = var.subnet_cidr["SUBNET_06"]
  availability_zone       = data.aws_availability_zones.tf_availability_zones.names[1]
  tags = merge(
    local.common_tags, {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-networking-Private-Subnet-01"}
  )
}
 
# --- Route Table ---
resource "aws_route_table" "private_03" {
  vpc_id = aws_vpc.tf_vpc.id
 
  tags = merge(
    local.common_tags, {"Name"= "${var.project_name}-${var.project_region}-${var.project_environment}-networking-private-rt"}
  )
}
# --- Route Table ---
resource "aws_route_table" "private_04" {
  vpc_id = aws_vpc.tf_vpc.id
 
  tags = merge(
    local.common_tags, {"Name"= "${var.project_name}-${var.project_region}-${var.project_environment}-networking-private-rt"}
  )
}

 
resource "aws_route_table_association" "private_03" {
  subnet_id      = aws_subnet.tf_subnet_private_03.id
  route_table_id = aws_route_table.private_03.id
}
 
resource "aws_route_table_association" "private_04" {
  subnet_id      = aws_subnet.tf_subnet_private_04.id
  route_table_id = aws_route_table.private_04.id
}

//eip for NAT

resource "aws_eip" "tf_nat_eip" {
  domain                    = "vpc"
  depends_on = [aws_internet_gateway.tf_igw]
  tags = merge(
    local.common_tags, {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-networking-natgw-eip"}
  )
}

resource "aws_eip" "tf_nat_eip2" {
  domain                    = "vpc"
  depends_on = [aws_internet_gateway.tf_igw]
  tags = merge(
    local.common_tags, {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-networking-natgw-eip2"}
  )
}

resource "aws_nat_gateway" "tf_nat" {
  allocation_id = aws_eip.tf_nat_eip.id
  subnet_id     = aws_subnet.tf_subnet_public_01.id
  depends_on    = [aws_internet_gateway.tf_igw]
  tags = merge(
    local.common_tags, {"Name"= "${var.project_name}-${var.project_region}-${var.project_environment}-networking-nat-gwid"}
  )
}

resource "aws_nat_gateway" "tf_nat2" {
  allocation_id = aws_eip.tf_nat_eip2.id
  subnet_id     = aws_subnet.tf_subnet_public_02.id
  depends_on    = [aws_internet_gateway.tf_igw]
  tags = merge(
    local.common_tags, {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-networking-nat-gwid2"}
  )

}


resource "aws_subnet" "tf_subnet_private_01" {
  vpc_id                  = aws_vpc.tf_vpc.id
  map_public_ip_on_launch = false
  cidr_block              = var.subnet_cidr["SUBNET_03"]
  availability_zone       = data.aws_availability_zones.tf_availability_zones.names[0]
  tags = merge(
    local.common_tags, {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-networking-Private-Subnet-01"}
  )
}

resource "aws_subnet" "tf_subnet_private_02" {
  vpc_id                  = aws_vpc.tf_vpc.id
  map_public_ip_on_launch = false
  cidr_block              = var.subnet_cidr["SUBNET_04"]
  availability_zone       = data.aws_availability_zones.tf_availability_zones.names[1]
  tags = merge(
    local.common_tags, {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-networking-Private-Subnet-02"}
  )
}


resource "aws_route_table" "tf_private_rt" {
  vpc_id = aws_vpc.tf_vpc.id
  
  tags = merge(
    local.common_tags, {"Name"= "${var.project_name}-${var.project_region}-${var.project_environment}-networking-private-rt"}
  )
}

resource "aws_route_table" "tf_private_rt2" {
  vpc_id = aws_vpc.tf_vpc.id
  
  tags = merge(
    local.common_tags, {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-networking-private-rt2"}
  )
}

resource "aws_route_table_association" "tf_private1_rt_ass" {
  subnet_id      = aws_subnet.tf_subnet_private_01.id
  route_table_id = aws_route_table.tf_private_rt.id
}
resource "aws_route_table_association" "tf_private2_rt_ass" {
  subnet_id      = aws_subnet.tf_subnet_private_02.id
  route_table_id = aws_route_table.tf_private_rt2.id
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.tf_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.tf_nat.id
}

resource "aws_route" "private_nat_gateway2" {
  route_table_id         = aws_route_table.tf_private_rt2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.tf_nat2.id
}


//route_table for vpc
resource "aws_route_table" "vpc" {
  vpc_id = aws_vpc.tf_vpc.id
}



//vpc endpoint for s3
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.tf_vpc.id
  service_name = "com.amazonaws.ap-southeast-2.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [aws_route_table.vpc.id]
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "AllowS3Access"
        Effect = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::*",
          "arn:aws:s3:::*/*"
        ]
      }
    ]
  })
}

