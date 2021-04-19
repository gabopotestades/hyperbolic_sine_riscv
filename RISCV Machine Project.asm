.globl main

#------------MACROS------------#
.macro EXIT # Ends the program
li a7, 10 
ecall
.end_macro

.macro PRINT_INT (%x) # Print a integer in the command line
la t1, %x
lw a0, (t1)
li a7, 1
ecall
.end_macro

.macro PRINT_FLOAT (%x) # Print a float in the command line
la t0, %x
fld fa0, (t0)
li a7, 3
ecall
.end_macro

.macro COMPUTE_EXPONENT (%n, %exponent)
  li t1,  2
  la t2,  %n
  lw a1, (t2)
  la t3,  %exponent
 mul t4,  t1, a1
addi t4,  t4, 1
  sw t4, (t3)
.end_macro

.macro GET_DIVIDEND (%x, %exponent, %dividend)
li t2, 1
la t3, %exponent
la t4, %x
la t5, %dividend
lw a1, (t3) 		#exponent
fld fa1, (t4)		#x
fld fa2, (t4)
       	 
LOOP_DIVIDEND:
	fmul.d fa2, fa2, fa1
     	   sub a1,   a1, t2
           bgt a1,   t2, LOOP_DIVIDEND
        
fsd fa2, (t5)
.end_macro

.macro GET_DIVISOR (%exponent, %divisor) #This is considered a factorial function
la t2, %exponent
la t3, %divisor
li t4, 1
lw a1, (t2)

FACTORIAL:
	mul t5, t5, a1
	sub a1, a1, t4
	beq a1, t4, FACTORIAL

fcvt.d.w fa1,  t5
     fsd fa1, (t3)
.end_macro

#------------DATA------------#

.data
x: .double 3
n: .word 2

exponent: .word 0
dividend: .double 0
divisor: .double 0

total: .double 0

#------------PROGRAM------------#
.text
main:

# Multiply exponent first
COMPUTE_EXPONENT(n, exponent)

# Get the dividend
GET_DIVIDEND(x, exponent, dividend)

# Get the divisor
GET_DIVISOR(exponent, divisor)

PRINT_FLOAT(divisor)

EXIT