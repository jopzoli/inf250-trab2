main:
	# (2^(e0-3))x(1+m0)x(2^(e1-3)x(1+m1))
	# =(2^((e0+e1-3+(M&2^9))-3))x(1+M))

	addi t0, x0, 0x38
    addi t1, x0, 0x46
    jal ra, mulf		# resultado em t2
    j _endblk

mulf:
	andi a1, t0, 0xf0	# tira o expoente 1
    andi a2, t1, 0xf0	# tira o expoente 2
    add  a2, a2, a1		# soma o expoente
    addi a2, a2, -48	# concerta
    andi a3, t0, 0xf	# extrai a mantissa 1
    andi a4, t1, 0xf	# extrai a mantissa 2
    addi a5, x0, 16		# salva para depois
    or   a3, a3, a5		# liga o 5 bit
    or   a4, a4, a5
    mul  a3, a3, a4		# multiplica a mantissa
    srli a3, a3, 4		# tira os últimos 4 bits
    slli a5, a5, 1		# liga o 6 bit
    blt  a3, a5, _nxt   # verifica se tem deslocamento
    addi a2, a2, 0x10	# soma no expoente
    srli a3, a3, 1		# divide a mantissa por 2
_nxt:
	andi a3, a3, 0xf	# tira a mantissa
	or   t2, a3, a2		# junta os bits
    ret

_endblk:
