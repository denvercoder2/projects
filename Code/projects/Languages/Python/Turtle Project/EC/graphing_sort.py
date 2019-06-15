import turtle
import random
import time
# making a background for seeing ability
t = turtle.Turtle()
wn=turtle.Screen()
wn.bgcolor("black")
#-------------------------------------------------------------#
# the main sort for the program
def sorted(list_): 
  # pythons default sort is timsort
  list_.sort()
  
#-------------------------------------------------------------------------------#
# I implemented a second sort (BubbleSort) so that there is some variety in the choice
def seperate_sort(list_):
  n = len(list_)
  for i in range(n):
      # Last i elements are in order
      for j in range(0, n-i-1, 1):
          if list_[j] > list_[j+1]:
              #swap if true
              list_[j], list_[j+1] = list_[j+1], list_[j] 

#-------------------------------------------------------------#        
def setup():
  user_choice = int(input("How many items would you like to generate to sort? A number between 10 and 20 works best: "))
  x = random.sample(range(0, 100), user_choice)
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
  user = str(input("Would you rather use TimSort or BubbleSort: "))
  for val in x:
    new_list.append(val)
  
  if user == "BubbleSort":
    seperate_sort(new_list)
  else:
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
    t.goto(counter + 20,0)
    t.pendown()
    t.forward(val)
  print("Graph was sorted using: ", user, "New sorted and graphed list is: ", new_list)
  
# call the main program

setup()
