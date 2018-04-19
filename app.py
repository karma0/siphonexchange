#!flask/bin/python
"""Main flask application"""

from multiprocessing import Process

from flask import Flask
from flaskrun import flaskrun

from config import CONFIG
import runner

from strategies.aws import Firehose

application = Flask(__name__)  # pylint: disable=invalid-name


@application.route('/', methods=['GET'])
def get_index():  # pylint: disable=missing-docstring
    return f"""{"Status":"{PUT_STREAM.status}"}"""


@application.route('/', methods=['POST'])
def post_index():  # pylint: disable=missing-docstring
    return f"""{"Status":"{PUT_STREAM.status}"}"""

PUT_STREAM = Firehose('siphonexchange-stream')


if __name__ == '__main__':
    BOT = Process(target=runner.main, args={
        'config': CONFIG,
        'strategies': [
            runner.CoinigyStrategy(),
            runner.PrintResult(),
            PUT_STREAM
        ]
    })

    BOT.start()
    flaskrun(application)
    BOT.join()
