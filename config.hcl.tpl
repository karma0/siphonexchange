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

      "credentials" {
        {{with secret "/secret/marketex/3rdparty/api/bittrex/credentials" }}
        "name" = "bittrex"
        "apiKey" = "{{ .Data.apikey }}"
        "secret" = "{{ .Data.secret }}"
        {{end}}
      }

      {{ range ls "marketex/exchanges" }}
      exchanges = {{ .Key }}
      {{ end }}

      {{ range ls "marketex/currencies" }}
      currencies = {{ .Key }}
      {{ end }}

    }
  ]
}

log_level = "WARNING"
