# 使い方

## リソースを展開

1. 各Providerをインストール `terraform init`
2. `example.tfvars` をコピーして編集

```
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

3. リソースをデプロイ `terraform apply -var-file=<2.で編集したtfvarsファイル名>`

## リソースを破棄

`terraform destroy -var-file=<2.で編集したtfvarsファイル名>`
