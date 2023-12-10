variable "project" {
  default = "mini-project"
}
variable "region" {
  default = "ap-southeast-1"
}
variable "vpc_cidr" {
  default = "10.10.0.0/16"
}
variable "environment" {
  default = "dev"
}
variable "private_cidr" {
  default = "10.10.0.0/16"
}
variable "public_cidr" {
  default = "10.10.16.0/16"
}
variable "count" {
  default = 2
}
variable "image_id" {
  default = ""
}
variable "instance_type" {
  default = "t2.micro"
}
variable "key_pair" {
    default = "linuxkey"
  
}