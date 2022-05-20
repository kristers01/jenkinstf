provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

resource "aws_instance" "jenkinstask" {
  depends_on             = [aws_security_group.jenkinstask-sg, aws_iam_instance_profile.ec2_profile]
  key_name               = "student"
  ami                    = "ami-0a8dc52684ee2fee2"
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  user_data              = file("script.sh")
  vpc_security_group_ids = [aws_security_group.jenkinstask-sg.id]
  tags = {
    Name = "JenkinsAWSTask"
  }
}