

variable "EKS_CLUSTER_NAME" {}
#  EKS 클러스터의 이름을 정의
# 실제 AWS 계정에서 생성한 EKS 클러스터의 이름을 제공하여 해당 클러스터를 식별

variable "NODE_GROUP_ARN" {}
# 노드 그룹의 IAM 역할의 ARN을 정의
# 노드 그룹이 사용할 IAM 역할의 ARN을 제공하여 해당 역할에 필요한 권한을 부여

variable "PRI_SUB_5_A_ID" {}
variable "PRI_SUB_6_B_ID" {}
# 프라이빗 서브넷의 ID를 정의하는데 사용
# 노드 그룹이 배포될 프라이빗 서브넷의 ID를 제공
