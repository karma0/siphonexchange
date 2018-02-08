#!flask/bin/python
"""Main flask application"""

from flask import Flask
from flaskrun import flaskrun

from config import CONFIG
import runner


application = Flask(__name__)  # pylint: disable=invalid-name


@application.route('/', methods=['GET'])
def get_index():  # pylint: disable=missing-docstring
    return '{"Output":"Hello World"}'


@application.route('/', methods=['POST'])
def post_index():  # pylint: disable=missing-docstring
    return '{"Output":"Hello World"}'


if __name__ == '__main__':
    flaskrun(application)
    runner.main(config=CONFIG)
