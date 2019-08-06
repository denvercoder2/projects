# Student attendance side proj

class Student:
    def __init__(self, name, owe):
        self.name = name
        self.owe = owe

    def roll(self):
        print ("Student name: ", self.name)

p1 = Student("Johnny", 100)


if __name__ == "__main__":
    p1.roll()