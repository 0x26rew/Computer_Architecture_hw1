.data
str1: .string " is ugly"
str2: .string " is not ugly"
input_num: .word 300                # input number

.text
main:
    lw    s2, input_num                # load the value of input number n
    add   a0, s2, zero                 # function argument
    jal   func                         # jump to function
    add   s3, a1, zero                 # store the return value of func
    beqz  s3, not_ugly                 # branch when input number is not ugly
    add   a0, s2, zero                 # print input integer
    li    a7, 1
    ecall
    la    a0, str1                     # print str1
    li    a7, 4
    ecall
    j     end
not_ugly:
    add   a0, s2, zero                 # print input integer
    li    a7, 1                        
    ecall
    la    a0, str2                     # print str2
    li    a7, 4
    ecall
end:                                   # end programm
    li    a7, 10
    ecall
         
func:
    li    a1, 1                        # return value of func
loop:                                  # begin of the do-while loop
    li    t0, 2
    rem   t4, a0, t0                   # t4 = n % 2
    bne   t4, zero, elif_3             # if t4 != 0, go to elif_3
    srli  a0, a0, 1                    # if t4 == 0, n /= 2
    j     compare                      
elif_3:
    li    t0, 3                        # t4 = n % 3
    rem   t4, a0, t0                   # if t4 != 0, go to elif_5
    bne   t4, zero, elif_5             # if t4 == 0, n /= 3
    div   a0, a0, t0
    j     compare    
elif_5:
    li    t0, 5                        # t4 = n %= 5
    rem   t4, a0, t0                   # if t4 != 0, go to else 
    bne   t4, zero, else               # if t4 == 0, n /= 5
    div   a0, a0, t0
    j     compare
else:
    li    a1, 0                        # n is not ugly
    j     return                       # break
compare:
    li    t0, 1                        
    blt   t0, a0, loop                 # if n > 1 go to loop
return:
    jr    ra