resource "aws_instance" "auto_trading_bot_for_cryptocurrency" {
  ami                         = "ami-0a3769ff70e8ed2c7"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.auth.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.instance_profile.name}"
  
  vpc_security_group_ids      = [
    "${aws_security_group.internal_sg.id}",
    "${aws_security_group.http_sg.id}",
    "${aws_security_group.ssh_sg.id}"
  ]
  subnet_id                   = "${aws_subnet.public_1a.id}"

  associate_public_ip_address = "true"
  user_data                   = "${file("files/user_data.sh")}"

  tags = {
    Name = "${var.r_prefix}-instance"
  }
}

resource "aws_key_pair" "auth" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}
