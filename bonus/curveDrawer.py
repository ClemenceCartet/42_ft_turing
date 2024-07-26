import csv
import matplotlib.pyplot as plt
import math


def draw():
    x = []
    y = []
    with open("timeCompl.csv", "r", newline="") as io:
        csv_parsing = list(csv.reader(io))
        for a, b in csv_parsing:
            x.append(int(a))
            y.append(int(b))
    xs = list(range(100))
    n = list(range(100))
    square = [x**2 for x in range(100)]
    logn = [math.log(x) for x in range(1, 100)]
    nlogn = [x * math.log(x) for x in range(1, 100)]
    exp2n = [2**x for x in range(100)]
    facto = [1]
    for i in range(1, 100):
        facto.append(facto[-1] * i)
    plt.plot(xs, n, "b", label="O(n)")
    plt.plot(xs, square, "r", label="O(n^2)")
    plt.plot(xs[1:100], logn, "g", label="O(logn)")
    plt.plot(xs[1:100], nlogn, "pink", label="O(nlogn)")
    plt.plot(xs, exp2n, "violet", label="O(2^n)")
    plt.plot(xs, facto, "brown", label="O(n!)")
    plt.ylim(0, 1000)
    plt.plot(x, y, "black")
    plt.title("Big-O Complexity")
    plt.xlabel("Elements")
    plt.ylabel("Operations")
    plt.legend()
    plt.show()

if __name__ == "__main__":
    draw()
