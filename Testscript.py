import math

x = 4.5345
total = 0

# Test for single n-term
if False:
    n = 6
    exponent = (2*n) + 1
    dividend = x**exponent
    divisor = math.factorial(exponent)
    ans_per_loop = dividend / divisor

    print(f'Exponent: {exponent}')
    print(f'Dividend: {dividend}')
    print(f'Divisor: {divisor}')
    print(f'Ans Per Loop: {ans_per_loop}')



#Test when n is 0 to 6
if True:

    print('Hyperbolic Sine Function')

    for n in range(0, 7):
        exponent = (2*n) + 1
        dividend = x**exponent
        divisor = math.factorial(exponent)
        ans_per_loop = dividend / divisor
        total = total + ans_per_loop
        print(f'Value when n is {n}: {ans_per_loop}')

    print(f'Total: {total}')    
 


