provider "aws" {
  region = "ca-central-1"
}


module "ec2_cluster" {
  source                 = "../modules/ec2"
  ami                    = var.ami
  ssh_key_name           = var.ssh_key_name
  instance_type          = var.instance_type
  #monitoring            = true
  myip                   = var.myip
  public_ip              = var.public_ip
  instance_count         = var.instance_count
}
