#!flask/bin/python # pylint: disable=missing-docstring

import os
import json

from flask import Flask
from flaskrun import flaskrun


# Setup configuration
CONFIG = {}  # type: dict
with open("nombot-config.json") as config_handle:
    CONFIG = json.loads(config_handle.read())
    for service in CONFIG['api']['services']:

        # Configure the credentials
        service["credentials"] = {
            "apikey": os.environ.get(f"{service['name'].upper()}_APIKEY"),
            "secret": os.environ.get(f"{service['name'].upper()}_SECRET")
        }

        # Find environment subscriptions
        for variable in os.environ.keys():
            priv_key = f"{service['name'].upper()}_SUBSCRIPTION_PRIVATE"
            if variable == priv_key:
                msg_type = \
                    os.environ.get(f"{priv_key}_TYPE", "ws_trade_ticker")
                if "subscriptions" not in service:
                    service["subscriptions"] = {}
                service["subscriptions"][variable] = msg_type


APP = Flask(__name__)


@APP.route('/', methods=['GET'])
def get_index():  # pylint: disable=missing-docstring
    return '{"Output":"Hello World"}'


@APP.route('/', methods=['POST'])
def post_index():  # pylint: disable=missing-docstring
    return '{"Output":"Hello World"}'


if __name__ == '__main__':
    flaskrun(APP)
