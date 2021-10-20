.data
str1: .string " is ugly"
str2: .string " is not ugly"

.text
main:
    li    a5, 210                      # load the value of input number n
    add   a0, a5, zero                 # function argument
    sw    a0, 0(sp)                    # store the input number
    jal   func                         # jump to function is Ugly
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
    
func:
    addi  sp, sp, -8                   # make space on stack 
    sw    ra, 4(sp)
    sw    a0, 0(sp)
    add   a5, a0, zero
    li    a0, 1                        # return value of func
loop:                                  # begin of the do-while loop
    li    a2, 2
    rem   a4, a5, a2                   # a4 = n % 2
    bne   a4, zero, elif_3             # if a4 != 0, go to elif_3
    srli  a5, a5, 1                    # if a4 == 0, n /= 2
    j     compare                      
elif_3:
    li    a2, 3                        # a4 = n % 3
    rem   a4, a5, a2                   # if a4 != 0, go to elif_5
    bne   a4, zero, elif_5             # if a4 == 0, n /= 3
    div   a5, a5, a2
    j     compare    
elif_5:
    li    a2, 5                        # a4 = n %= 5
    rem   a4, a5, a2                   # if a4 != 0, go to else 
    bne   a4, zero, else               # if a4 == 0, n /= 5
    div   a5, a5, a2
    j     compare
else:
    li    a0, 0                        # n is not ugly
    j     return                       # break
compare:
    li    a3, 1                        
    blt   a3, a5, loop                 # if n > 1 go to loop
return:
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