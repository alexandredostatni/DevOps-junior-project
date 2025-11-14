terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3  = "http://localhost:4566"
  }
}

resource "aws_s3_bucket" "artefatos" {
  bucket = var.bucket_name
}

resource "aws_s3_object" "app_zip" {
  bucket = aws_s3_bucket.artefatos.bucket
  key    = "app/latest.zip"
  source = "${path.module}/../../app.zip"  # será gerado no CI
}