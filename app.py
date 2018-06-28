"""Main flask application"""

from multiprocessing import Process

from flask import Flask

from flaskrun import flaskrun
from config import CONFIG
import runner

from strategies.aws import Firehose

app = Flask(__name__)  # pylint: disable=invalid-name


class Main:
    put_stream = Firehose('siphonexchange-stream')

    def __init__(self):
        self.bot = Process(target=runner.main, kwargs={
            'config': CONFIG,
            'strategies': [
                runner.Print(),
                self.put_stream
            ]
        })

    def status(self):
        return self.put_stream.status

    def start(self):
        self.bot.start()

    def stop(self):
        self.bot.join()


if __name__ == '__main__':
    bot = Main()

    @app.route('/')
    def get_index():  # pylint: disable=missing-docstring
        return f'{{"Status":"{bot.status()}"}}'

    bot.start()
    flaskrun(app)
    bot.stop()
