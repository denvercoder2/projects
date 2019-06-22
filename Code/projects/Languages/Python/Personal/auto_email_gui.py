# Scott GUI for auto_email
import tkinter
import auto_email
from tkinter import messagebox


top = tkinter.Tk()
top.geometry("250x250")
def run_auto():
    messagebox.showinfo("Run")

run  = tkinter.Button(top, text = "Click to enter custom message", command = auto_email.main)

run.pack()
top.mainloop()