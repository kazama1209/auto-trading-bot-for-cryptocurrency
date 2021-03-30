resource "aws_ecs_cluster" "auto_trading_bot_for_cryptocurrency" {
  name = "${var.r_prefix}-cluster"
}

resource "aws_ecs_task_definition" "auto_trading_bot_for_cryptocurrency" {
  family                = "auto-trading-bot-for-cryptocurrency-task"
  container_definitions = "${file("files/task-definitions/auto-trading-bot-for-cryptocurrency-task.json")}"
}
