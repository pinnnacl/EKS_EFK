output "security_group_id" {
  value = aws_security_group.eks_sg.id
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}
