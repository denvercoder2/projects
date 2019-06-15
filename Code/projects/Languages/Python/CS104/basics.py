# basics in python

# functions
def function_1():
    x = 1 + 2
    print(x)
    print("---------------------------------------------")

def pl():
    pl.new_list = [1,2,3,4,5,6,7,8,9,10]
    print('List example ----->' ,pl.new_list)
    print("---------------------------------------------")

def print_dictionary():
    new_dict = {
        "car": 'ford',
        'type': 'truck',
        'year': 1996
    }
    for k,v in new_dict.items():
        print('dict example ------>', k, ':', v)
        print("---------------------------------------------")

def print_tuple():
    new_tuple = ('python', 'c++', "linux")
    print('Tuple example ---> ', 'There are', len(new_tuple), 'words in this list')
    print("---------------------------------------------")


def sequence():
    x = pl.new_list
    print("Example of array indexing")
    print("---------------------------------------------")

    for i in range(len(x)):
        print ('Element at', i, 'is', x[i])
    print("---------------------------------------------")

def sets():
    states = set(['Tennessee','Alabama', 'Georgia'])
    if 'Alabama' in states:
        print('Set example ---- >', "True")
print("---------------------------------------------")

if __name__ == "__main__":
    pl()
    print_dictionary()
    print_tuple()
    sequence()
    sets()
