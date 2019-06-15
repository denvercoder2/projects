# binary logic
import turtle

# making a background for seeing ability
t = turtle.Turtle()
wn=turtle.Screen()
wn.bgcolor("black")
# simple logic gate input

  # Draw the gate and fill in the correct color of the circle based
  # on input from user
def draw_gate():
  t.speed(100)
  t.color("white")
  t.penup()
  t.goto(-190, 150)
  t.pendown()
  t.forward(50)
  
  t.penup()
  t.goto(-190, 100)
  t.pendown()
  t.forward(50)
  
  t.left(90)
  t.forward(75)
  t.right(180)
  t.forward(110)
  t.left(90)
  
  for i in range(180):
    t.left(1)
    t.forward(1)
  t.right(180)
  t.penup()
  for i in range(90):
    t.right(1)
    t.forward(1)
  t.pendown()
  t.left(90)
  t.forward(50)

# draw a circle and fill in the shape with green to simulate passing logic
def output_circle_good():
  t.pencolor("white")
  t.penup()
  t.goto(-35, 100)
  t.pendown()
  t.penup()
  t.color("green")
  t.begin_fill()
  t.circle(25)
  t.end_fill()


# draw a circle and fill in the shape with red to simulate failing logic
def output_circle_bad():
  t.pencolor("white")
  t.penup()
  t.goto(-35, 100)
  t.pendown()
  t.penup()

  t.color("red")
  t.begin_fill()
  t.circle(25)
  t.end_fill()

  
  # draw the gate and fill in LED based on whether uses has entered correct
  # sequence for the binary operation to be true
def draw_gate_good():
  draw_gate()
  output_circle_good()
  print("Input is good, logic is correct")
  # draw the gate and fill in LED based on whether uses has entered incorrect
  # sequence for the binary operation to be false
def draw_gate_bad():
  draw_gate()
  output_circle_bad()
  print("Input is bad or gate spelling is wrong")
  
  # define the logc for an and gate
  # if both inputs equal each other, then logic is true
def logic_and(a,b):
  if a == b:
      draw_gate_good()
  elif a != 0 or 1:
    draw_gate_bad()
    print("Inputs must be equal")
  elif b != 0 or 1:
    draw_gate_bad()
    print("Inputs must be equal ")
  else:
    draw_gate_bad()

  # define the logic for the or gate.
  # if both inputs equal each other, then logic is false
def logic_or(a,b):
  if a != b:
    draw_gate_good()
  else:
    draw_gate_bad()
  
  # have the user enter some values to go through the operation
  # based on what they enter, and the gate they pick, go to that funciton
def main():
  user = int(input("Input 1 for the gate (0 or 1): "))
  user_2 = int(input("Input 2 for the gate (0 or 1): "))
  gate = str(input("Or gate or And Gate? "))
  if gate == "And" or gate == "and": 
    logic_and(user, user_2)
  else:
    logic_or(user,user_2)
main()
