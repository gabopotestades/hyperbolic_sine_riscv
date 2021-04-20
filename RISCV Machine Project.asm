.globl main

#------------MACROS------------#
.macro EXIT # Ends the program
li a7, 10 
ecall
.end_macro

.macro NEWLINE # Print a new line
li a0, 10
li a7, 11
ecall
.end_macro

.macro PRINT_INT (%x) # Print a integer in the command line
la t0, %x
lw a0, (t0)
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

.macro COMPUTE_DIVIDEND (%x, %exponent, %dividend)
li t2, 1
la t3, %exponent
la t4, %x
la t5, %dividend
lw a1, (t3) 		
fld fa1, (t4)		
fld fa2, (t4)
beq  a1,  t2, END_COMPUTE_DIVIDEND  # Skip if exponent is 1
   	 
EXPONENTIATION:   
	fmul.d fa2, fa2, fa1
     	   sub  a1,  a1, t2
     	   bne  a1,  t2, EXPONENTIATION
           
END_COMPUTE_DIVIDEND:     
fsd fa2, (t5)
.end_macro

.macro COMPUTE_DIVISOR (%exponent, %divisor) #This is considered a factorial function
la t2, %exponent
la t3, %divisor
li t4, 1
li t5, 1
lw a1, (t2) 
fcvt.d.w fa1, t5
fcvt.d.w fa2, a1
fcvt.d.w fa3, t4 

FACTORIAL:
	fmul.d fa1, fa1, fa2
	fsub.d fa2, fa2, fa3
	 fgt.d  t6, fa2, fa3
	   bne  t4,  t6, FACTORIAL 

fsd fa1, (t3)
.end_macro

.macro DIVIDE(%dividend, %divisor, %ans_per_loop)
la t1, %dividend
la t2, %divisor
la t3, %ans_per_loop
fld fa1, (t1)
fld fa2, (t2)
fdiv.d fa3, fa1, fa2
fsd fa3, (t3)
.end_macro

.macro ADD_TOTAL_AND_INCREMENT_N(%ans_per_loop, %total, %n)
la t1, %ans_per_loop
la t2, %total
la t3, %n
lw t4, (t3)
li t5, 1 

# Add answer per loop to the total
fld fa1, (t1)
fld fa2, (t2)
fadd.d fa3, fa1, fa2
fsd fa3, (t2)

# Add n + 1
add t6, t4, t5
sw t6, (t3)
.end_macro

#------------DATA------------#

.data
x: .double 3  #<--------------- Input x here
n: .word 0

exponent: .word 0
dividend: .double 0
divisor: .double 0
ans_per_loop: .double 0

total: .double 0

#------------PROGRAM------------#
.text
main:

#This is the main loop
SUMMATION:

# Multiply exponent first
COMPUTE_EXPONENT(n, exponent)
#PRINT_INT(exponent)
#NEWLINE

# Get the dividend
COMPUTE_DIVIDEND(x, exponent, dividend)
#PRINT_FLOAT(dividend)
#NEWLINE

# Get the divisor
COMPUTE_DIVISOR(exponent, divisor)
#PRINT_FLOAT(divisor)
#NEWLINE

# Divide the two
DIVIDE(dividend, divisor, ans_per_loop)
#PRINT_FLOAT(ans_per_loop)
#NEWLINE

ADD_TOTAL_AND_INCREMENT_N(ans_per_loop, total, n)

la t0, n
lw t1, (t0)
li t2, 7
beq t1, t2, END_SUMMATION
bne t1, t2, SUMMATION

END_SUMMATION:
PRINT_FLOAT(total)
EXIT
