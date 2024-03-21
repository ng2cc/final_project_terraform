# EKS 클러스터 설정을 제어하고 필요한 정보를 제공하기 위해 사용
# 아래 변수들은 Terraform 모듈을 사용하여 EKS 클러스터를 배포할 때 사용

variable "EKS_CLUSTER_ROLE_ARN" {}
# EKS 클러스터를 생성할 때 필요한 클러스터 역할의 Amazon Resource Name(ARN)을 제공합니다.
# 이 역할은 클러스터가 AWS 서비스와 상호 작용할 수 있는 권한을 부여

variable "PUB_SUB_1_A_ID" {}
variable "PUB_SUB_2_B_ID" {}
variable "PRI_SUB_3_A_ID" {}
variable "PRI_SUB_4_B_ID" {}
# 클러스터의 노드가 배치되는 네트워크 환경을 정의

variable "PROJECT_NAME" {}
# 이름은 Terraform 모듈 내에서 사용되어 리소스들을 구분하거나 태그 지정하는 데 사용
