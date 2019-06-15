import turtle
import random

t = turtle.Turtle()
turtle.Screen().bgcolor("black")
# Rocket at night in 2D

# make a generic thruster shaoe
def thrusters():
  t.forward(50)
  t.left(115)
  t.forward(40)
  t.left(65)
  t.forward(25)
  t.left(75)
  t.forward(40)

# thruster 1 and location setting
def thrust_1():
  t.color("red")
  t.penup()
  t.goto(0, -150)
  t.pendown()
  t.begin_fill()
  thrusters()
  t.end_fill()
thrust_1()
# thruster 2 and location setting
def thrust_2():
  t.color("red")
  t.penup()
  t.goto(-50, -150)
  t.pendown()
  t.begin_fill()
  t.left(105)
  thrusters()
  t.end_fill()
thrust_2()
# thruster 13and location setting
def thrust_3():
  t.color("red")
  t.penup()
  t.goto(-100, -150)
  t.pendown()
  t.begin_fill()
  t.left(105)
  thrusters()
  t.end_fill()
thrust_3()  
# Draw the body of the rocket and fill it in
def body():
  t.color("white")
  t.penup()
  t.goto(-105, -112)
  t.pendown()
  t.begin_fill()
  t.right(255)
  t.forward(160)
  t.left(100)
  t.forward(180)
  t.left(80)
  t.forward(100)
  t.left(80)
  t.forward(180)
  t.end_fill()
body()
# draw the head of the rocket
def needle():
  t.color("blue")
  t.penup()
  t.goto(25, 65)
  t.pendown()
  t.begin_fill()
  t.left(100)
  t.forward(10)
  t.left(120)
  t.forward(120)
  t.left(60)
  t.forward(10)
  t.left(65)
  t.forward(115)
  t.right(245)
  t.forward(120)
  t.end_fill()
needle()

# draw the plane id pole on top
def plane_light():
  t.color("red")
  t.penup()
  t.goto(-30, 170)
  t.pendown()
  t.left(90)
  t.forward(25)
plane_light()

# make a moon in the sky
def circle_moon():
  t.penup()
  t.goto(180, 130)
  t.pendown()
  t.color("grey")
  t.width(5)
  t.begin_fill()
  t.rt(360)
  t.circle(50, 360)
  t.end_fill()
circle_moon()

# define a general star shape and color
def star():  
  t.color("yellow")  
  t.penup()
  x = random.randrange(-180, 180)
  y = random.randrange(-180, 180)
  t.goto(x, y)
  t.pendown()
  t.begin_fill()
  for _ in range(5):
    t.forward(25)
    t.left(144)
  t.end_fill()

  
  # get number of stars wanted from the user and 
  # display them at random parts on the screen
  # to simulate a night sky
def stars():
  t.penup()
  x = random.randrange(-100, 180)
  y = random.randrange(-100, 180)
  t.goto(x, y)
  t.pendown()
  user_choice = int(input("How many stars do you want to see?: "))
  for i in range(user_choice):
    star()
stars()
  
