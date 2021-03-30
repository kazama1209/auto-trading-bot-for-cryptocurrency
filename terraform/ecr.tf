resource "aws_ecr_repository" "auto_trading_bot_for_cryptocurrency" {
  name                 = "${var.r_prefix}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "auto_trading_bot_for_cryptocurrency" {
  repository = "${aws_ecr_repository.auto_trading_bot_for_cryptocurrency.name}"

  policy = <<EOF
  {
    "rules": [
      {
        "rulePriority": 1,
        "description": "Delete images when count is more than 500",
        "selection": {
          "tagStatus": "any",
          "countType": "imageCountMoreThan",
          "countNumber": 500
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  }
EOF
}
