# Needed for coverage analysis:
# cython: linetrace=True

import numpy as np

__all__ = ['some_function']


def some_function(int a, int b):
    return (a + b) % 42
