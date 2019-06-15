# dice
import random
def dice():
    for i in range(1,51):
        x = random.randrange(1, 7)
        print ("Outcome on roll: ", i, "is ---->", x)


if __name__ == "__main__":
    dice()
