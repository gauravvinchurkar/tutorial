output "asg-home-name"{
    value = aws_autoscaling_group.as_home.name
}
output "asg-laptop-name"{
    value = aws_autoscaling_group.as_laptop.name
}
output "asg-mobile-name"{
    value = aws_autoscaling_group.as_mobile.name
}