resource "aws_instance" "terraform" {
    ami = "ami-0220d79f3f480ecf5"
    instance_type = "t3.micro"
    vpc_security_group_ids =  [aws_security_group.allow_all.id]
    tags = {
        Name = "terraform-1"
        Terraform = "true"
    }

   
    provisioner "local-exec"{
      command = "echo ${self.private_ip} > inventory"
      on_failure = continue
    }

    # provisioner "local-exec"{
    #   command = "echo Instance is destroyed"
    #   when = destroy
    # }
    provisioner "local-exec" {
      command = "${var.is_windows ? "cmd /C echo Instance is destroyed" : "echo Instance is destroyed"}"
    }

    connection {
      type        = "ssh"
      user        = "ec2-user"
      password    = "DevOps321"
      host        = self.public_ip
  }

    provisioner "remote-exec" {
      inline = [
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx"
    ]
  }
    
    provisioner "remote-exec" {
      inline = [
      "sudo systemctl start nginx",
      "echo 'sucessfully stopped nginx server' "
    ]
    when = destroy
  }

}

resource "aws_security_group" "allow_all" {
  name   = "allow-all"

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
    Name = "allow-all"
  }
  
}