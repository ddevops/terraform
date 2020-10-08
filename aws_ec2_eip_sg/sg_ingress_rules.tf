variable "ingress_rules" {
    description = "List of ingress rules to create by name"
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block = string
      description = string
    }))
    default     = [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "Accept http traffic from all"
        },
        {
          from_port   = 3306
          to_port     = 3306
          protocol    = "tcp"
          cidr_block  = "150.10.10.10/32"
          description = "Allow mysql access from web server."
        },
        {
          from_port   = 10000
          to_port     = 65535
          protocol    = "udp"
          cidr_block  = "0.0.0.0/0"
          description = "Allow UDP ports from 10000 to 65535 for all"
        }
    ]
}
