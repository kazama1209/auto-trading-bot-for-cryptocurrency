# auto-trading-bot-for-cryptocurrency

仮想通貨自動売買BOT

## セットアップ

### 環境変数をセット

- bb_api.py内のAPI_KEY、SECRETのbybitのAPIキーとシークレットキーを記述。
- line_notify.py内のLINE_NOTIFY_TOKENにLINE Notifyのトークンを記述。

### Dockerコンテナを起動v

```
$ docker-compose up -d
```

### Dockerコンテナの中へ入る

```
$ docker exec -it python3 /bin/bash
```

### BOTを起動

```
$ cd opt
$ python start.py
```

成功すると、ターミナルに「Start trading」と表示されるとともにLINE通知が飛んでいく。

## デプロイ

今回はAmazonの「ECS」というサービスを使って本番稼働させる。各リソースはTerraformで構築。


### 初期化

```
$ cd terraform
$ terraform init
```

### 環境変数をセット

```
$ cp terraform.tfvars.sample terraform.tfvars
```

「terraform.tfvars」内に各環境変数をセット。

```
aws_access_key  = "AWSアクセスキー"
aws_secret_key  = "AWSシークレットキー"
key_name        = "キーペア名"
public_key_path = "公開鍵へのパス"
```

### 適用

```
$ terraform plan
```

BOTを動かすために必要なAWSリソース一式が作成されるので、後は「クラスター」→「タスク」→「新しいタスクの実行」を行えばOK。

### 後片付け

```
$ terraform destroy
```

不要になったら↑のコマンドを叩けば一発で全てのAWSリソースが削除される。
