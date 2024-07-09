# 概要

TerraformでAWSのリソースを管理するためのデモワークショップ

## 作成される主なリソース

| リソース | 説明 | モジュール |
| --- | --- | --- |
| VPC | CIDR `10.0.0.0/16` のVPCをデプロイ | [vpc.tf](vpc.tf) |
| Subnet | 各AZにPublic Subnet, Private Subnetをデプロイ | [subnet.tf](subnet.tf) |
| Security Group | EC2にアタッチするSecurity Group | [security_group.tf](security_group.tf) |
| AMI | Windows, LinuxのAMI | [ami.tf](ami.tf) |
| Keypair | Windows, LinuxそれぞれのPublic key / Private keyを作成 | [keypair.tf](keypair.tf) |
| EC2 | WindowsおよびNode.js用Linuxインスタンス | [ec2_windows.tf](ec2_windows.tf), [ec2_nodejs.tf](ec2_nodejs.tf) |

### トポロジー

![VPCトポロジー](../images/aws_vpc_topology.png)

# 使い方

## 事前準備

### 1. AWSコンソールでユーザー作成

#### 1-1. IAM Userを作成（コンソールへのログインは不要）

![IAM Userを作成](../images/aws_iam_user_1.png)

#### 1-2. 権限に `AmazonEC2FullAccess` と `AmazonVPCFullAccess` ポリシーを設定

![AmazonEC2FullAccessポリシーを設定](../images/aws_iam_user_2.png)  
![AmazonVPCFullAccessポリシーを設定](../images/aws_iam_user_3.png)

#### 1-3. 設定を確認（必要に応じてタグを追加）

![設定を確認](../images/aws_iam_user_4.png)

#### 1-4. Access KeyとSecret Keyを作成

![Access KeyとSecret Keyを作成](../images/aws_iam_user_5.png)

#### 1-5. ユースケースは `Thrid-party service` を選択

![`Thrid-party service`　を選択](../images/aws_iam_user_6.png)

#### 1-6. 生成されたAccess KeyとSecret Keyを控えておく（Secret Keyは2度と表示されないので要注意）

![Access KeyとSecret Keyをコピー](../images/aws_iam_user_7.png)

## リソースを展開

### 1. Providerをインストール

```bash
terraform init
```

### 2. 変数ファイルを編集

```bash
cp -p example.tfvars my_variables.tfvars
vim my_variables.tfvars
```

#### my_variables.tfvars

```hcl
# Provider settings
region     = "ap-northeast-1". # 東京リージョン
access_key = "AKI*****************"  # AWS Console AMIでユーザー作成してキー発行
secret_key = "****************************************"  # AWS Console AMIでユーザー作成してキー発行

# Common Settings
prefix        = "kikeyama"  # EC2インスタンス等につける任意の名前prefix
email         = "kikeyama@example.com"  # 自分のメアド（タグに入れるだけ）

# Instance settings
key_name      = "kikeyama-terraform-workshop-key"  # SSH鍵の名前
key_file_path = "/Users/kikeyama/aws"  # SSH鍵の格納フォルダ
home_cidr     = "123.45.6.78/32"  # whatismyip.comで確認
```

### 3. リソースをデプロイ 

```
terraform apply -var-file=<2.で編集したtfvarsファイル名>
```

## リソースを破棄

```bash
terraform destroy -var-file=<2.で編集したtfvarsファイル名>
```
