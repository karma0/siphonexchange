"""
Simple AWS strategies
"""
import json

import boto3

from bors.app.strategy import IStrategy


def serialize(data):
    """Serialize the aforementioned data"""
    return json.dumps(data)


class Firehose(IStrategy):
    """
    Firehose strategy - puts data from the API onto an AWS firehose.

    Parameters:
        *apiname (optional) - Defaults to 'ccxt'. Used as the key under
            context["strategy"], data is the pulled from ['data'].
        *region (optional) - Region name of the AWS firehose. Default: us-east-1
    """
    def __init__(self, name, apiname='ccxt', region='us-east-1'):
        self.name = name
        self.apiname = apiname

        self.firehose = boto3.client('firehose', region_name=region)

        self.status = "OK"

    def bind(self, context):
        """
        Bind the strategy to the middleware pipeline,
        returning the context.
        """
        self.firehose.put_record(
            **self._parametize(context["strategy"][self.apiname]["data"]))
        return context

    def _parametize(self, data):
        return {
            "DeliveryStreamName": self.name,
            "Record": {
                "Data": serialize(data)
                }
            }
