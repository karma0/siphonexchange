api "calls" {

  "fetchOrderBook" {
    "delay" = 1
  }

  "fetchTickers" {
    "delay" = 5
  }

  "fetchTrades" {
    "delay" = 3
  }
}

api {
  "services" = [
    {
      "name" = "ccxt"

      /*  This needs to get broken out...
      "credentials" {
        {{with secret "/secret/marketex/3rdparty/api/bittrex/credentials" }}
        "name" = "bittrex"
        "apiKey" = "{{ .Data.apikey }}"
        "secret" = "{{ .Data.secret }}"
        {{end}}
      }
      */

      {{ range ls "marketex/exchanges" }}
      exchanges = {{ .Key }}
      {{ end }}

      {{ range ls "marketex/currencies" }}
      currencies = {{ .Key }}
      {{ end }}

      /*
      exchanges = "bitstamp"
      exchanges = "bittrex"
      exchanges = "cex"
      exchanges = "kraken"
      exchanges = "poloniex"

      currencies = "AEON"
      currencies = "BCH"
      currencies = "BTC"
      currencies = "BTG"
      currencies = "DASH"
      currencies = "DOGE"
      currencies = "DOPE"
      currencies = "ETC"
      currencies = "ETH"
      currencies = "LTC"
      currencies = "NXT"
      currencies = "STR"
      currencies = "USD"
      currencies = "USDT"
      currencies = "XBT"
      currencies = "XDG"
      currencies = "XLM"
      currencies = "XMR"
      currencies = "XRP"
      currencies = "ZEC"
      */
    }

  ]
}

log_level = "WARNING"
