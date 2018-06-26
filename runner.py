#!/usr/bin/env python3

"""
Trading bot
"""

try:
    import coloredlogs
    coloredlogs.install()
except ImportError:
    print("Use Python coloredlogs module for colored output")

from nombot.api.services.ccxt import CCXTApi
from nombot.app.builder import NomAppBuilder
from nombot.app.config import NomAppConf

from bors.app.strategy import Strategy
#from nombot.app.strategy import Strategy
from nombot.strategies.print import PrintResult


def main(strategies=None, apiclasses=None, config=None):
    """Main routine"""
    if strategies is None:
        strategies = [
            PrintResult(),
        ]
    if apiclasses is None:
        apiclasses = [CCXTApi]

    # Roll out pipeline
    strat = Strategy(*strategies)
    conf = NomAppConf(config)
    impl = NomAppBuilder(apiclasses, strat, conf)

    # Run
    impl.run()


if __name__ == "__main__":
    main()
