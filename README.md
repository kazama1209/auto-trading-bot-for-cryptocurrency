# auto-trading-bot-for-cryptocurrency

仮想通貨自動売買BOT

## セットアップ

- bb_api.py内のAPI_KEY、SECRETのbybitのAPIキーとシークレットキーを記述
- line_notify.py内のLINE_NOTIFY_TOKENにLINE Notifyのトークンを記述

## Dockerコンテナを起動

```
$ docker-compose up -d
```

## Dockerコンテナの中へ入る

```
$ docker exec -it python3 /bin/bash
```

## BOTを起動

```
$ cd opt
$ python start.py
```
