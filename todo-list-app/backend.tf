# # Terraform의 백엔드를 S3로 설정하는 코드
# terraform {
#   backend "s3" {
#     bucket         = "swordbillz"
#     key            = "backend/App-eks.tfstate"
#     region         = "ap-northeast-1"
#     dynamodb_table = "dynamoDB-state"
#     encrypt        = true # 추가: 상태 파일 암호화 활성화
#   }
# }

# backend "s3": Terraform에게 백엔드로 S3를 사용할 것을 지시
# key: S3 버킷 내에서 .tfstate 파일이 저장될 키를 지정
# dynamodb_table: .tfstate 파일의 버전 관리와 동기화를 위한 DynamoDB 테이블의 이름을 지정

#위의 코드는 Terraform에서 사용하는 상태 파일인 .tfstate 파일을 지정된 AWS S3 버킷에 저장하고 있습니다. 이 상태 파일은 Terraform이 관리하는 인프라 리소스의 현재 상태를 추적하는 데 사용됩니다. 이것은 특히 여러 사용자 또는 여러 팀이 동시에 Terraform을 사용하여 인프라를 관리할 때 중요합니다.
#상태 파일은 Terraform 실행 중에 업데이트되며, 이 파일에는 생성된 리소스의 정보 및 Terraform이 추적하는 상태가 포함됩니다. 이 파일은 기본적으로 로컬 디스크에 저장되지만, 위의 코드에서와 같이 AWS S3와 같은 원격 백엔드에 저장할 수도 있습니다.
#그러나 여러 사용자가 동시에 Terraform을 사용할 때 상태 파일의 동시성 문제가 발생할 수 있습니다. 예를 들어, 한 사용자가 리소스를 생성하거나 수정하는 동안 다른 사용자가 동일한 리소스를 동시에 수정하려고 할 때 충돌이 발생할 수 있습니다. 이를 방지하기 위해 Terraform은 동시성 제어를 위한 옵션을 제공합니다.
#여기서 DynamoDB를 사용하는 것은 이러한 동시성 문제를 해결하기 위한 것입니다. 위의 코드에서 dynamodb_table 매개변수를 사용하여 DynamoDB 테이블을 지정하고 있습니다. 이 테이블은 Terraform 상태 파일의 락(lock)을 관리하는 데 사용됩니다.
#Terraform은 상태를 변경하기 전에 해당 상태 파일에 대한 락을 DynamoDB 테이블에 걸어 다른 사용자가 동시에 상태를 변경하지 못하도록 합니다. 이를 통해 여러 사용자가 동시에 Terraform을 실행할 때 상태 파일에 대한 충돌이 발생하는 것을 방지할 수 있습니다. 따라서 동시 실행 시 동기화 문제를 방지하여 인프라의 일관성과 안정성을 유지할 수 있습니다.
