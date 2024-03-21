# Terraform에서 출력(output)을 정의하여 생성된 리소스의 속성을 사용자에게 제공
# 아래의 출력을 사용하면 Terraform 실행 후에 이러한 값들을 확인하고
# 다른 Terraform 모듈이나 외부 시스템에서 이러한 리소스들을 참조할 수 있다
# 구성 요소들 간의 의존성을 관리, 재사용 가능한 인프라스트럭처를 구축

output "EKS_CLUSTER_ROLE_ARN" {
  value = aws_iam_role.eks_cluster_role.arn
}
# 생성된 IAM 역할 중에서 eks_cluster_role이라는 이름의 역할의 ARN(Amazon Resource Name)을 반환
# EKS 클러스터를 관리하는 데 사용되는 IAM 역할의 ARN

output "NODE_GROUP_ROLE_ARN" {
  value = aws_iam_role.nodes_general.arn
}

#  생성된 IAM 역할 중에서 nodes_general이라는 이름의 역할의 ARN을 반환
