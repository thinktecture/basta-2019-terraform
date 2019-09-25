module "infrastructure" {
    source = "../infrastructure"
    environment_name = "development"
    tags = {
        live_demo = "true"
    }

}
