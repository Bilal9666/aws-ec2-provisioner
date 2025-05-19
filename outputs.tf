output "instance_public_ip" {
  description = "public ip"
  value       = aws_instance.my_ec2.public_ip
}

output "elastic_ip" {
  description = "Elastic ip assigned to the instance"
  value       = aws_eip.my_eip.public_ip
}

output "ebs_volume_id" {
  description = "Id of extra storage allotted"
  value       = aws_ebs_volume.extra_volume.id
}