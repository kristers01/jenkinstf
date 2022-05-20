resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_instanceprofile"
  role = aws_iam_role.ec2_role.name
}
resource "aws_iam_role" "ec2_role" {
  name = "ec2_assumerole"

  assume_role_policy = file("ec2-assume.json")

  inline_policy {
    //gives full access to s3, ecr, ec2
    name   = "ec2_policy"
    policy = file("ec2-policy.json")
  }
}
