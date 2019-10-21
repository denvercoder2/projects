# bill unit tests
from bill_itemized import *

def test_rent():
    assert(rent(1115.0)) == 583.145
    assert(rent(10000.0)) == 5230.0

def test_utils():
    assert(utilities(100)) == 50.0
    assert(utilities(187.13)) == 93.565

def test_internet():
    assert(internet(100)) == 50.0
    assert(internet(187.13)) == 93.565

def test_totals():
    assert(totals(1,2.0,3.0)) == 6.0
    assert(totals(5500.0, 1.0, 1.0 )) == 5502.00