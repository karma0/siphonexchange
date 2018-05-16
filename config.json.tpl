{
  "api": {
    "ratelimit": 1,
    "calls": {
      "accounts": {
        "delay": 3,
        "priority": 1,
        "arguments": null
      }
    },
    "services": [
      {
        "name": "coinigy",
        "credentials": {
          {{with secret "/secret/marketex/3rdparty/api/credentials/coinigy" }}
          "apikey": "{{ .Data.apikey }}",
          "secret": "{{ .Data.secret }}"
          {{end}}
        },
        "subscriptions": {
          "TICKER": "ticker"
        },

        "exchanges": [
          "BTRX"
        ],

        "endpoints": {
          "rest": "https://api.coinigy.com/api/v1",
          "websocket": "wss://sc-02.coinigy.com/socketcluster/"
        }
      }
    ]
  },

  "logger": {
    "level": "INFO",
    "modules": {
      "test": {
        "level": "DEBUG"
      },
      "api": {
        "level": "DEBUG"
      },
      "coinigy": {
        "level": "DEBUG"
      }
    }
  },

  "currencies": [
    "BTC",
    "BTG",
    "DASH",
    "ETH",
    "LTC",
    "USDT",
    "XLM",
    "XMR",
    "XRP"
  ]

}
