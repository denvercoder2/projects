# I call this one abstract art
import random
import turtle

t = turtle.Turtle()

turtle.Screen().bgcolor("black")

color_choice = ["red","green","blue","orange","purple","pink","yellow"]
color = random.choice(color_choice)

# function for backwards movement in random range betweem 1 and 100
def backwards():
  t.backward(random.randrange(10, 25))


# function for bright movement in random range betweem 1 and 100
def right():
  t.right(random.randrange(10, 25))
  

# function for forwards movement in random range betweem 1 and 100
def forward():
  t.forward(random.randrange(10, 25))  
  

# function for left movement in random range betweem 1 and 100
def left():
  t.left(random.randrange(10, 25))
  

func_list = [backwards, right, forward, left]
# for a number in a range(1000), I let the interpretor choose what to do
# so it yields something different each time, it also choposes a different color each time the
# program is run.
def func():
  r = list(range(1000))
  random.shuffle(r)
  for i in r:
    x = random.choice(func_list) ()
    print(random.choice(func_list))
    t.color(color)
func()    