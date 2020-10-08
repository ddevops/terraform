output "security_group_id" {
  description = "The ID of the security group"
  value = aws_security_group.this.id
}

output "public_ip" {
  description = "EC2 public IP"
  value = aws_instance.this.*.public_ip
  }

output "private_ip" {
  description = "EC2 private IP"
  value = aws_instance.this.*.private_ip
  }

output "instance_id" {
  description = "EC2 instance ID"
  value = aws_instance.this.*.id
  }

 output "elastic_ip" {
   description = "Elastic IP"
   value = aws_eip.this[0].public_ip
 }

 output "elastic_ip_id" {
   description = "Elastic IP allocation ID"
   value = aws_eip.this[0].id
 }