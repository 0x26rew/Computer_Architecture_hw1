.data
str1: .string " is ugly."
str2: .string " is not ugly."

.text
main:
    li    a5, 210                      # load the value of input number n
    add   a0, a5, zero                 # function argument
    sw    a0, 0(sp)                    # store the input number
    jal   isUgly                       # jump to function isUgly
    add   a2, a0, zero                 # store the return value of func isUgly
    lw    a0, 0(sp)                    # restore the input number                   
    beqz  a2, not_ugly                 # branch when input number is not ugly
    jal   print_ugly                   
    j     end
not_ugly:
    jal   print_not_ugly
end:                                   # end programm
    li    a7, 10
    ecall    
isUgly:
    addi  sp, sp, -8                   # make space on stack 
    sw    ra, 4(sp)                 
    sw    a0, 0(sp)
    add   a5, a0, zero
    li    a0, 1                        # return value of func
    li    a4, 1
    bge   a4, a5, less_than_two        # check if input integer <= 1
    j     loop
less_than_two:
    li    a0, 0
    j     ret    
loop:                                  # begin of the do-while loop
    andi  a4, a5, 0x0001               # a4 = n % 2
    bne   a4, zero, elif_3             # if a4 != 0, go to elif_3
    srli  a5, a5, 1                    # if a4 == 0, n /= 2
    j     compare                      
elif_3:
    add   a4, zero, a5                 # a4 stores the value of n mod 3                  
    li    t0, 5
mod_3:
    bge   t0, a4, rm_3                 # if a4 <= 5, break the mod_3 loop 
    li    a3, 0                        # accumulator for the sum of the digits
acc_digit_3:                           # a3 is the sum of digits of a4
    beq   a4, zero, as_3               # if a4 == 0, stop accumulate digits
    andi  t1, a4, 3
    add   a3, a3, t1                   # a3 = a3 + (a4 & 3)
    srli  a4, a4, 2                    # a4 = a4 >> 2
    j     acc_digit_3  
as_3:
    add   a4, a3, zero                 # assign the value of a3 to a4, continue the mod_3 loop 
    j     mod_3
rm_3:
    li    t1, 2
    bge   t1, a4, check_rm_3           # a4 = (a4 > 2) ? (a - 3) : a
    addi  a4, a4, -3    
check_rm_3:
    bne   a4, zero, elif_5             # if n mod 3 == 0, n /= 3
    li    t0, 3                        # divisor
    add   a2, a5, zero                 # divident
    li    a3, 0                        # quotient
div_3:                                 
    sub   a2, a2, t0    
    addi  a3, a3, 1
    bnez  a2, div_3
    add   a5, a3, zero
    j     compare    
elif_5:
    add   a4, zero, a5                 # a4 stores the value of n mod 5 
    li    t0, 9
mod_5:
    bge   t0, a4, rm_5                 # if a4 <= 9, break the mod_5 loop
    li    a3, 0                        # accumulator for the sum of the digits
acc_digit_5:            
    beq   a4, zero, as_5               # if a4 == 0, stop accumulate digits
    andi  t1, a4, 7                            
    add   a3, a3, t1                   # a3 = a3 + (a4 & 7)               
    srli  t2, a4, 3                                      
    li    t3, 2
mul_3:                                   
    add   t2, t2, t2                  
    addi  t3, t3, -1
    bnez  t3, mul_3
    add   a4, t3, zero                 # a4 = (a4 >> 3) * 3
    j     acc_digit_5     
as_5:
    add   a4, a3, zero                 # assign the value of a3 to a4, continue the mod_5 loop
    j     mod_5
rm_5:
    li    t1, 4
    bge   t1, a4, check_rm_5           # a4 = (a4 > 4) ? (a - 5) : a
    addi  a4, a4, -5
check_rm_5:
    bne   a4, zero, set_not_ugly       # if a4 == 0, n /= 5
    li    t0, 5                        # divisor
    add   a2, a5, zero                 # divident 
    li    a3, 0                        # quotient
div_5:
    sub   a2, a2, t0    
    addi  a3, a3, 1
    bnez  a2, div_5
    add   a5, a3, zero
    j     compare   
    
set_not_ugly:
    li    a0, 0                        # n is not ugly
    j     ret                          # break
compare:
    li    a3, 1                        
    blt   a3, a5, loop                 # if n > 1 go to loop
ret:
    lw    ra, 4(sp)                    # restore ra
    addi  sp, sp, 8                    # restore stack
    jr    ra                           # return to main
print_ugly:
    li    a7, 1                        # a0 is 1            
    ecall
    la    a0, str1                     # print str1
    li    a7, 4
    ecall
    jr    ra
print_not_ugly:
    li    a7, 1                        # a0 is 0
    ecall
    la    a0, str2                     # print sr2
    li    a7, 4
    ecall
    jr    ra