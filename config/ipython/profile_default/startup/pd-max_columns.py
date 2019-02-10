from __future__ import print_function
import sys, os

try:
    import pandas as pd

    pd.set_option("display.max_columns", None)
    print("\n-- pd.get_option('display.max_columns') = None")

except ModuleNotFoundError:
    print("\n-- Pandas not found - the pd.set_option will not be set")

filename = os.path.abspath(__file__)
print("-- See " + filename)
