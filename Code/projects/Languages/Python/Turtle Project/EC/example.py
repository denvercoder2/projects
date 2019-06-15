import turtle

t = turtle.Turtle()
wn=turtle.Screen()
wn.bgcolor("blue")

def L():
  t.speed(10)
  
  t.pencolor("white")
  t.penup()
  t.goto(-120,100)
  t.pendown()
  t.begin_fill()
  t.color("white")
  t.left(90)
  t.forward(90)
  t.right(180)
  t.forward(90)
  t.left(90)
  t.forward(60)
  t.left(90)
  t.forward(10)
  t.left(90)
  t.forward(50)
  t.right(90)
  t.forward(80)
  t.left(90)
  t.forward(10)
  t.end_fill()
  C()
  
def C():
  t.pencolor("red")
  t.penup()
  t.goto(-30,80)
  t.pendown()
  t.begin_fill()
  t.color("red")
  for i in range(240):
    t.left(1)
    t.forward(1)
  t.left(90)
  t.forward(15)
  t.left(90)
  
  for i in range(170):
    t.right(1.5)
    t.forward(1)
    
  t.left(90)
  t.forward(20)
  t.left(100)
  t.forward(30)
  t.end_fill()
  
def main():
  L()
  print("IED Class of 2019")
main()