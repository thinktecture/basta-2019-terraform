variable "environment_name" {
  type = "string"
  description = "unique environment name"
  default = "development"
}

variable "tags" {
    type = "map"
    default = {}
    description = "Add custom tags to your infrastructure"

}
