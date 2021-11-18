output "s3_bucket_name" {
  value = aws_s3_bucket.flugel-s3-bucket.id
}
output "s3_bucket_region" {
  value = aws_s3_bucket.flugel-s3-bucket.region
}

output "instance_owner" {
  value = aws_instance.flugelInstance.tags
}
