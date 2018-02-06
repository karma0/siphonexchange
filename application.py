#!flask/bin/python

import os

from flask import Flask
from flaskrun import flaskrun


if not os.path.isfile('config.json'):
    import boto3
    import botocore

    BUCKET = os.environ['CONF_BUCKET']
    KEY = os.environ['CONF_FILE']

    s3 = boto3.resource('s3')

    try:
        s3.Bucket(BUCKET).download_file(KEY, 'config.json')
    except botocore.exceptions.ClientError as err:
        if err.response['Error']['Code'] == '404':
            print("Object does not exist")
        else:
            raise


application = Flask(__name__)


@application.route('/', methods=['GET'])
def get():
    return '{"Output":"Hello World"}'


@application.route('/', methods=['POST'])
def post():
    return '{"Output":"Hello World"}'


if __name__ == '__main__':
    flaskrun(application)
