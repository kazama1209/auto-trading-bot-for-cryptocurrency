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
