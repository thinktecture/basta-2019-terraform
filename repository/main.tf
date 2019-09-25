provider "github"{
    organization = "Thinktecture"
}

resource "github_repository" "demo_repo" {
    name = "basta-2019-terraform"
    description = "Sample code from Thorsten's talk about Terraform at BASTA!2029"
    private = false
}

output "clone_url" {
  value = "${github_repository.demo_repo.ssh_clone_url}"
}


