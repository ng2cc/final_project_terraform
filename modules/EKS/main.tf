# Terraform을 사용하여 AWS EKS 클러스터를 설정하는 구성
#  리소스 간의 의존성을 설정하는 데 사용됨
# IAM 역할의 권한이 EKS 클러스터 설정 이전에 생성되고, EKS 클러스터가 삭제되기 전에 삭제되어야 한다는 것을 보장하기 위해 사용
# (클러스터의 이름, IAM 역할, VPC 구성 및 네트워크 설정 등을 정의하여 클러스터를 설정하는 데 사용)



resource "aws_eks_cluster" "eks" {
  name = var.PROJECT_NAME
  # aws_eks_cluster 리소스는 AWS EKS 클러스터를 생성
  # name 속성은 클러스터의 이름을 지정합니다. 여기서는 변수 var.PROJECT_NAME으로 설정

  role_arn = var.EKS_CLUSTER_ROLE_ARN
  # role_arn 속성은 EKS 클러스터를 관리하는 데 사용되는 IAM 역할의 Amazon 리소스 이름(ARN)을 지정
  # 역할은 EKS 제어 평면이 AWS API 작업을 수행할 수 있도록 권한을 부여

  version = "1.27"

  vpc_config {
    endpoint_private_access = false
    # 클러스터의 프라이빗 API 서버 엔드포인트를 사용할지 여부를 지정

    endpoint_public_access = true
    # 클러스터의 퍼블릭 API 서버 엔드포인트를 사용할지 여부를 지정

    subnet_ids = [
      var.PUB_SUB_1_A_ID,
      var.PUB_SUB_2_B_ID,
      var.PRI_SUB_3_A_ID,
      var.PRI_SUB_4_B_ID
    ]
  }
  # 클러스터가 속할 서브넷들의 ID를 지정합니다. 최소한 두 개의 서로 다른 가용 영역에 속한 서브넷이여야함

}
