# Terraform의 백엔드를 S3로 설정하는 코드
terraform {
  backend "s3" {
    bucket         = "swordbillz"
    key            = "backend/App-eks.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "dynamoDB-state"
    encrypt        = true # 추가: 상태 파일 암호화 활성화
  }
}

# backend "s3": Terraform에게 백엔드로 S3를 사용할 것을 지시
# key: S3 버킷 내에서 .tfstate 파일이 저장될 키를 지정
# dynamodb_table: .tfstate 파일의 버전 관리와 동기화를 위한 DynamoDB 테이블의 이름을 지정

# Terraform은 .tfstate 파일을 사용하여 인프라의 현재 상태를 저장하고 관리합니다. 백엔드를 S3로 설정하면,
# .tfstate 파일을 S3 버킷에 저장하고 Terraform이 실행될 때마다 해당 파일을 읽어와 인프라를 구성
# S3를 백엔드로 사용하면 .tfstate 파일을 안전하게 저장하고, 여러 사용자가 동시에 Terraform을 실행할 때 동기화 문제를 방지할 수 있습니다.
