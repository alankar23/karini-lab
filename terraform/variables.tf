
variable "provider_config" {
  description = "provider details"
  type        = map(any)
  default = {
    region  = "ap-south-1"
    profile = "eks"
  }
}



data "aws_availability_zones" "current" {
  state = "available"
}
