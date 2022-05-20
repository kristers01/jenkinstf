output "instance_public_ip" {
  value = ["${aws_instance.jenkinstask.public_ip}:8080"]
}
