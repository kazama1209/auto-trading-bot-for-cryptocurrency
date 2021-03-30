resource "aws_security_group" "internal_sg" {
  name        = "${var.r_prefix}-internal-sg"
  description = "${var.r_prefix}-internal-sg"
  vpc_id      = "${aws_vpc.auto_trading_bot_for_cryptocurrency.id}"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.r_prefix}-internal-sg"
  }
}

resource "aws_security_group" "http_sg" {
  name        = "${var.r_prefix}-http-sg"
  description = "${var.r_prefix}-http-sg"
  vpc_id      = "${aws_vpc.auto_trading_bot_for_cryptocurrency.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.r_prefix}-http-sg"
  }
}

resource "aws_security_group" "ssh_sg" {
  name        = "${var.r_prefix}-ssh-sg"
  description = "${var.r_prefix}-ssh-sg"
  vpc_id      = "${aws_vpc.auto_trading_bot_for_cryptocurrency.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.r_prefix}-ssh-sg"
  }
}
