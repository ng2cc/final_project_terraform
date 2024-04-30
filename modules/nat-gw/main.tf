# 아래 구성을 통해 퍼블릭 서브넷에서 인터넷에 액세스하고 프라이빗 서브넷에서 인터넷을 통해 외부와 통신할 수 있도록 구성함

# [리소스]
# aws_eip: Elastic IP (EIP)를 할당하는 리소스입니다. 두 개의 EIP가 생성되며, 각각 NAT 게이트웨이에 연결됩니다. 각 EIP는 고유한 태그를 가지고 있습니다.
# aws_nat_gateway: NAT 게이트웨이를 생성하는 리소스입니다. NAT 게이트웨이는 퍼블릭 서브넷에 생성됩니다. 각 NAT 게이트웨이는 해당하는 EIP와 연결되며, 인터넷 게이트웨이에 의존성이 있습니다.
# aws_route_table: 라우팅 테이블을 생성하는 리소스입니다. 각 라우팅 테이블은 프라이빗 서브넷을 위한 것이며, 해당하는 NAT 게이트웨이를 통해 인터넷에 액세스할 수 있도록 구성됩니다.
# aws_route_table_association: 서브넷과 라우팅 테이블을 연결하는 리소스입니다. 각각의 프라이빗 서브넷은 해당하는 라우팅 테이블과 연결되어야 합니다.

# [코드 흐름]
# 먼저, 두 개의 Elastic IP (EIP)가 생성되고 각각 NAT 게이트웨이에 할당됩니다.
# 그런 다음, 두 개의 NAT 게이트웨이가 각각의 퍼블릭 서브넷에 생성됩니다. 각 NAT 게이트웨이는 해당하는 EIP와 연결됩니다.
# 라우팅 테이블이 생성되고, 각각의 라우팅 테이블은 NAT 게이트웨이를 통한 인터넷 액세스를 허용하는 라우트가 추가됩니다.
# 각각의 프라이빗 서브넷이 해당하는 라우팅 테이블과 연결됩니다.


resource "aws_eip" "EIP-NAT-GW-A" {
  vpc = true

  tags = {
    Name = "NAT-GW-EIP-A"
  }
}




resource "aws_eip" "EIP-NAT-GW-B" {
  vpc = true

  tags = {
    Name = "NAT-GW-EIP-B"
  }
}



resource "aws_nat_gateway" "NAT-GW-A" {
  allocation_id = aws_eip.EIP-NAT-GW-A.id
  subnet_id     = var.PUB_SUB_1_A_ID

  tags = {
    Name = "NAT-GW-A"
  }


  depends_on = [var.IGW_ID]
}


resource "aws_nat_gateway" "NAT-GW-B" {
  allocation_id = aws_eip.EIP-NAT-GW-B.id
  subnet_id     = var.PUB_SUB_2_B_ID

  tags = {
    Name = "NAT-GW-B"
  }


  depends_on = [var.IGW_ID]
}



resource "aws_route_table" "Pri-RT-A" {
  vpc_id = var.VPC_ID

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT-GW-A.id
  }

  tags = {
    Name = "Pri-RT-A"
  }
}


resource "aws_route_table_association" "pri-sub-3-a-with-Pri-RT-A" {
  subnet_id      = var.PRI_SUB_3_A_ID
  route_table_id = aws_route_table.Pri-RT-A.id
}

resource "aws_route_table_association" "pri-sub-5-a-with-Pri-RT-A" {
  subnet_id      = var.PRI_SUB_5_A_ID
  route_table_id = aws_route_table.Pri-RT-A.id
}
resource "aws_route_table_association" "pri-sub-7-a-with-Pri-RT-A" {
  subnet_id      = var.PRI_SUB_7_A_ID
  route_table_id = aws_route_table.Pri-RT-A.id
}



resource "aws_route_table" "Pri-RT-B" {
  vpc_id = var.VPC_ID

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT-GW-B.id
  }

  tags = {
    Name = "Pri-RT-B"
  }
}


resource "aws_route_table_association" "pri-sub-4-b-with-Pri-RT-B" {
  subnet_id      = var.PRI_SUB_4_B_ID
  route_table_id = aws_route_table.Pri-RT-B.id
}

resource "aws_route_table_association" "pri-sub-6-B-with-Pri-RT-A" {
  subnet_id      = var.PRI_SUB_6_B_ID
  route_table_id = aws_route_table.Pri-RT-A.id
}

resource "aws_route_table_association" "pri-sub-8-B-with-Pri-RT-A" {
  subnet_id      = var.PRI_SUB_8_B_ID
  route_table_id = aws_route_table.Pri-RT-A.id
}
