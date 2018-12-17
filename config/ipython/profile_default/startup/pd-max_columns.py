import os

print()
try:
    import pandas as pd

    pd.set_option("display.max_columns", None)
    print(
        "-- pd.get_option('display.max_columns') = "
        f"{pd.get_option('display.max_columns')}"
    )
except ModuleNotFoundError:
    print("-- Pandas not found - the pd.set_option will not be set")

print(f"-- See {os.path.abspath(__file__)}")
