# Needed for coverage analysis:
# cython: linetrace=True

import numpy as np

def some_function(int a, int b):
    return (a + b) % 42
