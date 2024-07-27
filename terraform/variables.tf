variable "mumbai_azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "singapore_azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}

variable "domain_name" {
  type    = string
  default = "domain"
}

variable "subdomain_name" {
  type    = string
  default = "subdomain"
}
