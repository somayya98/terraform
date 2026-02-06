resource "aws_instance" "terraform" {
    ami = "ami-0220d79f3f480ecf5"
    instance_type = "t3.micro"
    vpc_security_group_ids =  [aws_security_group.lifecycle.id]
    tags = {
        Name = "lifecycle"
        Terraform = "true"
    }
    # lifecycle {
    #   prevent_destroy = true
    # }
}

resource "aws_instance" "another" {
    ami = "ami-0220d79f3f480ecf5"
    instance_type = "t3.micro"
    tags = {
        Name = "another"
        Terraform = "true"
    }
    /* lifecycle{
      prevent_destroy = true
    } */
}

resource "aws_security_group" "lifecycle" {
  name   = "lifecycle_change"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "lifecycle"
  }
  lifecycle {
    create_before_destroy = true
  }
  
}