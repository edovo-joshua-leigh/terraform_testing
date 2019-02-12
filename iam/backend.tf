provider "aws" {
  region = "us-east-2"
  profile = "edovo-ops"
}

terraform {
  backend "s3" {
    bucket            = "edovo-ops-terraform-test"
    encrypt           = "true"
    region            = "us-east-2"
    key               = "edovo-ops/iam/terraform.tfstate"
    profile           = "edovo-ops"
  }
}
