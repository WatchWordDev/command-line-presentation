#!/usr/bin/env python3

import argparse


table = {}


def ackermann(m, n, verbose=0, cache=0):
    if cache and m in table and n in table[m]:
        return table[m][n]
    if m == 0:
        result = n + 1
    elif n == 0:
        result = ackermann(m - 1, 1, verbose, cache)
    else:
        result = ackermann(m - 1, ackermann(m, n - 1, verbose, cache), verbose, cache)
    if verbose:
        print(f"Ackermann({m}, {n}) = {result}")
    if cache:
        if m not in table:
            table[m] = {}
        table[m][n] = result
    return result


if __name__ == "__main__":
    parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter,
                                     description="""
    A(0, n) = n + 1,
    A(m, 0) = A(m - 1, 1),
    A(m, n) = A(m - 1, A(m, n - 1))

    https://en.wikipedia.org/wiki/Ackermann_function""")

    parser.add_argument("m", type=int, help="The first argument to the Ackermann function")
    parser.add_argument("n", type=int, help="The second argument to the Ackermann function")
    parser.add_argument("--verbose", "-v", default=0, help="Print each calculation.", action="count")
    parser.add_argument("--cache", "-c", default=0, help="Cache intermediate results.", action="count")
    args = parser.parse_args()
    result = ackermann(**vars(args))
    print(result)
