terraform {
  backend "s3"{
    bucket = "terraform-bucket-11111"
    region = "us-east-1"
    key = "terraform.tfstate"
  }

    
}
provider "aws" {
    region = var.region
}
module "my_vpc_module" {
    source = "./modules/vpc"
    project = var.project           
    vpc_cidr = var.vpc_cidr
    env = var.environment
    pvt_sub_cidr = var.private_cidr 
    pub_sub_cidr =var.public_cidr 
}
resource "aws_security_group" "my_sg" {
  name = "${var.project}-sg"
  vpc_id = module.my_vpc_module.vpc_id
  description = "allow hppt and https service"
ingress {
    protocol = "tcp" 
    from_port = 80
    to_port = 80
    cidr_blocks =["0.0.0.0/0"]
     }
ingress {
    protocol = "tcp" 
    from_port = 443
    to_port = 443
    cidr_blocks =["0.0.0.0/0"]
     }
     
egress {
    protocol = "-1" 
    from_port = 0
    to_port = 0
    cidr_blocks =["0.0.0.0/0"]
 }
 depends_on = [ module.my_vpc_module ]

}

module "autoscaling_group_name" {
    source = "./modules/autoscaling"
    image_id = var.image_id
    instance_type = var.instance_type
    key_pair = var.key_pair
    project = var.project
    env = var.environment
    subnet1 = module.my_vpc_module.pvt_subnet_id
    subnet2 = module.my_vpc_module.pub_subnet_id
    sg_ids = [aws_security_group.my_sg.id]
}
module "loadbalancer" {
  source = "./modules/loadbalancer"
  project = var.project
  vpc_id = module.my_vpc_module.id
  sg_ids = aws_security_group.my_sg.id
  subnet_ids = [module.my_vpc_module.pvt_subnet_id, module.my_vpc_module.pub_subnet_id]
  env = var.environment
}
resource "aws_autoscaling_attachment" "asg_lb_attach_home" {
  autoscaling_group_name = module.auto_scaling_groups.asg-home-name
  lb_target_group_arn = aws_lb_target_group.test.arn
}
resource "aws_autoscaling_attachment" "asg_lb_attach_laptop"{
  autoscaling_group_name = module.auto_scaling_groups.asg-laptop-name
  lb_target_group_arn = aws_lb_target_group.test.arn
}
resource "aws_autoscaling_attachment" "asg_lb_attach_mobile"{
  autoscaling_group_name = module.auto_scaling_groups.asg-mobile-name
  lb_target_group_arn = aws_lb_target_group.test.arn
}