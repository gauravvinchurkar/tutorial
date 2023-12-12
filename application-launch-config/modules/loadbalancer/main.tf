resource "aws_lb_target_group" "tg-home" {
    name = "${var.project}-tg-home"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    health_check {
      path = "/"
      port = 80
      protocol = "HTTP"
    }  
}
resource "aws_lb_target_group" "tg-mobile" {
    name = "${var.project}-tg-mobile"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    health_check {
      path = "/mobile"
      port = 80
      protocol = "HTTP"
    }  
}
resource "aws_lb_target_group" "tg-laptop" {
    name = "${var.project}-tg-laptop"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    health_check {
      path = "/laptop"
      port = 80
      protocol = "HTTP"
    }  
}
resource "aws_lb" "my_lb" {
    name = "${var.project}-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = var.sg_ids
    subnets = var.subnet_ids
    tags = {
        env = var.env
    }  
}
resource "aws_lb_listener" "my_lb_listener" {
    load_balancer_arn = aws_lb.my_lb.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.tg-home.arn
    } 
}
resource "aws_lb_listener_rule" "my_lb_listener_rule" {
    listener_arn = aws_lb_listener.my_lb_listener.arn
    priority = 101
    action {
      type = "forward"
      target_group_arn = aws_lb_target_group.tg-mobile.arn
    }
    condition {
      path_pattern {
        values = [ "/mobile*" ]
      }
    }
}
resource "aws_lb_listener_rule" "my_lb_listener_rule_2" {
    listener_arn = aws_lb_listener.my_lb_listener.arn
    priority = 102
    action {
      type = "forward"
      target_group_arn = aws_lb_target_group.tg-laptop.arn
    }
    condition {
      path_pattern {
        values = [ "/laptop*" ]
      }
    }
}








