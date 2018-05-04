"""Load configuration for the application"""
import os
import json


CONFIG = {}  # type: dict

# Setup configuration
with open("config.json") as config_handle:
    CONFIG = json.loads(config_handle.read())
    for service in CONFIG['api']['services']:

        service_name = service['name'].upper()

        # Configure the credentials
        service["credentials"] = {
            "apikey": f"{service_name}_APIKEY",
            "secret": f"{service_name}_SECRET"
        }

        # Find environment subscriptions
        for variable in os.environ.keys():
            priv_key = f"{service_name}_SUBSCRIPTION_PRIVATE"
            if variable == priv_key:
                msg_type = \
                    os.environ.get(f"{priv_key}_TYPE", "ws_trade_ticker")
                if "subscriptions" not in service:
                    service["subscriptions"] = {}
                service["subscriptions"][variable] = msg_type
