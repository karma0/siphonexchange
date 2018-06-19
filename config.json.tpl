{
  "api": {

    "calls": {

      "fetchOrderBook": {
        "delay": 1,
      },

      "fetchTickers": {
        "delay": 5
      },

      "fetchTrades": {
        "delay": 3
      }

    },

    "services": [

      {
        "name": "ccxt",

        "credentials": {
          {{with secret "/secret/marketex/3rdparty/api/bittrex/v1/credentials" }}
          "name": "bittrex",
          "apiKey": "{{ .Data.apikey }}",
          "secret": "{{ .Data.secret }}"
          {{end}}
        },

        "subscriptions": {
        },

        "exchanges": [
          "bitstamp",
          "bittrex",
          "cex",
          "kraken",
          "poloniex"
        ],

        "currencies": [
	        "AEON",
          "BCH",
          "BTC",
          "BTG",
          "DASH",
          "DOGE",
          "DOPE",
          "ETC",
          "ETH",
          "LTC",
          "NXT",
          "STR",
          "USD",
          "USDT",
          "XBT",
          "XDG",
          "XLM",
          "XMR",
          "XRP",
          "ZEC"
        ]

      }

    ]
  },

  "log_level": "WARNING"

}
