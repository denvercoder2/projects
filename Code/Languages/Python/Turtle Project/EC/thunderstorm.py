import turtle
import random
from time import sleep  
t = turtle.Turtle()
wn=turtle.Screen()
wn.bgcolor("cyan")
# draw the clouds on top
def clouds():
  t.pencolor("black")
  t.penup()
  t.goto(-200, 150)
  t.speed(50)
  t.color("grey")
  t.begin_fill()
  t.pendown()
  t.forward(400)
  t.left(90)
  t.forward(50)
  t.left(90)
  t.forward(400)
  t.left(90)
  t.forward(50)
  t.end_fill()
  goto_x = -200
  for i in range(15):
    t.speed(50)
    goto_x += 30
    t.penup()
    t.goto(goto_x - 30 , 150)
    t.pendown()
    t.begin_fill()
    t.circle(20)
    t.end_fill()
clouds()
# make a dynamic lightning
def lightning():
  t.speed(100)
  t.penup()
  t.pencolor("yellow")
  x_axis = -170
  for i in range(5):
    x_axis += 20
    t.goto(-170, 130)
    t.pendown()
    t.pensize(10)
    y = random.randint(10, 30)
  
  for i in range(5):
    t.forward(y)
    t.left(45)
    t.forward(y)
    t.right(45)
    t.forward(y)
  
# make dynamic rain at random spots
def rain_drop():
  t.pensize(3)
  t.pencolor("blue")
  t.penup()
  x = random.randrange(-170, 130)
  y = random.randrange(-170, 130)
  z = random.randrange(10, 20)
  t.goto(x, y)
  t.speed(50)
  t.pendown()
  t.pencolor("blue")
  t.forward(z)
  
# have a probability that lightning will occur and run for main storm 
def storm():
  zed = random.choice([1,2,3,4,5,6,7,8,9,10])
  print(zed)
  if zed > 3:
    lightning()
  # Draw rain on screen in the range of 250
  for i in range(250):
    print("rain drops: ", i)
    rain_drop()

storm()
