output "pvt_subnet_id" {
    value = aws_subnet.pvt_subnet
}
output "pub_subnet_id" {
    value = aws_subnet.pub_subnet
}
output "vpc_id" {
    value = aws_vpc.my_vpc.id
}