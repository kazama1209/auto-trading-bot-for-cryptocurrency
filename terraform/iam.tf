resource "aws_iam_role" "ecs_instance_role" {
  name               = "${var.r_prefix}-ecs-instance-role"
  assume_role_policy = "${file("files/roles/ec2-assume-role.json")}"
}

resource "aws_iam_role_policy_attachment" "ecs_instance_role_attach" {
  role        = "${aws_iam_role.ecs_instance_role.name}"
  policy_arn  = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.r_prefix}-instance-profile"
  role = "${aws_iam_role.ecs_instance_role.name}"
}
