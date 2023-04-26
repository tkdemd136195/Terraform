#target group 생성 및 인스턴스 추가
resource "aws_alb_target_group" "web-target" {
  name = "web-target"
  port             = 80
  protocol         = "HTTP"
  vpc_id           = aws_vpc.terraform-vpc.id
  health_check {
    path = "/"
    protocol = "HTTP"
    interval  = 30
  }
}

resource "aws_alb_target_group_attachment" "web-target-attachment" {
  target_group_arn = aws_alb_target_group.web-target.arn
  target_id        = aws_instance.web.id
  port             = 80
}


resource "aws_alb_target_group" "was-target" {
  name = "was-target"
  port             = 8080
  protocol         = "HTTP"
  vpc_id           = aws_vpc.terraform-vpc.id
  health_check {
    path = "/"
    protocol = "HTTP"
    interval  = 30
  }
}

resource "aws_alb_target_group_attachment" "was-target-attachment" {
  target_group_arn = aws_alb_target_group.was-target.arn
  target_id        = aws_instance.was.id
  port             = 80
}

#로드밸런서 생성
resource "aws_alb" "ex-lb" {
  name = "EX-LB"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.ex_lb.id]
  subnets         = [aws_subnet.public1.id, aws_subnet.public2.id]
  lifecycle { create_before_destroy = true }
}

resource "aws_alb" "in-lb" {
  name = "IN-LB"
  internal = true
  load_balancer_type = "application"
  security_groups = [aws_security_group.in_lb.id]
  subnets         = [aws_subnet.public1.id, aws_subnet.public2.id]
  lifecycle { create_before_destroy = true }
}

#리스너 설정
resource "aws_alb_listener" "EX-listener" {
  load_balancer_arn = aws_alb.ex-lb.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.web-target.arn
  }
}

resource "aws_alb_listener" "IN-listener" {
  load_balancer_arn = aws_alb.in-lb.arn
  port = "8080"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.was-target.arn
  }
}
