"""Main flask application"""

from multiprocessing import Process

from flask import Flask

from flaskrun import flaskrun
from config import CONFIG
import runner

from strategies.aws import Firehose

app = Flask(__name__)  # pylint: disable=invalid-name


@app.route('/')
def get_index():  # pylint: disable=missing-docstring
    return f'{{"Status":"{PUT_STREAM.status}"}}'


PUT_STREAM = Firehose('siphonexchange-stream')


if __name__ == '__main__':
    BOT = Process(target=runner.main, kwargs={
        'config': CONFIG,
        'strategies': [
            runner.Print(),
            PUT_STREAM
        ]
    })

    BOT.start()
    flaskrun(app)
    BOT.join()
