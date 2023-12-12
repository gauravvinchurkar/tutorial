resource "aws_launch_configuration" "lc-home" {
    image_id = var.image_id
    name = "${var.project}-lc-home"
    instance_type = var.instance_type
    security_groups = var.sg_ids
    key_name = var.key_name
    user_data = <<-EOF
         #!/bin/bash
         yum install httpd -y
         systemctl start httpd 
         systemctl enable httpd
         echo "<h1> hello world! welcome to home-page" > /var/www/html/index.html
    EOF 
      
}
resource "aws_launch_configuration" "lc-laptop" {
    image_id = var.image_id
    name = "${var.project}-lc-laptop"
    instance_type = var.instance_type
    security_groups = var.sg_ids
    key_name = var.key_name
    user_data = <<-EOF
         #!/bin/bash
         yum install httpd -y
         systemctl start httpd 
         systemctl enable httpd
         mkdir /var/www/html/laptop
         echo "<h1> SALE! SALE! SALE! welcome to laptop-page" > /var/www/html/laptop/index.html
    EOF
         
}
resource "aws_launch_configuration" "lc-mobile" {
    image_id = var.image_id
    name = "${var.project}-lc-mobile"
    instance_type = var.instance_type
    security_groups = var.sg_ids
    key_name = var.key_name
    user_data = <<-EOF
         #!/bin/bash
         yum install httpd -y
         systemctl start httpd 
         systemctl enable httpd
         mkdir /var/www/html/mobile
         echo "<h1> flat 50% off! welcome to mobile-page" > /var/www/html/mobile/index.html
    EOF 
}
resource "aws_autoscaling_group" "as_home" {
    name =  "${var.project}-as-home"
    desired_capacity   = 2
    max_size           = 4
    min_size           = 2
    launch_configuration = aws_launch_configuration.lc-home.name
    vpc_zone_identifier = [var.subnet1, var.subnet2]
    tags = {
        key = "Name"
        value = "${var.project}-home-app"
        propagate_at_launch = true  
    }
}
resource "aws_autoscaling_policy" "asg_policy_home" {
    name = "${var.project}-asg-policy-home"
    autoscaling_group_name = aws_autoscaling_group.as_home.name
    adjustment_type = "ChangeInCapacity"
    policy_type = "TargetTrackingScaling"
    target_tracking_configuration {
      predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
      }
      target_value = 50
    }
}
resource "aws_autoscaling_group" "as_laptop" {
    Name =  "${var.project}-as-laptop"
    desired_capacity   = 2
    max_size           = 4
    min_size           = 2
    launch_configuration = aws_launch_configuration.lc-laptop.name
    vpc_zone_identifier = [var.subnet1, var.subnet2]
    tags = {
        key = "Name"
        value = "${var.project}-laptop-app"
        propagate_at_launch = true  
    }
}
resource "aws_autoscaling_policy" "asg_policy_laptop" {
    name = "${var.project}-asg-policy-laptop"
    autoscaling_group_name = aws_autoscaling_group.as_laptop.name
    adjustment_type = "ChangeInCapacity"
    policy_type = "TargetTrackingScaling"
    target_tracking_configuration {
      predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
      }
      target_value = 50
    }
}
resource "aws_autoscaling_group" "as_mobile" {
    Name =  "${var.project}-as-mobile"
    desired_capacity   = 2
    max_size           = 4
    min_size           = 2
    launch_configuration = aws_launch_configuration.lc-mobile.name
    vpc_zone_identifier = [var.subnet1, var.subnet2]
    tags = {
        key = "Name"
        value = "${var.project}-mobile-app"
        propagate_at_launch = true  
    }
}
resource "aws_autoscaling_policy" "asg_policy_mobile" {
    name = "${var.project}-asg-policy-mobile"
    autoscaling_group_name = aws_autoscaling_group.as_mobile.name
    adjustment_type = "ChangeInCapacity"
    policy_type = "TargetTrackingScaling"
    target_tracking_configuration {
      predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
      }
      target_value = 50
    }
}








