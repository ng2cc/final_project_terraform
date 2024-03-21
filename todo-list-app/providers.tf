# Terraform 구성 파일의 시작 부분

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.REGION
}

# terraform 블록:
# terraform 블록은 Terraform 구성을 정의하는데 사용됩니다.
# required_providers 섹션은 이 파일에서 사용하는 제공자(Provider)를 명시합니다.
# 여기서는 AWS 제공자를 사용하고 있으며, 이는 AWS와 통합된 Terraform 리소스를 사용할 수 있도록 합니다.
# aws는 사용할 제공자의 이름이며, source 속성은 제공자의 소스를 지정합니다. 여기서는 "hashicorp/aws"로 지정되어 있으며,
# 이는 HashiCorp에서 제공하는 AWS 공식 Terraform 공급자입니다.
# version 속성은 사용할 제공자의 버전을 지정합니다. 여기서는 "4.67.0"으로 지정되어 있습니다.

# provider 블록:
# provider 블록은 Terraform이 사용할 제공자를 설정하는데 사용됩니다.
# 여기서는 AWS 제공자를 사용하고 있으며, aws는 사용할 제공자의 이름입니다.
# region 속성은 AWS 리전을 지정하는데 사용됩니다. 여기서는 사용자가 제공하는 var.REGION 변수에 따라 동적으로 설정됩니다.
# 이 코드는 AWS 제공자를 사용하여 Terraform이 AWS 인프라를 관리하도록 설정하고 있습니다. 특히 사용할 AWS 리전을
# 사용자가 제공하는 변수를 통해 동적으로 설정하고 있습니다.
