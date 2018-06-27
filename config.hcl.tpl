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
      name = "ccxt"

      {{range secrets "/secret/marketex/3rdparty/api" }}
        {{ $svc := . }}
        {{with secret (printf "/secret/marketex/3rdparty/api/%s%s" . "credentials") }}
      credentials = {
        name = "{{ $svc | split "/" | join "" }}"
        apiKey = "{{ .Data.apikey }}"
        secret = "{{ .Data.secret }}"
      }
        {{end}}
      {{end}}

      {{ range ls "marketex/exchanges" }}
      exchanges = "{{ .Key }}"
      {{ end }}

      {{ range ls "marketex/currencies" }}
      currencies = "{{ .Key }}"
      {{ end }}
    }

  ]
}

log_level = "WARNING"
