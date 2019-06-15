from simple_calculator import *

def test_addition():
    assert (addition(1,3)) == 4
    assert (addition(-3,2)) == -1 
    assert (addition(99999, 99999)) == 199998


def test_subtraction():
    assert (subtraction(1,1)) == 0
    assert (subtraction(-1,1)) == -2
        

def test_multiply():
    assert (multiplication(1,4)) == 4
    

def test_division():
    assert (division(4,4)) == 1
