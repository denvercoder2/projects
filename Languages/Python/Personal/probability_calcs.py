# probability calculations

'''Independent functions'''

def function_union_independent(a, b):
    # if two probabilities are independent, simply add them together to get the union
    return a * b

def test_function_union_independent():
    assert (function_union_independent(.5,.6)) == .30 
    assert (function_union_independent(.3,.3)) == .09

def function_given_independent_A(a,b):
    return a 

def test_function_given_independent_A():
    assert(function_given_independent_A(.5,.6)) == .5
    assert(function_given_independent_A(.9,.12)) == .9

def function_given_independent_B(a,b):
    return b

def test_function_given_independent_B():
    assert(function_given_independent_B(.5,.6)) == .6
    assert(function_given_independent_B(.1,.2)) == .2

''' end of independent functions '''



''' start of unions, intersections, and complements '''
def AorB(a,b):
    return (a + b) - (a * b)

def test_AorB():
    assert (AorB(.5,.3)) == .65
    assert (AorB(.1,.1)) == .19

# do deMorgans law later
def joint_probability(a,b):
    return a * b
    # probability of A * probability of B is the joint probability
    # P(A and B) = P(A) * P(B)

def test_joint_probability():
    assert (joint_probability(.3, .5)) == .15
    assert (joint_probability(.4, .4)) == .16000000000000003
    
