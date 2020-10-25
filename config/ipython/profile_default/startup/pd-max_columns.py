import logging
try:
    import pathlib
    no_pathlib = False
except ImportError:
    no_pathlib = True
    import os

logger = logging.getLogger(__name__)

try:
    import pandas as pd

    pd.set_option("display.max_columns", None)
    logger.info("\n-- pd.get_option('display.max_columns') = None")

except ImportError:
    logger.info("\n-- Pandas not found - the pd.set_option will not be set")

if no_pathlib:
    filename = os.path.abspath(__file__)
else:
    filename = pathlib.Path(__file__).resolve()
logger.info("-- See %s", filename)
