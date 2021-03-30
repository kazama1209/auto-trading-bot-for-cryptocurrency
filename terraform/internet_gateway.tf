resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.auto_trading_bot_for_cryptocurrency.id}"

  tags = {
    Name = "${var.r_prefix}-igw"
  }
}
