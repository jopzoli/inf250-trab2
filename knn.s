main:

mem:
# Ponto k
addi t0, x0, 3
sw t0, 0(gp)

addi t0, x0, 2
sw t0, 4(gp)

addi t0 ,x0, 1
sw t0, 8(gp)
# Ponto 1
addi t0, x0, 0
sw t0, 12(gp)

addi t0, x0, 0
sw t0, 16(gp)

addi t0, x0, 1
sw t0, 20(gp)
# Ponto 2
addi t0, x0, 0
sw t0, 24(gp)

addi t0, x0, 1
sw t0, 28(gp)

addi t0, x0, 2
sw t0, 32(gp)
# Ponto 3
addi t0, x0, 1
sw t0, 36(gp)

addi t0, x0, 0
sw t0, 40(gp)

addi t0, x0, 1
sw t0, 44(gp)
# Ponto 4
addi t0, x0, 2
sw t0, 48(gp)

addi t0, x0, 0
sw t0, 52(gp)

addi t0, x0, 1
sw t0, 56(gp)
# Ponto 5
addi t0, x0, 3
sw t0, 60(gp)

addi t0, x0, 0
sw t0, 64(gp)

addi t0, x0, 1
sw t0, 68(gp)
# Ponto 6
addi t0, x0, 0
sw t0, 72(gp)

addi t0, x0, 2
sw t0, 76(gp)

addi t0, x0, 2
sw t0, 80(gp)
# Ponto 7
addi t0, x0, 0
sw t0, 84(gp)

addi t0, x0, 3
sw t0, 88(gp)

addi t0, x0, 2
sw t0, 92(gp)
# Fim
addi t0, x0, -1
sw t0, 96(gp)

knn:
    # lw a0, 0(gp) # k
    lw a1, 4(gp) # m / x
    lw a2, 8(gp) # n / y
    add t1, x0, gp # for i
    addi t1, t1, 12
_loop0:
    lw t3, 0(t1) # salva x t3
    blt t3, x0, _endloop0 # se t3<0 (-1) sai do loop
    add t2, t1, x0 # for j
    lw t4, 4(t1) # salva y t4
    # dist(arr[i], o)
    sub t3, a1, t3 # x1 - kx
    sub t4, a2, t4 # y1 - ky
    # abs
    #addi a4, x0, -1 # salva pra depois
    bge t3, x0, _px00 # t3 >= 0
    mul t3, t3, t0 # t3 = t3 * -1
_px00:
    bge t4, x0, _px01 # t4 >= 0
    mul t4, t4, t0 # t4 = t4 * -1
_px01:
    add t3, t4, t3 # a0 = a0 + a1 (t3=dist1)
    
_loop1:
    lw t5, 0(t2) # salva x t5
    blt t5, x0, _endloop1 # se t5<0 (-1) sai do loop
    lw t6, 4(t2) # salva y t6
    
    # dist(arr[j], o)
    sub t5, a1, t5 # x1 - kx
    sub t6, a2, t6 # y1 - ky
    # abs
    bge t5, x0, _px02 # t3 >= 0
    mul t5, t5, t0 # t3 = t3 * -1
_px02:
    bge t6, x0, _px03 # t4 >= 0
    mul t6, t6, t0 # t4 = t4 * -1
_px03:
    add t5, t5, t6 # a0 = a0 + a1 (t5=dist2)
    
    # if (dist(arr[j], o) < dist(arr[i], o))
    bge t5, t3, _nxt1 #t3<t5 t1 = j, t2 = i
    # swap
    lw a0, 0(t2) # le x do t5 
    lw a4, 4(t2) # le y do t5
    lw a5, 8(t2) # le k do t5

    lw t4, 0(t1) # le x do t3
    sw t4, 0(t2) # salva x no t5
    lw t4, 4(t1) # le y do t3
    sw t4, 4(t2) # salva y no t5
    lw t4, 8(t1) # le k do t3
    sw t4, 8(t2) # salva k no t5

    sw a0, 0(t1)
    sw a4, 4(t1)
    sw a5, 8(t1)
_nxt1:
    addi t2, t2, 12 # j++
    j _loop1
_endloop1:
    addi t1, t1, 12 # i++  
    j _loop0
_endloop0:
  
_endblk:
 
