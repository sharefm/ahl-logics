terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }  
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.27.0"
    }
  }
  
}

provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "tf_ahl"
}
