output "tg_home_arn" {
  value = aws_lb_target_group.tg-home.arn
}
output "tg_laptop_arn" {
  value = aws_lb_target_group.tg-laptop.arn
}
output "tg_mobile_arn" {
  value = aws_lb_target_group.tg-mobile.arn
}
output "lb_dns" {
    value = aws_lb.my_lb.dns_name
  }