output "pvt_subnet_id" {
    value = aws.subnet.pvt_subnet_id
}
output "pub_subnet_id" {
    value = aws.subnet.pub_subnet_id
}
output "vpc_id" {
    value = aws_vpc.my_vpc.id
}