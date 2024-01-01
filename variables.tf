variable "cidr" {
  type        = list(string)
  description = "cidr block for instance"
}

variable "dns_hostnames" {
  type = bool
}

variable "dns_support" {
  type = bool
}
variable "subnet_cidr" {
  type        = list(string)
  description = "subnet cidr block for instance"
}
variable "map_ip" {
  type        = bool
  description = "map public ip on launch of subnet"
}
variable "availability-zones" {
  type        = list(string)
  description = "availbility zones"
}
variable "my_ip" {
  type        = list(string)
  description = "my public ip"
}
variable "ami" {
  type        = set(string)
  description = "owner ids"

}
variable "ami-filter" {
  type        = set(string)
  description = "name of amis"
}
variable "keypair" {
  type = string
}
variable "instance" {
  type        = string
  description = "instance type"
}