###EGRESS Rules###
resource "aws_security_group_rule" "egress_rules" {

  security_group_id = aws_security_group.this.id
  type              = "egress"

  cidr_blocks      = ["0.0.0.0/0"]
  description      = "Allow all outbound traffic"

  from_port = 0
  to_port   = 0
  protocol  = -1
}

###INGRESS Rules###
resource "aws_security_group_rule" "ingress_rules" {
  
  count = length(var.ingress_rules)

  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = [var.ingress_rules[count.index].cidr_block]
  description       = var.ingress_rules[count.index].description
  security_group_id = aws_security_group.this.id
}

#Attach EIP to first node only
###Elastic IP###
resource "aws_eip" "this" {
  count = 1
  instance = aws_instance.this[count.index].id
  vpc      = true
}

###EC2 Instances###
resource "aws_instance" "this" {
  
  count = 2

  ami                       = var.ami-id
  instance_type             = "m5.xlarge"
  vpc_security_group_ids    = [aws_security_group.this.id]
  subnet_id                 = var.ec2-subnet-id
  key_name                  = var.key-name

  tags = merge(
  {
    Name      = "node-${format("%02d", count.index+1)}"
  },
  var.tags
  )

  connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip
      private_key = file(var.key-path)
  }

  provisioner "file" {
    source      = "./scripts/script${format("%02d", count.index+1)}.sh"
    destination = "/tmp/script.sh"    
  }

}

resource "aws_security_group" "this" {

  name                   = var.sg-name
  description            = var.description
  vpc_id                 = var.vpc-id

  tags = merge(
    {
      "Name" = format("%s", var.sg-name)
    },
    var.tags,
  )
}
