        .file   "UglyNumber.c"
        .option nopic
        .text
        .section        .rodata
        .align  3
.LC0:
        .string "%d\n"
        .text
        .align  1
        .globl  main
        .type   main, @function
main:
        add     sp,sp,-32
        sd      ra,24(sp)
        sd      s0,16(sp)
        add     s0,sp,32
        li      a5,101
        sw      a5,-20(s0)
        li      a5,1
        sb      a5,-21(s0)
        lw      a5,-20(s0)
        sext.w  a5,a5
        bgtz    a5,.L3
        sb      zero,-21(s0)
        j       .L3
.L8:
        lw      a5,-20(s0)
        and     a5,a5,1
        sext.w  a5,a5
        bnez    a5,.L4
        lw      a5,-20(s0)
        srlw    a4,a5,31
        addw    a5,a4,a5
        sraw    a5,a5,1
        sw      a5,-20(s0)
        j       .L3
.L4:
        lw      a4,-20(s0)
        li      a5,3
        remw    a5,a4,a5
        sext.w  a5,a5
        bnez    a5,.L5
        lw      a4,-20(s0)
        li      a5,3
        divw    a5,a4,a5
        sw      a5,-20(s0)
        j       .L3
.L5:
        lw      a4,-20(s0)
        li      a5,5
        remw    a5,a4,a5
        sext.w  a5,a5
        bnez    a5,.L6
        lw      a4,-20(s0)
        li      a5,5
        divw    a5,a4,a5
        sw      a5,-20(s0)
        j       .L3
.L6:
        sb      zero,-21(s0)
        j       .L7
.L3:
        lw      a5,-20(s0)
        sext.w  a4,a5
        li      a5,1
        bgt     a4,a5,.L8
.L7:
        lbu     a5,-21(s0)
        sext.w  a5,a5
        mv      a1,a5
        lui     a5,%hi(.LC0)
        addi    a0,a5,%lo(.LC0)
        call    printf
        li      a5,0
        mv      a0,a5        
        lui     a5,%hi(.LC0)
        addi    a0,a5,%lo(.LC0)
        call    printf
        li      a5,0
        mv      a0,a5
        ld      ra,24(sp)
        ld      s0,16(sp)
        add     sp,sp,32
        jr      ra
        .size   main, .-main
        .ident  "GCC: (GNU) 7.3.0"        
        
        
