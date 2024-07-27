module "singapore-resources" {
  source = "./regional-resources"
  azs    = var.singapore_azs
  providers = {
    aws = aws.singapore
  }
}

module "mumbai-resources" {
  source = "./regional-resources"
  azs    = var.mumbai_azs
  providers = {
    aws = aws.mumbai
  }
}
