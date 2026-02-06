resource "aws_instance" "demo" {
  instance_type = "t3.micro"
  ami           = "ami-0220d79f3f480ecf5"
  vpc_security_group_ids = [
    "sg-0c77ef860ebe561f0"
  ]
  tags = {
    Name = "import-demo-change"
  }
}
