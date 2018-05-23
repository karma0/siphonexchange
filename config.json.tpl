{
  "api": {
    "ratelimit": 1,

    "calls": {
      "accounts": {
        "delay": 3,
        "priority": 1,
        "arguments": null
      },

	  "all": {
		"delay": 1,
		"priority": 1,
		"arguments": {
		  "exchange_code": "BTRX",
		  "exchange_market": "BTC/USDT",
		  "type": "all"
		}
	  }

    },

    "services": [

      {
        "name": "coinigy",

        "credentials": {
          {{with secret "/secret/marketex/3rdparty/api/coinigy/v1/credentials" }}
          "apikey": "{{ .Data.apikey }}",
          "secret": "{{ .Data.secret }}"
          {{end}}
        },

        "subscriptions": {
          {{with secret "/secret/marketex/3rdparty/api/coinigy/v1/subscriptions" }}
          "{{ .Data.ws_trade_ticker }}": "ws_trade_ticker",
          {{end}}
          "TICKER": "ticker"
        },

        "exchanges": [
          "BITS",
          "BTRX",
          "KRKN",
          "PLNX"
        ],

        "endpoints": {
          {{with secret "/secret/marketex/3rdparty/api/coinigy/v1/endpoints" }}
          "rest": "{{ .Data.rest }}",
          "websocket": "{{ .Data.websocket }}"
          {{end}}
        }

      }

    ]
  },

  "logger": {
    "level": "WARNING",
    "modules": {
      "test": {
        "level": "WARNING"
      },
      "api": {
        "level": "WARNING"
      },
      "coinigy": {
        "level": "WARNING"
      }
    }
  },

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
