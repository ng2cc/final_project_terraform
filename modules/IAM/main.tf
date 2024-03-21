# Terraform을 사용하여 AWS에서 EKS 클러스터 및 노드 그룹에 필요한 IAM역할 및 정책을 설정


# Amazon EKS 클러스터를 관리하기 위한 IAM 역할을 정의
# eks.amazonaws.com 서비스에 의해 사용될 수 있도록 설정됩니다.
# 이 역할은 Amazon EKS가 AWS 리소스에 액세스하고 Kubernetes 클러스터를 생성하는 데 필요한 권한을 제공
resource "aws_iam_role" "eks_cluster_role" {
  # The name of the role
  name = "${var.PROJECT_NAME}-EKS-role" #terraform.tfvars->PROJECT_NAME = "App-EKS"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


# 앞서 생성한 IAM 역할에 AmazonEKSClusterPolicy라는 AWS 관리 정책을 연결
# 이 정책은 Amazon EKS 클러스터에 필요한 권한을 부여

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  # The role the policy should be applied to
  role = aws_iam_role.eks_cluster_role.name
}


# 앞서 생성한 IAM 역할에 Elastic Load Balancing 서비스에
# 대한 완전한 액세스 권한을 부여하는 정책을 연결
resource "aws_iam_role_policy_attachment" "elastic_load_balancing_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
  role       = aws_iam_role.eks_cluster_role.name
}


# 하위 나머지 코드 부분은 EKS 노드 그룹에 필요한 IAM 역할과 정책을 정의하고, 해당 역할에 정책을 연결하는데 사용됩니다.
# 이러한 정책은 EKS 노드 그룹이 필요한 권한을 갖도록 합니다.

# Create IAM role for EKS Node Group
resource "aws_iam_role" "nodes_general" {
  # The name of the role
  name = "${var.PROJECT_NAME}-Node-group-role"

  # The policy that grants an entity permission to assume the role.
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }, 
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


# Resource: aws_iam_role_policy_attachment
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {
  # The ARN of the policy you want to apply.
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSWorkerNodePolicy
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

  # The role the policy should be applied to
  role = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
  # The ARN of the policy you want to apply.
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKS_CNI_Policy
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  # The role the policy should be applied to
  role = aws_iam_role.nodes_general.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  # The ARN of the policy you want to apply.
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEC2ContainerRegistryReadOnly
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  # The role the policy should be applied to
  role = aws_iam_role.nodes_general.name
}



