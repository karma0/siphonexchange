#!/usr/bin/env python3

"""
Firehose example
"""
import time
import sys
import os

sys.path.append(os.path.join(os.path.dirname(__file__), "../strategies"))
import aws


def get_data():
    """Get a somewhat innocuous chunk of data"""
    return {"strategy": {"ccxt": {"data": {"time": time.time()}}}}


def main():
    """Main is the name"""
    hose = aws.Firehose('siphonexchange-stream')
    while True:
        data = get_data()
        print(f"DATA: {data}")
        hose.bind(data)


if __name__ == "__main__":
    main()
