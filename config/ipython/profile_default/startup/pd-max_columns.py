from __future__ import print_function

import pathlib

try:
    import pandas as pd

    pd.set_option("display.max_columns", None)
    print("\n-- pd.get_option('display.max_columns') = None")

except ImportError:
    print("\n-- Pandas not found - the pd.set_option will not be set")

filename = pathlib.Path(__file__).resolve()
print("-- See " + filename)
