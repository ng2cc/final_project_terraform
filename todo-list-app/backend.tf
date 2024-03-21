terraform {
  backend "s3" {
    bucket         = "swordbillz"
    key            = "backend/App-eks.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "dynamoDB-state"
    encrypt        = true # 추가: 상태 파일 암호화 활성화
  }
}
