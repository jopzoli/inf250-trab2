
main:
	addi t0, x0, 0x36
    jal ra, printf
    j _endblk
    # 2 ^ e 1 . M

printf:
	add  a0, x0, x0
	addi a1, a0, '2'
    sw   a1, 0(gp)
    addi a1, a0, '^'
	sw   a1, 1(gp)
    srli a2, t0, 4
    addi a2, a2, -3
    bge  a2, x0, _pos
    addi a1, a0, '-'
    sw   a1, 2(gp)
    addi a3, x0, -1
    mul  a2, a2, a3
    addi a1, a2, '0'
    sw   a1, 3(gp)
    j    _man
_pos:
	addi a1, a2, '0'
    sw   a1, 2(gp)
_man:
	addi a1, x0, '1'
    sw   a1, 4(gp)
    addi a1, x0, '.'
    sw   a1, 5(gp)
    add  a4, x0, x0
    addi a3, x0, 0x8
    and  a1, t0, a3
    beq  a3, a1, _b4
_ret1:
    srli a3, a3, 1
    and  a1, t0, a3
    beq  a3, a1, _b3
_ret2:
    srli a3, a3, 1
    and  a1, t0, a3
    beq  a3, a1, _b2
_ret3:
    srli a3, a3, 1
    and  a1, t0, a3
    beq  a3, a1, _b1
_ret4:
	add a3, x0, x0
	addi a5, x0, 10
    rem  a2, a4, a5
    addi a2, a2, '0'
    slli a2, a2, 24
    or   a3, a3, a2
    div  a4, a4, a5
    rem  a2, a4, a5
    addi a2, a2, '0'
    slli a2, a2, 16
    or   a3, a3, a2
    div  a4, a4, a5
    rem  a2, a4, a5
    addi a2, a2, '0'
    slli a2, a2, 8
    or   a3, a3, a2
    div  a4, a4, a5
    rem  a2, a4, a5
    addi a2, a2, '0'
    or   a3, a3, a2
    sw   a3, 8(gp)
    ret
    
_b4:
	addi a4, a4, 2047
    addi a4, a4, 2047
    addi a4, a4, 906
    j    _ret1
_b3:
    addi a4, a4, 2047
    addi a4, a4, 453
    j    _ret2
_b2:
    addi a4, a4, 1250
    j    _ret3
_b1:
    addi a4, a4, 625
    j    _ret4

_endblk:
