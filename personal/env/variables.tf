variable "ami" {
  default = "ami-0801628222e2e96d6"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "ssh_key_name" {
  default = "ledn"
}
variable "myip" {
    default = "69.158.118.66/32"
}
variable "public_ip" {
  default = "true"
}
variable "instance_count" {
  default = 1
}