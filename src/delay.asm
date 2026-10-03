DELAY:  mov     r6, 00FFh
D0:     mov     r7, 00FFh
D1:     djnz    r7, D1

        djnz    r6, D0

        ret
