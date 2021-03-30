resource "aws_vpc" "auto_trading_bot_for_cryptocurrency" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.r_prefix}-vpc"
  }
}
