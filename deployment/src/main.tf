# ---- networking ---- #



# ---- ecs ---- #


resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "${var.prefix}-execution-task-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags               = {
    Name        = "${var.app_name}-iam-role"
    Environment = var.env_name
  }
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}


resource "aws_ecs_cluster" "cluster" {
  name = "${var.app_name}-${var.env_name}-cluster"
  tags = {
    Name        = "${var.app_name}-ecs"
    Environment = var.env_name
  }
}
#
#
resource "aws_ecs_task_definition" "task_definition" {
  family                = "${var.app_name}-${var.env_name}"
  container_definitions = <<DEFINITION
  [
    {
      "name": "${var.app_name}-${var.env_name}",
      "image": "${var.container_image}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 3000,
          "hostPort": 3000
        }
      ],
      "cpu": 256,
      "memory": 512,
      "networkMode": "awsvpc"
    }
  ]
  DEFINITION

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "512"
  cpu                      = "256"
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn            = aws_iam_role.ecsTaskExecutionRole.arn

  tags = {
    Name        = "${var.app_name}-ecs-td"
    Environment = var.env_name
  }
}

data "aws_ecs_task_definition" "main" {
  task_definition = aws_ecs_task_definition.task_definition.family
}

resource "aws_ecs_service" "service" {
  name            = "${var.app_name}-${var.env_name}-ecs-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = "${aws_ecs_task_definition.task_definition.family}:${max(aws_ecs_task_definition.task_definition.revision, data.aws_ecs_task_definition.main.revision)}"
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = aws_subnet.private.*.id
    assign_public_ip = false
    security_groups  = [
      aws_security_group.service_security_group.id,
      aws_security_group.load_balancer_security_group.id
    ]
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.target_group.arn # Referencing our target group
    container_name   = aws_ecs_task_definition.task_definition.family
    container_port   = 3000 # Specifying the container port
  }
}


## ---- security groups ---- #
resource "aws_security_group" "service_security_group" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.load_balancer_security_group.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.app_name}-service-sg"
    Environment = var.env_name
  }
}

# ---- ALB ---- #

resource "aws_security_group" "load_balancer_security_group" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name        = "${var.app_name}-alb-sg"
    Environment = var.env_name
  }
}

resource "aws_alb" "application_load_balancer" {
  name               = "${var.app_name}-${var.env_name}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.public.*.id
  security_groups    = [aws_security_group.load_balancer_security_group.id]

  tags = {
    Name        = "${var.app_name}-alb"
    Environment = var.env_name
  }
}

resource "aws_alb_target_group" "target_group" {
  name        = "${var.app_name}-${var.env_name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.vpc.id

  health_check {
    matcher = "200,301,302"
    path    = "/"
  }

  tags = {
    Name        = "${var.app_name}-lb-tg"
    Environment = var.env_name
  }

  depends_on = [
    aws_alb.application_load_balancer
  ]
}

resource "aws_alb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.id
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.gloomhaven_companion.arn
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group.id
  }
  depends_on = [aws_acm_certificate_validation.cert]

}
