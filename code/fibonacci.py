#!/usr/bin/env python3

import argparse


table = {}


def fibonacci(n, l, verbose=0, cache=0):
    if cache and n in table:
        return table[n]
    if n == 0:
        result = 0
    elif n == 1:
        result = 1
    else:
        result = fibonacci(n - 1, l, verbose, cache) + fibonacci(n - 2, l, verbose, cache)
    if verbose:
        print(f"Fibonacci({str(n).zfill(l)}) = {result}")
    if cache:
        table[n] = result
    return result


if __name__ == "__main__":
    parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter,
                                     description="""
    F(0) = 0,
    F(1) = 1,
    F(n) = F(n - 1) + F(n - 2)

    https://en.wikipedia.org/wiki/Fibonacci_number""")

    parser.add_argument("n", type=int, help="The Fibonacci number to calculate")
    parser.add_argument("--verbose", "-v", default=0, help="Print each calculation.", action="count")
    parser.add_argument("--cache", "-c", default=0, help="Use dynamic programming and cache intermediate results.", action="count")
    args = parser.parse_args()
    result = fibonacci(**vars(args), l=len(str(vars(args)['n'])))
    print(result)
