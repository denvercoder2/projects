import turtle
# simple drawing lambda
t = turtle.Turtle()

def head():
  # draw the head of lambda
  t.penup()
  t.goto(0, 150)
  t.pendown()
  t.forward(25)
  t.right(45)
  t.forward(200)
  t.right(120)
  t.forward(25)
  t.right(62)
  t.forward(200)
head()

def body():
  # draw the body of lambda
  t.penup()
  t.goto(75, -50)
  t.pendown()
  t.left(45)
  t.forward(25)
  t.right(90)
  t.forward(145)
  t.right(135)
  t.forward(35)
  t.right(45)
  t.forward(130)
body()