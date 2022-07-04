
variable "exoscale_zone_default" {
  type    = string
  default = "ch-gva-2"
}

variable "company" {
  type    = string
  default = "azeroth"
}


variable "cidr" {
  description = "Specify the number of connection broker"
  type        = list(string)
  default     = ["84.73.160.44/32"]
}

