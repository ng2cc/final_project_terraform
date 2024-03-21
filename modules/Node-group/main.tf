# Terraform을 사용하여 AWS에서 EKS 노드 그룹을 생성하는 것
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group

resource "aws_eks_node_group" "nodes_general" {

  cluster_name = var.EKS_CLUSTER_NAME
  # AWS에서 EKS 노드 그룹을 정의하는 Terraform 리소스를 시작
  # cluster_name은 노드 그룹이 속할 EKS 클러스터의 이름을 지정

  # Name of the EKS Node Group.
  node_group_name = "${var.EKS_CLUSTER_NAME}-NG"
  # node_group_name은 생성될 노드 그룹의 이름을 정의
  # (일반적으로 EKS 클러스터 이름에 "-NG"를 추가하여 노드 그룹의 이름을 생성)

  # Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group.
  node_role_arn = var.NODE_GROUP_ARN
  # node_role_arn은 노드 그룹이 사용할 IAM 역할의 ARN을 지정
  # var.NODE_GROUP_ARN은 변수로 정의되어 있으며, 해당 노드 그룹에 대한 IAM 역할의 ARN을 지정


  subnet_ids = [
    var.PRI_SUB_3_A_ID,
    var.PRI_SUB_4_B_ID
  ]
  # 노드 그룹이 속할 EC2 서브넷의 ID를 지정. 보통 프라이빗 서브넷이 지정함.


  # 아래는 노드그룹 크기, 인스턴스 타입, 디스크 크기 등의 설정. 노드 그룹의 IAM역할, 버전

  scaling_config {

    desired_size = 2


    max_size = 2


    min_size = 2
  }


  ami_type = "AL2_x86_64"


  capacity_type = "ON_DEMAND"


  disk_size = 20

  force_update_version = false

  instance_types = ["t3.small"]

  labels = {
    role = "${var.EKS_CLUSTER_NAME}-Node-group-role",
    name = "${var.EKS_CLUSTER_NAME}-NG"
  }


  version = "1.27"
}
