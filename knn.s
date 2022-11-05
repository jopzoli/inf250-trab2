mem:
    # Ponto k
    addi t0, x0, 3
    sw t0, 0(gp)

    addi t0, x0, 2
    sw t0, 4(gp)

    addi t0 ,x0, 1
    sw t0, 8(gp)
    # Ponto 1 (dist 3)
    addi t0, x0, 0
    sw t0, 12(gp)

    addi t0, x0, 0
    sw t0, 16(gp)

    addi t0, x0, 1
    sw t0, 20(gp)
    # Ponto 2 (dist 2)
    addi t0, x0, 0
    sw t0, 24(gp)

    addi t0, x0, 1
    sw t0, 28(gp)

    addi t0, x0, 2
    sw t0, 32(gp)
    # Ponto 3 (dist 2)
    addi t0, x0, 1
    sw t0, 36(gp)

    addi t0, x0, 0
    sw t0, 40(gp)

    addi t0, x0, 1
    sw t0, 44(gp)
    # Ponto 4 (dist 1)
    addi t0, x0, 2
    sw t0, 48(gp)

    addi t0, x0, 0
    sw t0, 52(gp)

    addi t0, x0, 1
    sw t0, 56(gp)
    # Ponto 5 (dist 2)
    addi t0, x0, 3
    sw t0, 60(gp)

    addi t0, x0, 0
    sw t0, 64(gp)

    addi t0, x0, 1
    sw t0, 68(gp)
    # Ponto 6 (dist 3)
    addi t0, x0, 0
    sw t0, 72(gp)

    addi t0, x0, 2
    sw t0, 76(gp)

    addi t0, x0, 2
    sw t0, 80(gp)
    # Ponto 7 (dist 4)
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
    lw   a1, 4(gp)      # k_x
    lw   a2, 8(gp)      # k_y

    add  t1, x0, gp     # posição do vetor
    addi t1, t1, 12     # i = 0
.loop0:
    lw   t3, 0(t1)      # arr[i].x
    beq  t3, t0, .brk0  # arr[i].x == -1 (para)
    addi t2, t1, 12     # j = i + 1

.loop1:
    lw   t5, 0(t2)      # arr[j].x
    beq  t5, t0, .nxt0  # arr[j].x == -1 (prox)

    lw   t3, 0(t1)      # arr[i].x
    lw   t4, 4(t1)      # arr[i].y

    lw   t6, 4(t2)      # arr[j].y

    sub  a3, a1, t3     # K_x - arr[i].x
    sub  a4, a2, t4     # K_y - arr[i].y

    bge  a3, x0, .pnix  # se positivo
    mul  a3, a3, t0     # se negativo
.pnix:
    bge  a4, x0, .pniy  # se positivo
    mul  a4, a4, t0     # se negativo
.pniy:
    add  a3, a3, a4     # dist(K, arr[i])

    sub  a5, a1, t5     # K_x - arr[j].x
    sub  a6, a2, t6     # K_y - arr[j].y

    bge  a5, x0, .pnjx  # se positivo
    mul  a5, a5, t0     # se negativo
.pnjx:
    bge  a6, x0, .pnjy  # se positivo
    mul  a6, a6, t0     # se negativo
.pnjy:
    add  a5, a5, a6     # dist(K, arr[j])

    blt  a3, a5, .nxt1  # se dist(K, arr[i]) < dist(K, arr[j])
    lw   a4, 8(t1)      # arr[i].k
    lw   a6, 8(t2)      # arr[j].k

    # swap(arr[i], arr[j]
    sw   t3, 0(t2)
    sw   t4, 4(t2)
    sw   a4, 8(t2)

    sw   t5, 0(t1)
    sw   t6, 4(t1)
    sw   a6, 8(t1)

.nxt1:
    addi t2, t2, 12     # j++
    j    .loop1

.nxt0:
    addi t1, t1, 12     # i++
    j    .loop0

.brk0:

    lw   a0, 0(gp)      # K_k
    add  t1, x0, gp     # posição do vetor
    addi t1, t1, 12     # i = 0
    add  t3, x0, x0     # classe 0
    add  t4, x0, x0     # classe 1
    add  t5, x0, x0     # classe 2
.loopk:
    beq  a0, x0, .bkrk  
    sw   t6, 8(t1)      # arr[i].k
    beq  t6, x0, .k0    # se arr[i].k == 0
    addi a1, x0, 1
    beq  t6, a1, .k1    # se arr[i].k == 1
    addi a1, a1, 1
    beq  t6, a1, .k2    # se arr[i].k == 2
.k0:
    addi t3, t3, 1
    j    .nxtk
.k1:
    addi t4, t4, 1
    j    .nxtk
.k2:
    addi t5, t5, 1
    j    .nxtk
.nxtk:
    add  a0, a0, t0
    addi t1, t1, 12     # i++
    j    .loopk

.bkrk:
    add  t6, t3, x0 #t6 = 0 (classe 0)

    beq  t6, t4, .cls0
    addi t6, t4, x0 # t6 = t4

.cls0:

    beq  t6, t5, .cls1
    add  t6, t5, x0 # t6=t5

.end:
    bne  t6, t3, .nk1
    addi t1, x0, 0
    sw   t1, 0(gp)
    j    _endblk

.nk1:
    bne  t6, t4, .nk2
    addi t1, x0, 1
    sw   t1, 0(gp)
    j    _endblk
    
.nk2:
    addi t1, x0, 2
    sw   t1, 0(gp)
    j    _endblk

_endblk:
#fim :)
