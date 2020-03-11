import pandas as pd
import numpy as np


def case_9_gas():

    # bus type demand
    bus = np.array(
        [
            [1, 1, 10],
            [2, 1, 10],
            [3, 1, 10],
            [4, 1, 10],
            [5, 1, 10],
            [6, 1, 10],
            [7, 1, 10],
            [8, 1, 10],
            [9, 2, 10]
        ]
    )

    # fbus tbus Cbr
    branch = np.array(
        [
            [1, 2, 3],
            [1, 5, 3],
            [2, 3, 4.5],
            [2, 6, 3],
            [4, 5, 4.5],
            [5, 7, 3],
            [6, 8, 3],
            [7, 8, 3],
            [8, 9, 3]
        ]
    )

    # compressor
    compressor = np.array(
        [
            [8, 9, 0.5]
        ]
    )

    # bus smin smax
    source = np.array(
        [
            [3, 0, 200],
            [4, 0, 200]
        ]
    )