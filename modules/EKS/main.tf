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
  #Kubernetes를 관리하는 AWS의 관리형 서비스로 버전이 따로 관리됨. 최적이 호환성을 위해 최신 버전 사용

  vpc_config {
    endpoint_private_access = false
    # 클러스터의 프라이빗 API 서버 엔드포인트를 사용할지 여부를 지정
    # 클러스터 내부에서 AWS 서비스에 대한 엔드포인트가 비공개로 접근 가능한지를 결정
    # false로 설정된 것은 클러스터 내부의 리소스가 AWS 서비스에 대한 엔드포인트에 직접 액세스할 수 없도록 하는 것
    # 클러스터 내부의 리소스는 클러스터 외부 리소스 또는 퍼블릭 엔드포인트를 통해만 AWS 서비스에 액세스할 수있다


    endpoint_public_access = true
    # 클러스터의 퍼블릭 API 서버 엔드포인트를 사용할지 여부를 지정
    # true로 설정된 것은 클러스터에 대한 퍼블릭 엔드포인트를 활성화하는 것으로, 클러스터를 외부에서도 액세스할 수 있도록하는것

    subnet_ids = [
      var.PUB_SUB_1_A_ID,
      var.PUB_SUB_2_B_ID,
      var.PRI_SUB_3_A_ID,
      var.PRI_SUB_4_B_ID,
      var.PRI_SUB_5_A_ID,
      var.PRI_SUB_6_B_ID
    ]
  }
  # 클러스터가 속할 서브넷들의 ID를 지정합니다. 최소한 두 개의 서로 다른 가용 영역에 속한 서브넷이여야함
  # endpoint_private_access: 불리언 값으로, 클러스터의 프라이빗 API 서버 엔드포인트를 사용할지 여부를 지정합니다. 이 값이 true로 설정되면 클러스터가 프라이빗 서브넷에 배치되어야 합니다. 기본값은 true입니다.
  # endpoint_public_access: 불리언 값으로, 클러스터의 퍼블릭 API 서버 엔드포인트를 사용할지 여부를 지정합니다. 이 값이 true로 설정되면 클러스터가 퍼블릭 서브넷에 배치되어야 합니다. 기본값은 true입니다.
  # subnet_ids: 클러스터가 속할 서브넷들의 ID를 리스트 형태로 지정합니다. 클러스터 노드가 배치될 서브넷을 지정하는 것이며, 최소한 두 개의 서로 다른 가용 영역에 속한 서브넷이어야 합니다. 이는 고가용성 및 장애 허용성을 확보하기 위한 것입니다.
  # 이렇게 설정된 VPC 구성은 AWS EKS 클러스터가 사용할 네트워킹 환경을 정의합니다. 클러스터가 프라이빗 또는 퍼블릭 서브넷에 배치되는지 여부와, 클러스터 노드가 어떤 서브넷에 배치될지를 결정하는 중요한 구성입니다.
}
