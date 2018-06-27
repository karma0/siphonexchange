"""Load configuration for the application"""
import os
import hcl


CONFIG = {}  # type: dict

# Setup configuration
with open("config.hcl", 'r') as config_handle:
    CONFIG = hcl.load(config_handle)
    for service in CONFIG['api']['services']:

        service_name = service['name'].upper()

        # Find environment subscriptions
        for variable in os.environ.keys():
            priv_key = f"{service_name}_SUBSCRIPTION_PRIVATE"
            if variable == priv_key:
                msg_type = \
                    os.environ.get(f"{priv_key}_TYPE", "ws_trade_ticker")
                if "subscriptions" not in service:
                    service["subscriptions"] = {}
                service["subscriptions"][variable] = msg_type
