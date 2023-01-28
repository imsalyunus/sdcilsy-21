terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.52.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
  shared_credentials_files = ["~/.aws/creds"]
}