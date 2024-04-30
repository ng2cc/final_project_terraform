# Terraform을 사용하여 Amazon EKS 클러스터를 프로비저닝
# 모듈을 사용하여 EKS 클러스터를 구성하는 리소스를 생성하고 설정

# creating VPC
module "VPC" {
  source           = "../modules/vpc"
  REGION           = var.REGION
  PROJECT_NAME     = var.PROJECT_NAME
  VPC_CIDR         = var.VPC_CIDR
  PUB_SUB_1_A_CIDR = var.PUB_SUB_1_A_CIDR
  PUB_SUB_2_B_CIDR = var.PUB_SUB_2_B_CIDR
  PRI_SUB_3_A_CIDR = var.PRI_SUB_3_A_CIDR
  PRI_SUB_4_B_CIDR = var.PRI_SUB_4_B_CIDR
  PRI_SUB_5_A_CIDR = var.PRI_SUB_5_A_CIDR
  PRI_SUB_6_B_CIDR = var.PRI_SUB_6_B_CIDR
  PRI_SUB_7_A_CIDR = var.PRI_SUB_7_A_CIDR
  PRI_SUB_8_B_CIDR = var.PRI_SUB_8_B_CIDR
}

# cretea NAT-NAT-GW
module "NAT-GW" {
  source = "../modules/nat-gw"

  PUB_SUB_1_A_ID = module.VPC.PUB_SUB_1_A_ID
  IGW_ID         = module.VPC.IGW_ID
  PUB_SUB_2_B_ID = module.VPC.PUB_SUB_2_B_ID
  VPC_ID         = module.VPC.VPC_ID
  PRI_SUB_3_A_ID = module.VPC.PRI_SUB_3_A_ID
  PRI_SUB_4_B_ID = module.VPC.PRI_SUB_4_B_ID
  PRI_SUB_5_A_ID = module.VPC.PRI_SUB_5_A_ID
  PRI_SUB_6_B_ID = module.VPC.PRI_SUB_6_B_ID
  PRI_SUB_7_A_ID = module.VPC.PRI_SUB_7_A_ID
  PRI_SUB_8_B_ID = module.VPC.PRI_SUB_8_B_ID

}


module "IAM" {
  source       = "../modules/IAM"
  PROJECT_NAME = var.PROJECT_NAME
}

module "EKS" {
  source               = "../modules/EKS"
  PROJECT_NAME         = var.PROJECT_NAME
  EKS_CLUSTER_ROLE_ARN = module.IAM.EKS_CLUSTER_ROLE_ARN
  PUB_SUB_1_A_ID       = module.VPC.PUB_SUB_1_A_ID
  PUB_SUB_2_B_ID       = module.VPC.PUB_SUB_2_B_ID
  PRI_SUB_3_A_ID       = module.VPC.PRI_SUB_3_A_ID
  PRI_SUB_4_B_ID       = module.VPC.PRI_SUB_4_B_ID
  PRI_SUB_5_A_ID       = module.VPC.PRI_SUB_5_A_ID
  PRI_SUB_6_B_ID       = module.VPC.PRI_SUB_6_B_ID
}


module "NODE_GROUP" {
  source           = "../modules/Node-group-1"
  EKS_CLUSTER_NAME = module.EKS.EKS_CLUSTER_NAME
  NODE_GROUP_ARN   = module.IAM.NODE_GROUP_ROLE_ARN
  PRI_SUB_3_A_ID   = module.VPC.PRI_SUB_3_A_ID
  PRI_SUB_4_B_ID   = module.VPC.PRI_SUB_4_B_ID
}

module "NODE_GROUP2" {
  source           = "../modules/Node-group-2"
  EKS_CLUSTER_NAME = module.EKS.EKS_CLUSTER_NAME
  NODE_GROUP_ARN   = module.IAM.NODE_GROUP_ROLE_ARN
  PRI_SUB_5_A_ID   = module.VPC.PRI_SUB_5_A_ID
  PRI_SUB_6_B_ID   = module.VPC.PRI_SUB_6_B_ID
}

