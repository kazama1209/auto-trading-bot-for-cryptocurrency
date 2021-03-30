resource "aws_subnet" "public_1a" {
  vpc_id                  = "${aws_vpc.auto_trading_bot_for_cryptocurrency.id}"
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.r_prefix}-public-subnet-1a"
  }
}

resource "aws_subnet" "public_1c" {
  vpc_id                  = "${aws_vpc.auto_trading_bot_for_cryptocurrency.id}"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.r_prefix}-public-subnet-1c"
  }
}
