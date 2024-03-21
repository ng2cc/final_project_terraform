# terraform 코드로 AWS의 EKS 클러스터의 이름을 가져오는 변수를 정의하는 부분

output "EKS_CLUSTER_NAME" {
  value = aws_eks_cluster.eks.id
}

# Terraform의 출력(output) 블록
# aws_eks_cluster 리소스의 id 속성을 변수의 값으로 설정하고 있습니다. aws_eks_cluster는 EKS 클러스터를 생성하는 리소스이며,
# id는 해당 클러스터의 고유 식별자
# EKS 클러스터의 이름을 "EKS_CLUSTER_NAME"이라는 변수로 가져올 수 있다
# 이 코드는 Terraform이 실행되면서 AWS에 정의된 EKS 클러스터의 ID를 출력으로 제공하는 것입니다.
# 이를 통해 나중에 다른 Terraform 모듈에서 이 클러스터를 참조하거나 외부 시스템에서 필요한 경우 클러스터 ID를 사용할 수 있다
