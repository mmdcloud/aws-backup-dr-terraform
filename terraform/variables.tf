variable "mumbai_azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "singapore_azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["ap-southeast-1a", "ap-southeast-1b"]
}

variable "domain_name" {
  type    = string
  default = "domain"
}

variable "subdomain_name" {
  type    = string
  default = "subdomain"
}
