output "s3_bucket_name" {
  value = aws_s3_bucket.flugel-s3-bucket.id
}
output "s3_bucket_region" {
  value = aws_s3_bucket.flugel-s3-bucket.region
}

output "instance_owner" {
  value = aws_instance.flugelInstance.tags.Owner
}

output "instance_name" {
  value = aws_instance.flugelInstance.tags.Name
}

output "instance_security_group" {
  value = aws_security_group.security_flugel_group.name
}
output "instance_id" {
  value = aws_instance.flugelInstance.id
}
