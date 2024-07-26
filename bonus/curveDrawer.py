import csv
import matplotlib.pyplot as plt


def draw():
    x = []
    y = []
    with open("timeCompl.csv", "r", newline="") as io:
        csvParsing = list(csv.reader(io))
        for a, b in csvParsing:
            x.append(a)
            y.append(b)
    plt.plot(x, y, "b")
    plt.savefig("graph.png")


if __name__ == "__main__":
    draw()
