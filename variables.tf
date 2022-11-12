variable "region" {
  description = "region to provision resources"
  type = string
  default = "ap-southeast-1"
}

variable "project_name" {
  description = "tag resources with project name for identify"
  type = string
}
