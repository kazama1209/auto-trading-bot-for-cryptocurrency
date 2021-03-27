import pandas as pd
pd.options.display.float_format = '{:.2f}'.format #小数点以下2桁まで表示

import requests
import time
import sys
import traceback
from datetime import datetime
from bb_api import BbApi
from line_notify import LineNotify

# CryptoCompareからBTC/JPYのヒストリカルデータを取得しローソク足を生成
def get_candles(timeframe, limit):
    # timeframe（時間軸）には「minute（1分足）」「hour(1時間足)」「day(日足)」のいずれかが入る
    base_url = f"https://min-api.cryptocompare.com/data/histo{timeframe}"
    
    params = {
        "fsym": "BTC",  # 通貨名(The cryptocurrency symbol of interest)
        "tsym": "USD",  # 通貨名(The currency symbol to convert into)
        "limit": limit, # 取得件数(The number of data points to return)
    }

    res = requests.get(base_url, params, timeout = 10).json()

    time, open, high, low, close = [], [], [], [], []

    for i in res["Data"]:
        time.append(datetime.fromtimestamp(i["time"]))
        open.append(i["open"])
        high.append(i["high"])
        low.append(i["low"])
        close.append(i["close"])
    
    candles = pd.DataFrame({
            "Time": time,  # 時刻
            "Open": open,  # 始値
            "High": high,  # 高音
            "Low": low,    # 安値
            "Close": close # 終値
        }
    )
    
    return candles

# 単純移動平均線を算出
def make_sma(candles, span):
    return pd.Series(candles["Close"]).rolling(window = span).mean()

bb_api = BbApi()
symbol = "BTC/USD" # 通貨ペア
amount = 1         # 注文量(USD)

line_notify = LineNotify()
line_notify.send("Start trading")

print("Start trading")

# Botを起動
while True:
    try:
        candles = get_candles("minute", 1000).set_index("Time")
        sma_5 = make_sma(candles, 5) # 短期移動平均線を作成
        sma_13 = make_sma(candles, 13) # 長期移動平均線を作成

        # 短期移動平均線 > 長期移動平均線 の状態が3本続いたらゴールデンクロス（騙し防止のために判断まで少し待つ）
        golden_cross = sma_5.iloc[-1] > sma_13.iloc[-1] \
            and sma_5.iloc[-2] > sma_13.iloc[-2] \
            and sma_5.iloc[-3] > sma_13.iloc[-3] \
            and sma_5.iloc[-4] < sma_13.iloc[-4]

        # 短期移動平均線 < 長期移動平均線 の状態が3本続いたらデッドクロス（騙し防止のために判断まで少し待つ）
        dead_cross = sma_5.iloc[-1] < sma_13.iloc[-1] \
            and sma_5.iloc[-2] < sma_13.iloc[-2] \
            and sma_5.iloc[-3] < sma_13.iloc[-3] \
            and sma_5.iloc[-4] > sma_13.iloc[-4]

        position = bb_api.get_position(symbol)

        if position["side"] == "None": # 保有ポジションが無い場合は新規の注文準備に入る
            if golden_cross: # ノーポジかつゴールデンクロスが現れたら新規買い
                order = bb_api.create_order(symbol, "market", "buy", amount)
                price = order["price"]
                line_notify.send(f"Buy on the market {price}")

            elif dead_cross: # ノーポジかつデッドクロスが現れたら新規売り
                order = bb_api.create_order(symbol, "market", "sell", amount)
                price = order["price"]
                line_notify.send(f"Sell on the market {price}")

        elif position["side"] == "Buy" and dead_cross: # 買いポジション保有中かつデッドクロスが現れたらドテン売り
            order = bb_api.create_order(symbol, "market", "sell", amount * 2)
            price = order["price"]
            line_notify.send(f"Stop and sell reversely {price}")

        elif position["side"] == "Sell" and golden_cross: # 売りポジション保有中かつゴールデンクロスが現れたらドテン買い
            order = bb_api.create_order(symbol, "market", "buy", amount * 2)
            price = order["price"]
            line_notify.send(f"Stop and buy reversely {price}")
        
        time.sleep(30)
    except:
        line_notify.send(traceback.format_exc())
        sys.exit() # 何か例外が生じた際はLINE通知を飛ばしてBotを停止する
