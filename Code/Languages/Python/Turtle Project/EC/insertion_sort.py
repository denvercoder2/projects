import turtle
import random
# making a background for seeing ability
t = turtle.Turtle()
wn=turtle.Screen()
wn.bgcolor("black")
#-------------------------------------------------------------#
# the main sort for the program
def sorted(list_): 
  # pythons default sort is timsort, and as we know
  # i'm probably not going to best it in the time 
  # i'm writing this program since it runs in O(nlogn)
  list_.sort()
  return list_
#-------------------------------------------------------------#        
def setup():
  x = random.sample(range(0, 100), 15)
  t.left(90)
  t.color("red")
  for key, val in enumerate(x):
    # show the key and value
    # start the counter
    counter = -200
    key = 0
#-------------------------------------------------------------#
# key count is started above and iterated through, adding one each pass to keep
# up with the count, this way the count displays as the key is passed over
#-------------------------------------------------------------#
  for val in x:
    key += 1
    print(key, val)
    counter += 10
    t.penup()
    t.goto(counter,0)
    t.pendown()
    t.forward(val)
  print("Original List reprsentation in graph form", x)
#-------------------------------------------------------------#
  # make a dynamic border
#-------------------------------------------------------------#
  t.penup()
  t.goto(counter + 30 ,0)
  t.pendown()
  t.color("white")
  t.right(180)
  t.forward(250)
  t.left(180)
  t.forward(500)
  print("Now to sort the list:  ")
  #-------------------------------------------------------------#
  # run the sort function and return the sorted list
  #-------------------------------------------------------------#
  new_list = []
  for val in x:
    new_list.append(val)
  sorted(new_list)
  #-------------------------------------------------------------#
  # now make the sorted representation
  #-------------------------------------------------------------#
  for key, val in enumerate(new_list):
    counter = 0
    key = 0
    t.color("blue")
  for val in new_list:
    key += 1
    print(key, val)
    counter += 10
    t.penup()
    t.goto(counter,0)
    t.pendown()
    t.forward(val)
  print("New sorted and graphed list is: ", new_list)
  
  

setup()
    

  

   