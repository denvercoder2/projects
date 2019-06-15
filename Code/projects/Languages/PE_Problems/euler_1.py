# # problem 1 code
# def one():
#     sum = 0
#     for i in range(1000):
#         if i % 3 == 0 or i % 5 == 0:
#             sum = sum+i
#             print(sum)

# def two(max):
#     f1, f2 = 0, 1
#     while f1 < max:
#         yield f1
#         f1, f2 = f2, f1 + f2
# print(sum(filter(lambda n: n % 2 == 0, two(4000000))))


# def prime_factors(n):
#     """Returns all the prime factors of a positive integer"""
#     factors = []
#     d = 2
#     while n > 1:
#         while n % d == 0:
#             factors.append(d)
#             n /= d
#         d = d + 1

#     return factors


# pfs = prime_factors(600851475143)
# largest_prime_factor = max(pfs) # The largest element in the prime factor list
# print (pfs) 
# print (largest_prime_factor)

# def Palindrome(s):
#     if s == s[::-1]:
#         return True
#     else:
#         return False

# i = 100
# j = 100
# greatest = 0
# while (i <= 999):
#     while (j <= 999):
#         product = i * j
#         if (product > greatest and Palindrome(str(product))):
#             greatest = product
#         j += 1
#     j = 100
#     i += 1
# print ("Answer: " + str(greatest))


# def get_divs(n):
#     divs = [x for x in range(1,20) if n % x == 0]
#     print(divs)
