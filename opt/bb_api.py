from pprint import pprint
import ccxt

API_KEY = ""
SECRET = ""

class BbApi:
    def __init__(self):
        self.bb_api = ccxt.bybit(
            {
                "apiKey": API_KEY,
                "secret": SECRET,
                "urls": {
                    "api": "https://api-testnet.bybit.com/" # testnet（デモ版）を使用する場合はこの記述が必要
                }
            }
        )
    
    # 保有中のポジションを取得
    def get_position(self, symbol):
        self.bb_api.load_markets()
        market = self.bb_api.market(symbol)

        return self.bb_api.v2_private_get_position_list({ "symbol": market["id"] })["result"]
    
    # 注文を作成する
    def create_order(self, symbol, order_type, side, amount):
        order = self.bb_api.create_order(
            symbol,     # 通貨ペア
            order_type, # 成行注文か指値注文か（market: 成行注文、limit: 指値注文）
            side,       # 買いか売りか（buy: 買い、sell: 売り）
            amount,     # 注文量（USD）
            { 
              "qty": amount
            }
        )

        return order
