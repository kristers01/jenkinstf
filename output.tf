output "instance_public_ip" {
  //outputs quick connect ip for convenience
  value = ["${aws_instance.jenkinstask.public_ip}:8080"]
}
