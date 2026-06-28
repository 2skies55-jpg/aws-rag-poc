output "instance_id" {
  value = aws_instance.rag_server.id
}

output "public_ip" {
  value = aws_instance.rag_server.public_ip
}