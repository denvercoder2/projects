# Scott GUI for auto_email
import tkinter
import auto_email
from tkinter import messagebox


top = tkinter.Tk()
top.geometry("500x500")

def send_auto():
    instruction  = tkinter.Button(top, text = "Click to enter custom message", command = auto_email.main)
    instruction.pack()
    top.mainloop()


def main():
    send_auto()


if __name__ == "__main__":
    main()
    