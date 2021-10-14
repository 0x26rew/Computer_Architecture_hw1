.data
str1: .string "is ugly"
str2: .string "is not ugly"

.text
main:
    li a1, 1    # isUgly = 1
    li a2, 630   # n = 100
    li a3, 1    # const 1
    bge a3, a2, not_ugly
    li a4, 2    # const 2
    li a5, 3    # const 3
    li a6, 5    # const 5
loop:
    rem a6, a2, a4
    bne a6, zero, elif_3
    div a2, a2, a4
    j   compare
elif_3:
    rem a6, a2, a5
    bne a6, zero, elif_5
    div a2, a2, a5
    j   compare    
elif_5:
    rem a6, a2, a6
    bne a6, zero, else
    div a2, a2, a6
    j   compare
else:
    li a1, 0
    j print
compare:    
    blt a3, a2, loop

print:
    beqz a1, not_ugly
ugly:
    la a0, str1
    li a7, 4
    ecall
    j end
not_ugly:    
    la a0, str2
    li a7, 4
    ecall
end:
    li a7, 10
    ecall