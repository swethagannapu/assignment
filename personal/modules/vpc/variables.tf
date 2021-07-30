variable "vpc_cidr" {
}
variable "subnet_cidr" {
}

output "subnet-id" {
    value = aws_subnet.ledn_subnet.id
}

output "vpc-id" {
    value = aws_vpc.ledn_vpc.id
}
