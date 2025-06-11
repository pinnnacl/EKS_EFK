output "bastion_instance_id" {
  value = aws_instance.ec2.id
}

output "bastion_public_ip" {
  value = aws_instance.ec2.public_ip
}
