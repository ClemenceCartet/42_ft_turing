import csv
import matplotlib.pyplot as plt
import numpy as np
import math


def draw():
    x = []
    y = []
    with open("timeCompl.csv", "r", newline="") as io:
        csvParsing = list(csv.reader(io))
        for a, b in csvParsing:
            x.append(int(a))
            y.append(int(b))
    xs = [x for x in range(100)]
    n = [x for x in range(100)]
    square = [x**2 for x in range(100)]
    logn = [math.log(x) for x in range(1, 100)]
    nlogn = [x * math.log(x) for x in range(1, 100)]
    exp2n = [2**x for x in range(100)]
    facto = [1]
    for i in range(1, 100):
        facto.append(facto[-1] * i)
    plt.plot(xs, n, "b")
    plt.plot(xs, square, "r")
    plt.plot(xs[1:100], logn, "g")
    plt.plot(xs[1:100], nlogn, "pink")
    plt.plot(xs, exp2n, "violet")
    plt.plot(xs, facto, "brown")
    plt.ylim(0, 1000)
    plt.plot(x, y, "black")
    plt.savefig("graph.png")


if __name__ == "__main__":
    draw()
