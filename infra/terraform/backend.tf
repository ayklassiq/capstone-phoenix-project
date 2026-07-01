terraform {

  backend "s3" {

    bucket = "ayoade-phoenix-terraform-state"
    key    = "kubernetes/prod.tfstate"
    region = "us-west-1"

    dynamodb_table = "terraform-lock"

    encrypt = true

  }
}