resource "aws_security_group" "node_group_one" {
  name_prefix = "node_group_one"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 31000
    to_port   = 31000
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}
