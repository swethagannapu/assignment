variable "vpc_cidr" {
  default = "172.16.0.0/16"
}
variable "subnet_cidr" {
  default = "172.16.10.0/24"
}
variable "ami" {
}
variable "instance_type" {
}
variable "ssh_key_name" {
}
variable "myip" {
}
variable "public_ip" {
}

variable "instance_count" {
}
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = ["${aws_instance.ledn[0].id}"]
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = ["${aws_instance.ledn[0].public_ip}"]
}

data "template_file" "user_data" {
  template = "${file("../files/proxy_userdata.sh")}"
}