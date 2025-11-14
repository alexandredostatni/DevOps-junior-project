output "bucket_url" {
  value = "s3://${aws_s3_bucket.artefatos.bucket}"
}