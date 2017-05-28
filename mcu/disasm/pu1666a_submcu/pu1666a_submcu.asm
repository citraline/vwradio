    .F2MC8L
    .area CODE1 (ABS)
    .org 0xe000

;1  disp_data_out    P46/SO2    (3LB data out)
;2  disp_ena_in      P47/SI2    (3LB enable in)
;62 disp_ena_out     P43        (3LB enable out)
;64 disp_clk_out     P45/SCK2   (3LB clock out)

    pdr0 = 0x00             ;port 0 data register
    ddr0 = 0x01             ;port 0 data direction register
    pdr1 = 0x02             ;port 1 data register
    ddr1 = 0x03             ;port 1 data direction register
    pdr2 = 0x04             ;port 2 data register
    wdtc = 0x09             ;watchdog timer control register
    tbtc = 0x0a             ;timebase timer control register
    pdr3 = 0x0c             ;port 3 data register
    ddr3 = 0x0d             ;port 3 data direction register
    pdr4 = 0x0e             ;port 4 data register
    bzcr = 0x0f             ;buzzer register
    pdr5 = 0x10             ;port 5 data register
    pdr6 = 0x11             ;port 6 data register
    cntr = 0x12             ;pwm control register
    comr = 0x13             ;pwm compare register
    pcr1 = 0x14             ;pwc pulse width control register 1
    pcr2 = 0x15             ;pwc pulse width control register 2
    rlbr = 0x16             ;pwc reload buffer register
    tmcr = 0x18             ;16-bit timer control register
    tchr = 0x19             ;16-bit timer count register (high)
    tclr = 0x1a             ;16-bit timer count register (low)
    smr1 = 0x1c             ;serial i/o 1 mode register
    sdr1 = 0x1d             ;serial i/o 1 data register
    smr2 = 0x1e             ;serial i/o 2 mode register
    sdr2 = 0x1f             ;serial i/o 2 data register
    adc1 = 0x20             ;a/d converter control register 1
    adc2 = 0x21             ;a/d converter control register 2
    adcd = 0x22             ;a/d converter data register
    eic1 = 0x24             ;external interrupt 1 control register 1
    eic2 = 0x25             ;external interrupt 1 control register 2
    ilr1 = 0x7c             ;interrupt level setting register 1
    ilr2 = 0x7d             ;interrupt level setting register 2
    ilr3 = 0x7e             ;interrupt level setting register 3

    .byte 0xFF              ;e000  ff          DATA '\xff'
    .byte 0xFF              ;e001  ff          DATA '\xff'
    .byte 0xFF              ;e002  ff          DATA '\xff'
    .byte 0xFF              ;e003  ff          DATA '\xff'
    .byte 0xFF              ;e004  ff          DATA '\xff'
    .byte 0xFF              ;e005  ff          DATA '\xff'
    .byte 0xFF              ;e006  ff          DATA '\xff'
    .byte 0xFF              ;e007  ff          DATA '\xff'
    .byte 0x98              ;e008  98          DATA '\x98'
    .byte 0x11              ;e009  11          DATA '\x11'
    .byte 0x17              ;e00a  17          DATA '\x17'
    .byte 0x02              ;e00b  02          DATA '\x02'
    .byte 0x02              ;e00c  02          DATA '\x02'
    .byte 0x45              ;e00d  45          DATA 'E'
    .byte 0x08              ;e00e  08          DATA '\x08'
    .byte 0x02              ;e00f  02          DATA '\x02'
    .byte 0x12              ;e010  12          DATA '\x12'
    .byte 0x09              ;e011  09          DATA '\t'


reset_e012:
    mov pdr0, #0xf3         ;e012  85 00 f3
    mov ddr0, #0x07         ;e015  85 01 07
    mov pdr1, #0xbf         ;e018  85 02 bf
    mov ddr1, #0x40         ;e01b  85 03 40
    mov pdr2, #0x01         ;e01e  85 04 01
    mov pdr3, #0x3f         ;e021  85 0c 3f
    mov ddr3, #0xf4         ;e024  85 0d f4
    mov pdr4, #0xff         ;e027  85 0e ff
    mov pdr5, #0xff         ;e02a  85 10 ff
    mov pdr6, #0xff         ;e02d  85 11 ff
    movw ix, #0x0080        ;e030  e6 00 80

lab_e033:
    mov a, #0x00            ;e033  04 00
    mov @ix+0x00, a         ;e035  46 00
    incw ix                 ;e037  c2
    movw a, ix              ;e038  f2
    movw a, #0x027f         ;e039  e4 02 7f
    cmpw a                  ;e03c  13
    bne lab_e033            ;e03d  fc f4
    movw a, #0x027f         ;e03f  e4 02 7f
    movw sp, a              ;e042  e1
    movw a, #0x0030         ;e043  e4 00 30
    movw ps, a              ;e046  71
    mov a, #0x0a            ;e047  04 0a
    .byte 0x61, 0x00, 0xd1  ;e049  61 00 d1    mov 0x00d1, a
    mov a, #0x20            ;e04c  04 20
    .byte 0x61, 0x00, 0x8a  ;e04e  61 00 8a    mov 0x008a, a
    mov 0xaa, #0x09         ;e051  85 aa 09
    call sub_e0b8           ;e054  31 e0 b8
    call sub_e1c0           ;e057  31 e1 c0
    mov 0x98, #0x05         ;e05a  85 98 05
    mov a, #0x05            ;e05d  04 05
    mov 0x013a, a           ;e05f  61 01 3a
    mov a, #0x14            ;e062  04 14
    mov 0x0145, a           ;e064  61 01 45
    mov a, #0x14            ;e067  04 14
    .byte 0x61, 0x00, 0xc9  ;e069  61 00 c9    mov 0x00c9, a

lab_e06c:
    bbc 0x00a9:7, lab_e075  ;e06c  b7 a9 06
    bbs 0x00a9:6, lab_e075  ;e06f  be a9 03
    call sub_f993           ;e072  31 f9 93

lab_e075:
    call sub_fa59           ;e075  31 fa 59
    call sub_e40c           ;e078  31 e4 0c
    bbc 0x0088:0, lab_e086  ;e07b  b0 88 08
    clrb 0x88:0             ;e07e  a0 88
    call sub_f81c           ;e080  31 f8 1c
    jmp lab_e089            ;e083  21 e0 89

lab_e086:
    call sub_f8df           ;e086  31 f8 df

lab_e089:
    bbc 0x00a9:6, lab_e08f  ;e089  b6 a9 03
    call sub_f9f5           ;e08c  31 f9 f5

lab_e08f:
    call sub_f3c7           ;e08f  31 f3 c7
    call sub_e20a           ;e092  31 e2 0a
    call sub_e26e           ;e095  31 e2 6e
    call sub_e55b           ;e098  31 e5 5b
    call sub_f1ac           ;e09b  31 f1 ac
    call sub_f6df           ;e09e  31 f6 df
    call sub_f541           ;e0a1  31 f5 41
    call sub_e0aa           ;e0a4  31 e0 aa
    jmp lab_e06c            ;e0a7  21 e0 6c

sub_e0aa:
    mov a, 0x013a           ;e0aa  60 01 3a
    bne lab_e0b2            ;e0ad  fc 03
    bbc 0x009c:1, lab_e0b5  ;e0af  b1 9c 03

lab_e0b2:
    clrb pdr0:3             ;e0b2  a3 00        /UPD_OE = low
    ret                     ;e0b4  20

lab_e0b5:
    setb pdr0:3             ;e0b5  ab 00        /UPD_OE = high
    ret                     ;e0b7  20

sub_e0b8:
    movw a, ps              ;e0b8  70
    movw a, #0x00ff         ;e0b9  e4 00 ff
    andw a                  ;e0bc  63
    movw ps, a              ;e0bd  71
    call sub_f59f           ;e0be  31 f5 9f
    call sub_f5c3           ;e0c1  31 f5 c3
    call sub_f5ec           ;e0c4  31 f5 ec
    call sub_f617           ;e0c7  31 f6 17
    ret                     ;e0ca  20

irq7_e0cb:
;irq7 (8-bit serial I/O #1)
;main-to-sub spi bus
    pushw a                 ;e0cb  40
    xchw a, t               ;e0cc  43
    pushw a                 ;e0cd  40
    pushw ix                ;e0ce  41
    movw a, ep              ;e0cf  f3
    pushw a                 ;e0d0  40
    clrb smr1:7             ;e0d1  a7 1c
    call sub_e2ff           ;e0d3  31 e2 ff
    popw a                  ;e0d6  50
    movw ep, a              ;e0d7  e3
    popw ix                 ;e0d8  51
    popw a                  ;e0d9  50
    xchw a, t               ;e0da  43
    popw a                  ;e0db  50
    reti                    ;e0dc  30

irq6_e0dd:
;irq6 (16-bit timer/counter)
    pushw a                 ;e0dd  40
    xchw a, t               ;e0de  43
    pushw a                 ;e0df  40
    pushw ix                ;e0e0  41
    movw a, ep              ;e0e1  f3
    pushw a                 ;e0e2  40
    clrb tmcr:2             ;e0e3  a2 18
    call sub_e437           ;e0e5  31 e4 37
    popw a                  ;e0e8  50
    movw ep, a              ;e0e9  e3
    popw ix                 ;e0ea  51
    popw a                  ;e0eb  50
    xchw a, t               ;e0ec  43
    popw a                  ;e0ed  50
    reti                    ;e0ee  30

irq5_e0ef:
;irq5 (pulse width count timer)
    pushw a                 ;e0ef  40
    xchw a, t               ;e0f0  43
    pushw a                 ;e0f1  40
    pushw ix                ;e0f2  41
    movw a, ep              ;e0f3  f3
    pushw a                 ;e0f4  40
    clrb pcr1:2             ;e0f5  a2 14
    movw a, #0x0000         ;e0f7  e4 00 00
    mov a, 0xaa             ;e0fa  05 aa
    beq lab_e107            ;e0fc  fd 09
    decw a                  ;e0fe  d0
    mov 0xaa, a             ;e0ff  45 aa
    bne lab_e107            ;e101  fc 04
    setb pdr1:6             ;e103  ae 02
    setb 0xa9:7             ;e105  af a9

lab_e107:
    mov a, #0x80            ;e107  04 80
    xor a, 0xd2             ;e109  55 d2
    mov 0xd2, a             ;e10b  45 d2
    call sub_e2b2           ;e10d  31 e2 b2
    bbc 0x00d2:7, lab_e14a  ;e110  b7 d2 37
    call sub_fa10           ;e113  31 fa 10
    bbs pdr3:0, lab_e151    ;e116  b8 0c 38     Branch if /M2S_ENA_IN = high
    bbs 0x009b:1, lab_e12d  ;e119  b9 9b 11
    setb 0x9b:1             ;e11c  a9 9b
    mov a, #0x05            ;e11e  04 05
    mov 0xcb, a             ;e120  45 cb
    mov a, #0x00            ;e122  04 00
    mov 0x0122, a           ;e124  61 01 22
    clrb smr1:0             ;e127  a0 1c
    nop                     ;e129  00
    nop                     ;e12a  00
    setb smr1:0             ;e12b  a8 1c

lab_e12d:
    mov a, 0xc4             ;e12d  05 c4
    beq lab_e134            ;e12f  fd 03
    decw a                  ;e131  d0
    mov 0xc4, a             ;e132  45 c4

lab_e134:
    mov a, 0xca             ;e134  05 ca
    beq lab_e13b            ;e136  fd 03
    decw a                  ;e138  d0
    mov 0xca, a             ;e139  45 ca

lab_e13b:
    mov a, 0xc8             ;e13b  05 c8
    beq lab_e142            ;e13d  fd 03
    decw a                  ;e13f  d0
    mov 0xc8, a             ;e140  45 c8

lab_e142:
    bbc pdr4:7, lab_e156    ;e142  b7 0e 11     ;Branch if DISP_ENA_IN = low
    mov a, 0xc5             ;e145  05 c5
    incw a                  ;e147  c0
    mov 0xc5, a             ;e148  45 c5

lab_e14a:
    popw a                  ;e14a  50
    movw ep, a              ;e14b  e3
    popw ix                 ;e14c  51
    popw a                  ;e14d  50
    xchw a, t               ;e14e  43
    popw a                  ;e14f  50
    reti                    ;e150  30

lab_e151:
    clrb 0x9b:1             ;e151  a1 9b
    jmp lab_e12d            ;e153  21 e1 2d

lab_e156:
;DISP_ENA_IN is low
    mov a, 0xc5             ;e156  05 c5
    beq lab_e14a            ;e158  fd f0
    mov 0xc6, a             ;e15a  45 c6
    mov a, #0x00            ;e15c  04 00
    mov 0xc5, a             ;e15e  45 c5
    jmp lab_e14a            ;e160  21 e1 4a

irq4_e163:
;irq4 (8-bit pwm timer)
    pushw a                 ;e163  40
    xchw a, t               ;e164  43
    pushw a                 ;e165  40
    pushw ix                ;e166  41
    movw a, ep              ;e167  f3
    pushw a                 ;e168  40
    clrb cntr:2             ;e169  a2 12
    call sub_f6c1           ;e16b  31 f6 c1
    popw a                  ;e16e  50
    movw ep, a              ;e16f  e3
    popw ix                 ;e170  51
    popw a                  ;e171  50
    xchw a, t               ;e172  43
    popw a                  ;e173  50
    reti                    ;e174  30

irq3_e175:
;irq3 (external interrupt #3)
;diag ill input
    pushw a                 ;e175  40
    xchw a, t               ;e176  43
    pushw a                 ;e177  40
    pushw ix                ;e178  41
    movw a, ep              ;e179  f3
    pushw a                 ;e17a  40
    clrb eic2:7             ;e17b  a7 25
    call sub_f44b           ;e17d  31 f4 4b
    popw a                  ;e180  50
    movw ep, a              ;e181  e3
    popw ix                 ;e182  51
    popw a                  ;e183  50
    xchw a, t               ;e184  43
    popw a                  ;e185  50
    reti                    ;e186  30

irq2_e187:
;irq2 (external interrupt #2)
;clipping input
    pushw a                 ;e187  40
    xchw a, t               ;e188  43
    pushw a                 ;e189  40
    pushw ix                ;e18a  41
    movw a, ep              ;e18b  f3
    pushw a                 ;e18c  40
    clrb eic2:3             ;e18d  a3 25
    call sub_f693           ;e18f  31 f6 93
    popw a                  ;e192  50
    movw ep, a              ;e193  e3
    popw ix                 ;e194  51
    popw a                  ;e195  50
    xchw a, t               ;e196  43
    popw a                  ;e197  50
    reti                    ;e198  30

irq0_e199:
;irq0 (external interrupt #0)
;mfsw input
    pushw a                 ;e199  40
    xchw a, t               ;e19a  43
    pushw a                 ;e19b  40
    pushw ix                ;e19c  41
    movw a, ep              ;e19d  f3
    pushw a                 ;e19e  40
    clrb eic1:3             ;e19f  a3 24
    call sub_e34e           ;e1a1  31 e3 4e
    popw a                  ;e1a4  50
    movw ep, a              ;e1a5  e3
    popw ix                 ;e1a6  51
    popw a                  ;e1a7  50
    xchw a, t               ;e1a8  43
    popw a                  ;e1a9  50
    reti                    ;e1aa  30

    .byte 0x60              ;e1ab  60          DATA '`'
    .byte 0x01              ;e1ac  01          DATA '\x01'
    .byte 0x4D              ;e1ad  4d          DATA 'M'
    .byte 0xFC              ;e1ae  fc          DATA '\xfc'
    .byte 0x08              ;e1af  08          DATA '\x08'
    .byte 0xAA              ;e1b0  aa          DATA '\xaa'
    .byte 0x0C              ;e1b1  0c          DATA '\x0c'
    .byte 0x04              ;e1b2  04          DATA '\x04'
    .byte 0xFF              ;e1b3  ff          DATA '\xff'
    .byte 0x61              ;e1b4  61          DATA 'a'
    .byte 0x01              ;e1b5  01          DATA '\x01'
    .byte 0x4D              ;e1b6  4d          DATA 'M'
    .byte 0x20              ;e1b7  20          DATA ' '
    .byte 0xA2              ;e1b8  a2          DATA '\xa2'
    .byte 0x0C              ;e1b9  0c          DATA '\x0c'
    .byte 0x04              ;e1ba  04          DATA '\x04'
    .byte 0x00              ;e1bb  00          DATA '\x00'
    .byte 0x61              ;e1bc  61          DATA 'a'
    .byte 0x01              ;e1bd  01          DATA '\x01'
    .byte 0x4D              ;e1be  4d          DATA 'M'
    .byte 0x20              ;e1bf  20          DATA ' '


sub_e1c0:
    mov tbtc, #0x00         ;e1c0  85 0a 00
    mov wdtc, #0x00         ;e1c3  85 09 00
    mov cntr, #0x00         ;e1c6  85 12 00
    mov comr, #0x00         ;e1c9  85 13 00
    mov rlbr, #0x1f         ;e1cc  85 16 1f
    mov pcr2, #0x08         ;e1cf  85 15 08
    mov pcr1, #0xa0         ;e1d2  85 14 a0
    mov tchr, #0x00         ;e1d5  85 19 00
    mov tclr, #0x00         ;e1d8  85 1a 00
    mov tmcr, #0x03         ;e1db  85 18 03
    mov sdr1, #0x00         ;e1de  85 1d 00
    mov smr1, #0x4f         ;e1e1  85 1c 4f
    mov sdr2, #0x00         ;e1e4  85 1f 00
    mov smr2, #0x3a         ;e1e7  85 1e 3a
    mov bzcr, #0x00         ;e1ea  85 0f 00
    mov eic1, #0x01         ;e1ed  85 24 01
    bbs pdr6:1, lab_e1f6    ;e1f0  b9 11 03
    mov eic1, #0x21         ;e1f3  85 24 21

lab_e1f6:
    mov eic2, #0x10         ;e1f6  85 25 10
    mov adc1, #0x00         ;e1f9  85 20 00
    mov adc2, #0x01         ;e1fc  85 21 01
    mov ilr1, #0xa9         ;e1ff  85 7c a9
    mov ilr2, #0x9a         ;e202  85 7d 9a
    mov ilr3, #0xfe         ;e205  85 7e fe
    seti                    ;e208  90
    ret                     ;e209  20

sub_e20a:
    call sub_e24e           ;e20a  31 e2 4e
    bbs 0x009a:0, lab_e24d  ;e20d  b8 9a 3d
    bbs 0x009b:6, lab_e24d  ;e210  be 9b 3a
    bbc 0x009a:4, lab_e24d  ;e213  b4 9a 37
    clrb 0x9a:4             ;e216  a4 9a

    mov a, 0x8a             ;e218  05 8a
    mov 0x0109, a           ;e21a  61 01 09

    mov a, 0x9e             ;e21d  05 9e
    mov 0x010a, a           ;e21f  61 01 0a

    mov a, 0x013b           ;e222  60 01 3b
    mov 0x010b, a           ;e225  61 01 0b

    mov a, 0x0146           ;e228  60 01 46
    mov 0x010c, a           ;e22b  61 01 0c

    movw a, 0x0109          ;e22e  c4 01 09
    movw 0x010e, a          ;e231  d4 01 0e
    movw a, 0x010b          ;e234  c4 01 0b
    movw 0x0110, a          ;e237  d4 01 10

    mov a, #0x20            ;e23a  04 20
    mov 0x0114, a           ;e23c  61 01 14
    mov a, #0x0a            ;e23f  04 0a
    mov 0x9f, a             ;e241  45 9f
    setb 0x9b:6             ;e243  ae 9b
    clrb 0x9b:7             ;e245  a7 9b
    clrb 0x9c:2             ;e247  a2 9c
    setb 0x9a:0             ;e249  a8 9a
    setb 0x9c:0             ;e24b  a8 9c

lab_e24d:
    ret                     ;e24d  20

sub_e24e:
    bbc 0x0088:1, lab_e261  ;e24e  b1 88 10
    bbs 0x009a:0, lab_e260  ;e251  b8 9a 0c
    clrb 0x88:1             ;e254  a1 88
    setb 0x9a:4             ;e256  ac 9a
    clrb 0x9b:3             ;e258  a3 9b
    setb 0x9b:2             ;e25a  aa 9b
    mov a, #0x0a            ;e25c  04 0a
    mov 0x9d, a             ;e25e  45 9d

lab_e260:
    ret                     ;e260  20

lab_e261:
    bbc 0x009b:0, lab_e260  ;e261  b0 9b fc
    bbs 0x009a:0, lab_e260  ;e264  b8 9a f9
    clrb 0x9b:0             ;e267  a0 9b
    setb 0x9a:4             ;e269  ac 9a
    jmp lab_e260            ;e26b  21 e2 60

sub_e26e:
    bbc 0x009a:3, lab_e27c  ;e26e  b3 9a 0b
    clrb 0x9a:3             ;e271  a3 9a
    mov a, 0x0115           ;e273  60 01 15
    and a, #0xf0            ;e276  64 f0
    cmp a, #0x80            ;e278  14 80
    beq lab_e27d            ;e27a  fd 01

lab_e27c:
    ret                     ;e27c  20

lab_e27d:
    mov a, 0x0115           ;e27d  60 01 15
    cmp a, #0x81            ;e280  14 81
    beq lab_e28f            ;e282  fd 0b
    cmp a, #0x82            ;e284  14 82
    beq lab_e2a8            ;e286  fd 20
    cmp a, #0x83            ;e288  14 83
    beq lab_e2ad            ;e28a  fd 21
    jmp lab_e27c            ;e28c  21 e2 7c

lab_e28f:
;A = 0x81
    clrb 0xab:4             ;e28f  a4 ab

lab_e291:
    movw a, 0x0116          ;e291  c4 01 16
    movw 0x011c, a          ;e294  d4 01 1c     Copy 0x0116-0x0117 to 0x011c-0x011d
    movw a, 0x0118          ;e297  c4 01 18
    movw 0x011e, a          ;e29a  d4 01 1e     Copy 0x0118-0x0119 to 0x011e-0x011f
    mov a, 0x011a           ;e29d  60 01 1a
    mov 0x0120, a           ;e2a0  61 01 20     Copy 0x11a to 0x0120
    setb 0x9a:7             ;e2a3  af 9a
    jmp lab_e27c            ;e2a5  21 e2 7c

lab_e2a8:
;A = 0x82
    setb 0xab:4             ;e2a8  ac ab
    jmp lab_e291            ;e2aa  21 e2 91

lab_e2ad:
;A = 0x83
    setb 0x9c:1             ;e2ad  a9 9c
    jmp lab_e27c            ;e2af  21 e2 7c

sub_e2b2:
    bbc 0x009a:0, lab_e2db  ;e2b2  b0 9a 26
    bbc 0x009c:2, lab_e2f8  ;e2b5  b2 9c 40
    bbc 0x009c:0, lab_e2e1  ;e2b8  b0 9c 26
    clrb 0x9c:0             ;e2bb  a0 9c
    clrb pdr3:4             ;e2bd  a4 0c        /S2M_CLK_OUT = low
    clrc                    ;e2bf  81

    movw ix, #0x010e        ;e2c0  e6 01 0e
    mov a, @ix+0x03         ;e2c3  06 03
    rolc a                  ;e2c5  02

    mov @ix+0x03, a         ;e2c6  46 03
    mov a, @ix+0x02         ;e2c8  06 02
    rolc a                  ;e2ca  02

    mov @ix+0x02, a         ;e2cb  46 02
    mov a, @ix+0x01         ;e2cd  06 01
    rolc a                  ;e2cf  02

    mov @ix+0x01, a         ;e2d0  46 01
    mov a, @ix+0x00         ;e2d2  06 00
    rolc a                  ;e2d4  02

    mov @ix+0x00, a         ;e2d5  46 00
    bhs lab_e2dc            ;e2d7  f8 03
    setb pdr3:5             ;e2d9  ad 0c        S2M_DATA_OUT = high

lab_e2db:
    ret                     ;e2db  20

lab_e2dc:
    clrb pdr3:5             ;e2dc  a5 0c        S2M_DATA_OUT = low
    jmp lab_e2db            ;e2de  21 e2 db

lab_e2e1:
    setb 0x9c:0             ;e2e1  a8 9c
    movw a, #0x0000         ;e2e3  e4 00 00
    mov a, 0x0114           ;e2e6  60 01 14
    decw a                  ;e2e9  d0
    mov 0x0114, a           ;e2ea  61 01 14
    bne lab_e2f3            ;e2ed  fc 04
    clrb 0x9a:0             ;e2ef  a0 9a
    setb pdr2:0             ;e2f1  a8 04        /S2M_ENA_OUT = high

lab_e2f3:
    setb pdr3:4             ;e2f3  ac 0c        /S2M_CLK_OUT = high
    jmp lab_e2db            ;e2f5  21 e2 db

lab_e2f8:
    clrb pdr2:0             ;e2f8  a0 04        /S2M_ENA_OUT = low
    setb 0x9c:2             ;e2fa  aa 9c
    jmp lab_e2db            ;e2fc  21 e2 db

sub_e2ff:
;something to do with main-to-sub bus.  new byte received?
    bbc 0x009a:2, lab_e307  ;e2ff  b2 9a 05
    mov a, #0x00            ;e302  04 00
    mov 0x0122, a           ;e304  61 01 22

lab_e307:
    mov a, #0x04            ;e307  04 04
    mov 0x0121, a           ;e309  61 01 21
    setb 0x9a:1             ;e30c  a9 9a
    clrb 0x9a:2             ;e30e  a2 9a
    movw ix, #0x0115        ;e310  e6 01 15
    movw a, @ix+0x01        ;e313  c6 01
    movw @ix+0x00, a        ;e315  d6 00
    movw a, @ix+0x03        ;e317  c6 03
    movw @ix+0x02, a        ;e319  d6 02
    mov a, @ix+0x05         ;e31b  06 05
    mov @ix+0x04, a         ;e31d  46 04
    mov a, sdr1             ;e31f  05 1d        A = byte from M2S_DATA_IN
    mov @ix+0x05, a         ;e321  46 05
    setb smr1:0             ;e323  a8 1c
    mov a, 0x0122           ;e325  60 01 22
    incw a                  ;e328  c0
    mov 0x0122, a           ;e329  61 01 22
    mov a, #0x06            ;e32c  04 06
    cmp a                   ;e32e  12           6 bytes received from Main-MCU?
    bne lab_e339            ;e32f  fc 08        No: branch to lab_e339
    setb 0x9a:3             ;e331  ab 9a

lab_e333:
    mov a, #0x00            ;e333  04 00
    mov 0x0122, a           ;e335  61 01 22

lab_e338:
    ret                     ;e338  20

lab_e339:
    mov a, 0x0122           ;e339  60 01 22
    cmp a, #0x01            ;e33c  14 01        1 byte received from Main-MCU?
    bne lab_e338            ;e33e  fc f8        No: branch to return
    movw ix, #0x0115        ;e340  e6 01 15
    mov a, @ix+0x05         ;e343  06 05
    and a, #0xf0            ;e345  64 f0
    cmp a, #0x80            ;e347  14 80
    beq lab_e338            ;e349  fd ed
    jmp lab_e333            ;e34b  21 e3 33

sub_e34e:
;mfsw changed
    mov a, 0x0126           ;e34e  60 01 26
    bne lab_e35e            ;e351  fc 0b
    movw a, tchr            ;e353  c5 19
    movw 0x0124, a          ;e355  d4 01 24
    mov a, #0x01            ;e358  04 01
    mov 0x0126, a           ;e35a  61 01 26

lab_e35d:
    ret                     ;e35d  20

lab_e35e:
    call sub_e364           ;e35e  31 e3 64
    jmp lab_e35d            ;e361  21 e3 5d

sub_e364:
;mfsw got bit
    mov a, 0x0126           ;e364  60 01 26
    incw a                  ;e367  c0
    mov 0x0126, a           ;e368  61 01 26
    movw a, tchr            ;e36b  c5 19
    movw a, 0x0124          ;e36d  c4 01 24
    clrc                    ;e370  81
    subcw a                 ;e371  33
    movw 0x012d, a          ;e372  d4 01 2d
    movw a, tchr            ;e375  c5 19
    movw 0x0124, a          ;e377  d4 01 24

    movw a, 0x012d          ;e37a  c4 01 2d
    movw a, #0x9c40         ;e37d  e4 9c 40
    cmpw a                  ;e380  13
    blo lab_e389            ;e381  f9 06

    mov a, #0x01            ;e383  04 01
    mov 0x0126, a           ;e385  61 01 26

lab_e388:
    ret                     ;e388  20

lab_e389:
;0x012d < #0x9c40
    movw a, 0x012d          ;e389  c4 01 2d
    movw a, #0x60ae         ;e38c  e4 60 ae
    cmpw a                  ;e38f  13
    blo lab_e395            ;e390  f9 03
    jmp lab_e388            ;e392  21 e3 88     ;return

lab_e395:
;0x012d < #0x60ae
    movw a, 0x012d          ;e395  c4 01 2d
    movw a, #0x34b2         ;e398  e4 34 b2
    cmpw a                  ;e39b  13
    blo lab_e3ab            ;e39c  f9 0d

;0x012d >= #0x34b2
    bbc 0x00a0:3, lab_e3a3  ;e39e  b3 a0 02
    setb 0xa0:7             ;e3a1  af a0

lab_e3a3:
    mov a, #0x00            ;e3a3  04 00
    mov 0x0126, a           ;e3a5  61 01 26
    jmp lab_e388            ;e3a8  21 e3 88     ;return

lab_e3ab:
;0x012d < #0x34b2
    movw a, 0x012d          ;e3ab  c4 01 2d
    movw a, #0x0d20         ;e3ae  e4 0d 20
    cmpw a                  ;e3b1  13
    blo lab_e3bb            ;e3b2  f9 07
    setc                    ;e3b4  91

lab_e3b5:
    call sub_e3bf           ;e3b5  31 e3 bf
    jmp lab_e388            ;e3b8  21 e3 88     ;return

lab_e3bb:
    clrc                    ;e3bb  81
    jmp lab_e3b5            ;e3bc  21 e3 b5

sub_e3bf:
;New MFSW bit received; it's in the carry flag
;
;MFSW buffer is 0x0129 - 0x012C
;
;                0x012c  0x012b  0x012a  0x0129
;                ------  ------  ------  ------
;Volume Down      0x41    0xE8    0x00    0xFF      Thought it was these values
;Volume Up        0x41    0xE8    0x80    0x7F
;Down             0x41    0xE8    0x50    0xAF
;Up               0x41    0xE8    0xD0    0x2F
;
;Volume Down      0x82    0x17    0x00    0xFF      Code seems to want this
;Volume Up        0x82    0x17    0x01    0xFE
;Down             0x82    0x17    0x0a    0xF5
;Up               0x82    0x17    0x0b    0xF4
;
    mov a, 0x0129           ;e3bf  60 01 29     ;rotate
    rorc a                  ;e3c2  03
    mov 0x0129, a           ;e3c3  61 01 29

    mov a, 0x012a           ;e3c6  60 01 2a     ;rotate
    rorc a                  ;e3c9  03
    mov 0x012a, a           ;e3ca  61 01 2a

    mov a, 0x012b           ;e3cd  60 01 2b     ;rotate
    rorc a                  ;e3d0  03
    mov 0x012b, a           ;e3d1  61 01 2b

    mov a, 0x012c           ;e3d4  60 01 2c     ;rotate
    rorc a                  ;e3d7  03
    mov 0x012c, a           ;e3d8  61 01 2c

    mov a, 0x0126           ;e3db  60 01 26     ;compare count of bits received?
    cmp a, #0x22            ;e3de  14 22
    bne lab_e406            ;e3e0  fc 24        ;branch if != 34 bits

    movw a, 0x012b          ;e3e2  c4 01 2b     ;compare first two bytes in packet
    movw a, #0x1782         ;e3e5  e4 17 82
    cmpw a                  ;e3e8  13
    bne lab_e407            ;e3e9  fc 1c        ;branch if != 0x1782

    setb 0xa0:3             ;e3eb  ab a0

    mov a, 0x0129           ;e3ed  60 01 29
    mov a, 0x012a           ;e3f0  60 01 2a
    xor a                   ;e3f3  52
    incw a                  ;e3f4  c0
    cmp a, #0x00            ;e3f5  14 00
    bne lab_e401            ;e3f7  fc 08        ;checksum failed?

    mov a, 0x012a           ;e3f9  60 01 2a     ;equal: load a = 0x012a
    mov 0x0128, a           ;e3fc  61 01 28     ;       store a in 0x0128
    setb 0xa0:0             ;e3ff  a8 a0

lab_e401:
    mov a, #0x00            ;e401  04 00
    mov 0x0126, a           ;e403  61 01 26     ;not equal

lab_e406:
    ret                     ;e406  20

lab_e407:
;checksum didn't match?
    clrb 0xa0:3             ;e407  a3 a0
    jmp lab_e401            ;e409  21 e4 01

sub_e40c:
    bbc 0x00a0:0, lab_e41d  ;e40c  b0 a0 0e
    clrb 0xa0:0             ;e40f  a0 a0

    mov a, 0x0128           ;e411  60 01 28     ;Copy 0x128 to 0x127
    mov 0x0127, a           ;e414  61 01 27

lab_e417:
    mov a, #0x0f            ;e417  04 0f
    mov 0x0123, a           ;e419  61 01 23

lab_e41c:
    ret                     ;e41c  20

lab_e41d:
    bbc 0x00a0:7, lab_e42f  ;e41d  b7 a0 0f
    clrb 0xa0:7             ;e420  a7 a0
    mov a, 0x0123           ;e422  60 01 23
    bne lab_e417            ;e425  fc f0

lab_e427:
    mov a, #0xff            ;e427  04 ff
    mov 0x0127, a           ;e429  61 01 27
    jmp lab_e41c            ;e42c  21 e4 1c     ;jmp to ret

lab_e42f:
    mov a, 0x0123           ;e42f  60 01 23
    beq lab_e427            ;e432  fd f3
    jmp lab_e41c            ;e434  21 e4 1c

sub_e437:
    mov a, 0x014a           ;e437  60 01 4a
    incw a                  ;e43a  c0
    mov 0x014a, a           ;e43b  61 01 4a
    ret                     ;e43e  20

sub_e43f:
;Convert buffer at 0x012f-0x139 from ASCII to uPD16432B codes
;
    movw ep, #0x012f        ;e43f  e7 01 2f
    call sub_e49b           ;e442  31 e4 9b     Replace ASCII code at 0x012f with uPD16432B char code
    movw ep, #0x0130        ;e445  e7 01 30
    call sub_e49b           ;e448  31 e4 9b     Replace ASCII code at 0x0130 with uPD16432B char code
    movw ep, #0x0131        ;e44b  e7 01 31
    bbs 0x00a9:1, lab_e457  ;e44e  b9 a9 06
    call sub_e49b           ;e451  31 e4 9b     Replace ASCII code at 0x0131 with uPD16432B char code
    jmp lab_e45a            ;e454  21 e4 5a

lab_e457:
    call sub_e515           ;e457  31 e5 15

lab_e45a:
    movw ep, #0x0132        ;e45a  e7 01 32
    bbs 0x00a9:1, lab_e466  ;e45d  b9 a9 06
    call sub_e49b           ;e460  31 e4 9b     Replace ASCII code at 0x0132 with uPD16432B char code
    jmp lab_e469            ;e463  21 e4 69     Jump to convert buffer at 0x0133-0x139 from ASCII to uPD16432B

lab_e466:
    call sub_e536           ;e466  31 e5 36

lab_e469:
;Convert buffer at 0x0133-0x139 from ASCII to uPD16432B codes
;
    movw ep, #0x0133        ;e469  e7 01 33
    call sub_e49b           ;e46c  31 e4 9b     Replace ASCII code at 0x0133 with uPD16432B char code
    movw ep, #0x0134        ;e46f  e7 01 34
    call sub_e49b           ;e472  31 e4 9b     Replace ASCII code at 0x0134 with uPD16432B char code
    movw ep, #0x0135        ;e475  e7 01 35
    call sub_e49b           ;e478  31 e4 9b     Replace ASCII code at 0x0135 with uPD16432B char code
    movw ep, #0x0136        ;e47b  e7 01 36
    call sub_e49b           ;e47e  31 e4 9b     Replace ASCII code at 0x0136 with uPD16432B char code
    movw ep, #0x0137        ;e481  e7 01 37
    call sub_e49b           ;e484  31 e4 9b     Replace ASCII code at 0x0137 with uPD16432B char code
    movw ep, #0x0138        ;e487  e7 01 38
    call sub_e49b           ;e48a  31 e4 9b     Replace ASCII code at 0x0138 with uPD16432B char code
    movw ep, #0x0139        ;e48d  e7 01 39
    call sub_e49b           ;e490  31 e4 9b     Replace ASCII code at 0x0139 with uPD16432B char code
    bbs 0x00ab:4, lab_e49a  ;e493  bc ab 04
    setb 0x87:2             ;e496  aa 87
    setb 0xab:5             ;e498  ad ab

lab_e49a:
    ret                     ;e49a  20

sub_e49b:
;Replace the ASCII code at @ep with its equivalent upd16432B character code.
;
    mov a, @ep              ;e49b  07
    mov a, #0x20            ;e49c  04 20
    cmp a                   ;e49e  12
    blo lab_e4b7            ;e49f  f9 16
    mov a, @ep              ;e4a1  07
    mov a, #0x7b            ;e4a2  04 7b
    cmp a                   ;e4a4  12
    bhs lab_e4b7            ;e4a5  f8 10
    movw a, #0x0000         ;e4a7  e4 00 00
    mov a, @ep              ;e4aa  07
    mov a, #0x20            ;e4ab  04 20
    clrc                    ;e4ad  81
    subc a                  ;e4ae  32
    movw a, #0xe4ba         ;e4af  e4 e4 ba
    clrc                    ;e4b2  81
    addcw a                 ;e4b3  23
    mov a, @a               ;e4b4  92
    mov @ep, a              ;e4b5  47
    ret                     ;e4b6  20

lab_e4b7:
    mov @ep, #0x20          ;e4b7  87 20
    ret                     ;e4b9  20

    .byte 0x20              ;e4ba  20          DATA ' '
    .byte 0x20              ;e4bb  20          DATA ' '
    .byte 0x20              ;e4bc  20          DATA ' '
    .byte 0x20              ;e4bd  20          DATA ' '
    .byte 0x20              ;e4be  20          DATA ' '
    .byte 0x20              ;e4bf  20          DATA ' '
    .byte 0x20              ;e4c0  20          DATA ' '
    .byte 0x20              ;e4c1  20          DATA ' '
    .byte 0x20              ;e4c2  20          DATA ' '
    .byte 0x20              ;e4c3  20          DATA ' '
    .byte 0x20              ;e4c4  20          DATA ' '
    .byte 0x2B              ;e4c5  2b          DATA '+'
    .byte 0x20              ;e4c6  20          DATA ' '
    .byte 0x2D              ;e4c7  2d          DATA '-'
    .byte 0x20              ;e4c8  20          DATA ' '
    .byte 0x20              ;e4c9  20          DATA ' '
    .byte 0xE4              ;e4ca  e4          DATA '\xe4'
    .byte 0xE5              ;e4cb  e5          DATA '\xe5'
    .byte 0xF3              ;e4cc  f3          DATA '\xf3'
    .byte 0xE6              ;e4cd  e6          DATA '\xe6'
    .byte 0xE7              ;e4ce  e7          DATA '\xe7'
    .byte 0xE8              ;e4cf  e8          DATA '\xe8'
    .byte 0xE9              ;e4d0  e9          DATA '\xe9'
    .byte 0x37              ;e4d1  37          DATA '7'
    .byte 0x38              ;e4d2  38          DATA '8'
    .byte 0xEA              ;e4d3  ea          DATA '\xea'
    .byte 0x20              ;e4d4  20          DATA ' '
    .byte 0x20              ;e4d5  20          DATA ' '
    .byte 0x20              ;e4d6  20          DATA ' '
    .byte 0x20              ;e4d7  20          DATA ' '
    .byte 0x20              ;e4d8  20          DATA ' '
    .byte 0x20              ;e4d9  20          DATA ' '
    .byte 0x20              ;e4da  20          DATA ' '
    .byte 0xE0              ;e4db  e0          DATA '\xe0'
    .byte 0xE1              ;e4dc  e1          DATA '\xe1'
    .byte 0x43              ;e4dd  43          DATA 'C'
    .byte 0x44              ;e4de  44          DATA 'D'
    .byte 0x45              ;e4df  45          DATA 'E'
    .byte 0x46              ;e4e0  46          DATA 'F'
    .byte 0x47              ;e4e1  47          DATA 'G'
    .byte 0x48              ;e4e2  48          DATA 'H'
    .byte 0x49              ;e4e3  49          DATA 'I'
    .byte 0x4A              ;e4e4  4a          DATA 'J'
    .byte 0x4B              ;e4e5  4b          DATA 'K'
    .byte 0x4C              ;e4e6  4c          DATA 'L'
    .byte 0x4D              ;e4e7  4d          DATA 'M'
    .byte 0xE2              ;e4e8  e2          DATA '\xe2'
    .byte 0x4F              ;e4e9  4f          DATA 'O'
    .byte 0x50              ;e4ea  50          DATA 'P'
    .byte 0x51              ;e4eb  51          DATA 'Q'
    .byte 0x52              ;e4ec  52          DATA 'R'
    .byte 0x53              ;e4ed  53          DATA 'S'
    .byte 0x54              ;e4ee  54          DATA 'T'
    .byte 0x55              ;e4ef  55          DATA 'U'
    .byte 0xE3              ;e4f0  e3          DATA '\xe3'
    .byte 0x57              ;e4f1  57          DATA 'W'
    .byte 0x58              ;e4f2  58          DATA 'X'
    .byte 0x59              ;e4f3  59          DATA 'Y'
    .byte 0x5A              ;e4f4  5a          DATA 'Z'
    .byte 0x20              ;e4f5  20          DATA ' '
    .byte 0x20              ;e4f6  20          DATA ' '
    .byte 0x20              ;e4f7  20          DATA ' '
    .byte 0x20              ;e4f8  20          DATA ' '
    .byte 0x20              ;e4f9  20          DATA ' '
    .byte 0x20              ;e4fa  20          DATA ' '
    .byte 0x61              ;e4fb  61          DATA 'a'
    .byte 0x62              ;e4fc  62          DATA 'b'
    .byte 0x63              ;e4fd  63          DATA 'c'
    .byte 0x64              ;e4fe  64          DATA 'd'
    .byte 0x65              ;e4ff  65          DATA 'e'
    .byte 0x66              ;e500  66          DATA 'f'
    .byte 0x67              ;e501  67          DATA 'g'
    .byte 0x68              ;e502  68          DATA 'h'
    .byte 0x69              ;e503  69          DATA 'i'
    .byte 0x6A              ;e504  6a          DATA 'j'
    .byte 0x6B              ;e505  6b          DATA 'k'
    .byte 0x6C              ;e506  6c          DATA 'l'
    .byte 0x6D              ;e507  6d          DATA 'm'
    .byte 0x6E              ;e508  6e          DATA 'n'
    .byte 0x6F              ;e509  6f          DATA 'o'
    .byte 0x70              ;e50a  70          DATA 'p'
    .byte 0x71              ;e50b  71          DATA 'q'
    .byte 0x72              ;e50c  72          DATA 'r'
    .byte 0x73              ;e50d  73          DATA 's'
    .byte 0x74              ;e50e  74          DATA 't'
    .byte 0x75              ;e50f  75          DATA 'u'
    .byte 0x76              ;e510  76          DATA 'v'
    .byte 0x77              ;e511  77          DATA 'w'
    .byte 0x78              ;e512  78          DATA 'x'
    .byte 0x79              ;e513  79          DATA 'y'
    .byte 0x7A              ;e514  7a          DATA 'z'


sub_e515:
    mov a, @ep              ;e515  07
    mov a, #0x31            ;e516  04 31
    cmp a                   ;e518  12
    blo lab_e531            ;e519  f9 16
    mov a, @ep              ;e51b  07
    mov a, #0x33            ;e51c  04 33
    cmp a                   ;e51e  12
    bhs lab_e531            ;e51f  f8 10
    movw a, #0x0000         ;e521  e4 00 00
    mov a, @ep              ;e524  07
    mov a, #0x31            ;e525  04 31
    clrc                    ;e527  81
    subc a                  ;e528  32
    movw a, #0xe534         ;e529  e4 e5 34
    clrc                    ;e52c  81
    addcw a                 ;e52d  23
    mov a, @a               ;e52e  92
    mov @ep, a              ;e52f  47
    ret                     ;e530  20

lab_e531:
    mov @ep, #0x20          ;e531  87 20
    ret                     ;e533  20

    .byte 0xEB              ;e534  eb          DATA '\xeb'
    .byte 0xEC              ;e535  ec          DATA '\xec'


sub_e536:
    mov a, @ep              ;e536  07
    mov a, #0x31            ;e537  04 31
    cmp a                   ;e539  12
    blo lab_e552            ;e53a  f9 16
    mov a, @ep              ;e53c  07
    mov a, #0x37            ;e53d  04 37
    cmp a                   ;e53f  12
    bhs lab_e552            ;e540  f8 10
    movw a, #0x0000         ;e542  e4 00 00
    mov a, @ep              ;e545  07
    mov a, #0x31            ;e546  04 31
    clrc                    ;e548  81
    subc a                  ;e549  32
    movw a, #0xe555         ;e54a  e4 e5 55
    clrc                    ;e54d  81
    addcw a                 ;e54e  23
    mov a, @a               ;e54f  92
    mov @ep, a              ;e550  47
    ret                     ;e551  20

lab_e552:
    mov @ep, #0x20          ;e552  87 20
    ret                     ;e554  20

    .byte 0xE5              ;e555  e5          DATA '\xe5'
    .byte 0xED              ;e556  ed          DATA '\xed'
    .byte 0xEE              ;e557  ee          DATA '\xee'
    .byte 0xEF              ;e558  ef          DATA '\xef'
    .byte 0xF0              ;e559  f0          DATA '\xf0'
    .byte 0xF2              ;e55a  f2          DATA '\xf2'


sub_e55b:
    movw a, ps              ;e55b  70
    movw a, #0x00ff         ;e55c  e4 00 ff
    andw a                  ;e55f  63
    movw ps, a              ;e560  71
    bbc 0x009a:7, lab_e57f  ;e561  b7 9a 1b
    clrb 0x9a:7             ;e564  a7 9a
    setb 0x9c:3             ;e566  ab 9c
    clrb 0xa9:0             ;e568  a0 a9
    clrb 0xa9:1             ;e56a  a1 a9
    movw ep, #0x011d        ;e56c  e7 01 1d
    mov a, @ep              ;e56f  07
    beq lab_e5d0            ;e570  fd 5e
    cmp a, #0x10            ;e572  14 10
    bhs lab_e580            ;e574  f8 0a
    call sub_e60f           ;e576  31 e6 0f

lab_e579:
    call sub_e5d6           ;e579  31 e5 d6
    call sub_e43f           ;e57c  31 e4 3f     Convert buffer at 0x012f-0x139 from ASCII to uPD16432B codes

lab_e57f:
    ret                     ;e57f  20

lab_e580:
;A >= 0x10
    cmp a, #0x20            ;e580  14 20
    bhs lab_e58a            ;e582  f8 06
    call sub_e6f6           ;e584  31 e6 f6     Call if A >= 0x10, A < 0x20
    jmp lab_e579            ;e587  21 e5 79

lab_e58a:
;A >= 0x20
    cmp a, #0x40            ;e58a  14 40
    bhs lab_e594            ;e58c  f8 06
    call sub_e761           ;e58e  31 e7 61     Call if A >= 0x20, A < 0x40
    jmp lab_e579            ;e591  21 e5 79

lab_e594:
;A >= 0x40
    cmp a, #0x50            ;e594  14 50
    bhs lab_e59e            ;e596  f8 06
    call sub_e931           ;e598  31 e9 31     Call if A >= 0x40, A < 0x50
    jmp lab_e579            ;e59b  21 e5 79

lab_e59e:
;A >= 0x50
    cmp a, #0x60            ;e59e  14 60
    bhs lab_e5a8            ;e5a0  f8 06
    call sub_e9f1           ;e5a2  31 e9 f1     Call if A >= 0x50, A < 0x60
    jmp lab_e579            ;e5a5  21 e5 79

lab_e5a8:
;A >= 0x60
    cmp a, #0x80            ;e5a8  14 80
    bhs lab_e5b2            ;e5aa  f8 06
    call sub_ea6b           ;e5ac  31 ea 6b     Call if A >= 0x60, A < 0x80
    jmp lab_e579            ;e5af  21 e5 79

lab_e5b2:
;A >= 0x80
    cmp a, #0xb0            ;e5b2  14 b0
    bhs lab_e5bc            ;e5b4  f8 06
    call sub_eb78           ;e5b6  31 eb 78     Call if A >= 0x80, A < 0xB0
    jmp lab_e579            ;e5b9  21 e5 79

lab_e5bc:
;A >= 0xb0
    cmp a, #0xc0            ;e5bc  14 c0
    bhs lab_e5c6            ;e5be  f8 06
    call sub_ec12           ;e5c0  31 ec 12     Call if A >= 0xB0, A < 0xC0
    jmp lab_e579            ;e5c3  21 e5 79

lab_e5c6:
;A >= 0xc0
    cmp a, #0xd0            ;e5c6  14 d0
    bhs lab_e5d0            ;e5c8  f8 06
    call sub_ec50           ;e5ca  31 ec 50     Call if A >= 0xC0, A < 0xD0
    jmp lab_e579            ;e5cd  21 e5 79

lab_e5d0:
;A > 0xD0
    call sub_ec8e           ;e5d0  31 ec 8e     Call if A > 0xD0
    jmp lab_e579            ;e5d3  21 e5 79

sub_e5d6:
    movw ix, #0x00a1        ;e5d6  e6 00 a1
    movw a, #0x0000         ;e5d9  e4 00 00
    movw @ix+0x00, a        ;e5dc  d6 00
    movw @ix+0x02, a        ;e5de  d6 02
    movw @ix+0x04, a        ;e5e0  d6 04
    movw @ix+0x06, a        ;e5e2  d6 06
    movw ep, #0x011c        ;e5e4  e7 01 1c
    mov a, @ep              ;e5e7  07
    rorc a                  ;e5e8  03
    bhs lab_e5ed            ;e5e9  f8 02
    setb 0xa8:3             ;e5eb  ab a8

lab_e5ed:
    rorc a                  ;e5ed  03
    bhs lab_e5f2            ;e5ee  f8 02
    setb 0xa7:0             ;e5f0  a8 a7

lab_e5f2:
    rorc a                  ;e5f2  03
    bhs lab_e5f7            ;e5f3  f8 02
    setb 0xa7:5             ;e5f5  ad a7

lab_e5f7:
    rorc a                  ;e5f7  03
    bhs lab_e5fc            ;e5f8  f8 02
    setb 0xa3:3             ;e5fa  ab a3

lab_e5fc:
    rorc a                  ;e5fc  03
    bhs lab_e601            ;e5fd  f8 02
    setb 0xa2:0             ;e5ff  a8 a2

lab_e601:
    rorc a                  ;e601  03
    bhs lab_e606            ;e602  f8 02
    setb 0xa2:5             ;e604  ad a2

lab_e606:
    rorc a                  ;e606  03
    blo lab_e60c            ;e607  f9 03
    bbc 0x00a9:0, lab_e60e  ;e609  b0 a9 02

lab_e60c:
    setb 0xa4:6             ;e60c  ae a4

lab_e60e:
    ret                     ;e60e  20

sub_e60f:
    movw a, #0x0000         ;e60f  e4 00 00
    mov a, @ep              ;e612  07
    mov a, #0x01            ;e613  04 01
    clrc                    ;e615  81
    subc a                  ;e616  32
    mov r0, a               ;e617  48
    movw a, #0x000b         ;e618  e4 00 0b
    mulu a                  ;e61b  01
    movw a, #0xedad         ;e61c  e4 ed ad     A = pointer to table of LCD messages
    clrc                    ;e61f  81
    addcw a                 ;e620  23
    movw ix, a              ;e621  e2
    movw ep, #0x012f        ;e622  e7 01 2f
    call sub_eca1           ;e625  31 ec a1
    movw ix, #0x012f        ;e628  e6 01 2f
    movw ep, #0x011e        ;e62b  e7 01 1e
    movw a, #0x0000         ;e62e  e4 00 00
    mov a, r0               ;e631  08
    cmp a, #0x0f            ;e632  14 0f
    bhs lab_e65d            ;e634  f8 27
    clrc                    ;e636  81
    rolc a                  ;e637  02
    movw a, #0xe63f         ;e638  e4 e6 3f
    clrc                    ;e63b  81
    addcw a                 ;e63c  23
    movw a, @a              ;e63d  93
    jmp @a                  ;e63e  e0

    .word lab_e661          ;e63f  e6 61       VECTOR
    .word lab_e677          ;e641  e6 77       VECTOR
    .word lab_e69e          ;e643  e6 9e       VECTOR
    .word lab_e6a1          ;e645  e6 a1       VECTOR
    .word lab_e6b7          ;e647  e6 b7       VECTOR
    .word lab_e6ba          ;e649  e6 ba       VECTOR
    .word lab_e6bd          ;e64b  e6 bd       VECTOR
    .word lab_e6c0          ;e64d  e6 c0       VECTOR
    .word lab_e6c9          ;e64f  e6 c9       VECTOR
    .word lab_e6d2          ;e651  e6 d2       VECTOR
    .word lab_e6db          ;e653  e6 db       VECTOR
    .word lab_e6de          ;e655  e6 de       VECTOR
    .word lab_e6e1          ;e657  e6 e1       VECTOR
    .word lab_e6ea          ;e659  e6 ea       VECTOR
    .word lab_e6ed          ;e65b  e6 ed       VECTOR


lab_e65d:
    call sub_ecce           ;e65d  31 ec ce
    ret                     ;e660  20

lab_e661:
    mov a, @ep              ;e661  07
    call sub_ed92           ;e662  31 ed 92
    mov @ix+0x03, a         ;e665  46 03
    incw ep                 ;e667  c3
    mov a, @ep              ;e668  07
    call sub_ed88           ;e669  31 ed 88
    mov @ix+0x08, a         ;e66c  46 08
    mov a, @ep              ;e66e  07
    call sub_ed92           ;e66f  31 ed 92
    mov @ix+0x09, a         ;e672  46 09
    jmp lab_e65d            ;e674  21 e6 5d

lab_e677:
    incw ep                 ;e677  c3
    mov a, @ep              ;e678  07
    and a, #0xf0            ;e679  64 f0
    beq lab_e688            ;e67b  fd 0b
    call sub_ed88           ;e67d  31 ed 88
    cmp a, #0x41            ;e680  14 41
    bne lab_e686            ;e682  fc 02
    mov a, #0x2d            ;e684  04 2d

lab_e686:
    mov @ix+0x05, a         ;e686  46 05

lab_e688:
    mov a, @ep              ;e688  07
    call sub_ed92           ;e689  31 ed 92
    mov @ix+0x06, a         ;e68c  46 06
    incw ep                 ;e68e  c3
    mov a, @ep              ;e68f  07
    call sub_ed88           ;e690  31 ed 88
    mov @ix+0x07, a         ;e693  46 07
    mov a, @ep              ;e695  07
    call sub_ed92           ;e696  31 ed 92
    mov @ix+0x08, a         ;e699  46 08
    jmp lab_e65d            ;e69b  21 e6 5d

lab_e69e:
    jmp lab_e677            ;e69e  21 e6 77

lab_e6a1:
    mov a, @ep              ;e6a1  07
    call sub_ed92           ;e6a2  31 ed 92
    mov @ix+0x06, a         ;e6a5  46 06
    incw ep                 ;e6a7  c3
    mov a, @ep              ;e6a8  07
    call sub_ed88           ;e6a9  31 ed 88
    mov @ix+0x09, a         ;e6ac  46 09
    mov a, @ep              ;e6ae  07
    call sub_ed92           ;e6af  31 ed 92
    mov @ix+0x0a, a         ;e6b2  46 0a
    jmp lab_e65d            ;e6b4  21 e6 5d

lab_e6b7:
    jmp lab_e65d            ;e6b7  21 e6 5d

lab_e6ba:
    jmp lab_e65d            ;e6ba  21 e6 5d

lab_e6bd:
    jmp lab_e65d            ;e6bd  21 e6 5d

lab_e6c0:
    mov a, @ep              ;e6c0  07
    call sub_ed92           ;e6c1  31 ed 92
    mov @ix+0x03, a         ;e6c4  46 03
    jmp lab_e65d            ;e6c6  21 e6 5d

lab_e6c9:
    mov a, @ep              ;e6c9  07
    call sub_ed92           ;e6ca  31 ed 92
    mov @ix+0x03, a         ;e6cd  46 03
    jmp lab_e677            ;e6cf  21 e6 77

lab_e6d2:
    mov a, @ep              ;e6d2  07
    call sub_ed92           ;e6d3  31 ed 92
    mov @ix+0x03, a         ;e6d6  46 03
    jmp lab_e65d            ;e6d8  21 e6 5d

lab_e6db:
    jmp lab_e6d2            ;e6db  21 e6 d2

lab_e6de:
    jmp lab_e65d            ;e6de  21 e6 5d

lab_e6e1:
    mov a, @ep              ;e6e1  07
    call sub_ed92           ;e6e2  31 ed 92
    mov @ix+0x02, a         ;e6e5  46 02
    jmp lab_e65d            ;e6e7  21 e6 5d

lab_e6ea:
    jmp lab_e65d            ;e6ea  21 e6 5d

lab_e6ed:
    mov a, @ep              ;e6ed  07
    call sub_ed92           ;e6ee  31 ed 92
    mov @ix+0x03, a         ;e6f1  46 03
    jmp lab_e65d            ;e6f3  21 e6 5d

sub_e6f6:
;Called if A >= 0x10 and A < 0x20
    movw a, #0x0000         ;e6f6  e4 00 00
    mov a, @ep              ;e6f9  07
    mov a, #0x10            ;e6fa  04 10
    clrc                    ;e6fc  81
    subc a                  ;e6fd  32
    mov r0, a               ;e6fe  48
    movw a, #0x000b         ;e6ff  e4 00 0b
    mulu a                  ;e702  01
    movw a, #0xee52         ;e703  e4 ee 52
    clrc                    ;e706  81
    addcw a                 ;e707  23
    movw ix, a              ;e708  e2
    movw ep, #0x012f        ;e709  e7 01 2f
    call sub_eca1           ;e70c  31 ec a1
    movw ix, #0x012f        ;e70f  e6 01 2f
    movw ep, #0x011e        ;e712  e7 01 1e
    movw a, #0x0000         ;e715  e4 00 00
    mov a, r0               ;e718  08
    cmp a, #0x07            ;e719  14 07
    bhs lab_e734            ;e71b  f8 17
    clrc                    ;e71d  81
    rolc a                  ;e71e  02
    movw a, #0xe726         ;e71f  e4 e7 26
    clrc                    ;e722  81
    addcw a                 ;e723  23
    movw a, @a              ;e724  93
    jmp @a                  ;e725  e0

    .word lab_e738          ;e726  e7 38       VECTOR
    .word lab_e73b          ;e728  e7 3b       VECTOR
    .word lab_e73e          ;e72a  e7 3e       VECTOR
    .word lab_e755          ;e72c  e7 55       VECTOR
    .word lab_e758          ;e72e  e7 58       VECTOR
    .word lab_e75b          ;e730  e7 5b       VECTOR
    .word lab_e75e          ;e732  e7 5e       VECTOR


lab_e734:
    call sub_ecce           ;e734  31 ec ce
    ret                     ;e737  20

lab_e738:
    jmp lab_e734            ;e738  21 e7 34

lab_e73b:
    jmp lab_e734            ;e73b  21 e7 34

lab_e73e:
    mov a, @ep              ;e73e  07
    call sub_ed5d           ;e73f  31 ed 5d
    mov a, r7               ;e742  0f
    and a, #0xf0            ;e743  64 f0
    beq lab_e74c            ;e745  fd 05
    call sub_ed88           ;e747  31 ed 88
    mov @ix+0x09, a         ;e74a  46 09

lab_e74c:
    mov a, r7               ;e74c  0f
    call sub_ed92           ;e74d  31 ed 92
    mov @ix+0x0a, a         ;e750  46 0a
    jmp lab_e734            ;e752  21 e7 34

lab_e755:
    jmp lab_e734            ;e755  21 e7 34

lab_e758:
    jmp lab_e734            ;e758  21 e7 34

lab_e75b:
    jmp lab_e734            ;e75b  21 e7 34

lab_e75e:
    jmp lab_e734            ;e75e  21 e7 34

sub_e761:
;Called if A >= 0x20 and A < 0x40
    movw a, #0x0000         ;e761  e4 00 00
    mov a, @ep              ;e764  07
    mov a, #0x20            ;e765  04 20
    clrc                    ;e767  81
    subc a                  ;e768  32
    mov r0, a               ;e769  48
    movw a, #0x000b         ;e76a  e4 00 0b
    mulu a                  ;e76d  01
    movw a, #0xee9f         ;e76e  e4 ee 9f
    clrc                    ;e771  81
    addcw a                 ;e772  23
    movw ix, a              ;e773  e2
    movw ep, #0x012f        ;e774  e7 01 2f
    call sub_eca1           ;e777  31 ec a1
    movw ix, #0x012f        ;e77a  e6 01 2f
    movw ep, #0x011e        ;e77d  e7 01 1e
    movw a, #0x0000         ;e780  e4 00 00
    mov a, r0               ;e783  08
    cmp a, #0x18            ;e784  14 18
    bhs lab_e7c1            ;e786  f8 39
    clrc                    ;e788  81
    rolc a                  ;e789  02
    movw a, #0xe791         ;e78a  e4 e7 91
    clrc                    ;e78d  81
    addcw a                 ;e78e  23
    movw a, @a              ;e78f  93
    jmp @a                  ;e790  e0

    .word lab_e7c5          ;e791  e7 c5       VECTOR
    .word lab_e7c8          ;e793  e7 c8       VECTOR
    .word lab_e7e9          ;e795  e7 e9       VECTOR
    .word lab_e828          ;e797  e8 28       VECTOR
    .word lab_e831          ;e799  e8 31       VECTOR
    .word lab_e880          ;e79b  e8 80       VECTOR
    .word lab_e889          ;e79d  e8 89       VECTOR
    .word lab_e88c          ;e79f  e8 8c       VECTOR
    .word lab_e895          ;e7a1  e8 95       VECTOR
    .word lab_e898          ;e7a3  e8 98       VECTOR
    .word lab_e89b          ;e7a5  e8 9b       VECTOR
    .word lab_e89e          ;e7a7  e8 9e       VECTOR
    .word lab_e8a1          ;e7a9  e8 a1       VECTOR
    .word lab_e8a4          ;e7ab  e8 a4       VECTOR
    .word lab_e8b7          ;e7ad  e8 b7       VECTOR
    .word lab_e8ba          ;e7af  e8 ba       VECTOR
    .word lab_e8bd          ;e7b1  e8 bd       VECTOR
    .word lab_e8c0          ;e7b3  e8 c0       VECTOR
    .word lab_e8c3          ;e7b5  e8 c3       VECTOR
    .word lab_e8c6          ;e7b7  e8 c6       VECTOR
    .word lab_e90a          ;e7b9  e9 0a       VECTOR
    .word lab_e928          ;e7bb  e9 28       VECTOR
    .word lab_e92b          ;e7bd  e9 2b       VECTOR
    .word lab_e92e          ;e7bf  e9 2e       VECTOR


lab_e7c1:
    call sub_ecce           ;e7c1  31 ec ce
    ret                     ;e7c4  20

lab_e7c5:
    jmp lab_e7c1            ;e7c5  21 e7 c1

lab_e7c8:
    setb 0xa9:0             ;e7c8  a8 a9
    incw ep                 ;e7ca  c3
    mov a, @ep              ;e7cb  07
    call sub_ed88           ;e7cc  31 ed 88
    mov @ix+0x05, a         ;e7cf  46 05
    mov a, @ep              ;e7d1  07
    call sub_ed92           ;e7d2  31 ed 92
    mov @ix+0x06, a         ;e7d5  46 06
    movw ep, #0xe00b        ;e7d7  e7 e0 0b
    mov a, @ep              ;e7da  07
    call sub_ed88           ;e7db  31 ed 88
    mov @ix+0x07, a         ;e7de  46 07
    mov a, @ep              ;e7e0  07
    call sub_ed92           ;e7e1  31 ed 92
    mov @ix+0x08, a         ;e7e4  46 08
    jmp lab_e7c1            ;e7e6  21 e7 c1

lab_e7e9:
    mov a, @ep              ;e7e9  07
    call sub_ed33           ;e7ea  31 ed 33
    mov r1, a               ;e7ed  49
    swap                    ;e7ee  10
    mov r2, a               ;e7ef  4a
    and a, #0xf0            ;e7f0  64 f0
    beq lab_e7f9            ;e7f2  fd 05
    call sub_ed88           ;e7f4  31 ed 88
    mov @ix+0x00, a         ;e7f7  46 00

lab_e7f9:
    mov a, r2               ;e7f9  0a
    call sub_ed92           ;e7fa  31 ed 92
    mov @ix+0x01, a         ;e7fd  46 01
    mov a, r1               ;e7ff  09
    call sub_ed88           ;e800  31 ed 88
    mov @ix+0x02, a         ;e803  46 02
    mov a, r1               ;e805  09
    call sub_ed92           ;e806  31 ed 92
    mov @ix+0x03, a         ;e809  46 03

lab_e80b:
    incw ep                 ;e80b  c3
    mov a, @ep              ;e80c  07
    call sub_ed88           ;e80d  31 ed 88
    mov @ix+0x04, a         ;e810  46 04
    mov a, @ep              ;e812  07
    call sub_ed92           ;e813  31 ed 92
    mov @ix+0x06, a         ;e816  46 06
    incw ep                 ;e818  c3
    mov a, @ep              ;e819  07
    call sub_ed88           ;e81a  31 ed 88
    mov @ix+0x08, a         ;e81d  46 08
    mov a, @ep              ;e81f  07
    call sub_ed92           ;e820  31 ed 92
    mov @ix+0x0a, a         ;e823  46 0a
    jmp lab_e7c1            ;e825  21 e7 c1

lab_e828:
    mov a, @ep              ;e828  07
    call sub_ed92           ;e829  31 ed 92
    mov @ix+0x03, a         ;e82c  46 03
    jmp lab_e80b            ;e82e  21 e8 0b

lab_e831:
    mov a, @ep              ;e831  07
    and a, #0xf0            ;e832  64 f0
    beq lab_e878            ;e834  fd 42
    mov a, #0x2d            ;e836  04 2d
    mov @ix+0x01, a         ;e838  46 01
    mov a, @ep              ;e83a  07
    xor a, #0xff            ;e83b  54 ff
    incw a                  ;e83d  c0

lab_e83e:
    call sub_ed92           ;e83e  31 ed 92
    mov @ix+0x02, a         ;e841  46 02
    incw ep                 ;e843  c3
    mov a, @ep              ;e844  07
    call sub_ed5d           ;e845  31 ed 5d
    mov a, r6               ;e848  0e
    beq lab_e850            ;e849  fd 05
    call sub_ed92           ;e84b  31 ed 92
    mov @ix+0x04, a         ;e84e  46 04

lab_e850:
    mov a, r7               ;e850  0f
    call sub_ed88           ;e851  31 ed 88
    mov @ix+0x05, a         ;e854  46 05
    mov a, r7               ;e856  0f
    call sub_ed92           ;e857  31 ed 92
    mov @ix+0x06, a         ;e85a  46 06
    incw ep                 ;e85c  c3
    mov a, @ep              ;e85d  07
    call sub_ed5d           ;e85e  31 ed 5d
    mov a, r6               ;e861  0e
    beq lab_e869            ;e862  fd 05
    call sub_ed92           ;e864  31 ed 92
    mov @ix+0x08, a         ;e867  46 08

lab_e869:
    mov a, r7               ;e869  0f
    call sub_ed88           ;e86a  31 ed 88
    mov @ix+0x09, a         ;e86d  46 09
    mov a, r7               ;e86f  0f
    call sub_ed92           ;e870  31 ed 92
    mov @ix+0x0a, a         ;e873  46 0a
    jmp lab_e7c1            ;e875  21 e7 c1

lab_e878:
    mov a, #0x2b            ;e878  04 2b
    mov @ix+0x01, a         ;e87a  46 01
    mov a, @ep              ;e87c  07
    jmp lab_e83e            ;e87d  21 e8 3e

lab_e880:
    mov a, @ep              ;e880  07
    call sub_ed92           ;e881  31 ed 92
    mov @ix+0x09, a         ;e884  46 09
    jmp lab_e7c1            ;e886  21 e7 c1

lab_e889:
    jmp lab_e880            ;e889  21 e8 80

lab_e88c:
    mov a, @ep              ;e88c  07
    call sub_ed92           ;e88d  31 ed 92
    mov @ix+0x0a, a         ;e890  46 0a
    jmp lab_e7c1            ;e892  21 e7 c1

lab_e895:
    jmp lab_e88c            ;e895  21 e8 8c

lab_e898:
    jmp lab_e88c            ;e898  21 e8 8c

lab_e89b:
    jmp lab_e88c            ;e89b  21 e8 8c

lab_e89e:
    jmp lab_e88c            ;e89e  21 e8 8c

lab_e8a1:
    jmp lab_e88c            ;e8a1  21 e8 8c

lab_e8a4:
    mov a, @ep              ;e8a4  07
    and a, #0xf0            ;e8a5  64 f0
    beq lab_e8ae            ;e8a7  fd 05
    call sub_ed88           ;e8a9  31 ed 88
    mov @ix+0x09, a         ;e8ac  46 09

lab_e8ae:
    mov a, @ep              ;e8ae  07
    call sub_ed92           ;e8af  31 ed 92
    mov @ix+0x0a, a         ;e8b2  46 0a
    jmp lab_e7c1            ;e8b4  21 e7 c1

lab_e8b7:
    jmp lab_e8a4            ;e8b7  21 e8 a4

lab_e8ba:
    jmp lab_e8a4            ;e8ba  21 e8 a4

lab_e8bd:
    jmp lab_e7c1            ;e8bd  21 e7 c1

lab_e8c0:
    jmp lab_e7c1            ;e8c0  21 e7 c1

lab_e8c3:
    jmp lab_e7c1            ;e8c3  21 e7 c1

lab_e8c6:
    mov a, @ep              ;e8c6  07
    and a, #0xf0            ;e8c7  64 f0
    beq lab_e8d0            ;e8c9  fd 05
    call sub_ed88           ;e8cb  31 ed 88
    mov @ix+0x04, a         ;e8ce  46 04

lab_e8d0:
    mov a, @ep              ;e8d0  07
    call sub_ed92           ;e8d1  31 ed 92
    mov @ix+0x05, a         ;e8d4  46 05
    incw ep                 ;e8d6  c3
    mov a, @ep              ;e8d7  07
    call sub_ed92           ;e8d8  31 ed 92
    mov @ix+0x07, a         ;e8db  46 07
    incw ep                 ;e8dd  c3
    mov a, @ep              ;e8de  07
    and a, #0xf0            ;e8df  64 f0
    beq lab_e902            ;e8e1  fd 1f
    mov a, #0x2d            ;e8e3  04 2d
    mov @ix+0x08, a         ;e8e5  46 08
    mov a, @ep              ;e8e7  07
    xor a, #0xff            ;e8e8  54 ff
    incw a                  ;e8ea  c0

lab_e8eb:
    clrc                    ;e8eb  81
    addc a, #0x00           ;e8ec  24 00
    daa                     ;e8ee  84
    mov r0, a               ;e8ef  48
    call sub_ed88           ;e8f0  31 ed 88
    cmp a, #0x30            ;e8f3  14 30
    beq lab_e8f9            ;e8f5  fd 02
    mov @ix+0x09, a         ;e8f7  46 09

lab_e8f9:
    mov a, r0               ;e8f9  08
    call sub_ed92           ;e8fa  31 ed 92
    mov @ix+0x0a, a         ;e8fd  46 0a
    jmp lab_e7c1            ;e8ff  21 e7 c1

lab_e902:
    mov a, #0x2b            ;e902  04 2b
    mov @ix+0x08, a         ;e904  46 08
    mov a, @ep              ;e906  07
    jmp lab_e8eb            ;e907  21 e8 eb

lab_e90a:
    mov a, @ep              ;e90a  07
    mov r0, a               ;e90b  48
    beq lab_e913            ;e90c  fd 05
    rolc a                  ;e90e  02
    blo lab_e91e            ;e90f  f9 0d
    mov a, #0x2b            ;e911  04 2b

lab_e913:
    mov @ix+0x09, a         ;e913  46 09
    mov a, r0               ;e915  08
    call sub_ed92           ;e916  31 ed 92
    mov @ix+0x0a, a         ;e919  46 0a
    jmp lab_e7c1            ;e91b  21 e7 c1

lab_e91e:
    mov a, r0               ;e91e  08
    xor a, #0xff            ;e91f  54 ff
    incw a                  ;e921  c0
    mov r0, a               ;e922  48
    mov a, #0x2d            ;e923  04 2d
    jmp lab_e913            ;e925  21 e9 13

lab_e928:
    jmp lab_e90a            ;e928  21 e9 0a

lab_e92b:
    jmp lab_e7c1            ;e92b  21 e7 c1

lab_e92e:
    jmp lab_e7c1            ;e92e  21 e7 c1

sub_e931:
;Called if A >= 0x40 and A < 0x50
    movw a, #0x0000         ;e931  e4 00 00
    mov a, @ep              ;e934  07
    mov a, #0x40            ;e935  04 40
    clrc                    ;e937  81
    subc a                  ;e938  32
    mov r0, a               ;e939  48
    movw a, #0x000b         ;e93a  e4 00 0b
    mulu a                  ;e93d  01
    movw a, #0xefbd         ;e93e  e4 ef bd
    clrc                    ;e941  81
    addcw a                 ;e942  23
    movw ix, a              ;e943  e2
    movw ep, #0x012f        ;e944  e7 01 2f
    call sub_eca1           ;e947  31 ec a1
    movw ix, #0x012f        ;e94a  e6 01 2f
    movw ep, #0x011e        ;e94d  e7 01 1e
    movw a, #0x0000         ;e950  e4 00 00
    mov a, r0               ;e953  08
    cmp a, #0x08            ;e954  14 08
    bhs lab_e971            ;e956  f8 19
    clrc                    ;e958  81
    rolc a                  ;e959  02
    movw a, #0xe961         ;e95a  e4 e9 61
    clrc                    ;e95d  81
    addcw a                 ;e95e  23
    movw a, @a              ;e95f  93
    jmp @a                  ;e960  e0

    .word lab_e975          ;e961  e9 75       VECTOR
    .word lab_e9af          ;e963  e9 af       VECTOR
    .word lab_e9c1          ;e965  e9 c1       VECTOR
    .word lab_e9c6          ;e967  e9 c6       VECTOR
    .word lab_e9c9          ;e969  e9 c9       VECTOR
    .word lab_e9de          ;e96b  e9 de       VECTOR
    .word lab_e9e1          ;e96d  e9 e1       VECTOR
    .word lab_e9ee          ;e96f  e9 ee       VECTOR


lab_e971:
    call sub_ecce           ;e971  31 ec ce
    ret                     ;e974  20

lab_e975:
    setb 0xa9:0             ;e975  a8 a9
    setb 0xa9:1             ;e977  a9 a9
    mov a, @ep              ;e979  07
    call sub_ed88           ;e97a  31 ed 88
    mov @ix+0x02, a         ;e97d  46 02
    mov a, @ep              ;e97f  07
    call sub_ed92           ;e980  31 ed 92
    cmp a, #0x30            ;e983  14 30
    beq lab_e989            ;e985  fd 02
    mov @ix+0x03, a         ;e987  46 03

lab_e989:
    incw ep                 ;e989  c3
    mov a, @ep              ;e98a  07
    call sub_ed33           ;e98b  31 ed 33

lab_e98e:
    mov r1, a               ;e98e  49
    swap                    ;e98f  10
    mov r2, a               ;e990  4a
    and a, #0xf0            ;e991  64 f0
    beq lab_e99a            ;e993  fd 05
    call sub_ed88           ;e995  31 ed 88
    mov @ix+0x04, a         ;e998  46 04

lab_e99a:
    mov a, r2               ;e99a  0a
    call sub_ed92           ;e99b  31 ed 92
    mov @ix+0x05, a         ;e99e  46 05
    mov a, r1               ;e9a0  09
    call sub_ed88           ;e9a1  31 ed 88
    mov @ix+0x06, a         ;e9a4  46 06
    mov a, r1               ;e9a6  09
    call sub_ed92           ;e9a7  31 ed 92
    mov @ix+0x07, a         ;e9aa  46 07
    jmp lab_e971            ;e9ac  21 e9 71

lab_e9af:
    mov a, @ep              ;e9af  07
    call sub_ed92           ;e9b0  31 ed 92
    cmp a, #0x30            ;e9b3  14 30
    beq lab_e9b9            ;e9b5  fd 02
    mov @ix+0x03, a         ;e9b7  46 03

lab_e9b9:
    incw ep                 ;e9b9  c3
    mov a, @ep              ;e9ba  07
    call sub_ed53           ;e9bb  31 ed 53
    jmp lab_e98e            ;e9be  21 e9 8e

lab_e9c1:
    setb 0xa9:0             ;e9c1  a8 a9
    jmp lab_e989            ;e9c3  21 e9 89

lab_e9c6:
    jmp lab_e9b9            ;e9c6  21 e9 b9

lab_e9c9:
    setb 0xa9:1             ;e9c9  a9 a9
    mov a, @ep              ;e9cb  07
    call sub_ed88           ;e9cc  31 ed 88
    mov @ix+0x02, a         ;e9cf  46 02
    mov a, @ep              ;e9d1  07
    call sub_ed92           ;e9d2  31 ed 92
    cmp a, #0x30            ;e9d5  14 30
    beq lab_e9db            ;e9d7  fd 02
    mov @ix+0x03, a         ;e9d9  46 03

lab_e9db:
    jmp lab_e971            ;e9db  21 e9 71

lab_e9de:
    jmp lab_e9c9            ;e9de  21 e9 c9

lab_e9e1:
    mov a, @ep              ;e9e1  07
    call sub_ed92           ;e9e2  31 ed 92
    cmp a, #0x30            ;e9e5  14 30
    beq lab_e9eb            ;e9e7  fd 02
    mov @ix+0x03, a         ;e9e9  46 03

lab_e9eb:
    jmp lab_e971            ;e9eb  21 e9 71

lab_e9ee:
    jmp lab_e9e1            ;e9ee  21 e9 e1

sub_e9f1:
;Called if A >= 50 and A < 0x60
    movw a, #0x0000         ;e9f1  e4 00 00
    mov a, @ep              ;e9f4  07
    mov a, #0x50            ;e9f5  04 50
    clrc                    ;e9f7  81
    subc a                  ;e9f8  32
    mov r0, a               ;e9f9  48
    movw a, #0x000b         ;e9fa  e4 00 0b
    mulu a                  ;e9fd  01
    movw a, #0xf015         ;e9fe  e4 f0 15
    clrc                    ;ea01  81
    addcw a                 ;ea02  23
    movw ix, a              ;ea03  e2
    movw ep, #0x012f        ;ea04  e7 01 2f
    call sub_eca1           ;ea07  31 ec a1
    movw ix, #0x012f        ;ea0a  e6 01 2f
    movw ep, #0x011e        ;ea0d  e7 01 1e
    movw a, #0x0000         ;ea10  e4 00 00
    mov a, r0               ;ea13  08
    cmp a, #0x0e            ;ea14  14 0e
    bhs lab_ea3d            ;ea16  f8 25
    clrc                    ;ea18  81
    rolc a                  ;ea19  02
    movw a, #0xea21         ;ea1a  e4 ea 21
    clrc                    ;ea1d  81
    addcw a                 ;ea1e  23
    movw a, @a              ;ea1f  93
    jmp @a                  ;ea20  e0

    .word lab_ea41          ;ea21  ea 41       VECTOR
    .word lab_ea44          ;ea23  ea 44       VECTOR
    .word lab_ea47          ;ea25  ea 47       VECTOR
    .word lab_ea4a          ;ea27  ea 4a       VECTOR
    .word lab_ea4d          ;ea29  ea 4d       VECTOR
    .word lab_ea50          ;ea2b  ea 50       VECTOR
    .word lab_ea53          ;ea2d  ea 53       VECTOR
    .word lab_ea56          ;ea2f  ea 56       VECTOR
    .word lab_ea59          ;ea31  ea 59       VECTOR
    .word lab_ea5c          ;ea33  ea 5c       VECTOR
    .word lab_ea5f          ;ea35  ea 5f       VECTOR
    .word lab_ea62          ;ea37  ea 62       VECTOR
    .word lab_ea65          ;ea39  ea 65       VECTOR
    .word lab_ea68          ;ea3b  ea 68       VECTOR


lab_ea3d:
    call sub_ecce           ;ea3d  31 ec ce
    ret                     ;ea40  20

lab_ea41:
    jmp lab_ea3d            ;ea41  21 ea 3d

lab_ea44:
    jmp lab_ea3d            ;ea44  21 ea 3d

lab_ea47:
    jmp lab_ea3d            ;ea47  21 ea 3d

lab_ea4a:
    jmp lab_ea3d            ;ea4a  21 ea 3d

lab_ea4d:
    jmp lab_ea3d            ;ea4d  21 ea 3d

lab_ea50:
    jmp lab_ea3d            ;ea50  21 ea 3d

lab_ea53:
    jmp lab_ea3d            ;ea53  21 ea 3d

lab_ea56:
    jmp lab_ea3d            ;ea56  21 ea 3d

lab_ea59:
    jmp lab_ea3d            ;ea59  21 ea 3d

lab_ea5c:
    jmp lab_ea3d            ;ea5c  21 ea 3d

lab_ea5f:
    jmp lab_ea3d            ;ea5f  21 ea 3d

lab_ea62:
    jmp lab_ea3d            ;ea62  21 ea 3d

lab_ea65:
    jmp lab_ea3d            ;ea65  21 ea 3d

lab_ea68:
    jmp lab_ea3d            ;ea68  21 ea 3d

sub_ea6b:
;Called if A >= 0x60 and A < 0x80
    movw a, #0x0000         ;ea6b  e4 00 00
    mov a, @ep              ;ea6e  07
    mov a, #0x60            ;ea6f  04 60
    clrc                    ;ea71  81
    subc a                  ;ea72  32
    mov r0, a               ;ea73  48
    cmp a, #0x02            ;ea74  14 02
    blo lab_ea88            ;ea76  f9 10
    movw a, #0x000b         ;ea78  e4 00 0b
    mulu a                  ;ea7b  01
    movw a, #0xf0af         ;ea7c  e4 f0 af
    clrc                    ;ea7f  81
    addcw a                 ;ea80  23
    movw ix, a              ;ea81  e2
    movw ep, #0x012f        ;ea82  e7 01 2f
    call sub_eca1           ;ea85  31 ec a1

lab_ea88:
    movw ix, #0x012f        ;ea88  e6 01 2f
    movw ep, #0x011e        ;ea8b  e7 01 1e
    movw a, #0x0000         ;ea8e  e4 00 00
    mov a, r0               ;ea91  08
    cmp a, #0x0a            ;ea92  14 0a
    bhs lab_eab3            ;ea94  f8 1d
    clrc                    ;ea96  81
    rolc a                  ;ea97  02
    movw a, #0xea9f         ;ea98  e4 ea 9f
    clrc                    ;ea9b  81
    addcw a                 ;ea9c  23
    movw a, @a              ;ea9d  93
    jmp @a                  ;ea9e  e0

    .word lab_eab7          ;ea9f  ea b7       VECTOR   A=0
    .word lab_ead2          ;eaa1  ea d2       VECTOR   A=1
    .word lab_eaed          ;eaa3  ea ed       VECTOR   A=2
    .word lab_eb0b          ;eaa5  eb 0b       VECTOR   A=3
    .word lab_eb0e          ;eaa7  eb 0e       VECTOR   A=4
    .word lab_eb3d          ;eaa9  eb 3d       VECTOR   A=5
    .word lab_eb6c          ;eaab  eb 6c       VECTOR   A=6
    .word lab_eb6f          ;eaad  eb 6f       VECTOR   A=7
    .word lab_eb72          ;eaaf  eb 72       VECTOR   A=8
    .word lab_eb75          ;eab1  eb 75       VECTOR   A=9


lab_eab3:
    call sub_ecce           ;eab3  31 ec ce
    ret                     ;eab6  20

lab_eab7:
    mov a, #0x00            ;eab7  04 00
    mov @ix+0x04, a         ;eab9  46 04
    mov @ix+0x05, a         ;eabb  46 05
    mov a, #0x4d            ;eabd  04 4d
    mov @ix+0x06, a         ;eabf  46 06
    mov a, #0x41            ;eac1  04 41
    mov @ix+0x07, a         ;eac3  46 07
    mov a, #0x58            ;eac5  04 58
    mov @ix+0x08, a         ;eac7  46 08
    mov a, #0x00            ;eac9  04 00
    mov @ix+0x09, a         ;eacb  46 09
    mov @ix+0x0a, a         ;eacd  46 0a
    jmp lab_eab3            ;eacf  21 ea b3

lab_ead2:
    mov a, #0x00            ;ead2  04 00
    mov @ix+0x04, a         ;ead4  46 04
    mov @ix+0x05, a         ;ead6  46 05
    mov a, #0x4d            ;ead8  04 4d
    mov @ix+0x06, a         ;eada  46 06
    mov a, #0x49            ;eadc  04 49
    mov @ix+0x07, a         ;eade  46 07
    mov a, #0x4e            ;eae0  04 4e
    mov @ix+0x08, a         ;eae2  46 08
    mov a, #0x00            ;eae4  04 00
    mov @ix+0x09, a         ;eae6  46 09
    mov @ix+0x0a, a         ;eae8  46 0a
    jmp lab_eab3            ;eaea  21 ea b3

lab_eaed:
    mov a, @ep              ;eaed  07
    mov r0, a               ;eaee  48
    beq lab_eaf6            ;eaef  fd 05
    rolc a                  ;eaf1  02
    blo lab_eb01            ;eaf2  f9 0d
    mov a, #0x2b            ;eaf4  04 2b

lab_eaf6:
    mov @ix+0x06, a         ;eaf6  46 06
    mov a, r0               ;eaf8  08
    call sub_ed92           ;eaf9  31 ed 92
    mov @ix+0x08, a         ;eafc  46 08
    jmp lab_eab3            ;eafe  21 ea b3

lab_eb01:
    mov a, r0               ;eb01  08
    xor a, #0xff            ;eb02  54 ff
    incw a                  ;eb04  c0
    mov r0, a               ;eb05  48
    mov a, #0x2d            ;eb06  04 2d
    jmp lab_eaf6            ;eb08  21 ea f6

lab_eb0b:
    jmp lab_eaed            ;eb0b  21 ea ed

lab_eb0e:
    mov a, @ep              ;eb0e  07
    and a, #0xf0            ;eb0f  64 f0
    cmp a, #0xf0            ;eb11  14 f0
    beq lab_eb32            ;eb13  fd 1d
    mov a, @ep              ;eb15  07
    cmp a, #0x09            ;eb16  14 09
    blo lab_eb1f            ;eb18  f9 05
    clrc                    ;eb1a  81
    addc a, #0x00           ;eb1b  24 00
    daa                     ;eb1d  84
    mov @ep, a              ;eb1e  47

lab_eb1f:
    mov a, @ep              ;eb1f  07
    and a, #0xf0            ;eb20  64 f0
    beq lab_eb29            ;eb22  fd 05
    call sub_ed88           ;eb24  31 ed 88
    mov @ix+0x09, a         ;eb27  46 09

lab_eb29:
    mov a, @ep              ;eb29  07
    call sub_ed92           ;eb2a  31 ed 92
    mov @ix+0x0a, a         ;eb2d  46 0a
    jmp lab_eab3            ;eb2f  21 ea b3

lab_eb32:
    mov a, @ep              ;eb32  07
    xor a, #0xff            ;eb33  54 ff
    clrc                    ;eb35  81
    addc a, #0x01           ;eb36  24 01
    daa                     ;eb38  84
    mov @ep, a              ;eb39  47
    jmp lab_eb1f            ;eb3a  21 eb 1f

lab_eb3d:
    mov a, @ep              ;eb3d  07
    and a, #0xf0            ;eb3e  64 f0
    cmp a, #0xf0            ;eb40  14 f0
    beq lab_eb61            ;eb42  fd 1d
    mov a, @ep              ;eb44  07
    cmp a, #0x09            ;eb45  14 09
    blo lab_eb4e            ;eb47  f9 05
    clrc                    ;eb49  81
    addc a, #0x00           ;eb4a  24 00
    daa                     ;eb4c  84
    mov @ep, a              ;eb4d  47

lab_eb4e:
    mov a, @ep              ;eb4e  07
    and a, #0xf0            ;eb4f  64 f0
    beq lab_eb58            ;eb51  fd 05
    call sub_ed88           ;eb53  31 ed 88
    mov @ix+0x09, a         ;eb56  46 09

lab_eb58:
    mov a, @ep              ;eb58  07
    call sub_ed92           ;eb59  31 ed 92
    mov @ix+0x0a, a         ;eb5c  46 0a
    jmp lab_eab3            ;eb5e  21 ea b3

lab_eb61:
    mov a, @ep              ;eb61  07
    xor a, #0xff            ;eb62  54 ff
    clrc                    ;eb64  81
    addc a, #0x01           ;eb65  24 01
    daa                     ;eb67  84
    mov @ep, a              ;eb68  47
    jmp lab_eb4e            ;eb69  21 eb 4e

lab_eb6c:
    jmp lab_eab3            ;eb6c  21 ea b3

lab_eb6f:
    jmp lab_eb3d            ;eb6f  21 eb 3d

lab_eb72:
    jmp lab_eb0e            ;eb72  21 eb 0e

lab_eb75:
    jmp lab_eab3            ;eb75  21 ea b3

sub_eb78:
;Called if A >= 0x80 and A < 0xB0
    movw a, #0x0000         ;eb78  e4 00 00
    mov a, @ep              ;eb7b  07
    mov a, #0x80            ;eb7c  04 80
    clrc                    ;eb7e  81
    subc a                  ;eb7f  32
    mov r0, a               ;eb80  48
    movw a, #0x000b         ;eb81  e4 00 0b
    mulu a                  ;eb84  01
    movw a, #0xf11d         ;eb85  e4 f1 1d
    clrc                    ;eb88  81
    addcw a                 ;eb89  23
    movw ix, a              ;eb8a  e2
    movw ep, #0x012f        ;eb8b  e7 01 2f
    call sub_eca1           ;eb8e  31 ec a1
    movw ix, #0x012f        ;eb91  e6 01 2f
    movw ep, #0x011e        ;eb94  e7 01 1e
    movw a, #0x0000         ;eb97  e4 00 00
    mov a, r0               ;eb9a  08
    cmp a, #0x08            ;eb9b  14 08
    bhs lab_ebb8            ;eb9d  f8 19
    clrc                    ;eb9f  81
    rolc a                  ;eba0  02
    movw a, #0xeba8         ;eba1  e4 eb a8
    clrc                    ;eba4  81
    addcw a                 ;eba5  23
    movw a, @a              ;eba6  93
    jmp @a                  ;eba7  e0

    .word lab_ebbc          ;eba8  eb bc       VECTOR   A=0
    .word lab_ebbf          ;ebaa  eb bf       VECTOR   A=1
    .word lab_ebc2          ;ebac  eb c2       VECTOR   A=2
    .word lab_ebe9          ;ebae  eb e9       VECTOR   A=3
    .word lab_ebf6          ;ebb0  eb f6       VECTOR   A=4
    .word lab_ebf9          ;ebb2  eb f9       VECTOR   A=5
    .word lab_ebfc          ;ebb4  eb fc       VECTOR   A=6
    .word lab_ec0f          ;ebb6  ec 0f       VECTOR   A=7


lab_ebb8:
    call sub_ecce           ;ebb8  31 ec ce
    ret                     ;ebbb  20

lab_ebbc:
    jmp lab_ebb8            ;ebbc  21 eb b8

lab_ebbf:
    jmp lab_ebb8            ;ebbf  21 eb b8

lab_ebc2:
    mov a, @ep              ;ebc2  07
    and a, #0x0f            ;ebc3  64 0f
    beq lab_ebcc            ;ebc5  fd 05
    call sub_ed92           ;ebc7  31 ed 92
    mov @ix+0x00, a         ;ebca  46 00

lab_ebcc:
    incw ep                 ;ebcc  c3
    mov a, @ep              ;ebcd  07
    call sub_ed88           ;ebce  31 ed 88
    mov @ix+0x05, a         ;ebd1  46 05
    mov a, @ep              ;ebd3  07
    call sub_ed92           ;ebd4  31 ed 92
    mov @ix+0x06, a         ;ebd7  46 06
    incw ep                 ;ebd9  c3
    mov a, @ep              ;ebda  07
    call sub_ed88           ;ebdb  31 ed 88
    mov @ix+0x07, a         ;ebde  46 07
    mov a, @ep              ;ebe0  07
    call sub_ed92           ;ebe1  31 ed 92
    mov @ix+0x08, a         ;ebe4  46 08
    jmp lab_ebb8            ;ebe6  21 eb b8

lab_ebe9:
    mov a, @ep              ;ebe9  07
    and a, #0x0f            ;ebea  64 0f
    beq lab_ebf3            ;ebec  fd 05
    call sub_ed92           ;ebee  31 ed 92
    mov @ix+0x00, a         ;ebf1  46 00

lab_ebf3:
    jmp lab_ebb8            ;ebf3  21 eb b8

lab_ebf6:
    jmp lab_ebb8            ;ebf6  21 eb b8

lab_ebf9:
    jmp lab_ebb8            ;ebf9  21 eb b8

lab_ebfc:
    mov a, @ep              ;ebfc  07
    call sub_ed5d           ;ebfd  31 ed 5d
    mov a, r7               ;ec00  0f
    call sub_ed88           ;ec01  31 ed 88
    mov @ix+0x00, a         ;ec04  46 00
    mov a, r7               ;ec06  0f
    call sub_ed92           ;ec07  31 ed 92
    mov @ix+0x01, a         ;ec0a  46 01
    jmp lab_ebb8            ;ec0c  21 eb b8

lab_ec0f:
    jmp lab_ebb8            ;ec0f  21 eb b8

sub_ec12:
;Called if A >= 0xB0 and A < 0xC0
    movw a, #0x0000         ;ec12  e4 00 00
    mov a, @ep              ;ec15  07
    mov a, #0xb0            ;ec16  04 b0
    clrc                    ;ec18  81
    subc a                  ;ec19  32
    mov r0, a               ;ec1a  48
    movw a, #0x000b         ;ec1b  e4 00 0b
    mulu a                  ;ec1e  01
    movw a, #0xf175         ;ec1f  e4 f1 75
    clrc                    ;ec22  81
    addcw a                 ;ec23  23
    movw ix, a              ;ec24  e2
    movw ep, #0x012f        ;ec25  e7 01 2f
    call sub_eca1           ;ec28  31 ec a1
    movw ix, #0x012f        ;ec2b  e6 01 2f
    movw ep, #0x011e        ;ec2e  e7 01 1e
    movw a, #0x0000         ;ec31  e4 00 00
    mov a, r0               ;ec34  08
    cmp a, #0x02            ;ec35  14 02
    bhs lab_ec46            ;ec37  f8 0d
    clrc                    ;ec39  81
    rolc a                  ;ec3a  02
    movw a, #0xec42         ;ec3b  e4 ec 42
    clrc                    ;ec3e  81
    addcw a                 ;ec3f  23
    movw a, @a              ;ec40  93
    jmp @a                  ;ec41  e0

    .word lab_ec4a          ;ec42  ec 4a       VECTOR   A=0
    .word lab_ec4d          ;ec44  ec 4d       VECTOR   A=1


lab_ec46:
    call sub_ecce           ;ec46  31 ec ce
    ret                     ;ec49  20

lab_ec4a:
    jmp lab_ec46            ;ec4a  21 ec 46

lab_ec4d:
    jmp lab_ec46            ;ec4d  21 ec 46

sub_ec50:
;Called if A >= 0xC0 and A < 0xD0
    movw a, #0x0000         ;ec50  e4 00 00
    mov a, @ep              ;ec53  07
    mov a, #0xc0            ;ec54  04 c0
    clrc                    ;ec56  81
    subc a                  ;ec57  32
    mov r0, a               ;ec58  48
    movw a, #0x000b         ;ec59  e4 00 0b
    mulu a                  ;ec5c  01
    movw a, #0xf18b         ;ec5d  e4 f1 8b
    clrc                    ;ec60  81
    addcw a                 ;ec61  23
    movw ix, a              ;ec62  e2
    movw ep, #0x012f        ;ec63  e7 01 2f
    call sub_eca1           ;ec66  31 ec a1
    movw ix, #0x012f        ;ec69  e6 01 2f
    movw ep, #0x011e        ;ec6c  e7 01 1e
    movw a, #0x0000         ;ec6f  e4 00 00
    mov a, r0               ;ec72  08
    cmp a, #0x02            ;ec73  14 02
    bhs lab_ec84            ;ec75  f8 0d
    clrc                    ;ec77  81
    rolc a                  ;ec78  02
    movw a, #0xec80         ;ec79  e4 ec 80
    clrc                    ;ec7c  81
    addcw a                 ;ec7d  23
    movw a, @a              ;ec7e  93
    jmp @a                  ;ec7f  e0

    .word lab_ec88          ;ec80  ec 88       VECTOR   A=0
    .word lab_ec8b          ;ec82  ec 8b       VECTOR   A=1


lab_ec84:
    call sub_ecce           ;ec84  31 ec ce
    ret                     ;ec87  20

lab_ec88:
    jmp lab_ec84            ;ec88  21 ec 84

lab_ec8b:
    jmp lab_ec84            ;ec8b  21 ec 84

sub_ec8e:
;Called if A > 0xD0
    movw a, #0x0000         ;ec8e  e4 00 00
    movw a, #0xf1a1         ;ec91  e4 f1 a1
    clrc                    ;ec94  81
    addcw a                 ;ec95  23
    movw ix, a              ;ec96  e2
    movw ep, #0x012f        ;ec97  e7 01 2f
    call sub_eca1           ;ec9a  31 ec a1
    call sub_ecce           ;ec9d  31 ec ce
    ret                     ;eca0  20

sub_eca1:
    mov a, @ix+0x00         ;eca1  06 00
    mov @ep, a              ;eca3  47
    incw ep                 ;eca4  c3
    mov a, @ix+0x01         ;eca5  06 01
    mov @ep, a              ;eca7  47
    incw ep                 ;eca8  c3
    mov a, @ix+0x02         ;eca9  06 02
    mov @ep, a              ;ecab  47
    incw ep                 ;ecac  c3
    mov a, @ix+0x03         ;ecad  06 03
    mov @ep, a              ;ecaf  47
    incw ep                 ;ecb0  c3
    mov a, @ix+0x04         ;ecb1  06 04
    mov @ep, a              ;ecb3  47
    incw ep                 ;ecb4  c3
    mov a, @ix+0x05         ;ecb5  06 05
    mov @ep, a              ;ecb7  47
    incw ep                 ;ecb8  c3
    mov a, @ix+0x06         ;ecb9  06 06
    mov @ep, a              ;ecbb  47
    incw ep                 ;ecbc  c3
    mov a, @ix+0x07         ;ecbd  06 07
    mov @ep, a              ;ecbf  47
    incw ep                 ;ecc0  c3
    mov a, @ix+0x08         ;ecc1  06 08
    mov @ep, a              ;ecc3  47
    incw ep                 ;ecc4  c3
    mov a, @ix+0x09         ;ecc5  06 09
    mov @ep, a              ;ecc7  47
    incw ep                 ;ecc8  c3
    mov a, @ix+0x0a         ;ecc9  06 0a
    mov @ep, a              ;eccb  47
    incw ep                 ;eccc  c3
    ret                     ;eccd  20

sub_ecce:
    movw ix, #0x00d7        ;ecce  e6 00 d7
    movw ep, #0x012f        ;ecd1  e7 01 2f
    mov r0, #0x04           ;ecd4  88 04

lab_ecd6:
    mov a, @ep              ;ecd6  07
    and a, #0x7f            ;ecd7  64 7f
    mov @ix+0x00, a         ;ecd9  46 00
    incw ix                 ;ecdb  c2
    incw ep                 ;ecdc  c3
    dec r0                  ;ecdd  d8
    bne lab_ecd6            ;ecde  fc f6
    movw ix, #0x00d7        ;ece0  e6 00 d7
    mov a, #0x00            ;ece3  04 00
    mov @ix+0x04, a         ;ece5  46 04
    mov @ix+0x05, a         ;ece7  46 05
    mov @ix+0x06, a         ;ece9  46 06
    mov @ix+0x07, a         ;eceb  46 07
    movw ix, #0x00df        ;eced  e6 00 df
    movw ep, #0x0133        ;ecf0  e7 01 33
    mov r0, #0x07           ;ecf3  88 07

lab_ecf5:
    mov a, @ep              ;ecf5  07
    and a, #0x7f            ;ecf6  64 7f
    mov @ix+0x00, a         ;ecf8  46 00
    incw ix                 ;ecfa  c2
    incw ep                 ;ecfb  c3
    dec r0                  ;ecfc  d8
    bne lab_ecf5            ;ecfd  fc f6
    movw ix, #0x00d7        ;ecff  e6 00 d7
    mov a, #0x00            ;ed02  04 00
    mov @ix+0x0f, a         ;ed04  46 0f
    movw ix, #0x00d7        ;ed06  e6 00 d7
    mov a, 0x011c           ;ed09  60 01 1c
    and a, #0x40            ;ed0c  64 40
    bne lab_ed13            ;ed0e  fc 03
    bbc 0x00a9:0, lab_ed27  ;ed10  b0 a9 14

lab_ed13:
    mov a, @ix+0x0e         ;ed13  06 0e
    mov @ix+0x0f, a         ;ed15  46 0f
    mov a, @ix+0x0d         ;ed17  06 0d
    mov @ix+0x0e, a         ;ed19  46 0e
    mov a, @ix+0x0c         ;ed1b  06 0c
    mov @ix+0x0d, a         ;ed1d  46 0d
    mov a, @ix+0x0b         ;ed1f  06 0b
    mov @ix+0x0c, a         ;ed21  46 0c
    mov a, #0x2e            ;ed23  04 2e
    mov @ix+0x0b, a         ;ed25  46 0b

lab_ed27:
    bbc 0x00a9:1, lab_ed32  ;ed27  b1 a9 08
    mov a, @ix+0x03         ;ed2a  06 03
    mov @ix+0x04, a         ;ed2c  46 04
    mov a, #0x00            ;ed2e  04 00
    mov @ix+0x03, a         ;ed30  46 03

lab_ed32:
    ret                     ;ed32  20

sub_ed33:
    mov r3, a               ;ed33  4b
    mov r1, #0x79           ;ed34  89 79
    mov r2, #0x08           ;ed36  8a 08
    mov r4, #0x02           ;ed38  8c 02

lab_ed3a:
    mov a, r3               ;ed3a  0b
    decw a                  ;ed3b  d0
    cmp a, #0xff            ;ed3c  14 ff
    beq lab_ed4f            ;ed3e  fd 0f
    mov r3, a               ;ed40  4b
    mov a, r1               ;ed41  09
    mov a, r4               ;ed42  0c
    clrc                    ;ed43  81
    addc a                  ;ed44  22
    daa                     ;ed45  84
    mov r1, a               ;ed46  49
    mov a, r2               ;ed47  0a
    addc a, #0x00           ;ed48  24 00
    daa                     ;ed4a  84
    mov r2, a               ;ed4b  4a
    jmp lab_ed3a            ;ed4c  21 ed 3a

lab_ed4f:
    mov a, r2               ;ed4f  0a
    swap                    ;ed50  10
    mov a, r1               ;ed51  09
    ret                     ;ed52  20

sub_ed53:
    mov r3, a               ;ed53  4b
    mov r1, #0x30           ;ed54  89 30
    mov r2, #0x05           ;ed56  8a 05
    mov r4, #0x10           ;ed58  8c 10
    jmp lab_ed3a            ;ed5a  21 ed 3a

sub_ed5d:
    mov r5, a               ;ed5d  4d
    mov r6, #0x00           ;ed5e  8e 00
    mov r7, #0x00           ;ed60  8f 00
    mov a, r5               ;ed62  0d

lab_ed63:
    clrc                    ;ed63  81
    subc a, #0x64           ;ed64  34 64
    bhs lab_ed79            ;ed66  f8 11
    clrc                    ;ed68  81
    addc a, #0x64           ;ed69  24 64

lab_ed6b:
    clrc                    ;ed6b  81
    subc a, #0x0a           ;ed6c  34 0a
    bhs lab_ed7d            ;ed6e  f8 0d
    clrc                    ;ed70  81
    addc a, #0x0a           ;ed71  24 0a
    mov a, r7               ;ed73  0f
    clrc                    ;ed74  81
    addc a                  ;ed75  22
    daa                     ;ed76  84
    mov r7, a               ;ed77  4f
    ret                     ;ed78  20

lab_ed79:
    inc r6                  ;ed79  ce
    jmp lab_ed63            ;ed7a  21 ed 63

lab_ed7d:
    mov r5, a               ;ed7d  4d
    mov a, r7               ;ed7e  0f
    clrc                    ;ed7f  81
    addc a, #0x10           ;ed80  24 10
    daa                     ;ed82  84
    mov r7, a               ;ed83  4f
    mov a, r5               ;ed84  0d
    jmp lab_ed6b            ;ed85  21 ed 6b

sub_ed88:
    movw a, #0x00f0         ;ed88  e4 00 f0
    andw a                  ;ed8b  63
    clrc                    ;ed8c  81
    rolc a                  ;ed8d  02
    rolc a                  ;ed8e  02
    rolc a                  ;ed8f  02
    rolc a                  ;ed90  02
    rolc a                  ;ed91  02

sub_ed92:
    movw a, #0x000f         ;ed92  e4 00 0f
    andw a                  ;ed95  63
    movw a, #0xed9d         ;ed96  e4 ed 9d
    clrc                    ;ed99  81
    addcw a                 ;ed9a  23
    mov a, @a               ;ed9b  92
    ret                     ;ed9c  20

    .byte 0x30              ;ed9d  30          DATA '0'
    .byte 0x31              ;ed9e  31          DATA '1'
    .byte 0x32              ;ed9f  32          DATA '2'
    .byte 0x33              ;eda0  33          DATA '3'
    .byte 0x34              ;eda1  34          DATA '4'
    .byte 0x35              ;eda2  35          DATA '5'
    .byte 0x36              ;eda3  36          DATA '6'
    .byte 0x37              ;eda4  37          DATA '7'
    .byte 0x38              ;eda5  38          DATA '8'
    .byte 0x39              ;eda6  39          DATA '9'
    .byte 0x41              ;eda7  41          DATA 'A'
    .byte 0x42              ;eda8  42          DATA 'B'
    .byte 0x43              ;eda9  43          DATA 'C'
    .byte 0x44              ;edaa  44          DATA 'D'
    .byte 0x45              ;edab  45          DATA 'E'
    .byte 0x46              ;edac  46          DATA 'F'

    .byte 0x43              ;edad  43          DATA 'C'
    .byte 0x44              ;edae  44          DATA 'D'
    .byte 0x00              ;edaf  00          DATA '\x00'
    .byte 0x00              ;edb0  00          DATA '\x00'
    .byte 0x00              ;edb1  00          DATA '\x00'
    .byte 0x54              ;edb2  54          DATA 'T'
    .byte 0x52              ;edb3  52          DATA 'R'
    .byte 0x00              ;edb4  00          DATA '\x00'
    .byte 0x00              ;edb5  00          DATA '\x00'
    .byte 0x00              ;edb6  00          DATA '\x00'
    .byte 0x00              ;edb7  00          DATA '\x00'
    .byte 0x43              ;edb8  43          DATA 'C'
    .byte 0x55              ;edb9  55          DATA 'U'
    .byte 0x45              ;edba  45          DATA 'E'
    .byte 0x00              ;edbb  00          DATA '\x00'
    .byte 0x00              ;edbc  00          DATA '\x00'
    .byte 0x00              ;edbd  00          DATA '\x00'
    .byte 0x00              ;edbe  00          DATA '\x00'
    .byte 0x00              ;edbf  00          DATA '\x00'
    .byte 0x00              ;edc0  00          DATA '\x00'
    .byte 0x00              ;edc1  00          DATA '\x00'
    .byte 0x00              ;edc2  00          DATA '\x00'
    .byte 0x52              ;edc3  52          DATA 'R'
    .byte 0x45              ;edc4  45          DATA 'E'
    .byte 0x56              ;edc5  56          DATA 'V'
    .byte 0x00              ;edc6  00          DATA '\x00'
    .byte 0x00              ;edc7  00          DATA '\x00'
    .byte 0x00              ;edc8  00          DATA '\x00'
    .byte 0x00              ;edc9  00          DATA '\x00'
    .byte 0x00              ;edca  00          DATA '\x00'
    .byte 0x00              ;edcb  00          DATA '\x00'
    .byte 0x00              ;edcc  00          DATA '\x00'
    .byte 0x00              ;edcd  00          DATA '\x00'
    .byte 0x53              ;edce  53          DATA 'S'
    .byte 0x43              ;edcf  43          DATA 'C'
    .byte 0x41              ;edd0  41          DATA 'A'
    .byte 0x4E              ;edd1  4e          DATA 'N'
    .byte 0x43              ;edd2  43          DATA 'C'
    .byte 0x44              ;edd3  44          DATA 'D'
    .byte 0x00              ;edd4  00          DATA '\x00'
    .byte 0x54              ;edd5  54          DATA 'T'
    .byte 0x52              ;edd6  52          DATA 'R'
    .byte 0x00              ;edd7  00          DATA '\x00'
    .byte 0x00              ;edd8  00          DATA '\x00'
    .byte 0x4E              ;edd9  4e          DATA 'N'
    .byte 0x4F              ;edda  4f          DATA 'O'
    .byte 0x00              ;eddb  00          DATA '\x00'
    .byte 0x00              ;eddc  00          DATA '\x00'
    .byte 0x43              ;eddd  43          DATA 'C'
    .byte 0x48              ;edde  48          DATA 'H'
    .byte 0x41              ;eddf  41          DATA 'A'
    .byte 0x4E              ;ede0  4e          DATA 'N'
    .byte 0x47              ;ede1  47          DATA 'G'
    .byte 0x45              ;ede2  45          DATA 'E'
    .byte 0x52              ;ede3  52          DATA 'R'
    .byte 0x4E              ;ede4  4e          DATA 'N'
    .byte 0x4F              ;ede5  4f          DATA 'O'
    .byte 0x00              ;ede6  00          DATA '\x00'
    .byte 0x00              ;ede7  00          DATA '\x00'
    .byte 0x4D              ;ede8  4d          DATA 'M'
    .byte 0x41              ;ede9  41          DATA 'A'
    .byte 0x47              ;edea  47          DATA 'G'
    .byte 0x41              ;edeb  41          DATA 'A'
    .byte 0x5A              ;edec  5a          DATA 'Z'
    .byte 0x49              ;eded  49          DATA 'I'
    .byte 0x4E              ;edee  4e          DATA 'N'
    .byte 0x00              ;edef  00          DATA '\x00'
    .byte 0x00              ;edf0  00          DATA '\x00'
    .byte 0x00              ;edf1  00          DATA '\x00'
    .byte 0x00              ;edf2  00          DATA '\x00'
    .byte 0x4E              ;edf3  4e          DATA 'N'
    .byte 0x4F              ;edf4  4f          DATA 'O'
    .byte 0x00              ;edf5  00          DATA '\x00'
    .byte 0x44              ;edf6  44          DATA 'D'
    .byte 0x49              ;edf7  49          DATA 'I'
    .byte 0x53              ;edf8  53          DATA 'S'
    .byte 0x43              ;edf9  43          DATA 'C'
    .byte 0x43              ;edfa  43          DATA 'C'
    .byte 0x44              ;edfb  44          DATA 'D'
    .byte 0x00              ;edfc  00          DATA '\x00'
    .byte 0x00              ;edfd  00          DATA '\x00'
    .byte 0x00              ;edfe  00          DATA '\x00'
    .byte 0x45              ;edff  45          DATA 'E'
    .byte 0x52              ;ee00  52          DATA 'R'
    .byte 0x52              ;ee01  52          DATA 'R'
    .byte 0x4F              ;ee02  4f          DATA 'O'
    .byte 0x52              ;ee03  52          DATA 'R'
    .byte 0x00              ;ee04  00          DATA '\x00'
    .byte 0x43              ;ee05  43          DATA 'C'
    .byte 0x44              ;ee06  44          DATA 'D'
    .byte 0x00              ;ee07  00          DATA '\x00'
    .byte 0x00              ;ee08  00          DATA '\x00'
    .byte 0x00              ;ee09  00          DATA '\x00'
    .byte 0x00              ;ee0a  00          DATA '\x00'
    .byte 0x00              ;ee0b  00          DATA '\x00'
    .byte 0x00              ;ee0c  00          DATA '\x00'
    .byte 0x00              ;ee0d  00          DATA '\x00'
    .byte 0x00              ;ee0e  00          DATA '\x00'
    .byte 0x00              ;ee0f  00          DATA '\x00'
    .byte 0x43              ;ee10  43          DATA 'C'
    .byte 0x44              ;ee11  44          DATA 'D'
    .byte 0x00              ;ee12  00          DATA '\x00'
    .byte 0x00              ;ee13  00          DATA '\x00'
    .byte 0x00              ;ee14  00          DATA '\x00'
    .byte 0x00              ;ee15  00          DATA '\x00'
    .byte 0x4D              ;ee16  4d          DATA 'M'
    .byte 0x41              ;ee17  41          DATA 'A'
    .byte 0x58              ;ee18  58          DATA 'X'
    .byte 0x00              ;ee19  00          DATA '\x00'
    .byte 0x00              ;ee1a  00          DATA '\x00'
    .byte 0x43              ;ee1b  43          DATA 'C'
    .byte 0x44              ;ee1c  44          DATA 'D'
    .byte 0x00              ;ee1d  00          DATA '\x00'
    .byte 0x00              ;ee1e  00          DATA '\x00'
    .byte 0x00              ;ee1f  00          DATA '\x00'
    .byte 0x00              ;ee20  00          DATA '\x00'
    .byte 0x4D              ;ee21  4d          DATA 'M'
    .byte 0x49              ;ee22  49          DATA 'I'
    .byte 0x4E              ;ee23  4e          DATA 'N'
    .byte 0x00              ;ee24  00          DATA '\x00'
    .byte 0x00              ;ee25  00          DATA '\x00'
    .byte 0x43              ;ee26  43          DATA 'C'
    .byte 0x48              ;ee27  48          DATA 'H'
    .byte 0x4B              ;ee28  4b          DATA 'K'
    .byte 0x00              ;ee29  00          DATA '\x00'
    .byte 0x4D              ;ee2a  4d          DATA 'M'
    .byte 0x41              ;ee2b  41          DATA 'A'
    .byte 0x47              ;ee2c  47          DATA 'G'
    .byte 0x41              ;ee2d  41          DATA 'A'
    .byte 0x5A              ;ee2e  5a          DATA 'Z'
    .byte 0x49              ;ee2f  49          DATA 'I'
    .byte 0x4E              ;ee30  4e          DATA 'N'
    .byte 0x43              ;ee31  43          DATA 'C'
    .byte 0x44              ;ee32  44          DATA 'D'
    .byte 0x00              ;ee33  00          DATA '\x00'
    .byte 0x00              ;ee34  00          DATA '\x00'
    .byte 0x43              ;ee35  43          DATA 'C'
    .byte 0x44              ;ee36  44          DATA 'D'
    .byte 0x00              ;ee37  00          DATA '\x00'
    .byte 0x45              ;ee38  45          DATA 'E'
    .byte 0x52              ;ee39  52          DATA 'R'
    .byte 0x52              ;ee3a  52          DATA 'R'
    .byte 0x00              ;ee3b  00          DATA '\x00'
    .byte 0x43              ;ee3c  43          DATA 'C'
    .byte 0x44              ;ee3d  44          DATA 'D'
    .byte 0x00              ;ee3e  00          DATA '\x00'
    .byte 0x00              ;ee3f  00          DATA '\x00'
    .byte 0x00              ;ee40  00          DATA '\x00'
    .byte 0x45              ;ee41  45          DATA 'E'
    .byte 0x52              ;ee42  52          DATA 'R'
    .byte 0x52              ;ee43  52          DATA 'R'
    .byte 0x4F              ;ee44  4f          DATA 'O'
    .byte 0x52              ;ee45  52          DATA 'R'
    .byte 0x00              ;ee46  00          DATA '\x00'
    .byte 0x43              ;ee47  43          DATA 'C'
    .byte 0x44              ;ee48  44          DATA 'D'
    .byte 0x00              ;ee49  00          DATA '\x00'
    .byte 0x00              ;ee4a  00          DATA '\x00'
    .byte 0x00              ;ee4b  00          DATA '\x00'
    .byte 0x4E              ;ee4c  4e          DATA 'N'
    .byte 0x4F              ;ee4d  4f          DATA 'O'
    .byte 0x00              ;ee4e  00          DATA '\x00'
    .byte 0x43              ;ee4f  43          DATA 'C'
    .byte 0x44              ;ee50  44          DATA 'D'
    .byte 0x00              ;ee51  00          DATA '\x00'

    ;Table for A >= 0x10 and A < 0x20
    .byte 0x53              ;ee52  53          DATA 'S'
    .byte 0x45              ;ee53  45          DATA 'E'
    .byte 0x54              ;ee54  54          DATA 'T'
    .byte 0x00              ;ee55  00          DATA '\x00'
    .byte 0x4F              ;ee56  4f          DATA 'O'
    .byte 0x4E              ;ee57  4e          DATA 'N'
    .byte 0x56              ;ee58  56          DATA 'V'
    .byte 0x4F              ;ee59  4f          DATA 'O'
    .byte 0x4C              ;ee5a  4c          DATA 'L'
    .byte 0x00              ;ee5b  00          DATA '\x00'
    .byte 0x59              ;ee5c  59          DATA 'Y'
    .byte 0x53              ;ee5d  53          DATA 'S'
    .byte 0x45              ;ee5e  45          DATA 'E'
    .byte 0x54              ;ee5f  54          DATA 'T'
    .byte 0x00              ;ee60  00          DATA '\x00'
    .byte 0x4F              ;ee61  4f          DATA 'O'
    .byte 0x4E              ;ee62  4e          DATA 'N'
    .byte 0x56              ;ee63  56          DATA 'V'
    .byte 0x4F              ;ee64  4f          DATA 'O'
    .byte 0x4C              ;ee65  4c          DATA 'L'
    .byte 0x00              ;ee66  00          DATA '\x00'
    .byte 0x4E              ;ee67  4e          DATA 'N'
    .byte 0x53              ;ee68  53          DATA 'S'
    .byte 0x45              ;ee69  45          DATA 'E'
    .byte 0x54              ;ee6a  54          DATA 'T'
    .byte 0x00              ;ee6b  00          DATA '\x00'
    .byte 0x4F              ;ee6c  4f          DATA 'O'
    .byte 0x4E              ;ee6d  4e          DATA 'N'
    .byte 0x56              ;ee6e  56          DATA 'V'
    .byte 0x4F              ;ee6f  4f          DATA 'O'
    .byte 0x4C              ;ee70  4c          DATA 'L'
    .byte 0x00              ;ee71  00          DATA '\x00'
    .byte 0x00              ;ee72  00          DATA '\x00'
    .byte 0x53              ;ee73  53          DATA 'S'
    .byte 0x45              ;ee74  45          DATA 'E'
    .byte 0x54              ;ee75  54          DATA 'T'
    .byte 0x00              ;ee76  00          DATA '\x00'
    .byte 0x43              ;ee77  43          DATA 'C'
    .byte 0x44              ;ee78  44          DATA 'D'
    .byte 0x00              ;ee79  00          DATA '\x00'
    .byte 0x4D              ;ee7a  4d          DATA 'M'
    .byte 0x49              ;ee7b  49          DATA 'I'
    .byte 0x58              ;ee7c  58          DATA 'X'
    .byte 0x31              ;ee7d  31          DATA '1'
    .byte 0x53              ;ee7e  53          DATA 'S'
    .byte 0x45              ;ee7f  45          DATA 'E'
    .byte 0x54              ;ee80  54          DATA 'T'
    .byte 0x00              ;ee81  00          DATA '\x00'
    .byte 0x43              ;ee82  43          DATA 'C'
    .byte 0x44              ;ee83  44          DATA 'D'
    .byte 0x00              ;ee84  00          DATA '\x00'
    .byte 0x4D              ;ee85  4d          DATA 'M'
    .byte 0x49              ;ee86  49          DATA 'I'
    .byte 0x58              ;ee87  58          DATA 'X'
    .byte 0x36              ;ee88  36          DATA '6'
    .byte 0x54              ;ee89  54          DATA 'T'
    .byte 0x41              ;ee8a  41          DATA 'A'
    .byte 0x50              ;ee8b  50          DATA 'P'
    .byte 0x45              ;ee8c  45          DATA 'E'
    .byte 0x00              ;ee8d  00          DATA '\x00'
    .byte 0x53              ;ee8e  53          DATA 'S'
    .byte 0x4B              ;ee8f  4b          DATA 'K'
    .byte 0x49              ;ee90  49          DATA 'I'
    .byte 0x50              ;ee91  50          DATA 'P'
    .byte 0x00              ;ee92  00          DATA '\x00'
    .byte 0x59              ;ee93  59          DATA 'Y'
    .byte 0x54              ;ee94  54          DATA 'T'
    .byte 0x41              ;ee95  41          DATA 'A'
    .byte 0x50              ;ee96  50          DATA 'P'
    .byte 0x45              ;ee97  45          DATA 'E'
    .byte 0x00              ;ee98  00          DATA '\x00'
    .byte 0x53              ;ee99  53          DATA 'S'
    .byte 0x4B              ;ee9a  4b          DATA 'K'
    .byte 0x49              ;ee9b  49          DATA 'I'
    .byte 0x50              ;ee9c  50          DATA 'P'
    .byte 0x00              ;ee9d  00          DATA '\x00'
    .byte 0x4E              ;ee9e  4e          DATA 'N'

    ;Table for A >= 0x20 and A < 0x40
    .byte 0x52              ;ee9f  52          DATA 'R'
    .byte 0x41              ;eea0  41          DATA 'A'
    .byte 0x44              ;eea1  44          DATA 'D'
    .byte 0x00              ;eea2  00          DATA '\x00'
    .byte 0x33              ;eea3  33          DATA '3'
    .byte 0x43              ;eea4  43          DATA 'C'
    .byte 0x50              ;eea5  50          DATA 'P'
    .byte 0x00              ;eea6  00          DATA '\x00'
    .byte 0x54              ;eea7  54          DATA 'T'
    .byte 0x37              ;eea8  37          DATA '7'
    .byte 0x00              ;eea9  00          DATA '\x00'
    .byte 0x56              ;eeaa  56          DATA 'V'
    .byte 0x45              ;eeab  45          DATA 'E'
    .byte 0x52              ;eeac  52          DATA 'R'
    .byte 0x00              ;eead  00          DATA '\x00'
    .byte 0x00              ;eeae  00          DATA '\x00'
    .byte 0x00              ;eeaf  00          DATA '\x00'
    .byte 0x00              ;eeb0  00          DATA '\x00'
    .byte 0x00              ;eeb1  00          DATA '\x00'
    .byte 0x00              ;eeb2  00          DATA '\x00'
    .byte 0x00              ;eeb3  00          DATA '\x00'
    .byte 0x00              ;eeb4  00          DATA '\x00'
    .byte 0x00              ;eeb5  00          DATA '\x00'
    .byte 0x00              ;eeb6  00          DATA '\x00'
    .byte 0x00              ;eeb7  00          DATA '\x00'
    .byte 0x00              ;eeb8  00          DATA '\x00'
    .byte 0x00              ;eeb9  00          DATA '\x00'
    .byte 0x00              ;eeba  00          DATA '\x00'
    .byte 0x00              ;eebb  00          DATA '\x00'
    .byte 0x00              ;eebc  00          DATA '\x00'
    .byte 0x00              ;eebd  00          DATA '\x00'
    .byte 0x00              ;eebe  00          DATA '\x00'
    .byte 0x00              ;eebf  00          DATA '\x00'
    .byte 0x48              ;eec0  48          DATA 'H'
    .byte 0x43              ;eec1  43          DATA 'C'
    .byte 0x00              ;eec2  00          DATA '\x00'
    .byte 0x00              ;eec3  00          DATA '\x00'
    .byte 0x00              ;eec4  00          DATA '\x00'
    .byte 0x00              ;eec5  00          DATA '\x00'
    .byte 0x00              ;eec6  00          DATA '\x00'
    .byte 0x00              ;eec7  00          DATA '\x00'
    .byte 0x00              ;eec8  00          DATA '\x00'
    .byte 0x00              ;eec9  00          DATA '\x00'
    .byte 0x00              ;eeca  00          DATA '\x00'
    .byte 0x56              ;eecb  56          DATA 'V'
    .byte 0x00              ;eecc  00          DATA '\x00'
    .byte 0x00              ;eecd  00          DATA '\x00'
    .byte 0x00              ;eece  00          DATA '\x00'
    .byte 0x00              ;eecf  00          DATA '\x00'
    .byte 0x00              ;eed0  00          DATA '\x00'
    .byte 0x00              ;eed1  00          DATA '\x00'
    .byte 0x00              ;eed2  00          DATA '\x00'
    .byte 0x00              ;eed3  00          DATA '\x00'
    .byte 0x00              ;eed4  00          DATA '\x00'
    .byte 0x00              ;eed5  00          DATA '\x00'
    .byte 0x53              ;eed6  53          DATA 'S'
    .byte 0x45              ;eed7  45          DATA 'E'
    .byte 0x45              ;eed8  45          DATA 'E'
    .byte 0x4B              ;eed9  4b          DATA 'K'
    .byte 0x53              ;eeda  53          DATA 'S'
    .byte 0x45              ;eedb  45          DATA 'E'
    .byte 0x54              ;eedc  54          DATA 'T'
    .byte 0x00              ;eedd  00          DATA '\x00'
    .byte 0x4D              ;eede  4d          DATA 'M'
    .byte 0x00              ;eedf  00          DATA '\x00'
    .byte 0x00              ;eee0  00          DATA '\x00'
    .byte 0x53              ;eee1  53          DATA 'S'
    .byte 0x45              ;eee2  45          DATA 'E'
    .byte 0x45              ;eee3  45          DATA 'E'
    .byte 0x4B              ;eee4  4b          DATA 'K'
    .byte 0x53              ;eee5  53          DATA 'S'
    .byte 0x45              ;eee6  45          DATA 'E'
    .byte 0x54              ;eee7  54          DATA 'T'
    .byte 0x00              ;eee8  00          DATA '\x00'
    .byte 0x4E              ;eee9  4e          DATA 'N'
    .byte 0x00              ;eeea  00          DATA '\x00'
    .byte 0x00              ;eeeb  00          DATA '\x00'
    .byte 0x53              ;eeec  53          DATA 'S'
    .byte 0x45              ;eeed  45          DATA 'E'
    .byte 0x45              ;eeee  45          DATA 'E'
    .byte 0x4B              ;eeef  4b          DATA 'K'
    .byte 0x53              ;eef0  53          DATA 'S'
    .byte 0x45              ;eef1  45          DATA 'E'
    .byte 0x54              ;eef2  54          DATA 'T'
    .byte 0x00              ;eef3  00          DATA '\x00'
    .byte 0x4D              ;eef4  4d          DATA 'M'
    .byte 0x31              ;eef5  31          DATA '1'
    .byte 0x00              ;eef6  00          DATA '\x00'
    .byte 0x53              ;eef7  53          DATA 'S'
    .byte 0x45              ;eef8  45          DATA 'E'
    .byte 0x45              ;eef9  45          DATA 'E'
    .byte 0x4B              ;eefa  4b          DATA 'K'
    .byte 0x53              ;eefb  53          DATA 'S'
    .byte 0x45              ;eefc  45          DATA 'E'
    .byte 0x54              ;eefd  54          DATA 'T'
    .byte 0x00              ;eefe  00          DATA '\x00'
    .byte 0x4D              ;eeff  4d          DATA 'M'
    .byte 0x32              ;ef00  32          DATA '2'
    .byte 0x00              ;ef01  00          DATA '\x00'
    .byte 0x53              ;ef02  53          DATA 'S'
    .byte 0x45              ;ef03  45          DATA 'E'
    .byte 0x45              ;ef04  45          DATA 'E'
    .byte 0x4B              ;ef05  4b          DATA 'K'
    .byte 0x53              ;ef06  53          DATA 'S'
    .byte 0x45              ;ef07  45          DATA 'E'
    .byte 0x54              ;ef08  54          DATA 'T'
    .byte 0x00              ;ef09  00          DATA '\x00'
    .byte 0x4D              ;ef0a  4d          DATA 'M'
    .byte 0x33              ;ef0b  33          DATA '3'
    .byte 0x00              ;ef0c  00          DATA '\x00'
    .byte 0x53              ;ef0d  53          DATA 'S'
    .byte 0x45              ;ef0e  45          DATA 'E'
    .byte 0x45              ;ef0f  45          DATA 'E'
    .byte 0x4B              ;ef10  4b          DATA 'K'
    .byte 0x53              ;ef11  53          DATA 'S'
    .byte 0x45              ;ef12  45          DATA 'E'
    .byte 0x54              ;ef13  54          DATA 'T'
    .byte 0x00              ;ef14  00          DATA '\x00'
    .byte 0x4E              ;ef15  4e          DATA 'N'
    .byte 0x31              ;ef16  31          DATA '1'
    .byte 0x00              ;ef17  00          DATA '\x00'
    .byte 0x53              ;ef18  53          DATA 'S'
    .byte 0x45              ;ef19  45          DATA 'E'
    .byte 0x45              ;ef1a  45          DATA 'E'
    .byte 0x4B              ;ef1b  4b          DATA 'K'
    .byte 0x53              ;ef1c  53          DATA 'S'
    .byte 0x45              ;ef1d  45          DATA 'E'
    .byte 0x54              ;ef1e  54          DATA 'T'
    .byte 0x00              ;ef1f  00          DATA '\x00'
    .byte 0x4E              ;ef20  4e          DATA 'N'
    .byte 0x32              ;ef21  32          DATA '2'
    .byte 0x00              ;ef22  00          DATA '\x00'
    .byte 0x53              ;ef23  53          DATA 'S'
    .byte 0x45              ;ef24  45          DATA 'E'
    .byte 0x45              ;ef25  45          DATA 'E'
    .byte 0x4B              ;ef26  4b          DATA 'K'
    .byte 0x53              ;ef27  53          DATA 'S'
    .byte 0x45              ;ef28  45          DATA 'E'
    .byte 0x54              ;ef29  54          DATA 'T'
    .byte 0x00              ;ef2a  00          DATA '\x00'
    .byte 0x4E              ;ef2b  4e          DATA 'N'
    .byte 0x33              ;ef2c  33          DATA '3'
    .byte 0x00              ;ef2d  00          DATA '\x00'
    .byte 0x53              ;ef2e  53          DATA 'S'
    .byte 0x45              ;ef2f  45          DATA 'E'
    .byte 0x45              ;ef30  45          DATA 'E'
    .byte 0x4B              ;ef31  4b          DATA 'K'
    .byte 0x53              ;ef32  53          DATA 'S'
    .byte 0x45              ;ef33  45          DATA 'E'
    .byte 0x54              ;ef34  54          DATA 'T'
    .byte 0x00              ;ef35  00          DATA '\x00'
    .byte 0x58              ;ef36  58          DATA 'X'
    .byte 0x00              ;ef37  00          DATA '\x00'
    .byte 0x00              ;ef38  00          DATA '\x00'
    .byte 0x53              ;ef39  53          DATA 'S'
    .byte 0x45              ;ef3a  45          DATA 'E'
    .byte 0x45              ;ef3b  45          DATA 'E'
    .byte 0x4B              ;ef3c  4b          DATA 'K'
    .byte 0x53              ;ef3d  53          DATA 'S'
    .byte 0x45              ;ef3e  45          DATA 'E'
    .byte 0x54              ;ef3f  54          DATA 'T'
    .byte 0x00              ;ef40  00          DATA '\x00'
    .byte 0x59              ;ef41  59          DATA 'Y'
    .byte 0x00              ;ef42  00          DATA '\x00'
    .byte 0x00              ;ef43  00          DATA '\x00'
    .byte 0x53              ;ef44  53          DATA 'S'
    .byte 0x45              ;ef45  45          DATA 'E'
    .byte 0x45              ;ef46  45          DATA 'E'
    .byte 0x4B              ;ef47  4b          DATA 'K'
    .byte 0x53              ;ef48  53          DATA 'S'
    .byte 0x45              ;ef49  45          DATA 'E'
    .byte 0x54              ;ef4a  54          DATA 'T'
    .byte 0x00              ;ef4b  00          DATA '\x00'
    .byte 0x5A              ;ef4c  5a          DATA 'Z'
    .byte 0x00              ;ef4d  00          DATA '\x00'
    .byte 0x00              ;ef4e  00          DATA '\x00'
    .byte 0x46              ;ef4f  46          DATA 'F'
    .byte 0x45              ;ef50  45          DATA 'E'
    .byte 0x52              ;ef51  52          DATA 'R'
    .byte 0x4E              ;ef52  4e          DATA 'N'
    .byte 0x00              ;ef53  00          DATA '\x00'
    .byte 0x00              ;ef54  00          DATA '\x00'
    .byte 0x00              ;ef55  00          DATA '\x00'
    .byte 0x4F              ;ef56  4f          DATA 'O'
    .byte 0x4E              ;ef57  4e          DATA 'N'
    .byte 0x00              ;ef58  00          DATA '\x00'
    .byte 0x00              ;ef59  00          DATA '\x00'
    .byte 0x46              ;ef5a  46          DATA 'F'
    .byte 0x45              ;ef5b  45          DATA 'E'
    .byte 0x52              ;ef5c  52          DATA 'R'
    .byte 0x4E              ;ef5d  4e          DATA 'N'
    .byte 0x00              ;ef5e  00          DATA '\x00'
    .byte 0x00              ;ef5f  00          DATA '\x00'
    .byte 0x00              ;ef60  00          DATA '\x00'
    .byte 0x4F              ;ef61  4f          DATA 'O'
    .byte 0x46              ;ef62  46          DATA 'F'
    .byte 0x46              ;ef63  46          DATA 'F'
    .byte 0x00              ;ef64  00          DATA '\x00'
    .byte 0x54              ;ef65  54          DATA 'T'
    .byte 0x45              ;ef66  45          DATA 'E'
    .byte 0x53              ;ef67  53          DATA 'S'
    .byte 0x54              ;ef68  54          DATA 'T'
    .byte 0x54              ;ef69  54          DATA 'T'
    .byte 0x55              ;ef6a  55          DATA 'U'
    .byte 0x4E              ;ef6b  4e          DATA 'N'
    .byte 0x00              ;ef6c  00          DATA '\x00'
    .byte 0x4F              ;ef6d  4f          DATA 'O'
    .byte 0x4E              ;ef6e  4e          DATA 'N'
    .byte 0x00              ;ef6f  00          DATA '\x00'
    .byte 0x54              ;ef70  54          DATA 'T'
    .byte 0x45              ;ef71  45          DATA 'E'
    .byte 0x53              ;ef72  53          DATA 'S'
    .byte 0x54              ;ef73  54          DATA 'T'
    .byte 0x00              ;ef74  00          DATA '\x00'
    .byte 0x00              ;ef75  00          DATA '\x00'
    .byte 0x51              ;ef76  51          DATA 'Q'
    .byte 0x00              ;ef77  00          DATA '\x00'
    .byte 0x00              ;ef78  00          DATA '\x00'
    .byte 0x00              ;ef79  00          DATA '\x00'
    .byte 0x00              ;ef7a  00          DATA '\x00'
    .byte 0x54              ;ef7b  54          DATA 'T'
    .byte 0x45              ;ef7c  45          DATA 'E'
    .byte 0x53              ;ef7d  53          DATA 'S'
    .byte 0x54              ;ef7e  54          DATA 'T'
    .byte 0x42              ;ef7f  42          DATA 'B'
    .byte 0x41              ;ef80  41          DATA 'A'
    .byte 0x53              ;ef81  53          DATA 'S'
    .byte 0x53              ;ef82  53          DATA 'S'
    .byte 0x00              ;ef83  00          DATA '\x00'
    .byte 0x00              ;ef84  00          DATA '\x00'
    .byte 0x00              ;ef85  00          DATA '\x00'
    .byte 0x54              ;ef86  54          DATA 'T'
    .byte 0x45              ;ef87  45          DATA 'E'
    .byte 0x53              ;ef88  53          DATA 'S'
    .byte 0x54              ;ef89  54          DATA 'T'
    .byte 0x54              ;ef8a  54          DATA 'T'
    .byte 0x52              ;ef8b  52          DATA 'R'
    .byte 0x45              ;ef8c  45          DATA 'E'
    .byte 0x42              ;ef8d  42          DATA 'B'
    .byte 0x00              ;ef8e  00          DATA '\x00'
    .byte 0x00              ;ef8f  00          DATA '\x00'
    .byte 0x00              ;ef90  00          DATA '\x00'
    .byte 0x54              ;ef91  54          DATA 'T'
    .byte 0x45              ;ef92  45          DATA 'E'
    .byte 0x53              ;ef93  53          DATA 'S'
    .byte 0x54              ;ef94  54          DATA 'T'
    .byte 0x54              ;ef95  54          DATA 'T'
    .byte 0x55              ;ef96  55          DATA 'U'
    .byte 0x4E              ;ef97  4e          DATA 'N'
    .byte 0x00              ;ef98  00          DATA '\x00'
    .byte 0x4F              ;ef99  4f          DATA 'O'
    .byte 0x46              ;ef9a  46          DATA 'F'
    .byte 0x46              ;ef9b  46          DATA 'F'
    .byte 0x00              ;ef9c  00          DATA '\x00'
    .byte 0x4F              ;ef9d  4f          DATA 'O'
    .byte 0x4E              ;ef9e  4e          DATA 'N'
    .byte 0x00              ;ef9f  00          DATA '\x00'
    .byte 0x54              ;efa0  54          DATA 'T'
    .byte 0x55              ;efa1  55          DATA 'U'
    .byte 0x4E              ;efa2  4e          DATA 'N'
    .byte 0x49              ;efa3  49          DATA 'I'
    .byte 0x4E              ;efa4  4e          DATA 'N'
    .byte 0x47              ;efa5  47          DATA 'G'
    .byte 0x00              ;efa6  00          DATA '\x00'
    .byte 0x54              ;efa7  54          DATA 'T'
    .byte 0x45              ;efa8  45          DATA 'E'
    .byte 0x53              ;efa9  53          DATA 'S'
    .byte 0x54              ;efaa  54          DATA 'T'
    .byte 0x42              ;efab  42          DATA 'B'
    .byte 0x41              ;efac  41          DATA 'A'
    .byte 0x53              ;efad  53          DATA 'S'
    .byte 0x53              ;efae  53          DATA 'S'
    .byte 0x00              ;efaf  00          DATA '\x00'
    .byte 0x00              ;efb0  00          DATA '\x00'
    .byte 0x00              ;efb1  00          DATA '\x00'
    .byte 0x54              ;efb2  54          DATA 'T'
    .byte 0x45              ;efb3  45          DATA 'E'
    .byte 0x53              ;efb4  53          DATA 'S'
    .byte 0x54              ;efb5  54          DATA 'T'
    .byte 0x54              ;efb6  54          DATA 'T'
    .byte 0x52              ;efb7  52          DATA 'R'
    .byte 0x45              ;efb8  45          DATA 'E'
    .byte 0x42              ;efb9  42          DATA 'B'
    .byte 0x00              ;efba  00          DATA '\x00'
    .byte 0x00              ;efbb  00          DATA '\x00'
    .byte 0x00              ;efbc  00          DATA '\x00'

    ;Table for A >= 0x40 and A < 0x50
    .byte 0x46              ;efbd  46          DATA 'F'
    .byte 0x4D              ;efbe  4d          DATA 'M'
    .byte 0x00              ;efbf  00          DATA '\x00'
    .byte 0x00              ;efc0  00          DATA '\x00'
    .byte 0x00              ;efc1  00          DATA '\x00'
    .byte 0x00              ;efc2  00          DATA '\x00'
    .byte 0x00              ;efc3  00          DATA '\x00'
    .byte 0x00              ;efc4  00          DATA '\x00'
    .byte 0x4D              ;efc5  4d          DATA 'M'
    .byte 0x48              ;efc6  48          DATA 'H'
    .byte 0x5A              ;efc7  5a          DATA 'Z'
    .byte 0x41              ;efc8  41          DATA 'A'
    .byte 0x4D              ;efc9  4d          DATA 'M'
    .byte 0x00              ;efca  00          DATA '\x00'
    .byte 0x00              ;efcb  00          DATA '\x00'
    .byte 0x00              ;efcc  00          DATA '\x00'
    .byte 0x00              ;efcd  00          DATA '\x00'
    .byte 0x00              ;efce  00          DATA '\x00'
    .byte 0x00              ;efcf  00          DATA '\x00'
    .byte 0x4B              ;efd0  4b          DATA 'K'
    .byte 0x48              ;efd1  48          DATA 'H'
    .byte 0x5A              ;efd2  5a          DATA 'Z'
    .byte 0x53              ;efd3  53          DATA 'S'
    .byte 0x43              ;efd4  43          DATA 'C'
    .byte 0x41              ;efd5  41          DATA 'A'
    .byte 0x4E              ;efd6  4e          DATA 'N'
    .byte 0x00              ;efd7  00          DATA '\x00'
    .byte 0x00              ;efd8  00          DATA '\x00'
    .byte 0x00              ;efd9  00          DATA '\x00'
    .byte 0x00              ;efda  00          DATA '\x00'
    .byte 0x4D              ;efdb  4d          DATA 'M'
    .byte 0x48              ;efdc  48          DATA 'H'
    .byte 0x5A              ;efdd  5a          DATA 'Z'
    .byte 0x53              ;efde  53          DATA 'S'
    .byte 0x43              ;efdf  43          DATA 'C'
    .byte 0x41              ;efe0  41          DATA 'A'
    .byte 0x4E              ;efe1  4e          DATA 'N'
    .byte 0x00              ;efe2  00          DATA '\x00'
    .byte 0x00              ;efe3  00          DATA '\x00'
    .byte 0x00              ;efe4  00          DATA '\x00'
    .byte 0x00              ;efe5  00          DATA '\x00'
    .byte 0x4B              ;efe6  4b          DATA 'K'
    .byte 0x48              ;efe7  48          DATA 'H'
    .byte 0x5A              ;efe8  5a          DATA 'Z'
    .byte 0x46              ;efe9  46          DATA 'F'
    .byte 0x4D              ;efea  4d          DATA 'M'
    .byte 0x00              ;efeb  00          DATA '\x00'
    .byte 0x00              ;efec  00          DATA '\x00'
    .byte 0x00              ;efed  00          DATA '\x00'
    .byte 0x00              ;efee  00          DATA '\x00'
    .byte 0x4D              ;efef  4d          DATA 'M'
    .byte 0x41              ;eff0  41          DATA 'A'
    .byte 0x58              ;eff1  58          DATA 'X'
    .byte 0x00              ;eff2  00          DATA '\x00'
    .byte 0x00              ;eff3  00          DATA '\x00'
    .byte 0x46              ;eff4  46          DATA 'F'
    .byte 0x4D              ;eff5  4d          DATA 'M'
    .byte 0x00              ;eff6  00          DATA '\x00'
    .byte 0x00              ;eff7  00          DATA '\x00'
    .byte 0x00              ;eff8  00          DATA '\x00'
    .byte 0x00              ;eff9  00          DATA '\x00'
    .byte 0x4D              ;effa  4d          DATA 'M'
    .byte 0x49              ;effb  49          DATA 'I'
    .byte 0x4E              ;effc  4e          DATA 'N'
    .byte 0x00              ;effd  00          DATA '\x00'
    .byte 0x00              ;effe  00          DATA '\x00'
    .byte 0x41              ;efff  41          DATA 'A'
    .byte 0x4D              ;f000  4d          DATA 'M'
    .byte 0x00              ;f001  00          DATA '\x00'
    .byte 0x00              ;f002  00          DATA '\x00'
    .byte 0x00              ;f003  00          DATA '\x00'
    .byte 0x00              ;f004  00          DATA '\x00'
    .byte 0x4D              ;f005  4d          DATA 'M'
    .byte 0x41              ;f006  41          DATA 'A'
    .byte 0x58              ;f007  58          DATA 'X'
    .byte 0x00              ;f008  00          DATA '\x00'
    .byte 0x00              ;f009  00          DATA '\x00'
    .byte 0x41              ;f00a  41          DATA 'A'
    .byte 0x4D              ;f00b  4d          DATA 'M'
    .byte 0x00              ;f00c  00          DATA '\x00'
    .byte 0x00              ;f00d  00          DATA '\x00'
    .byte 0x00              ;f00e  00          DATA '\x00'
    .byte 0x00              ;f00f  00          DATA '\x00'
    .byte 0x4D              ;f010  4d          DATA 'M'
    .byte 0x49              ;f011  49          DATA 'I'
    .byte 0x4E              ;f012  4e          DATA 'N'
    .byte 0x00              ;f013  00          DATA '\x00'
    .byte 0x00              ;f014  00          DATA '\x00'

    ;Table for A >= 0x50 and A < 0x60
    .byte 0x54              ;f015  54          DATA 'T'
    .byte 0x41              ;f016  41          DATA 'A'
    .byte 0x50              ;f017  50          DATA 'P'
    .byte 0x45              ;f018  45          DATA 'E'
    .byte 0x00              ;f019  00          DATA '\x00'
    .byte 0x50              ;f01a  50          DATA 'P'
    .byte 0x4C              ;f01b  4c          DATA 'L'
    .byte 0x41              ;f01c  41          DATA 'A'
    .byte 0x59              ;f01d  59          DATA 'Y'
    .byte 0x00              ;f01e  00          DATA '\x00'
    .byte 0x41              ;f01f  41          DATA 'A'
    .byte 0x54              ;f020  54          DATA 'T'
    .byte 0x41              ;f021  41          DATA 'A'
    .byte 0x50              ;f022  50          DATA 'P'
    .byte 0x45              ;f023  45          DATA 'E'
    .byte 0x00              ;f024  00          DATA '\x00'
    .byte 0x50              ;f025  50          DATA 'P'
    .byte 0x4C              ;f026  4c          DATA 'L'
    .byte 0x41              ;f027  41          DATA 'A'
    .byte 0x59              ;f028  59          DATA 'Y'
    .byte 0x00              ;f029  00          DATA '\x00'
    .byte 0x42              ;f02a  42          DATA 'B'
    .byte 0x54              ;f02b  54          DATA 'T'
    .byte 0x41              ;f02c  41          DATA 'A'
    .byte 0x50              ;f02d  50          DATA 'P'
    .byte 0x45              ;f02e  45          DATA 'E'
    .byte 0x00              ;f02f  00          DATA '\x00'
    .byte 0x00              ;f030  00          DATA '\x00'
    .byte 0x46              ;f031  46          DATA 'F'
    .byte 0x46              ;f032  46          DATA 'F'
    .byte 0x00              ;f033  00          DATA '\x00'
    .byte 0x00              ;f034  00          DATA '\x00'
    .byte 0x00              ;f035  00          DATA '\x00'
    .byte 0x54              ;f036  54          DATA 'T'
    .byte 0x41              ;f037  41          DATA 'A'
    .byte 0x50              ;f038  50          DATA 'P'
    .byte 0x45              ;f039  45          DATA 'E'
    .byte 0x00              ;f03a  00          DATA '\x00'
    .byte 0x00              ;f03b  00          DATA '\x00'
    .byte 0x52              ;f03c  52          DATA 'R'
    .byte 0x45              ;f03d  45          DATA 'E'
    .byte 0x57              ;f03e  57          DATA 'W'
    .byte 0x00              ;f03f  00          DATA '\x00'
    .byte 0x00              ;f040  00          DATA '\x00'
    .byte 0x54              ;f041  54          DATA 'T'
    .byte 0x41              ;f042  41          DATA 'A'
    .byte 0x50              ;f043  50          DATA 'P'
    .byte 0x45              ;f044  45          DATA 'E'
    .byte 0x4D              ;f045  4d          DATA 'M'
    .byte 0x53              ;f046  53          DATA 'S'
    .byte 0x53              ;f047  53          DATA 'S'
    .byte 0x00              ;f048  00          DATA '\x00'
    .byte 0x46              ;f049  46          DATA 'F'
    .byte 0x46              ;f04a  46          DATA 'F'
    .byte 0x00              ;f04b  00          DATA '\x00'
    .byte 0x54              ;f04c  54          DATA 'T'
    .byte 0x41              ;f04d  41          DATA 'A'
    .byte 0x50              ;f04e  50          DATA 'P'
    .byte 0x45              ;f04f  45          DATA 'E'
    .byte 0x4D              ;f050  4d          DATA 'M'
    .byte 0x53              ;f051  53          DATA 'S'
    .byte 0x53              ;f052  53          DATA 'S'
    .byte 0x00              ;f053  00          DATA '\x00'
    .byte 0x52              ;f054  52          DATA 'R'
    .byte 0x45              ;f055  45          DATA 'E'
    .byte 0x57              ;f056  57          DATA 'W'
    .byte 0x54              ;f057  54          DATA 'T'
    .byte 0x41              ;f058  41          DATA 'A'
    .byte 0x50              ;f059  50          DATA 'P'
    .byte 0x45              ;f05a  45          DATA 'E'
    .byte 0x00              ;f05b  00          DATA '\x00'
    .byte 0x53              ;f05c  53          DATA 'S'
    .byte 0x43              ;f05d  43          DATA 'C'
    .byte 0x41              ;f05e  41          DATA 'A'
    .byte 0x4E              ;f05f  4e          DATA 'N'
    .byte 0x00              ;f060  00          DATA '\x00'
    .byte 0x41              ;f061  41          DATA 'A'
    .byte 0x54              ;f062  54          DATA 'T'
    .byte 0x41              ;f063  41          DATA 'A'
    .byte 0x50              ;f064  50          DATA 'P'
    .byte 0x45              ;f065  45          DATA 'E'
    .byte 0x00              ;f066  00          DATA '\x00'
    .byte 0x53              ;f067  53          DATA 'S'
    .byte 0x43              ;f068  43          DATA 'C'
    .byte 0x41              ;f069  41          DATA 'A'
    .byte 0x4E              ;f06a  4e          DATA 'N'
    .byte 0x00              ;f06b  00          DATA '\x00'
    .byte 0x42              ;f06c  42          DATA 'B'
    .byte 0x54              ;f06d  54          DATA 'T'
    .byte 0x41              ;f06e  41          DATA 'A'
    .byte 0x50              ;f06f  50          DATA 'P'
    .byte 0x45              ;f070  45          DATA 'E'
    .byte 0x00              ;f071  00          DATA '\x00'
    .byte 0x4D              ;f072  4d          DATA 'M'
    .byte 0x45              ;f073  45          DATA 'E'
    .byte 0x54              ;f074  54          DATA 'T'
    .byte 0x41              ;f075  41          DATA 'A'
    .byte 0x4C              ;f076  4c          DATA 'L'
    .byte 0x00              ;f077  00          DATA '\x00'
    .byte 0x54              ;f078  54          DATA 'T'
    .byte 0x41              ;f079  41          DATA 'A'
    .byte 0x50              ;f07a  50          DATA 'P'
    .byte 0x45              ;f07b  45          DATA 'E'
    .byte 0x00              ;f07c  00          DATA '\x00'
    .byte 0x00              ;f07d  00          DATA '\x00'
    .byte 0x42              ;f07e  42          DATA 'B'
    .byte 0x4C              ;f07f  4c          DATA 'L'
    .byte 0x53              ;f080  53          DATA 'S'
    .byte 0x00              ;f081  00          DATA '\x00'
    .byte 0x00              ;f082  00          DATA '\x00'
    .byte 0x00              ;f083  00          DATA '\x00'
    .byte 0x00              ;f084  00          DATA '\x00'
    .byte 0x00              ;f085  00          DATA '\x00'
    .byte 0x00              ;f086  00          DATA '\x00'
    .byte 0x4E              ;f087  4e          DATA 'N'
    .byte 0x4F              ;f088  4f          DATA 'O'
    .byte 0x00              ;f089  00          DATA '\x00'
    .byte 0x54              ;f08a  54          DATA 'T'
    .byte 0x41              ;f08b  41          DATA 'A'
    .byte 0x50              ;f08c  50          DATA 'P'
    .byte 0x45              ;f08d  45          DATA 'E'
    .byte 0x54              ;f08e  54          DATA 'T'
    .byte 0x41              ;f08f  41          DATA 'A'
    .byte 0x50              ;f090  50          DATA 'P'
    .byte 0x45              ;f091  45          DATA 'E'
    .byte 0x00              ;f092  00          DATA '\x00'
    .byte 0x45              ;f093  45          DATA 'E'
    .byte 0x52              ;f094  52          DATA 'R'
    .byte 0x52              ;f095  52          DATA 'R'
    .byte 0x4F              ;f096  4f          DATA 'O'
    .byte 0x52              ;f097  52          DATA 'R'
    .byte 0x00              ;f098  00          DATA '\x00'
    .byte 0x54              ;f099  54          DATA 'T'
    .byte 0x41              ;f09a  41          DATA 'A'
    .byte 0x50              ;f09b  50          DATA 'P'
    .byte 0x45              ;f09c  45          DATA 'E'
    .byte 0x00              ;f09d  00          DATA '\x00'
    .byte 0x00              ;f09e  00          DATA '\x00'
    .byte 0x4D              ;f09f  4d          DATA 'M'
    .byte 0x41              ;f0a0  41          DATA 'A'
    .byte 0x58              ;f0a1  58          DATA 'X'
    .byte 0x00              ;f0a2  00          DATA '\x00'
    .byte 0x00              ;f0a3  00          DATA '\x00'
    .byte 0x54              ;f0a4  54          DATA 'T'
    .byte 0x41              ;f0a5  41          DATA 'A'
    .byte 0x50              ;f0a6  50          DATA 'P'
    .byte 0x45              ;f0a7  45          DATA 'E'
    .byte 0x00              ;f0a8  00          DATA '\x00'
    .byte 0x00              ;f0a9  00          DATA '\x00'
    .byte 0x4D              ;f0aa  4d          DATA 'M'
    .byte 0x49              ;f0ab  49          DATA 'I'
    .byte 0x4E              ;f0ac  4e          DATA 'N'
    .byte 0x00              ;f0ad  00          DATA '\x00'
    .byte 0x00              ;f0ae  00          DATA '\x00'

    ;Table for A >= 0x60 and A < 0x80
    .byte 0x00              ;f0af  00          DATA '\x00'
    .byte 0x00              ;f0b0  00          DATA '\x00'
    .byte 0x00              ;f0b1  00          DATA '\x00'
    .byte 0x00              ;f0b2  00          DATA '\x00'
    .byte 0x00              ;f0b3  00          DATA '\x00'
    .byte 0x4D              ;f0b4  4d          DATA 'M'
    .byte 0x41              ;f0b5  41          DATA 'A'
    .byte 0x58              ;f0b6  58          DATA 'X'
    .byte 0x00              ;f0b7  00          DATA '\x00'
    .byte 0x00              ;f0b8  00          DATA '\x00'
    .byte 0x00              ;f0b9  00          DATA '\x00'
    .byte 0x00              ;f0ba  00          DATA '\x00'
    .byte 0x00              ;f0bb  00          DATA '\x00'
    .byte 0x00              ;f0bc  00          DATA '\x00'
    .byte 0x00              ;f0bd  00          DATA '\x00'
    .byte 0x00              ;f0be  00          DATA '\x00'
    .byte 0x4D              ;f0bf  4d          DATA 'M'
    .byte 0x49              ;f0c0  49          DATA 'I'
    .byte 0x4E              ;f0c1  4e          DATA 'N'
    .byte 0x00              ;f0c2  00          DATA '\x00'
    .byte 0x00              ;f0c3  00          DATA '\x00'
    .byte 0x00              ;f0c4  00          DATA '\x00'
    .byte 0x42              ;f0c5  42          DATA 'B'
    .byte 0x41              ;f0c6  41          DATA 'A'
    .byte 0x53              ;f0c7  53          DATA 'S'
    .byte 0x53              ;f0c8  53          DATA 'S'
    .byte 0x00              ;f0c9  00          DATA '\x00'
    .byte 0x00              ;f0ca  00          DATA '\x00'
    .byte 0x00              ;f0cb  00          DATA '\x00'
    .byte 0x00              ;f0cc  00          DATA '\x00'
    .byte 0x00              ;f0cd  00          DATA '\x00'
    .byte 0x00              ;f0ce  00          DATA '\x00'
    .byte 0x00              ;f0cf  00          DATA '\x00'
    .byte 0x54              ;f0d0  54          DATA 'T'
    .byte 0x52              ;f0d1  52          DATA 'R'
    .byte 0x45              ;f0d2  45          DATA 'E'
    .byte 0x42              ;f0d3  42          DATA 'B'
    .byte 0x00              ;f0d4  00          DATA '\x00'
    .byte 0x00              ;f0d5  00          DATA '\x00'
    .byte 0x00              ;f0d6  00          DATA '\x00'
    .byte 0x00              ;f0d7  00          DATA '\x00'
    .byte 0x00              ;f0d8  00          DATA '\x00'
    .byte 0x00              ;f0d9  00          DATA '\x00'
    .byte 0x00              ;f0da  00          DATA '\x00'
    .byte 0x42              ;f0db  42          DATA 'B'
    .byte 0x41              ;f0dc  41          DATA 'A'
    .byte 0x4C              ;f0dd  4c          DATA 'L'
    .byte 0x00              ;f0de  00          DATA '\x00'
    .byte 0x4C              ;f0df  4c          DATA 'L'
    .byte 0x45              ;f0e0  45          DATA 'E'
    .byte 0x46              ;f0e1  46          DATA 'F'
    .byte 0x54              ;f0e2  54          DATA 'T'
    .byte 0x00              ;f0e3  00          DATA '\x00'
    .byte 0x00              ;f0e4  00          DATA '\x00'
    .byte 0x00              ;f0e5  00          DATA '\x00'
    .byte 0x42              ;f0e6  42          DATA 'B'
    .byte 0x41              ;f0e7  41          DATA 'A'
    .byte 0x4C              ;f0e8  4c          DATA 'L'
    .byte 0x00              ;f0e9  00          DATA '\x00'
    .byte 0x52              ;f0ea  52          DATA 'R'
    .byte 0x49              ;f0eb  49          DATA 'I'
    .byte 0x47              ;f0ec  47          DATA 'G'
    .byte 0x48              ;f0ed  48          DATA 'H'
    .byte 0x54              ;f0ee  54          DATA 'T'
    .byte 0x00              ;f0ef  00          DATA '\x00'
    .byte 0x00              ;f0f0  00          DATA '\x00'
    .byte 0x42              ;f0f1  42          DATA 'B'
    .byte 0x41              ;f0f2  41          DATA 'A'
    .byte 0x4C              ;f0f3  4c          DATA 'L'
    .byte 0x00              ;f0f4  00          DATA '\x00'
    .byte 0x43              ;f0f5  43          DATA 'C'
    .byte 0x45              ;f0f6  45          DATA 'E'
    .byte 0x4E              ;f0f7  4e          DATA 'N'
    .byte 0x54              ;f0f8  54          DATA 'T'
    .byte 0x45              ;f0f9  45          DATA 'E'
    .byte 0x52              ;f0fa  52          DATA 'R'
    .byte 0x00              ;f0fb  00          DATA '\x00'
    .byte 0x46              ;f0fc  46          DATA 'F'
    .byte 0x41              ;f0fd  41          DATA 'A'
    .byte 0x44              ;f0fe  44          DATA 'D'
    .byte 0x45              ;f0ff  45          DATA 'E'
    .byte 0x46              ;f100  46          DATA 'F'
    .byte 0x52              ;f101  52          DATA 'R'
    .byte 0x4F              ;f102  4f          DATA 'O'
    .byte 0x4E              ;f103  4e          DATA 'N'
    .byte 0x54              ;f104  54          DATA 'T'
    .byte 0x00              ;f105  00          DATA '\x00'
    .byte 0x00              ;f106  00          DATA '\x00'
    .byte 0x46              ;f107  46          DATA 'F'
    .byte 0x41              ;f108  41          DATA 'A'
    .byte 0x44              ;f109  44          DATA 'D'
    .byte 0x45              ;f10a  45          DATA 'E'
    .byte 0x52              ;f10b  52          DATA 'R'
    .byte 0x45              ;f10c  45          DATA 'E'
    .byte 0x41              ;f10d  41          DATA 'A'
    .byte 0x52              ;f10e  52          DATA 'R'
    .byte 0x00              ;f10f  00          DATA '\x00'
    .byte 0x00              ;f110  00          DATA '\x00'
    .byte 0x00              ;f111  00          DATA '\x00'
    .byte 0x46              ;f112  46          DATA 'F'
    .byte 0x41              ;f113  41          DATA 'A'
    .byte 0x44              ;f114  44          DATA 'D'
    .byte 0x45              ;f115  45          DATA 'E'
    .byte 0x43              ;f116  43          DATA 'C'
    .byte 0x45              ;f117  45          DATA 'E'
    .byte 0x4E              ;f118  4e          DATA 'N'
    .byte 0x54              ;f119  54          DATA 'T'
    .byte 0x45              ;f11a  45          DATA 'E'
    .byte 0x52              ;f11b  52          DATA 'R'
    .byte 0x00              ;f11c  00          DATA '\x00'

    ;Table for A >= 0x80 and A < 0xB0
    .byte 0x00              ;f11d  00          DATA '\x00'
    .byte 0x00              ;f11e  00          DATA '\x00'
    .byte 0x00              ;f11f  00          DATA '\x00'
    .byte 0x00              ;f120  00          DATA '\x00'
    .byte 0x4E              ;f121  4e          DATA 'N'
    .byte 0x4F              ;f122  4f          DATA 'O'
    .byte 0x00              ;f123  00          DATA '\x00'
    .byte 0x43              ;f124  43          DATA 'C'
    .byte 0x4F              ;f125  4f          DATA 'O'
    .byte 0x44              ;f126  44          DATA 'D'
    .byte 0x45              ;f127  45          DATA 'E'
    .byte 0x00              ;f128  00          DATA '\x00'
    .byte 0x00              ;f129  00          DATA '\x00'
    .byte 0x00              ;f12a  00          DATA '\x00'
    .byte 0x00              ;f12b  00          DATA '\x00'
    .byte 0x00              ;f12c  00          DATA '\x00'
    .byte 0x43              ;f12d  43          DATA 'C'
    .byte 0x4F              ;f12e  4f          DATA 'O'
    .byte 0x44              ;f12f  44          DATA 'D'
    .byte 0x45              ;f130  45          DATA 'E'
    .byte 0x00              ;f131  00          DATA '\x00'
    .byte 0x00              ;f132  00          DATA '\x00'
    .byte 0x00              ;f133  00          DATA '\x00'
    .byte 0x00              ;f134  00          DATA '\x00'
    .byte 0x00              ;f135  00          DATA '\x00'
    .byte 0x00              ;f136  00          DATA '\x00'
    .byte 0x00              ;f137  00          DATA '\x00'
    .byte 0x00              ;f138  00          DATA '\x00'
    .byte 0x00              ;f139  00          DATA '\x00'
    .byte 0x00              ;f13a  00          DATA '\x00'
    .byte 0x00              ;f13b  00          DATA '\x00'
    .byte 0x00              ;f13c  00          DATA '\x00'
    .byte 0x00              ;f13d  00          DATA '\x00'
    .byte 0x00              ;f13e  00          DATA '\x00'
    .byte 0x00              ;f13f  00          DATA '\x00'
    .byte 0x00              ;f140  00          DATA '\x00'
    .byte 0x00              ;f141  00          DATA '\x00'
    .byte 0x00              ;f142  00          DATA '\x00'
    .byte 0x53              ;f143  53          DATA 'S'
    .byte 0x41              ;f144  41          DATA 'A'
    .byte 0x46              ;f145  46          DATA 'F'
    .byte 0x45              ;f146  45          DATA 'E'
    .byte 0x00              ;f147  00          DATA '\x00'
    .byte 0x00              ;f148  00          DATA '\x00'
    .byte 0x00              ;f149  00          DATA '\x00'
    .byte 0x00              ;f14a  00          DATA '\x00'
    .byte 0x00              ;f14b  00          DATA '\x00'
    .byte 0x00              ;f14c  00          DATA '\x00'
    .byte 0x49              ;f14d  49          DATA 'I'
    .byte 0x4E              ;f14e  4e          DATA 'N'
    .byte 0x49              ;f14f  49          DATA 'I'
    .byte 0x54              ;f150  54          DATA 'T'
    .byte 0x49              ;f151  49          DATA 'I'
    .byte 0x41              ;f152  41          DATA 'A'
    .byte 0x4C              ;f153  4c          DATA 'L'
    .byte 0x00              ;f154  00          DATA '\x00'
    .byte 0x00              ;f155  00          DATA '\x00'
    .byte 0x00              ;f156  00          DATA '\x00'
    .byte 0x00              ;f157  00          DATA '\x00'
    .byte 0x4E              ;f158  4e          DATA 'N'
    .byte 0x4F              ;f159  4f          DATA 'O'
    .byte 0x00              ;f15a  00          DATA '\x00'
    .byte 0x43              ;f15b  43          DATA 'C'
    .byte 0x4F              ;f15c  4f          DATA 'O'
    .byte 0x44              ;f15d  44          DATA 'D'
    .byte 0x45              ;f15e  45          DATA 'E'
    .byte 0x00              ;f15f  00          DATA '\x00'
    .byte 0x00              ;f160  00          DATA '\x00'
    .byte 0x00              ;f161  00          DATA '\x00'
    .byte 0x00              ;f162  00          DATA '\x00'
    .byte 0x00              ;f163  00          DATA '\x00'
    .byte 0x53              ;f164  53          DATA 'S'
    .byte 0x41              ;f165  41          DATA 'A'
    .byte 0x46              ;f166  46          DATA 'F'
    .byte 0x45              ;f167  45          DATA 'E'
    .byte 0x00              ;f168  00          DATA '\x00'
    .byte 0x00              ;f169  00          DATA '\x00'
    .byte 0x00              ;f16a  00          DATA '\x00'
    .byte 0x00              ;f16b  00          DATA '\x00'
    .byte 0x00              ;f16c  00          DATA '\x00'
    .byte 0x00              ;f16d  00          DATA '\x00'
    .byte 0x43              ;f16e  43          DATA 'C'
    .byte 0x4C              ;f16f  4c          DATA 'L'
    .byte 0x45              ;f170  45          DATA 'E'
    .byte 0x41              ;f171  41          DATA 'A'
    .byte 0x52              ;f172  52          DATA 'R'
    .byte 0x00              ;f173  00          DATA '\x00'
    .byte 0x00              ;f174  00          DATA '\x00'
    .byte 0x00              ;f175  00          DATA '\x00'
    .byte 0x00              ;f176  00          DATA '\x00'
    .byte 0x00              ;f177  00          DATA '\x00'
    .byte 0x00              ;f178  00          DATA '\x00'
    .byte 0x00              ;f179  00          DATA '\x00'
    .byte 0x44              ;f17a  44          DATA 'D'
    .byte 0x49              ;f17b  49          DATA 'I'
    .byte 0x41              ;f17c  41          DATA 'A'
    .byte 0x47              ;f17d  47          DATA 'G'
    .byte 0x00              ;f17e  00          DATA '\x00'
    .byte 0x00              ;f17f  00          DATA '\x00'
    .byte 0x54              ;f180  54          DATA 'T'
    .byte 0x45              ;f181  45          DATA 'E'
    .byte 0x53              ;f182  53          DATA 'S'
    .byte 0x54              ;f183  54          DATA 'T'
    .byte 0x44              ;f184  44          DATA 'D'
    .byte 0x49              ;f185  49          DATA 'I'
    .byte 0x53              ;f186  53          DATA 'S'
    .byte 0x50              ;f187  50          DATA 'P'
    .byte 0x4C              ;f188  4c          DATA 'L'
    .byte 0x41              ;f189  41          DATA 'A'
    .byte 0x59              ;f18a  59          DATA 'Y'
    .byte 0x00              ;f18b  00          DATA '\x00'
    .byte 0x00              ;f18c  00          DATA '\x00'
    .byte 0x00              ;f18d  00          DATA '\x00'
    .byte 0x00              ;f18e  00          DATA '\x00'
    .byte 0x00              ;f18f  00          DATA '\x00'
    .byte 0x42              ;f190  42          DATA 'B'
    .byte 0x4F              ;f191  4f          DATA 'O'
    .byte 0x53              ;f192  53          DATA 'S'
    .byte 0x45              ;f193  45          DATA 'E'
    .byte 0x00              ;f194  00          DATA '\x00'
    .byte 0x00              ;f195  00          DATA '\x00'
    .byte 0x00              ;f196  00          DATA '\x00'
    .byte 0x00              ;f197  00          DATA '\x00'
    .byte 0x00              ;f198  00          DATA '\x00'
    .byte 0x00              ;f199  00          DATA '\x00'
    .byte 0x00              ;f19a  00          DATA '\x00'
    .byte 0x00              ;f19b  00          DATA '\x00'
    .byte 0x00              ;f19c  00          DATA '\x00'
    .byte 0x00              ;f19d  00          DATA '\x00'
    .byte 0x00              ;f19e  00          DATA '\x00'
    .byte 0x00              ;f19f  00          DATA '\x00'
    .byte 0x00              ;f1a0  00          DATA '\x00'

    ;Table for A > 0xD0
    .byte 0x00              ;f1a1  00          DATA '\x00'
    .byte 0x00              ;f1a2  00          DATA '\x00'
    .byte 0x00              ;f1a3  00          DATA '\x00'
    .byte 0x00              ;f1a4  00          DATA '\x00'
    .byte 0x56              ;f1a5  56          DATA 'V'
    .byte 0x57              ;f1a6  57          DATA 'W'
    .byte 0x2D              ;f1a7  2d          DATA '-'
    .byte 0x43              ;f1a8  43          DATA 'C'
    .byte 0x41              ;f1a9  41          DATA 'A'
    .byte 0x52              ;f1aa  52          DATA 'R'
    .byte 0x00              ;f1ab  00          DATA '\x00'


sub_f1ac:
    movw a, ps              ;f1ac  70
    movw a, #0x00ff         ;f1ad  e4 00 ff
    andw a                  ;f1b0  63
    movw ps, a              ;f1b1  71
    call sub_f1f3           ;f1b2  31 f1 f3
    bbc 0x00ab:5, lab_f1d4  ;f1b5  b5 ab 1c
    bbc 0x00ab:0, lab_f1d4  ;f1b8  b0 ab 19
    clrb 0xab:5             ;f1bb  a5 ab
    mov a, #0x10            ;f1bd  04 10
    mov 0xca, a             ;f1bf  45 ca

lab_f1c1:
    mov a, #0x05            ;f1c1  04 05
    mov 0xcb, a             ;f1c3  45 cb
    mov a, #0x14            ;f1c5  04 14
    mov 0xc9, a             ;f1c7  45 c9

    mov a, #0x04            ;f1c9  04 04
    mov 0xc3, a             ;f1cb  45 c3        Set 0x00C3 = 0x04

lab_f1cd:
    call sub_f230           ;f1cd  31 f2 30
    call sub_f3b2           ;f1d0  31 f3 b2
    ret                     ;f1d3  20

lab_f1d4:
    bbc 0x00ab:4, lab_f1e3  ;f1d4  b4 ab 0c
    bbc 0x00ab:0, lab_f1e3  ;f1d7  b0 ab 09
    clrb 0xab:4             ;f1da  a4 ab
    mov a, #0x10            ;f1dc  04 10
    mov 0xca, a             ;f1de  45 ca
    jmp lab_f1c1            ;f1e0  21 f1 c1

lab_f1e3:
    mov a, 0xc9             ;f1e3  05 c9
    bne lab_f1ec            ;f1e5  fc 05
    setb 0xab:0             ;f1e7  a8 ab
    jmp lab_f1c1            ;f1e9  21 f1 c1

lab_f1ec:
    mov a, 0xcb             ;f1ec  05 cb
    bne lab_f1cd            ;f1ee  fc dd
    jmp lab_f1c1            ;f1f0  21 f1 c1

sub_f1f3:
    mov a, 0xc6             ;f1f3  05 c6
    cmp a, #0x04            ;f1f5  14 04
    bhs lab_f213            ;f1f7  f8 1a
    cmp a, #0x02            ;f1f9  14 02
    blo lab_f213            ;f1fb  f9 16

lab_f1fd:
    mov a, #0x14            ;f1fd  04 14
    mov 0xc9, a             ;f1ff  45 c9
    mov a, #0x00            ;f201  04 00
    mov 0xc6, a             ;f203  45 c6
    bbs 0x00ab:0, lab_f212  ;f205  b8 ab 0a
    setb 0xab:0             ;f208  a8 ab
    mov a, #0x00            ;f20a  04 00
    mov 0xca, a             ;f20c  45 ca

    mov a, #0x04            ;f20e  04 04
    mov 0xc3, a             ;f210  45 c3        Set 0x00C3 = 0x04

lab_f212:
    ret                     ;f212  20

lab_f213:
    mov a, 0xc6             ;f213  05 c6
    cmp a, #0x07            ;f215  14 07
    bhs lab_f220            ;f217  f8 07
    cmp a, #0x04            ;f219  14 04
    blo lab_f220            ;f21b  f9 03
    jmp lab_f1fd            ;f21d  21 f1 fd

lab_f220:
    mov a, 0xc6             ;f220  05 c6
    cmp a, #0x0a            ;f222  14 0a
    bhs lab_f212            ;f224  f8 ec
    cmp a, #0x07            ;f226  14 07
    blo lab_f212            ;f228  f9 e8
    mov 0xc6, #0x00         ;f22a  85 c6 00
    jmp lab_f212            ;f22d  21 f2 12

sub_f230:
    mov a, 0xc3             ;f230  05 c3        A = read byte at 0x00C3
    bne lab_f235            ;f232  fc 01

lab_f234:
    ret                     ;f234  20

lab_f235:
    cmp a, #0x02            ;f235  14 02        If A = 0x02, call sub_f267 and return
    bne lab_f23f            ;f237  fc 06
    call sub_f267           ;f239  31 f2 67
    jmp lab_f234            ;f23c  21 f2 34

lab_f23f:
    cmp a, #0x04            ;f23f  14 04        If A = 0x04, call ...
    bne lab_f249            ;f241  fc 06
    call sub_f281           ;f243  31 f2 81
    jmp lab_f234            ;f246  21 f2 34

lab_f249:
    cmp a, #0x06            ;f249  14 06
    bne lab_f253            ;f24b  fc 06
    call sub_f29d           ;f24d  31 f2 9d
    jmp lab_f234            ;f250  21 f2 34

lab_f253:
    cmp a, #0x08            ;f253  14 08
    bne lab_f25d            ;f255  fc 06
    call sub_f2c4           ;f257  31 f2 c4
    jmp lab_f234            ;f25a  21 f2 34

lab_f25d:
    cmp a, #0x0a            ;f25d  14 0a
    bne lab_f234            ;f25f  fc d3
    call sub_f2f4           ;f261  31 f2 f4
    jmp lab_f234            ;f264  21 f2 34

sub_f267:
;handle 0x00C3 = 0x02
    clrb pdr4:3             ;f267  a3 0e        ;/DISP_ENA_OUT = low

    movw a, #0x0007         ;f269  e4 00 07     ;Busy loop
lab_f26c:
    decw a                  ;f26c  d0
    bne lab_f26c            ;f26d  fc fd

    setb pdr4:3             ;f26f  ab 0e        ;/DISP_ENA_OUT = high

    movw a, #0x0020         ;f271  e4 00 20     ;Busy loop
lab_f274:
    decw a                  ;f274  d0
    bne lab_f274            ;f275  fc fd

    mov a, #0xf3            ;f277  04 f3
    call sub_f2ff           ;f279  31 f2 ff     ;Send 0xF3 out 3LB SPI bus

    mov a, #0x04            ;f27c  04 04
    mov 0xc3, a             ;f27e  45 c3        ;Set 0x00C3 = 0x04
    ret                     ;f280  20

sub_f281:
;handle 0x00C3 = 0x04
    mov a, 0xca             ;f281  05 ca
    bne lab_f29c            ;f283  fc 17

    mov a, #0x06            ;f285  04 06
    mov 0xc3, a             ;f287  45 c3        ;Set 0x00C3 = 0x06

    call sub_f30f           ;f289  31 f3 0f
    mov 0xc2, #0x00         ;f28c  85 c2 00
    mov a, #0x03            ;f28f  04 03
    mov 0xc8, a             ;f291  45 c8
    mov a, 0xe7             ;f293  05 e7
    cmp a, #0x05            ;f295  14 05
    beq lab_f29c            ;f297  fd 03
    incw a                  ;f299  c0
    mov 0xe7, a             ;f29a  45 e7

lab_f29c:
    ret                     ;f29c  20

sub_f29d:
;handle 0x00C4 = 0x06
    bbs pdr4:7, lab_f2c3    ;f29d  bf 0e 23     ;Branch if DISP_ENA_IN = high
    mov a, 0xc8             ;f2a0  05 c8
    bne lab_f2c3            ;f2a2  fc 1f
    clrb pdr4:3             ;f2a4  a3 0e        ;/DISP_ENA_OUT = low

    movw a, #0x0007         ;f2a6  e4 00 07     ;Busy loop
lab_f2a9:
    decw a                  ;f2a9  d0
    bne lab_f2a9            ;f2aa  fc fd

    setb pdr4:3             ;f2ac  ab 0e        ;/DISP_ENA_OUT = high

    movw a, #0x0020         ;f2ae  e4 00 20     ;Busy loop
lab_f2b1:
    decw a                  ;f2b1  d0
    bne lab_f2b1            ;f2b2  fc fd

    call sub_f2fc           ;f2b4  31 f2 fc     ;Send data byte at pointer in 0x00C0 out 3LB SPI
    mov a, #0x08            ;f2b7  04 08

    mov 0xc3, a             ;f2b9  45 c3
    movw a, 0xc0            ;f2bb  c5 c0        ;Set 0x00C3 = 0xC0

    incw a                  ;f2bd  c0
    movw 0xc0, a            ;f2be  d5 c0
    mov 0xc4, #0x00         ;f2c0  85 c4 00

lab_f2c3:
    ret                     ;f2c3  20

sub_f2c4:
;handle 0x00C = 0x08
    mov a, 0xc4             ;f2c4  05 c4
    bne lab_f2f3            ;f2c6  fc 2b
    bbc pdr4:7, lab_f2f3    ;f2c8  b7 0e 28     ;Branch if DISP_ENA_IN = low
    mov a, #0x00            ;f2cb  04 00
    mov 0xe7, a             ;f2cd  45 e7
    movw a, #0x0000         ;f2cf  e4 00 00
    mov a, 0xc2             ;f2d2  05 c2
    mov a, #0xac            ;f2d4  04 ac
    clrc                    ;f2d6  81
    addc a                  ;f2d7  22
    mov a, @a               ;f2d8  92
    call sub_f2fc           ;f2d9  31 f2 fc     ;Send data byte at pointer in 0x00C0 out 3LB SPI
    mov 0xc4, #0x00         ;f2dc  85 c4 00
    setb 0xab:1             ;f2df  a9 ab
    movw a, 0xc0            ;f2e1  c5 c0
    incw a                  ;f2e3  c0
    movw 0xc0, a            ;f2e4  d5 c0
    mov a, 0xc2             ;f2e6  05 c2
    incw a                  ;f2e8  c0
    mov 0xc2, a             ;f2e9  45 c2
    cmp a, #0x13            ;f2eb  14 13
    bne lab_f2f3            ;f2ed  fc 04

    mov a, #0x0a            ;f2ef  04 0a
    mov 0xc3, a             ;f2f1  45 c3        ;Set 0x00C3 = 0x0A

lab_f2f3:
    ret                     ;f2f3  20

sub_f2f4:
;handle 0x00C3 = 0x0A
    mov a, #0x00            ;f2f4  04 00
    mov 0xc3, a             ;f2f6  45 c3        ;Set 0x00C3 = 0
    mov 0xc6, #0x00         ;f2f8  85 c6 00
    ret                     ;f2fb  20

sub_f2fc:
;Read a byte from the pointer in 0x00C0 and send it out 3LB bus SPI
    movw a, 0xc0            ;f2fc  c5 c0
    mov a, @a               ;f2fe  92

sub_f2ff:
;Send byte in A out 3LB bus SPI
    mov sdr2, a             ;f2ff  45 1f
    clrb smr2:7             ;f301  a7 1e
    nop                     ;f303  00
    nop                     ;f304  00
    nop                     ;f305  00
    setb smr2:0             ;f306  a8 1e
    nop                     ;f308  00
    nop                     ;f309  00
    nop                     ;f30a  00

lab_f30b:
    bbc smr2:7, lab_f30b    ;f30b  b7 1e fd
    ret                     ;f30e  20

sub_f30f:
    mov a, 0xd7             ;f30f  05 d7
    bne lab_f315            ;f311  fc 02
    mov a, #0x20            ;f313  04 20

lab_f315:
    mov 0xaf, a             ;f315  45 af
    mov a, 0xd8             ;f317  05 d8
    bne lab_f31d            ;f319  fc 02
    mov a, #0x20            ;f31b  04 20

lab_f31d:
    mov 0xb0, a             ;f31d  45 b0
    mov a, 0xd9             ;f31f  05 d9
    bne lab_f325            ;f321  fc 02
    mov a, #0x20            ;f323  04 20

lab_f325:
    mov 0xb1, a             ;f325  45 b1
    mov a, 0xda             ;f327  05 da
    bne lab_f32d            ;f329  fc 02
    mov a, #0x20            ;f32b  04 20

lab_f32d:
    mov 0xb2, a             ;f32d  45 b2
    mov a, 0xdb             ;f32f  05 db
    bne lab_f335            ;f331  fc 02
    mov a, #0x20            ;f333  04 20

lab_f335:
    mov 0xb3, a             ;f335  45 b3
    mov a, 0xdc             ;f337  05 dc
    bne lab_f33d            ;f339  fc 02
    mov a, #0x20            ;f33b  04 20

lab_f33d:
    mov 0xb4, a             ;f33d  45 b4
    mov a, 0xdd             ;f33f  05 dd
    bne lab_f345            ;f341  fc 02
    mov a, #0x20            ;f343  04 20

lab_f345:
    mov 0xb5, a             ;f345  45 b5
    mov a, 0xde             ;f347  05 de
    bne lab_f34d            ;f349  fc 02
    mov a, #0x20            ;f34b  04 20

lab_f34d:
    mov 0xb6, a             ;f34d  45 b6
    mov a, 0xdf             ;f34f  05 df
    bne lab_f355            ;f351  fc 02
    mov a, #0x1c            ;f353  04 1c

lab_f355:
    mov 0xb7, a             ;f355  45 b7
    mov a, 0xe0             ;f357  05 e0
    bne lab_f35d            ;f359  fc 02
    mov a, #0x1c            ;f35b  04 1c

lab_f35d:
    mov 0xb8, a             ;f35d  45 b8
    mov a, 0xe1             ;f35f  05 e1
    bne lab_f365            ;f361  fc 02
    mov a, #0x1c            ;f363  04 1c

lab_f365:
    mov 0xb9, a             ;f365  45 b9
    mov a, 0xe2             ;f367  05 e2
    bne lab_f36d            ;f369  fc 02
    mov a, #0x1c            ;f36b  04 1c

lab_f36d:
    mov 0xba, a             ;f36d  45 ba
    mov a, 0xe3             ;f36f  05 e3
    bne lab_f375            ;f371  fc 02
    mov a, #0x1c            ;f373  04 1c

lab_f375:
    mov 0xbb, a             ;f375  45 bb
    mov a, 0xe4             ;f377  05 e4
    bne lab_f37d            ;f379  fc 02
    mov a, #0x1c            ;f37b  04 1c

lab_f37d:
    mov 0xbc, a             ;f37d  45 bc
    mov a, 0xe5             ;f37f  05 e5
    bne lab_f385            ;f381  fc 02
    mov a, #0x1c            ;f383  04 1c

lab_f385:
    mov 0xbd, a             ;f385  45 bd
    mov a, 0xe6             ;f387  05 e6
    bne lab_f38d            ;f389  fc 02
    mov a, #0x1c            ;f38b  04 1c

lab_f38d:
    mov 0xbe, a             ;f38d  45 be

    mov a, #0x81            ;f38f  04 81        0x00AC = Navi packet byte 0 = 0x81
    mov 0xac, a             ;f391  45 ac

    mov a, #0x12            ;f393  04 12        0x00AD = Navi packet byte 1 = Number of bytes (0x12)
    mov 0xad, a             ;f395  45 ad

    mov a, #0xf0            ;f397  04 f0
    mov 0xae, a             ;f399  45 ae        0x00AE = Navi packet byte 2 = 0xF0

    mov r0, #0x12           ;f39b  88 12        R0 = 0x12 bytes to count down
    movw ix, #0x00ac        ;f39d  e6 00 ac     IX = 0x00AC (Navi packet buffer)

    mov a, @ix+0x00         ;f3a0  06 00        A = read byte in Navi packet buffer
lab_f3a2:
    incw ix                 ;f3a2  c2           Increment pointer
    mov a, @ix+0x00         ;f3a3  06 00        A = read next byte in buffer, T = previous byte
    xor a                   ;f3a5  52           A = A ^ T
    dec r0                  ;f3a6  d8
    bne lab_f3a2            ;f3a7  fc f9        Loop until 0x12 bytes are done

    decw a                  ;f3a9  d0
    mov 0xbf, a             ;f3aa  45 bf        move checksum into end of packet buffer
    movw a, #0x00ac         ;f3ac  e4 00 ac
    movw 0xc0, a            ;f3af  d5 c0        ?? 0x00C0 = 0x81?
    ret                     ;f3b1  20

sub_f3b2:
    bbc 0x00ab:1, lab_f3be  ;f3b2  b1 ab 09
    clrb 0xab:1             ;f3b5  a1 ab
    setb 0xab:2             ;f3b7  aa ab
    mov a, #0x0a            ;f3b9  04 0a
    mov 0xc7, a             ;f3bb  45 c7

lab_f3bd:
    ret                     ;f3bd  20

lab_f3be:
    mov a, 0xc7             ;f3be  05 c7
    bne lab_f3bd            ;f3c0  fc fb
    clrb 0xab:2             ;f3c2  a2 ab
    jmp lab_f3bd            ;f3c4  21 f3 bd

sub_f3c7:
    bbc 0x009b:3, lab_f3e4  ;f3c7  b3 9b 1a

lab_f3ca:
    clrb 0x9b:3             ;f3ca  a3 9b
    setb 0x9b:2             ;f3cc  aa 9b
    mov a, #0x0a            ;f3ce  04 0a
    mov 0x9d, a             ;f3d0  45 9d
    call sub_f3ef           ;f3d2  31 f3 ef
    call sub_f413           ;f3d5  31 f4 13
    call sub_f41f           ;f3d8  31 f4 1f
    call sub_f42e           ;f3db  31 f4 2e
    call sub_f43f           ;f3de  31 f4 3f
    setb 0x9b:0             ;f3e1  a8 9b

lab_f3e3:
    ret                     ;f3e3  20

lab_f3e4:
    bbc 0x009b:2, lab_f3ca  ;f3e4  b2 9b e3
    bbc 0x00cd:3, lab_f3e3  ;f3e7  b3 cd f9
    clrb 0xcd:3             ;f3ea  a3 cd
    jmp lab_f3ca            ;f3ec  21 f3 ca

sub_f3ef:
    mov a, 0x9e             ;f3ef  05 9e
    and a, #0xfc            ;f3f1  64 fc
    mov 0x9e, a             ;f3f3  45 9e
    mov a, pdr0             ;f3f5  05 00
    and a, #0xc0            ;f3f7  64 c0
    cmp a, #0x80            ;f3f9  14 80
    bne lab_f405            ;f3fb  fc 08
    mov a, #0x01            ;f3fd  04 01

lab_f3ff:
    mov a, 0x9e             ;f3ff  05 9e
    orw a                   ;f401  73
    mov 0x9e, a             ;f402  45 9e
    ret                     ;f404  20

lab_f405:
    cmp a, #0x40            ;f405  14 40
    bne lab_f40e            ;f407  fc 05
    mov a, #0x02            ;f409  04 02
    jmp lab_f3ff            ;f40b  21 f3 ff

lab_f40e:
    mov a, #0x00            ;f40e  04 00
    jmp lab_f3ff            ;f410  21 f3 ff

sub_f413:
    mov a, 0x9e             ;f413  05 9e
    and a, #0xf7            ;f415  64 f7
    mov 0x9e, a             ;f417  45 9e
    bbc 0x00ab:2, lab_f41e  ;f419  b2 ab 02
    setb 0x9e:3             ;f41c  ab 9e

lab_f41e:
    ret                     ;f41e  20

sub_f41f:
    mov a, 0x9e             ;f41f  05 9e
    and a, #0xef            ;f421  64 ef
    mov 0x9e, a             ;f423  45 9e
    mov a, 0xe7             ;f425  05 e7
    cmp a, #0x05            ;f427  14 05
    bne lab_f42d            ;f429  fc 02
    setb 0x9e:4             ;f42b  ac 9e

lab_f42d:
    ret                     ;f42d  20

sub_f42e:
    mov a, 0x9e             ;f42e  05 9e
    and a, #0x3f            ;f430  64 3f
    mov 0x9e, a             ;f432  45 9e
    bbc pdr0:4, lab_f439    ;f434  b4 00 02     ;Branch if DIAG_SW1 = low
    setb 0x9e:6             ;f437  ae 9e

lab_f439:
    bbc pdr0:5, lab_f43e    ;f439  b5 00 02     ;Branch if DIAG_SW2 = low
    setb 0x9e:7             ;f43c  af 9e

lab_f43e:
    ret                     ;f43e  20

sub_f43f:
    mov a, 0x9e             ;f43f  05 9e
    and a, #0xdf            ;f441  64 df
    mov 0x9e, a             ;f443  45 9e
    bbc 0x00cd:0, lab_f44a  ;f445  b0 cd 02
    setb 0x9e:5             ;f448  ad 9e

lab_f44a:
    ret                     ;f44a  20

sub_f44b:
    movw a, tchr            ;f44b  c5 19
    movw 0x013f, a          ;f44d  d4 01 3f
    mov a, 0x013c           ;f450  60 01 3c
    bne lab_f45b            ;f453  fc 06
    call sub_f46b           ;f455  31 f4 6b

lab_f458:
    clrb eic2:7             ;f458  a7 25
    ret                     ;f45a  20

lab_f45b:
    cmp a, #0x01            ;f45b  14 01
    bne lab_f465            ;f45d  fc 06
    call sub_f483           ;f45f  31 f4 83
    jmp lab_f458            ;f462  21 f4 58

lab_f465:
    call sub_f4a6           ;f465  31 f4 a6
    jmp lab_f458            ;f468  21 f4 58

sub_f46b:
    bbc pdr6:3, lab_f47c    ;f46b  b3 11 0e
    movw a, 0x013f          ;f46e  c4 01 3f
    movw 0x013d, a          ;f471  d4 01 3d
    mov a, #0x01            ;f474  04 01
    setb eic2:5             ;f476  ad 25

lab_f478:
    mov 0x013c, a           ;f478  61 01 3c
    ret                     ;f47b  20

lab_f47c:
    mov a, #0x00            ;f47c  04 00
    clrb eic2:5             ;f47e  a5 25
    jmp lab_f478            ;f480  21 f4 78

sub_f483:
    bbs pdr6:3, lab_f49f    ;f483  bb 11 19
    clrc                    ;f486  81
    movw a, 0x013f          ;f487  c4 01 3f
    movw a, 0x013d          ;f48a  c4 01 3d
    subcw a                 ;f48d  33
    movw 0x0141, a          ;f48e  d4 01 41
    movw a, 0x013f          ;f491  c4 01 3f
    movw 0x013d, a          ;f494  d4 01 3d
    mov a, #0x02            ;f497  04 02
    clrb eic2:5             ;f499  a5 25

lab_f49b:
    mov 0x013c, a           ;f49b  61 01 3c
    ret                     ;f49e  20

lab_f49f:
    mov a, #0x00            ;f49f  04 00
    clrb eic2:5             ;f4a1  a5 25
    jmp lab_f49b            ;f4a3  21 f4 9b

sub_f4a6:
    bbc pdr6:3, lab_f4c6    ;f4a6  b3 11 1d
    clrc                    ;f4a9  81
    movw a, 0x013f          ;f4aa  c4 01 3f
    movw a, 0x013d          ;f4ad  c4 01 3d
    subcw a                 ;f4b0  33
    movw 0x0143, a          ;f4b1  d4 01 43
    movw a, 0x013f          ;f4b4  c4 01 3f
    movw 0x013d, a          ;f4b7  d4 01 3d
    setb 0xd2:0             ;f4ba  a8 d2
    setb 0xd2:4             ;f4bc  ac d2
    mov a, #0x01            ;f4be  04 01
    setb eic2:5             ;f4c0  ad 25

lab_f4c2:
    mov 0x013c, a           ;f4c2  61 01 3c
    ret                     ;f4c5  20

lab_f4c6:
    mov a, #0x00            ;f4c6  04 00
    clrb eic2:5             ;f4c8  a5 25
    jmp lab_f4c2            ;f4ca  21 f4 c2

sub_f4cd:
    bbs 0x00d2:0, lab_f4e6  ;f4cd  b8 d2 16
    bbc pdr6:3, lab_f4e1    ;f4d0  b3 11 0e
    mov a, #0x64            ;f4d3  04 64

lab_f4d5:
    mov 0x013b, a           ;f4d5  61 01 3b

lab_f4d8:
    mov a, 0x0148           ;f4d8  60 01 48
    and a, #0xfe            ;f4db  64 fe
    mov 0x0148, a           ;f4dd  61 01 48
    ret                     ;f4e0  20

lab_f4e1:
    mov a, #0x00            ;f4e1  04 00
    jmp lab_f4d5            ;f4e3  21 f4 d5

lab_f4e6:
    clrb 0xd2:0             ;f4e6  a0 d2
    movw a, 0x0141          ;f4e8  c4 01 41
    movw 0xd4, a            ;f4eb  d5 d4
    movw a, 0x0143          ;f4ed  c4 01 43
    movw a, 0xd4            ;f4f0  c5 d4
    clrc                    ;f4f2  81
    addcw a                 ;f4f3  23
    bhs lab_f4f9            ;f4f4  f8 03
    movw a, #0xffff         ;f4f6  e4 ff ff

lab_f4f9:
    movw a, #0xff00         ;f4f9  e4 ff 00
    andw a                  ;f4fc  63
    swap                    ;f4fd  10
    mov r0, a               ;f4fe  48
    movw a, 0xd4            ;f4ff  c5 d4
    movw a, #0xff00         ;f501  e4 ff 00
    andw a                  ;f504  63
    swap                    ;f505  10
    call sub_f644           ;f506  31 f6 44
    mov a, r1               ;f509  09
    cmp a, #0x64            ;f50a  14 64
    blo lab_f510            ;f50c  f9 02
    mov a, #0x64            ;f50e  04 64

lab_f510:
    mov 0x013b, a           ;f510  61 01 3b
    jmp lab_f4d8            ;f513  21 f4 d8

sub_f516:
    bbc 0x009c:1, lab_f520  ;f516  b1 9c 07
    clrb 0x9c:3             ;f519  a3 9c

lab_f51b:
    clrb pdr3:6             ;f51b  a6 0c        ILL_CONT1 = low
    clrb pdr3:7             ;f51d  a7 0c        ILL_CONT2 = low
    ret                     ;f51f  20

lab_f520:
    bbc 0x009c:3, lab_f51b  ;f520  b3 9c f8
    bbc 0x00d2:4, lab_f532  ;f523  b4 d2 0c

lab_f526:
    mov a, #0x14            ;f526  04 14
    mov 0x0145, a           ;f528  61 01 45
    clrb 0xd2:4             ;f52b  a4 d2
    setb pdr3:6             ;f52d  ae 0c        ILL_CONT1 = high
    clrb pdr3:7             ;f52f  a7 0c        ILL_CONT2 = low

lab_f531:
    ret                     ;f531  20

lab_f532:
    mov a, 0x0145           ;f532  60 01 45
    bne lab_f531            ;f535  fc fa
    bbs pdr6:3, lab_f526    ;f537  bb 11 ec
    clrb pdr3:6             ;f53a  a6 0c        ILL_CONT1 = low
    setb pdr3:7             ;f53c  af 0c        ILL_CONT2 = high
    jmp lab_f531            ;f53e  21 f5 31

sub_f541:
    movw a, ps              ;f541  70
    movw a, #0x00ff         ;f542  e4 00 ff
    andw a                  ;f545  63
    movw ps, a              ;f546  71
    call sub_f516           ;f547  31 f5 16
    call sub_f571           ;f54a  31 f5 71
    mov a, 0x0148           ;f54d  60 01 48
    rorc a                  ;f550  03
    bhs lab_f557            ;f551  f8 04
    call sub_f4cd           ;f553  31 f4 cd

lab_f556:
    ret                     ;f556  20

lab_f557:
    rorc a                  ;f557  03
    bhs lab_f556            ;f558  f8 fc
    call sub_f59f           ;f55a  31 f5 9f
    call sub_f5c3           ;f55d  31 f5 c3
    call sub_f5ec           ;f560  31 f5 ec
    call sub_f617           ;f563  31 f6 17
    mov a, 0x0148           ;f566  60 01 48
    and a, #0xfd            ;f569  64 fd
    mov 0x0148, a           ;f56b  61 01 48
    jmp lab_f556            ;f56e  21 f5 56

sub_f571:
    mov a, 0x0147           ;f571  60 01 47
    bne lab_f57e            ;f574  fc 08
    mov a, #0x01            ;f576  04 01
    mov 0x0147, a           ;f578  61 01 47
    mov 0x0148, a           ;f57b  61 01 48

lab_f57e:
    bbc 0x00d2:3, lab_f592  ;f57e  b3 d2 11
    mov a, 0x0147           ;f581  60 01 47
    clrc                    ;f584  81
    rolc a                  ;f585  02
    cmp a, #0x04            ;f586  14 04
    blo lab_f58c            ;f588  f9 02
    mov a, #0x01            ;f58a  04 01

lab_f58c:
    mov 0x0147, a           ;f58c  61 01 47
    mov 0x0148, a           ;f58f  61 01 48

lab_f592:
    bbs 0x00d2:2, lab_f59e  ;f592  ba d2 09
    setb 0xd2:2             ;f595  aa d2
    clrb 0xd2:3             ;f597  a3 d2
    mov a, #0x05            ;f599  04 05
    mov 0x0149, a           ;f59b  61 01 49

lab_f59e:
    ret                     ;f59e  20

sub_f59f:
    mov adc2, #0x01         ;f59f  85 21 01
    mov adc1, #0x61         ;f5a2  85 20 61

lab_f5a5:
    bbc adc1:3, lab_f5a5    ;f5a5  b3 20 fd
    mov a, adcd             ;f5a8  05 22
    mov r0, a               ;f5aa  48
    mov adc1, #0x21         ;f5ab  85 20 21

lab_f5ae:
    bbc adc1:3, lab_f5ae    ;f5ae  b3 20 fd
    mov a, adcd             ;f5b1  05 22
    call sub_f644           ;f5b3  31 f6 44
    call sub_f66b           ;f5b6  31 f6 6b
    mov a, 0x0146           ;f5b9  60 01 46
    and a, #0xfc            ;f5bc  64 fc
    or a, r1                ;f5be  79
    mov 0x0146, a           ;f5bf  61 01 46
    ret                     ;f5c2  20

sub_f5c3:
    mov adc2, #0x01         ;f5c3  85 21 01
    mov adc1, #0x61         ;f5c6  85 20 61

lab_f5c9:
    bbc adc1:3, lab_f5c9    ;f5c9  b3 20 fd
    mov a, adcd             ;f5cc  05 22
    mov r0, a               ;f5ce  48
    mov adc1, #0x31         ;f5cf  85 20 31

lab_f5d2:
    bbc adc1:3, lab_f5d2    ;f5d2  b3 20 fd
    mov a, adcd             ;f5d5  05 22
    call sub_f644           ;f5d7  31 f6 44
    call sub_f66b           ;f5da  31 f6 6b
    clrc                    ;f5dd  81
    mov a, r1               ;f5de  09
    rolc a                  ;f5df  02
    rolc a                  ;f5e0  02
    mov r1, a               ;f5e1  49
    mov a, 0x0146           ;f5e2  60 01 46
    and a, #0xf3            ;f5e5  64 f3
    or a, r1                ;f5e7  79
    mov 0x0146, a           ;f5e8  61 01 46
    ret                     ;f5eb  20

sub_f5ec:
    mov adc2, #0x01         ;f5ec  85 21 01
    mov adc1, #0x61         ;f5ef  85 20 61

lab_f5f2:
    bbc adc1:3, lab_f5f2    ;f5f2  b3 20 fd
    mov a, adcd             ;f5f5  05 22
    mov r0, a               ;f5f7  48
    mov adc1, #0x41         ;f5f8  85 20 41

lab_f5fb:
    bbc adc1:3, lab_f5fb    ;f5fb  b3 20 fd
    mov a, adcd             ;f5fe  05 22
    call sub_f644           ;f600  31 f6 44
    call sub_f66b           ;f603  31 f6 6b
    clrc                    ;f606  81
    mov a, r1               ;f607  09
    rolc a                  ;f608  02
    rolc a                  ;f609  02
    rolc a                  ;f60a  02
    rolc a                  ;f60b  02
    mov r1, a               ;f60c  49
    mov a, 0x0146           ;f60d  60 01 46
    and a, #0xcf            ;f610  64 cf
    or a, r1                ;f612  79
    mov 0x0146, a           ;f613  61 01 46
    ret                     ;f616  20

sub_f617:
    mov adc2, #0x01         ;f617  85 21 01
    mov adc1, #0x61         ;f61a  85 20 61

lab_f61d:
    bbc adc1:3, lab_f61d    ;f61d  b3 20 fd
    mov a, adcd             ;f620  05 22
    mov r0, a               ;f622  48
    mov adc1, #0x51         ;f623  85 20 51

lab_f626:
    bbc adc1:3, lab_f626    ;f626  b3 20 fd
    mov a, adcd             ;f629  05 22
    call sub_f644           ;f62b  31 f6 44
    call sub_f66b           ;f62e  31 f6 6b
    clrc                    ;f631  81
    mov a, r1               ;f632  09
    rolc a                  ;f633  02
    rolc a                  ;f634  02
    rolc a                  ;f635  02
    rolc a                  ;f636  02
    rolc a                  ;f637  02
    rolc a                  ;f638  02
    mov r1, a               ;f639  49
    mov a, 0x0146           ;f63a  60 01 46
    and a, #0x3f            ;f63d  64 3f
    or a, r1                ;f63f  79
    mov 0x0146, a           ;f640  61 01 46
    ret                     ;f643  20

sub_f644:
    mov r2, a               ;f644  4a
    mov r1, #0x00           ;f645  89 00
    mov a, r0               ;f647  08
    beq lab_f657            ;f648  fd 0d
    mov a, r2               ;f64a  0a
    beq lab_f659            ;f64b  fd 0c
    clrc                    ;f64d  81
    subc a, r0              ;f64e  38
    blo lab_f65a            ;f64f  f9 09
    mov r1, #0x64           ;f651  89 64
    clrc                    ;f653  81
    subc a, r0              ;f654  38
    blo lab_f65a            ;f655  f9 03

lab_f657:
    mov r1, #0xc8           ;f657  89 c8

lab_f659:
    ret                     ;f659  20

lab_f65a:
    clrc                    ;f65a  81
    addc a, r0              ;f65b  28
    mov a, #0x64            ;f65c  04 64
    mulu a                  ;f65e  01
    movw 0xd4, a            ;f65f  d5 d4
    movw a, 0xd4            ;f661  c5 d4
    mov a, r0               ;f663  08
    divu a                  ;f664  11
    clrc                    ;f665  81
    addc a, r1              ;f666  29
    mov r1, a               ;f667  49
    jmp lab_f659            ;f668  21 f6 59

sub_f66b:
    mov a, r1               ;f66b  09
    cmp a, #0x28            ;f66c  14 28
    bhs lab_f673            ;f66e  f8 03
    mov r1, #0x02           ;f670  89 02

lab_f672:
    ret                     ;f672  20

lab_f673:
    cmp a, #0x62            ;f673  14 62
    bhs lab_f67c            ;f675  f8 05
    mov r1, #0x01           ;f677  89 01
    jmp lab_f672            ;f679  21 f6 72

lab_f67c:
    cmp a, #0x79            ;f67c  14 79
    bhs lab_f685            ;f67e  f8 05
    mov r1, #0x03           ;f680  89 03
    jmp lab_f672            ;f682  21 f6 72

lab_f685:
    cmp a, #0x86            ;f685  14 86
    bhs lab_f68e            ;f687  f8 05
    mov r1, #0x00           ;f689  89 00
    jmp lab_f672            ;f68b  21 f6 72

lab_f68e:
    mov r1, #0x02           ;f68e  89 02
    jmp lab_f672            ;f690  21 f6 72

sub_f693:
    mov a, 0xcc             ;f693  05 cc
    bne lab_f6a5            ;f695  fc 0e
    mov 0xcc, #0x01         ;f697  85 cc 01
    setb eic2:1             ;f69a  a9 25
    clrb cntr:3             ;f69c  a3 12
    mov comr, #0x96         ;f69e  85 13 96
    mov cntr, #0x19         ;f6a1  85 12 19
    ret                     ;f6a4  20

lab_f6a5:
    cmp a, #0x01            ;f6a5  14 01
    bne lab_f6b7            ;f6a7  fc 0e
    mov 0xcc, #0x02         ;f6a9  85 cc 02
    clrb eic2:1             ;f6ac  a1 25
    clrb cntr:3             ;f6ae  a3 12
    mov comr, #0x64         ;f6b0  85 13 64
    mov cntr, #0x19         ;f6b3  85 12 19
    ret                     ;f6b6  20

lab_f6b7:
    setb 0xcd:5             ;f6b7  ad cd
    setb 0xce:0             ;f6b9  a8 ce
    mov cntr, #0x10         ;f6bb  85 12 10
    clrb eic2:0             ;f6be  a0 25
    ret                     ;f6c0  20

sub_f6c1:
    mov a, 0xcc             ;f6c1  05 cc
    cmp a, #0x01            ;f6c3  14 01
    bne lab_f6d1            ;f6c5  fc 0a
    setb 0xcd:5             ;f6c7  ad cd
    setb 0xce:0             ;f6c9  a8 ce
    mov cntr, #0x10         ;f6cb  85 12 10
    clrb eic2:0             ;f6ce  a0 25
    ret                     ;f6d0  20

lab_f6d1:
    cmp a, #0x02            ;f6d1  14 02
    bne lab_f6de            ;f6d3  fc 09
    setb 0xcd:5             ;f6d5  ad cd
    clrb 0xce:0             ;f6d7  a0 ce
    mov cntr, #0x10         ;f6d9  85 12 10
    clrb eic2:0             ;f6dc  a0 25

lab_f6de:
    ret                     ;f6de  20

sub_f6df:
    mov a, 0xd1             ;f6df  05 d1
    bne lab_f711            ;f6e1  fc 2e
    bbc 0x00cd:7, lab_f707  ;f6e3  b7 cd 21

lab_f6e6:
    mov 0xcf, #0x19         ;f6e6  85 cf 19
    clrb 0xcd:7             ;f6e9  a7 cd
    setb 0xcd:6             ;f6eb  ae cd
    mov adc2, #0x01         ;f6ed  85 21 01
    mov adc1, #0x71         ;f6f0  85 20 71

lab_f6f3:
    bbc adc1:3, lab_f6f3    ;f6f3  b3 20 fd
    mov a, adcd             ;f6f6  05 22
    cmp a, #0x0d            ;f6f8  14 0d
    blo lab_f70d            ;f6fa  f9 11
    setb 0xcd:1             ;f6fc  a9 cd
    clrb 0xcd:4             ;f6fe  a4 cd

lab_f700:
    call sub_f749           ;f700  31 f7 49
    call sub_f72d           ;f703  31 f7 2d
    ret                     ;f706  20

lab_f707:
    bbc 0x00cd:6, lab_f6e6  ;f707  b6 cd dc
    jmp lab_f700            ;f70a  21 f7 00

lab_f70d:
    cmp a, #0x02            ;f70d  14 02
    bhs lab_f718            ;f70f  f8 07

lab_f711:
    setb 0xcd:2             ;f711  aa cd
    clrb 0xcd:4             ;f713  a4 cd
    jmp lab_f700            ;f715  21 f7 00

lab_f718:
    bbs 0x00cd:4, lab_f700  ;f718  bc cd e5
    mov 0xcc, #0x00         ;f71b  85 cc 00
    clrb 0xcd:5             ;f71e  a5 cd
    clrb eic2:1             ;f720  a1 25
    clrb cntr:2             ;f722  a2 12
    clrb eic2:3             ;f724  a3 25
    setb 0xcd:4             ;f726  ac cd
    setb eic2:0             ;f728  a8 25
    jmp lab_f700            ;f72a  21 f7 00

sub_f72d:
    bbc 0x00cd:1, lab_f73a  ;f72d  b1 cd 0a
    clrb 0xcd:1             ;f730  a1 cd
    bbs 0x00cd:0, lab_f739  ;f732  b8 cd 04
    setb 0xcd:0             ;f735  a8 cd
    setb 0xcd:3             ;f737  ab cd

lab_f739:
    ret                     ;f739  20

lab_f73a:
    bbc 0x00cd:2, lab_f739  ;f73a  b2 cd fc
    clrb 0xcd:2             ;f73d  a2 cd
    bbc 0x00cd:0, lab_f739  ;f73f  b0 cd f7
    clrb 0xcd:0             ;f742  a0 cd
    setb 0xcd:3             ;f744  ab cd
    jmp lab_f739            ;f746  21 f7 39

sub_f749:
    bbc 0x00cd:4, lab_f760  ;f749  b4 cd 14
    bbc 0x00cd:5, lab_f766  ;f74c  b5 cd 17
    bbc 0x00ce:0, lab_f761  ;f74f  b0 ce 0f
    setb 0xcd:2             ;f752  aa cd

lab_f754:
    mov a, #0x0a            ;f754  04 0a
    mov 0xd0, a             ;f756  45 d0
    clrb 0xce:2             ;f758  a2 ce
    setb 0xce:1             ;f75a  a9 ce
    clrb 0xcd:5             ;f75c  a5 cd
    clrb 0xce:0             ;f75e  a0 ce

lab_f760:
    ret                     ;f760  20

lab_f761:
    setb 0xcd:1             ;f761  a9 cd
    jmp lab_f754            ;f763  21 f7 54

lab_f766:
    bbc 0x00ce:2, lab_f760  ;f766  b2 ce f7
    clrb 0xce:2             ;f769  a2 ce
    mov 0xcc, #0x00         ;f76b  85 cc 00
    clrb eic2:1             ;f76e  a1 25
    clrb cntr:2             ;f770  a2 12
    clrb eic2:3             ;f772  a3 25
    setb eic2:0             ;f774  a8 25
    jmp lab_f760            ;f776  21 f7 60

sub_f779:
;Read key data from uPD16432B
;
    setb pdr0:2             ;f779  aa 00        UPD_STB = high

    mov a, #0x44            ;f77b  04 44        Command byte = 0x44 (0b01000100)
                            ;                   Data Setting Command
                            ;                     4=Read key data
    call sub_f9db           ;f77d  31 f9 db     Send byte in A to the uPD16432B

    mov ddr0, #0x0e         ;f780  85 01 0e
    setb pdr0:0             ;f783  a8 00        UPD_DATA = high
    setb pdr0:1             ;f785  a9 00        UPD_CLK = high
    movw a, #0x008f         ;f787  e4 00 8f
    movw 0x80, a            ;f78a  d5 80
    mov 0x82, #0x04         ;f78c  85 82 04     4 bytes left to receive

lab_f78f:
    mov a, 0x82             ;f78f  05 82        A = number of bytes left to receive
    beq lab_f7bd            ;f791  fd 2a        Branch if no more bytes left
    decw a                  ;f793  d0           Decrement number of bytes left
    mov 0x82, a             ;f794  45 82        Save number of bytes left
    mov 0x84, #0x08         ;f796  85 84 08     8 bits left to receive

lab_f799:
;Receive a byte of key data from uPD16432B
;
    mov a, 0x84             ;f799  05 84        A = number of bits left to receive
    beq lab_f7b5            ;f79b  fd 18        Branch if no more bits left
    decw a                  ;f79d  d0
    mov 0x84, a             ;f79e  45 84
    clrb pdr0:1             ;f7a0  a1 00        UPD_CLK = low
    nop                     ;f7a2  00
    nop                     ;f7a3  00
    setb pdr0:1             ;f7a4  a9 00        UPD_CLK = high
    movw a, 0x80            ;f7a6  c5 80
    movw ep, a              ;f7a8  e3
    mov a, @ep              ;f7a9  07
    clrc                    ;f7aa  81
    rolc a                  ;f7ab  02
    mov @ep, a              ;f7ac  47
    bbc pdr0:0, lab_f799    ;f7ad  b0 00 e9     Branch if UPD_DATA = low
    or a, #0x01             ;f7b0  74 01
    mov @ep, a              ;f7b2  47
    bne lab_f799            ;f7b3  fc e4

lab_f7b5:
    movw a, 0x80            ;f7b5  c5 80
    incw a                  ;f7b7  c0
    movw 0x80, a            ;f7b8  d5 80
    jmp lab_f78f            ;f7ba  21 f7 8f

lab_f7bd:
;All 4 bytes of key data have been received from uPD16432B
;
    clrb pdr0:2             ;f7bd  a2 00        UPD_STB = low
    movw ix, #0x008b        ;f7bf  e6 00 8b
    mov a, 0x8f             ;f7c2  05 8f
    xor a, @ix+0x00         ;f7c4  56 00
    mov a, 0x90             ;f7c6  05 90
    xor a, @ix+0x01         ;f7c8  56 01
    or a                    ;f7ca  72
    mov a, 0x91             ;f7cb  05 91
    xor a, @ix+0x02         ;f7cd  56 02
    or a                    ;f7cf  72
    mov a, 0x92             ;f7d0  05 92
    xor a, @ix+0x03         ;f7d2  56 03
    or a                    ;f7d4  72
    bne lab_f80e            ;f7d5  fc 37
    mov a, 0x0108           ;f7d7  60 01 08
    bne lab_f801            ;f7da  fc 25
    movw ix, #0x0093        ;f7dc  e6 00 93
    mov a, 0x8f             ;f7df  05 8f
    xor a, @ix+0x00         ;f7e1  56 00
    mov a, 0x90             ;f7e3  05 90
    xor a, @ix+0x01         ;f7e5  56 01
    or a                    ;f7e7  72
    mov a, 0x91             ;f7e8  05 91
    xor a, @ix+0x02         ;f7ea  56 02
    or a                    ;f7ec  72
    mov a, 0x92             ;f7ed  05 92
    xor a, @ix+0x03         ;f7ef  56 03
    or a                    ;f7f1  72
    beq lab_f81b            ;f7f2  fd 27
    movw a, 0x8f            ;f7f4  c5 8f
    movw 0x93, a            ;f7f6  d5 93
    movw a, 0x91            ;f7f8  c5 91
    movw 0x95, a            ;f7fa  d5 95
    setb 0x88:0             ;f7fc  a8 88
    jmp lab_f81b            ;f7fe  21 f8 1b

lab_f801:
    movw a, #0x0000         ;f801  e4 00 00
    mov a, 0x0108           ;f804  60 01 08
    decw a                  ;f807  d0
    mov 0x0108, a           ;f808  61 01 08
    jmp lab_f81b            ;f80b  21 f8 1b

lab_f80e:
    movw a, 0x8f            ;f80e  c5 8f
    movw 0x8b, a            ;f810  d5 8b
    movw a, 0x91            ;f812  c5 91
    movw 0x8d, a            ;f814  d5 8d
    mov a, #0x02            ;f816  04 02
    mov 0x0108, a           ;f818  61 01 08

lab_f81b:
    ret                     ;f81b  20

sub_f81c:
    mov 0x85, #0x1c         ;f81c  85 85 1c
    mov 0x82, #0x00         ;f81f  85 82 00
    mov 0x83, #0x00         ;f822  85 83 00
    mov 0x84, #0x04         ;f825  85 84 04
    movw ep, #0x0093        ;f828  e7 00 93

lab_f82b:
    mov a, @ep              ;f82b  07
    call sub_f8bb           ;f82c  31 f8 bb
    call sub_f8bb           ;f82f  31 f8 bb
    call sub_f8bb           ;f832  31 f8 bb
    call sub_f8bb           ;f835  31 f8 bb
    call sub_f8bb           ;f838  31 f8 bb
    call sub_f8bb           ;f83b  31 f8 bb
    call sub_f8bb           ;f83e  31 f8 bb
    call sub_f8bb           ;f841  31 f8 bb
    incw ep                 ;f844  c3
    movw a, #0x0000         ;f845  e4 00 00
    mov a, 0x84             ;f848  05 84
    decw a                  ;f84a  d0
    mov 0x84, a             ;f84b  45 84
    bne lab_f82b            ;f84d  fc dc
    mov a, 0x83             ;f84f  05 83
    bne lab_f86e            ;f851  fc 1b
    movw a, #0x0000         ;f853  e4 00 00
    movw 0x8f, a            ;f856  d5 8f
    movw 0x91, a            ;f858  d5 91
    movw 0x8b, a            ;f85a  d5 8b
    movw 0x8d, a            ;f85c  d5 8d
    movw 0x93, a            ;f85e  d5 93
    movw 0x95, a            ;f860  d5 95
    clrb 0x89:0             ;f862  a0 89
    mov 0xd6, #0x00         ;f864  85 d6 00
    setb 0x88:1             ;f867  a9 88

lab_f869:
    mov a, #0x20            ;f869  04 20
    mov 0x8a, a             ;f86b  45 8a

lab_f86d:
    ret                     ;f86d  20

lab_f86e:
    cmp a, #0x01            ;f86e  14 01
    bne lab_f895            ;f870  fc 23
    bbs 0x0089:0, lab_f884  ;f872  b8 89 0f
    setb 0x89:0             ;f875  a8 89
    mov a, 0x85             ;f877  05 85

lab_f879:
    or a, #0x80             ;f879  74 80
    mov 0x8a, a             ;f87b  45 8a
    setb 0x88:1             ;f87d  a9 88
    clrb 0x89:7             ;f87f  a7 89
    jmp lab_f86d            ;f881  21 f8 6d

lab_f884:
    mov a, 0x85             ;f884  05 85
    mov a, 0x8a             ;f886  05 8a
    cmp a                   ;f888  12
    beq lab_f86d            ;f889  fd e2
    bbs 0x0089:7, lab_f86d  ;f88b  bf 89 df
    setb 0x88:1             ;f88e  a9 88

lab_f890:
    setb 0x89:7             ;f890  af 89
    jmp lab_f869            ;f892  21 f8 69

lab_f895:
    cmp a, #0x03            ;f895  14 03
    bne lab_f890            ;f897  fc f7
    cmp 0xd6, #0x07         ;f899  95 d6 07
    bne lab_f8a1            ;f89c  fc 03
    bbs 0x0089:0, lab_f890  ;f89e  b8 89 ef

lab_f8a1:
    mov a, 0xd3             ;f8a1  05 d3
    call sub_f939           ;f8a3  31 f9 39
    mov a, 0x86             ;f8a6  05 86
    call sub_f939           ;f8a8  31 f9 39
    mov a, 0x85             ;f8ab  05 85
    call sub_f939           ;f8ad  31 f9 39
    cmp 0xd6, #0x07         ;f8b0  95 d6 07
    bne lab_f890            ;f8b3  fc db
    setb 0x89:0             ;f8b5  a8 89
    mov a, #0x19            ;f8b7  04 19
    bne lab_f879            ;f8b9  fc be

sub_f8bb:
    rolc a                  ;f8bb  02
    bhs lab_f8d8            ;f8bc  f8 1a
    mov a, 0x86             ;f8be  05 86
    mov 0xd3, a             ;f8c0  45 d3
    xch a, t                ;f8c2  42
    mov a, 0x85             ;f8c3  05 85
    mov 0x86, a             ;f8c5  45 86
    xch a, t                ;f8c7  42
    mov a, 0x82             ;f8c8  05 82
    mov 0x85, a             ;f8ca  45 85
    xch a, t                ;f8cc  42
    cmp 0x83, #0x04         ;f8cd  95 83 04
    bhs lab_f8d8            ;f8d0  f8 06
    mov a, 0x83             ;f8d2  05 83
    incw a                  ;f8d4  c0
    mov 0x83, a             ;f8d5  45 83
    xch a, t                ;f8d7  42

lab_f8d8:
    mov a, 0x82             ;f8d8  05 82
    incw a                  ;f8da  c0
    mov 0x82, a             ;f8db  45 82
    xch a, t                ;f8dd  42
    ret                     ;f8de  20

sub_f8df:
    mov a, 0x0127           ;f8df  60 01 27
    cmp a, #0xff            ;f8e2  14 ff
    bne lab_f8ff            ;f8e4  fc 19
    bbc 0x0089:3, lab_f8f3  ;f8e6  b3 89 0a
    clrb 0x89:3             ;f8e9  a3 89
    clrb 0x89:0             ;f8eb  a0 89

lab_f8ed:
    mov a, #0x20            ;f8ed  04 20
    mov 0x8a, a             ;f8ef  45 8a
    setb 0x88:1             ;f8f1  a9 88

lab_f8f3:
    ret                     ;f8f3  20

lab_f8f4:
    or a, #0x80             ;f8f4  74 80
    mov 0x8a, a             ;f8f6  45 8a
    setb 0x88:1             ;f8f8  a9 88
    setb 0x89:3             ;f8fa  ab 89
    setb 0x89:0             ;f8fc  a8 89

lab_f8fe:
    ret                     ;f8fe  20

lab_f8ff:
    bbs 0x0089:0, lab_f928  ;f8ff  b8 89 26
    mov a, 0x0127           ;f902  60 01 27
    mov 0x014c, a           ;f905  61 01 4c

    cmp a, #0x00            ;f908  14 00        ;0x00 -> 0x1c
    bne lab_f910            ;f90a  fc 04
    mov a, #0x1c            ;f90c  04 1c        ;mfsw vol down?
    bne lab_f8f4            ;f90e  fc e4        ;no: goto lab_f8f4

lab_f910:
    cmp a, #0x01            ;f910  14 01        ;0x01 -> 0x1d
    bne lab_f918            ;f912  fc 04
    mov a, #0x1d            ;f914  04 1d        ;mfsw vol up
    bne lab_f8f4            ;f916  fc dc

lab_f918:
    cmp a, #0x0a            ;f918  14 0a        ;0x0a -> 0x1e
    bne lab_f920            ;f91a  fc 04
    mov a, #0x1e            ;f91c  04 1e        ;mfsw down
    bne lab_f8f4            ;f91e  fc d4

lab_f920:
    cmp a, #0x0b            ;f920  14 0b        ;0x0b -> 0x1f
    bne lab_f8fe            ;f922  fc da
    mov a, #0x1f            ;f924  04 1f        ;mfsw up
    bne lab_f8f4            ;f926  fc cc

lab_f928:
    mov a, 0x0127           ;f928  60 01 27
    mov a, 0x014c           ;f92b  60 01 4c
    cmp a                   ;f92e  12
    beq lab_f8fe            ;f92f  fd cd
    mov a, #0xfe            ;f931  04 fe
    mov 0x014c, a           ;f933  61 01 4c
    jmp lab_f8ed            ;f936  21 f8 ed     ;jmp to ret

sub_f939:
    cmp a, #0x18            ;f939  14 18
    bne lab_f940            ;f93b  fc 03
    setb 0xd6:0             ;f93d  a8 d6
    ret                     ;f93f  20

lab_f940:
    cmp a, #0x06            ;f940  14 06
    bne lab_f947            ;f942  fc 03
    setb 0xd6:1             ;f944  a9 d6
    ret                     ;f946  20

lab_f947:
    cmp a, #0x00            ;f947  14 00
    bne lab_f94d            ;f949  fc 02
    setb 0xd6:2             ;f94b  aa d6

lab_f94d:
    ret                     ;f94d  20

sub_f94e:
;Send uPD16432B display RAM and pictograph RAM
;
    pushw ix                ;f94e  41

    mov a, #0x40            ;f94f  04 40        Command byte = 0x40 (0b01000000)
                            ;                   Data Setting Command
                            ;                     0=Write to display RAM
                            ;                     Address increment mode: 0=increment
    call sub_f9cd           ;f951  31 f9 cd     Send single-byte command to uPD16432B

    movw ix, #0x013a        ;f954  e6 01 3a

    mov a, #0x82            ;f957  04 82        Command byte = 0x82 (0b10000010)
                            ;                     Address Setting Command
                            ;                     Address = 02

    setb pdr0:2             ;f959  aa 00        UPD_STB = high
    nop                     ;f95b  00
    nop                     ;f95c  00

lab_f95d:
    call sub_f9db           ;f95d  31 f9 db     Send byte in A to the uPD16432B
    movw a, ix              ;f960  f2
    movw a, #0x012f         ;f961  e4 01 2f
    cmpw a                  ;f964  13
    beq lab_f96d            ;f965  fd 06
    decw ix                 ;f967  d2
    mov a, @ix+0x00         ;f968  06 00
    jmp lab_f95d            ;f96a  21 f9 5d

lab_f96d:
    clrb pdr0:2             ;f96d  a2 00        UPD_STB = low
    nop                     ;f96f  00
    nop                     ;f970  00

    mov a, #0x41            ;f971  04 41        Command byte = 0x41 (0b01000001)
                            ;                   Data Setting Command
                            ;                     1=Write to pictograph RAM
                            ;                     Address
    call sub_f9cd           ;f973  31 f9 cd     Send single-byte command to uPD16432B

    movw ix, #0x00a0        ;f976  e6 00 a0

    mov a, #0x80            ;f979  04 80        Command byte = 0x80 (0b10000000)
                            ;                   Address Setting Command
                            ;                     Address = 00

    setb pdr0:2             ;f97b  aa 00        UPD_STB = high
    nop                     ;f97d  00
    nop                     ;f97e  00

lab_f97f:
    call sub_f9db           ;f97f  31 f9 db     Send byte in A to the uPD16432B
    movw a, ix              ;f982  f2
    movw a, #0x00a8         ;f983  e4 00 a8
    cmpw a                  ;f986  13
    beq lab_f98f            ;f987  fd 06
    incw ix                 ;f989  c2
    mov a, @ix+0x00         ;f98a  06 00
    jmp lab_f97f            ;f98c  21 f9 7f

lab_f98f:
    clrb pdr0:2             ;f98f  a2 00        UPD_STB = low
    popw ix                 ;f991  51
    ret                     ;f992  20

sub_f993:
    nop                     ;f993  00
    nop                     ;f994  00
    nop                     ;f995  00
    nop                     ;f996  00
    nop                     ;f997  00
    nop                     ;f998  00
    nop                     ;f999  00
    nop                     ;f99a  00

    mov a, #0x04            ;f99b  04 04        Command byte = 0x04 (0b00000100)
                            ;                   Display Setting Command
                            ;                     Duty setting: 0=1/8 duty
                            ;                     Master/slave setting: 0=master
                            ;                     Drive voltage supply method: 1=internal
    call sub_f9cd           ;f99d  31 f9 cd     Send single-byte command to uPD16432B

    mov a, #0xcf            ;f9a0  04 cf        Command byte = 0xcf (0b11001111)
                            ;                   Status command
                            ;                     Test mode setting: 0=Normal operation
                            ;                     Standby mode setting: 0=Normal operation
                            ;                     Key scan control: 1=Key scan operation
                            ;                     LED control: 1=Normal operation
                            ;                     LCD mode: 3=Normal operation (0b11)
    call sub_f9cd           ;f9a2  31 f9 cd     Send single-byte command to uPD16432B

    mov a, #0x20            ;f9a5  04 20
    swap                    ;f9a7  10
    mov a, #0x20            ;f9a8  04 20
    movw ix, #0x012f        ;f9aa  e6 01 2f
    movw @ix+0x00, a        ;f9ad  d6 00
    movw @ix+0x02, a        ;f9af  d6 02
    movw @ix+0x04, a        ;f9b1  d6 04
    movw @ix+0x06, a        ;f9b3  d6 06
    movw @ix+0x08, a        ;f9b5  d6 08
    mov @ix+0x0a, a         ;f9b7  46 0a
    movw a, #0x0000         ;f9b9  e4 00 00
    movw ix, #0x00a1        ;f9bc  e6 00 a1
    movw @ix+0x00, a        ;f9bf  d6 00
    movw @ix+0x02, a        ;f9c1  d6 02
    movw @ix+0x04, a        ;f9c3  d6 04
    movw @ix+0x06, a        ;f9c5  d6 06
    call sub_f94e           ;f9c7  31 f9 4e     Send display RAM and pictograph RAM to uPD16432B
    setb 0xa9:6             ;f9ca  ae a9
    ret                     ;f9cc  20

sub_f9cd:
;Send a single-byte command to the uPD16432B
    setb pdr0:2             ;f9cd  aa 00        UPD_STB = high
    nop                     ;f9cf  00
    nop                     ;f9d0  00
    call sub_f9db           ;f9d1  31 f9 db     Send byte in A to the uPD16432B
    nop                     ;f9d4  00
    nop                     ;f9d5  00
    clrb pdr0:2             ;f9d6  a2 00        UPD_STB = low
    nop                     ;f9d8  00
    nop                     ;f9d9  00
    ret                     ;f9da  20

sub_f9db:
;Send byte in A to uPD16432B
;
    mov ddr0, #0x0f         ;f9db  85 01 0f
    setb pdr0:1             ;f9de  a9 00        UPD_CLK = high
    mov r7, #0x08           ;f9e0  8f 08

lab_f9e2:
    rolc a                  ;f9e2  02
    bhs lab_f9e9            ;f9e3  f8 04
    setb pdr0:0             ;f9e5  a8 00        UPD_DATA = high
    blo lab_f9eb            ;f9e7  f9 02

lab_f9e9:
    clrb pdr0:0             ;f9e9  a0 00        UPD_DATA = low

lab_f9eb:
    clrb pdr0:1             ;f9eb  a1 00        UPD_CLK = low
    nop                     ;f9ed  00
    nop                     ;f9ee  00
    setb pdr0:1             ;f9ef  a9 00        UPD_CLK = high
    dec r7                  ;f9f1  df
    bne lab_f9e2            ;f9f2  fc ee
    ret                     ;f9f4  20

sub_f9f5:
    bbc 0x0087:7, lab_fa08  ;f9f5  b7 87 10
    clrb 0x87:7             ;f9f8  a7 87

    mov a, #0x04            ;f9fa  04 04        Command byte = 0x04 (0b00000100)
                            ;                   Display Setting Command
                            ;                     Duty setting: 0=1/8 duty
                            ;                     Master/slave setting: 0=master
                            ;                     Drive voltage supply method: 1=internal
    call sub_f9cd           ;f9fc  31 f9 cd     Send single-byte command to uPD16432B

    mov a, #0xcf            ;f9ff  04 cf        Command byte = 0xcf (0b11001111)
                            ;                   Status command
                            ;                     Test mode setting: 0=Normal operation
                            ;                     Standby mode setting: 0=Normal operation
                            ;                     Key scan control: 1=Key scan operation
                            ;                     LED control: 1=Normal operation
                            ;                     LCD mode: 3=Normal operation (0b11)
    call sub_f9cd           ;fa01  31 f9 cd     Send single-byte command to uPD16432B

    call sub_f94e           ;fa04  31 f9 4e     Send display RAM and pictograph RAM to uPD16432B
    ret                     ;fa07  20

lab_fa08:
    bbc 0x0087:2, lab_fa0f  ;fa08  b2 87 04
    clrb 0x87:2             ;fa0b  a2 87
    setb 0x87:7             ;fa0d  af 87

lab_fa0f:
    ret                     ;fa0f  20

sub_fa10:
    mov a, 0x0145           ;fa10  60 01 45
    beq lab_fa19            ;fa13  fd 04
    decw a                  ;fa15  d0
    mov 0x0145, a           ;fa16  61 01 45

lab_fa19:
    bbc 0x00cd:6, lab_fa2a  ;fa19  b6 cd 0e
    movw a, #0x0000         ;fa1c  e4 00 00
    mov a, 0xcf             ;fa1f  05 cf
    decw a                  ;fa21  d0
    mov 0xcf, a             ;fa22  45 cf
    bne lab_fa2a            ;fa24  fc 04
    clrb 0xcd:6             ;fa26  a6 cd
    setb 0xcd:7             ;fa28  af cd

lab_fa2a:
    bbc 0x00ce:1, lab_fa3b  ;fa2a  b1 ce 0e
    movw a, #0x0000         ;fa2d  e4 00 00
    mov a, 0xd0             ;fa30  05 d0
    decw a                  ;fa32  d0
    mov 0xd0, a             ;fa33  45 d0
    bne lab_fa3b            ;fa35  fc 04
    clrb 0xce:1             ;fa37  a1 ce
    setb 0xce:2             ;fa39  aa ce

lab_fa3b:
    mov a, 0x99             ;fa3b  05 99
    incw a                  ;fa3d  c0
    mov 0x99, a             ;fa3e  45 99
    cmp a, #0x0a            ;fa40  14 0a
    blo lab_fa58            ;fa42  f9 14
    mov 0x99, #0x00         ;fa44  85 99 00
    setb 0x97:0             ;fa47  a8 97
    movw a, #0x0000         ;fa49  e4 00 00
    mov a, 0x98             ;fa4c  05 98
    decw a                  ;fa4e  d0
    mov 0x98, a             ;fa4f  45 98
    bne lab_fa58            ;fa51  fc 05
    mov 0x98, #0x0a         ;fa53  85 98 0a
    setb 0x97:1             ;fa56  a9 97

lab_fa58:
    ret                     ;fa58  20

sub_fa59:
    bbc 0x0097:0, lab_fa61  ;fa59  b0 97 05
    clrb 0x97:0             ;fa5c  a0 97
    call sub_fa6a           ;fa5e  31 fa 6a

lab_fa61:
    bbc 0x0097:1, lab_fa69  ;fa61  b1 97 05
    clrb 0x97:1             ;fa64  a1 97
    call sub_fad2           ;fa66  31 fa d2

lab_fa69:
    ret                     ;fa69  20

sub_fa6a:
    bbc 0x00a9:6, lab_fa70  ;fa6a  b6 a9 03
    call sub_f779           ;fa6d  31 f7 79     Read key data from uPD16432B

lab_fa70:
    bbc 0x00d2:2, lab_fa83  ;fa70  b2 d2 10
    movw a, #0x0000         ;fa73  e4 00 00
    mov a, 0x0149           ;fa76  60 01 49
    decw a                  ;fa79  d0
    mov 0x0149, a           ;fa7a  61 01 49
    bne lab_fa83            ;fa7d  fc 04
    clrb 0xd2:2             ;fa7f  a2 d2
    setb 0xd2:3             ;fa81  ab d2

lab_fa83:
    bbc 0x009a:1, lab_fa96  ;fa83  b1 9a 10
    movw a, #0x0000         ;fa86  e4 00 00
    mov a, 0x0121           ;fa89  60 01 21
    decw a                  ;fa8c  d0
    mov 0x0121, a           ;fa8d  61 01 21
    bne lab_fa96            ;fa90  fc 04
    clrb 0x9a:1             ;fa92  a1 9a
    setb 0x9a:2             ;fa94  aa 9a

lab_fa96:
    bbc 0x009b:6, lab_faa7  ;fa96  b6 9b 0e
    movw a, #0x0000         ;fa99  e4 00 00
    mov a, 0x9f             ;fa9c  05 9f
    decw a                  ;fa9e  d0
    mov 0x9f, a             ;fa9f  45 9f
    bne lab_faa7            ;faa1  fc 04
    clrb 0x9b:6             ;faa3  a6 9b
    setb 0x9b:7             ;faa5  af 9b

lab_faa7:
    mov a, 0x0123           ;faa7  60 01 23
    beq lab_fab0            ;faaa  fd 04
    decw a                  ;faac  d0
    mov 0x0123, a           ;faad  61 01 23

lab_fab0:
    bbc 0x009b:2, lab_fac1  ;fab0  b2 9b 0e
    movw a, #0x0000         ;fab3  e4 00 00
    mov a, 0x9d             ;fab6  05 9d
    decw a                  ;fab8  d0
    mov 0x9d, a             ;fab9  45 9d
    bne lab_fac1            ;fabb  fc 04
    clrb 0x9b:2             ;fabd  a2 9b
    setb 0x9b:3             ;fabf  ab 9b

lab_fac1:
    mov a, 0x013a           ;fac1  60 01 3a
    beq lab_faca            ;fac4  fd 04
    decw a                  ;fac6  d0
    mov 0x013a, a           ;fac7  61 01 3a

lab_faca:
    mov a, 0xcb             ;faca  05 cb
    beq lab_fad1            ;facc  fd 03
    decw a                  ;face  d0
    mov 0xcb, a             ;facf  45 cb

lab_fad1:
    ret                     ;fad1  20

sub_fad2:
    mov a, 0xc7             ;fad2  05 c7
    beq lab_fad9            ;fad4  fd 03
    decw a                  ;fad6  d0
    mov 0xc7, a             ;fad7  45 c7

lab_fad9:
    mov a, 0xc9             ;fad9  05 c9
    beq lab_fae0            ;fadb  fd 03
    decw a                  ;fadd  d0
    mov 0xc9, a             ;fade  45 c9

lab_fae0:
    mov a, 0xd1             ;fae0  05 d1
    beq lab_fae7            ;fae2  fd 03
    decw a                  ;fae4  d0
    mov 0xd1, a             ;fae5  45 d1

lab_fae7:
    ret                     ;fae7  20

    .byte 0xFF              ;fae8  ff          DATA '\xff'
    .byte 0xFF              ;fae9  ff          DATA '\xff'
    .byte 0xFF              ;faea  ff          DATA '\xff'
    .byte 0xFF              ;faeb  ff          DATA '\xff'
    .byte 0xFF              ;faec  ff          DATA '\xff'
    .byte 0xFF              ;faed  ff          DATA '\xff'
    .byte 0xFF              ;faee  ff          DATA '\xff'
    .byte 0xFF              ;faef  ff          DATA '\xff'
    .byte 0xFF              ;faf0  ff          DATA '\xff'
    .byte 0xFF              ;faf1  ff          DATA '\xff'
    .byte 0xFF              ;faf2  ff          DATA '\xff'
    .byte 0xFF              ;faf3  ff          DATA '\xff'
    .byte 0xFF              ;faf4  ff          DATA '\xff'
    .byte 0xFF              ;faf5  ff          DATA '\xff'
    .byte 0xFF              ;faf6  ff          DATA '\xff'
    .byte 0xFF              ;faf7  ff          DATA '\xff'
    .byte 0xFF              ;faf8  ff          DATA '\xff'
    .byte 0xFF              ;faf9  ff          DATA '\xff'
    .byte 0xFF              ;fafa  ff          DATA '\xff'
    .byte 0xFF              ;fafb  ff          DATA '\xff'
    .byte 0xFF              ;fafc  ff          DATA '\xff'
    .byte 0xFF              ;fafd  ff          DATA '\xff'
    .byte 0xFF              ;fafe  ff          DATA '\xff'
    .byte 0xFF              ;faff  ff          DATA '\xff'
    .byte 0xFF              ;fb00  ff          DATA '\xff'
    .byte 0xFF              ;fb01  ff          DATA '\xff'
    .byte 0xFF              ;fb02  ff          DATA '\xff'
    .byte 0xFF              ;fb03  ff          DATA '\xff'
    .byte 0xFF              ;fb04  ff          DATA '\xff'
    .byte 0xFF              ;fb05  ff          DATA '\xff'
    .byte 0xFF              ;fb06  ff          DATA '\xff'
    .byte 0xFF              ;fb07  ff          DATA '\xff'
    .byte 0xFF              ;fb08  ff          DATA '\xff'
    .byte 0xFF              ;fb09  ff          DATA '\xff'
    .byte 0xFF              ;fb0a  ff          DATA '\xff'
    .byte 0xFF              ;fb0b  ff          DATA '\xff'
    .byte 0xFF              ;fb0c  ff          DATA '\xff'
    .byte 0xFF              ;fb0d  ff          DATA '\xff'
    .byte 0xFF              ;fb0e  ff          DATA '\xff'
    .byte 0xFF              ;fb0f  ff          DATA '\xff'
    .byte 0xFF              ;fb10  ff          DATA '\xff'
    .byte 0xFF              ;fb11  ff          DATA '\xff'
    .byte 0xFF              ;fb12  ff          DATA '\xff'
    .byte 0xFF              ;fb13  ff          DATA '\xff'
    .byte 0xFF              ;fb14  ff          DATA '\xff'
    .byte 0xFF              ;fb15  ff          DATA '\xff'
    .byte 0xFF              ;fb16  ff          DATA '\xff'
    .byte 0xFF              ;fb17  ff          DATA '\xff'
    .byte 0xFF              ;fb18  ff          DATA '\xff'
    .byte 0xFF              ;fb19  ff          DATA '\xff'
    .byte 0xFF              ;fb1a  ff          DATA '\xff'
    .byte 0xFF              ;fb1b  ff          DATA '\xff'
    .byte 0xFF              ;fb1c  ff          DATA '\xff'
    .byte 0xFF              ;fb1d  ff          DATA '\xff'
    .byte 0xFF              ;fb1e  ff          DATA '\xff'
    .byte 0xFF              ;fb1f  ff          DATA '\xff'
    .byte 0xFF              ;fb20  ff          DATA '\xff'
    .byte 0xFF              ;fb21  ff          DATA '\xff'
    .byte 0xFF              ;fb22  ff          DATA '\xff'
    .byte 0xFF              ;fb23  ff          DATA '\xff'
    .byte 0xFF              ;fb24  ff          DATA '\xff'
    .byte 0xFF              ;fb25  ff          DATA '\xff'
    .byte 0xFF              ;fb26  ff          DATA '\xff'
    .byte 0xFF              ;fb27  ff          DATA '\xff'
    .byte 0xFF              ;fb28  ff          DATA '\xff'
    .byte 0xFF              ;fb29  ff          DATA '\xff'
    .byte 0xFF              ;fb2a  ff          DATA '\xff'
    .byte 0xFF              ;fb2b  ff          DATA '\xff'
    .byte 0xFF              ;fb2c  ff          DATA '\xff'
    .byte 0xFF              ;fb2d  ff          DATA '\xff'
    .byte 0xFF              ;fb2e  ff          DATA '\xff'
    .byte 0xFF              ;fb2f  ff          DATA '\xff'
    .byte 0xFF              ;fb30  ff          DATA '\xff'
    .byte 0xFF              ;fb31  ff          DATA '\xff'
    .byte 0xFF              ;fb32  ff          DATA '\xff'
    .byte 0xFF              ;fb33  ff          DATA '\xff'
    .byte 0xFF              ;fb34  ff          DATA '\xff'
    .byte 0xFF              ;fb35  ff          DATA '\xff'
    .byte 0xFF              ;fb36  ff          DATA '\xff'
    .byte 0xFF              ;fb37  ff          DATA '\xff'
    .byte 0xFF              ;fb38  ff          DATA '\xff'
    .byte 0xFF              ;fb39  ff          DATA '\xff'
    .byte 0xFF              ;fb3a  ff          DATA '\xff'
    .byte 0xFF              ;fb3b  ff          DATA '\xff'
    .byte 0xFF              ;fb3c  ff          DATA '\xff'
    .byte 0xFF              ;fb3d  ff          DATA '\xff'
    .byte 0xFF              ;fb3e  ff          DATA '\xff'
    .byte 0xFF              ;fb3f  ff          DATA '\xff'
    .byte 0xFF              ;fb40  ff          DATA '\xff'
    .byte 0xFF              ;fb41  ff          DATA '\xff'
    .byte 0xFF              ;fb42  ff          DATA '\xff'
    .byte 0xFF              ;fb43  ff          DATA '\xff'
    .byte 0xFF              ;fb44  ff          DATA '\xff'
    .byte 0xFF              ;fb45  ff          DATA '\xff'
    .byte 0xFF              ;fb46  ff          DATA '\xff'
    .byte 0xFF              ;fb47  ff          DATA '\xff'
    .byte 0xFF              ;fb48  ff          DATA '\xff'
    .byte 0xFF              ;fb49  ff          DATA '\xff'
    .byte 0xFF              ;fb4a  ff          DATA '\xff'
    .byte 0xFF              ;fb4b  ff          DATA '\xff'
    .byte 0xFF              ;fb4c  ff          DATA '\xff'
    .byte 0xFF              ;fb4d  ff          DATA '\xff'
    .byte 0xFF              ;fb4e  ff          DATA '\xff'
    .byte 0xFF              ;fb4f  ff          DATA '\xff'
    .byte 0xFF              ;fb50  ff          DATA '\xff'
    .byte 0xFF              ;fb51  ff          DATA '\xff'
    .byte 0xFF              ;fb52  ff          DATA '\xff'
    .byte 0xFF              ;fb53  ff          DATA '\xff'
    .byte 0xFF              ;fb54  ff          DATA '\xff'
    .byte 0xFF              ;fb55  ff          DATA '\xff'
    .byte 0xFF              ;fb56  ff          DATA '\xff'
    .byte 0xFF              ;fb57  ff          DATA '\xff'
    .byte 0xFF              ;fb58  ff          DATA '\xff'
    .byte 0xFF              ;fb59  ff          DATA '\xff'
    .byte 0xFF              ;fb5a  ff          DATA '\xff'
    .byte 0xFF              ;fb5b  ff          DATA '\xff'
    .byte 0xFF              ;fb5c  ff          DATA '\xff'
    .byte 0xFF              ;fb5d  ff          DATA '\xff'
    .byte 0xFF              ;fb5e  ff          DATA '\xff'
    .byte 0xFF              ;fb5f  ff          DATA '\xff'
    .byte 0xFF              ;fb60  ff          DATA '\xff'
    .byte 0xFF              ;fb61  ff          DATA '\xff'
    .byte 0xFF              ;fb62  ff          DATA '\xff'
    .byte 0xFF              ;fb63  ff          DATA '\xff'
    .byte 0xFF              ;fb64  ff          DATA '\xff'
    .byte 0xFF              ;fb65  ff          DATA '\xff'
    .byte 0xFF              ;fb66  ff          DATA '\xff'
    .byte 0xFF              ;fb67  ff          DATA '\xff'
    .byte 0xFF              ;fb68  ff          DATA '\xff'
    .byte 0xFF              ;fb69  ff          DATA '\xff'
    .byte 0xFF              ;fb6a  ff          DATA '\xff'
    .byte 0xFF              ;fb6b  ff          DATA '\xff'
    .byte 0xFF              ;fb6c  ff          DATA '\xff'
    .byte 0xFF              ;fb6d  ff          DATA '\xff'
    .byte 0xFF              ;fb6e  ff          DATA '\xff'
    .byte 0xFF              ;fb6f  ff          DATA '\xff'
    .byte 0xFF              ;fb70  ff          DATA '\xff'
    .byte 0xFF              ;fb71  ff          DATA '\xff'
    .byte 0xFF              ;fb72  ff          DATA '\xff'
    .byte 0xFF              ;fb73  ff          DATA '\xff'
    .byte 0xFF              ;fb74  ff          DATA '\xff'
    .byte 0xFF              ;fb75  ff          DATA '\xff'
    .byte 0xFF              ;fb76  ff          DATA '\xff'
    .byte 0xFF              ;fb77  ff          DATA '\xff'
    .byte 0xFF              ;fb78  ff          DATA '\xff'
    .byte 0xFF              ;fb79  ff          DATA '\xff'
    .byte 0xFF              ;fb7a  ff          DATA '\xff'
    .byte 0xFF              ;fb7b  ff          DATA '\xff'
    .byte 0xFF              ;fb7c  ff          DATA '\xff'
    .byte 0xFF              ;fb7d  ff          DATA '\xff'
    .byte 0xFF              ;fb7e  ff          DATA '\xff'
    .byte 0xFF              ;fb7f  ff          DATA '\xff'
    .byte 0xFF              ;fb80  ff          DATA '\xff'
    .byte 0xFF              ;fb81  ff          DATA '\xff'
    .byte 0xFF              ;fb82  ff          DATA '\xff'
    .byte 0xFF              ;fb83  ff          DATA '\xff'
    .byte 0xFF              ;fb84  ff          DATA '\xff'
    .byte 0xFF              ;fb85  ff          DATA '\xff'
    .byte 0xFF              ;fb86  ff          DATA '\xff'
    .byte 0xFF              ;fb87  ff          DATA '\xff'
    .byte 0xFF              ;fb88  ff          DATA '\xff'
    .byte 0xFF              ;fb89  ff          DATA '\xff'
    .byte 0xFF              ;fb8a  ff          DATA '\xff'
    .byte 0xFF              ;fb8b  ff          DATA '\xff'
    .byte 0xFF              ;fb8c  ff          DATA '\xff'
    .byte 0xFF              ;fb8d  ff          DATA '\xff'
    .byte 0xFF              ;fb8e  ff          DATA '\xff'
    .byte 0xFF              ;fb8f  ff          DATA '\xff'
    .byte 0xFF              ;fb90  ff          DATA '\xff'
    .byte 0xFF              ;fb91  ff          DATA '\xff'
    .byte 0xFF              ;fb92  ff          DATA '\xff'
    .byte 0xFF              ;fb93  ff          DATA '\xff'
    .byte 0xFF              ;fb94  ff          DATA '\xff'
    .byte 0xFF              ;fb95  ff          DATA '\xff'
    .byte 0xFF              ;fb96  ff          DATA '\xff'
    .byte 0xFF              ;fb97  ff          DATA '\xff'
    .byte 0xFF              ;fb98  ff          DATA '\xff'
    .byte 0xFF              ;fb99  ff          DATA '\xff'
    .byte 0xFF              ;fb9a  ff          DATA '\xff'
    .byte 0xFF              ;fb9b  ff          DATA '\xff'
    .byte 0xFF              ;fb9c  ff          DATA '\xff'
    .byte 0xFF              ;fb9d  ff          DATA '\xff'
    .byte 0xFF              ;fb9e  ff          DATA '\xff'
    .byte 0xFF              ;fb9f  ff          DATA '\xff'
    .byte 0xFF              ;fba0  ff          DATA '\xff'
    .byte 0xFF              ;fba1  ff          DATA '\xff'
    .byte 0xFF              ;fba2  ff          DATA '\xff'
    .byte 0xFF              ;fba3  ff          DATA '\xff'
    .byte 0xFF              ;fba4  ff          DATA '\xff'
    .byte 0xFF              ;fba5  ff          DATA '\xff'
    .byte 0xFF              ;fba6  ff          DATA '\xff'
    .byte 0xFF              ;fba7  ff          DATA '\xff'
    .byte 0xFF              ;fba8  ff          DATA '\xff'
    .byte 0xFF              ;fba9  ff          DATA '\xff'
    .byte 0xFF              ;fbaa  ff          DATA '\xff'
    .byte 0xFF              ;fbab  ff          DATA '\xff'
    .byte 0xFF              ;fbac  ff          DATA '\xff'
    .byte 0xFF              ;fbad  ff          DATA '\xff'
    .byte 0xFF              ;fbae  ff          DATA '\xff'
    .byte 0xFF              ;fbaf  ff          DATA '\xff'
    .byte 0xFF              ;fbb0  ff          DATA '\xff'
    .byte 0xFF              ;fbb1  ff          DATA '\xff'
    .byte 0xFF              ;fbb2  ff          DATA '\xff'
    .byte 0xFF              ;fbb3  ff          DATA '\xff'
    .byte 0xFF              ;fbb4  ff          DATA '\xff'
    .byte 0xFF              ;fbb5  ff          DATA '\xff'
    .byte 0xFF              ;fbb6  ff          DATA '\xff'
    .byte 0xFF              ;fbb7  ff          DATA '\xff'
    .byte 0xFF              ;fbb8  ff          DATA '\xff'
    .byte 0xFF              ;fbb9  ff          DATA '\xff'
    .byte 0xFF              ;fbba  ff          DATA '\xff'
    .byte 0xFF              ;fbbb  ff          DATA '\xff'
    .byte 0xFF              ;fbbc  ff          DATA '\xff'
    .byte 0xFF              ;fbbd  ff          DATA '\xff'
    .byte 0xFF              ;fbbe  ff          DATA '\xff'
    .byte 0xFF              ;fbbf  ff          DATA '\xff'
    .byte 0xFF              ;fbc0  ff          DATA '\xff'
    .byte 0xFF              ;fbc1  ff          DATA '\xff'
    .byte 0xFF              ;fbc2  ff          DATA '\xff'
    .byte 0xFF              ;fbc3  ff          DATA '\xff'
    .byte 0xFF              ;fbc4  ff          DATA '\xff'
    .byte 0xFF              ;fbc5  ff          DATA '\xff'
    .byte 0xFF              ;fbc6  ff          DATA '\xff'
    .byte 0xFF              ;fbc7  ff          DATA '\xff'
    .byte 0xFF              ;fbc8  ff          DATA '\xff'
    .byte 0xFF              ;fbc9  ff          DATA '\xff'
    .byte 0xFF              ;fbca  ff          DATA '\xff'
    .byte 0xFF              ;fbcb  ff          DATA '\xff'
    .byte 0xFF              ;fbcc  ff          DATA '\xff'
    .byte 0xFF              ;fbcd  ff          DATA '\xff'
    .byte 0xFF              ;fbce  ff          DATA '\xff'
    .byte 0xFF              ;fbcf  ff          DATA '\xff'
    .byte 0xFF              ;fbd0  ff          DATA '\xff'
    .byte 0xFF              ;fbd1  ff          DATA '\xff'
    .byte 0xFF              ;fbd2  ff          DATA '\xff'
    .byte 0xFF              ;fbd3  ff          DATA '\xff'
    .byte 0xFF              ;fbd4  ff          DATA '\xff'
    .byte 0xFF              ;fbd5  ff          DATA '\xff'
    .byte 0xFF              ;fbd6  ff          DATA '\xff'
    .byte 0xFF              ;fbd7  ff          DATA '\xff'
    .byte 0xFF              ;fbd8  ff          DATA '\xff'
    .byte 0xFF              ;fbd9  ff          DATA '\xff'
    .byte 0xFF              ;fbda  ff          DATA '\xff'
    .byte 0xFF              ;fbdb  ff          DATA '\xff'
    .byte 0xFF              ;fbdc  ff          DATA '\xff'
    .byte 0xFF              ;fbdd  ff          DATA '\xff'
    .byte 0xFF              ;fbde  ff          DATA '\xff'
    .byte 0xFF              ;fbdf  ff          DATA '\xff'
    .byte 0xFF              ;fbe0  ff          DATA '\xff'
    .byte 0xFF              ;fbe1  ff          DATA '\xff'
    .byte 0xFF              ;fbe2  ff          DATA '\xff'
    .byte 0xFF              ;fbe3  ff          DATA '\xff'
    .byte 0xFF              ;fbe4  ff          DATA '\xff'
    .byte 0xFF              ;fbe5  ff          DATA '\xff'
    .byte 0xFF              ;fbe6  ff          DATA '\xff'
    .byte 0xFF              ;fbe7  ff          DATA '\xff'
    .byte 0xFF              ;fbe8  ff          DATA '\xff'
    .byte 0xFF              ;fbe9  ff          DATA '\xff'
    .byte 0xFF              ;fbea  ff          DATA '\xff'
    .byte 0xFF              ;fbeb  ff          DATA '\xff'
    .byte 0xFF              ;fbec  ff          DATA '\xff'
    .byte 0xFF              ;fbed  ff          DATA '\xff'
    .byte 0xFF              ;fbee  ff          DATA '\xff'
    .byte 0xFF              ;fbef  ff          DATA '\xff'
    .byte 0xFF              ;fbf0  ff          DATA '\xff'
    .byte 0xFF              ;fbf1  ff          DATA '\xff'
    .byte 0xFF              ;fbf2  ff          DATA '\xff'
    .byte 0xFF              ;fbf3  ff          DATA '\xff'
    .byte 0xFF              ;fbf4  ff          DATA '\xff'
    .byte 0xFF              ;fbf5  ff          DATA '\xff'
    .byte 0xFF              ;fbf6  ff          DATA '\xff'
    .byte 0xFF              ;fbf7  ff          DATA '\xff'
    .byte 0xFF              ;fbf8  ff          DATA '\xff'
    .byte 0xFF              ;fbf9  ff          DATA '\xff'
    .byte 0xFF              ;fbfa  ff          DATA '\xff'
    .byte 0xFF              ;fbfb  ff          DATA '\xff'
    .byte 0xFF              ;fbfc  ff          DATA '\xff'
    .byte 0xFF              ;fbfd  ff          DATA '\xff'
    .byte 0xFF              ;fbfe  ff          DATA '\xff'
    .byte 0xFF              ;fbff  ff          DATA '\xff'
    .byte 0xFF              ;fc00  ff          DATA '\xff'
    .byte 0xFF              ;fc01  ff          DATA '\xff'
    .byte 0xFF              ;fc02  ff          DATA '\xff'
    .byte 0xFF              ;fc03  ff          DATA '\xff'
    .byte 0xFF              ;fc04  ff          DATA '\xff'
    .byte 0xFF              ;fc05  ff          DATA '\xff'
    .byte 0xFF              ;fc06  ff          DATA '\xff'
    .byte 0xFF              ;fc07  ff          DATA '\xff'
    .byte 0xFF              ;fc08  ff          DATA '\xff'
    .byte 0xFF              ;fc09  ff          DATA '\xff'
    .byte 0xFF              ;fc0a  ff          DATA '\xff'
    .byte 0xFF              ;fc0b  ff          DATA '\xff'
    .byte 0xFF              ;fc0c  ff          DATA '\xff'
    .byte 0xFF              ;fc0d  ff          DATA '\xff'
    .byte 0xFF              ;fc0e  ff          DATA '\xff'
    .byte 0xFF              ;fc0f  ff          DATA '\xff'
    .byte 0xFF              ;fc10  ff          DATA '\xff'
    .byte 0xFF              ;fc11  ff          DATA '\xff'
    .byte 0xFF              ;fc12  ff          DATA '\xff'
    .byte 0xFF              ;fc13  ff          DATA '\xff'
    .byte 0xFF              ;fc14  ff          DATA '\xff'
    .byte 0xFF              ;fc15  ff          DATA '\xff'
    .byte 0xFF              ;fc16  ff          DATA '\xff'
    .byte 0xFF              ;fc17  ff          DATA '\xff'
    .byte 0xFF              ;fc18  ff          DATA '\xff'
    .byte 0xFF              ;fc19  ff          DATA '\xff'
    .byte 0xFF              ;fc1a  ff          DATA '\xff'
    .byte 0xFF              ;fc1b  ff          DATA '\xff'
    .byte 0xFF              ;fc1c  ff          DATA '\xff'
    .byte 0xFF              ;fc1d  ff          DATA '\xff'
    .byte 0xFF              ;fc1e  ff          DATA '\xff'
    .byte 0xFF              ;fc1f  ff          DATA '\xff'
    .byte 0xFF              ;fc20  ff          DATA '\xff'
    .byte 0xFF              ;fc21  ff          DATA '\xff'
    .byte 0xFF              ;fc22  ff          DATA '\xff'
    .byte 0xFF              ;fc23  ff          DATA '\xff'
    .byte 0xFF              ;fc24  ff          DATA '\xff'
    .byte 0xFF              ;fc25  ff          DATA '\xff'
    .byte 0xFF              ;fc26  ff          DATA '\xff'
    .byte 0xFF              ;fc27  ff          DATA '\xff'
    .byte 0xFF              ;fc28  ff          DATA '\xff'
    .byte 0xFF              ;fc29  ff          DATA '\xff'
    .byte 0xFF              ;fc2a  ff          DATA '\xff'
    .byte 0xFF              ;fc2b  ff          DATA '\xff'
    .byte 0xFF              ;fc2c  ff          DATA '\xff'
    .byte 0xFF              ;fc2d  ff          DATA '\xff'
    .byte 0xFF              ;fc2e  ff          DATA '\xff'
    .byte 0xFF              ;fc2f  ff          DATA '\xff'
    .byte 0xFF              ;fc30  ff          DATA '\xff'
    .byte 0xFF              ;fc31  ff          DATA '\xff'
    .byte 0xFF              ;fc32  ff          DATA '\xff'
    .byte 0xFF              ;fc33  ff          DATA '\xff'
    .byte 0xFF              ;fc34  ff          DATA '\xff'
    .byte 0xFF              ;fc35  ff          DATA '\xff'
    .byte 0xFF              ;fc36  ff          DATA '\xff'
    .byte 0xFF              ;fc37  ff          DATA '\xff'
    .byte 0xFF              ;fc38  ff          DATA '\xff'
    .byte 0xFF              ;fc39  ff          DATA '\xff'
    .byte 0xFF              ;fc3a  ff          DATA '\xff'
    .byte 0xFF              ;fc3b  ff          DATA '\xff'
    .byte 0xFF              ;fc3c  ff          DATA '\xff'
    .byte 0xFF              ;fc3d  ff          DATA '\xff'
    .byte 0xFF              ;fc3e  ff          DATA '\xff'
    .byte 0xFF              ;fc3f  ff          DATA '\xff'
    .byte 0xFF              ;fc40  ff          DATA '\xff'
    .byte 0xFF              ;fc41  ff          DATA '\xff'
    .byte 0xFF              ;fc42  ff          DATA '\xff'
    .byte 0xFF              ;fc43  ff          DATA '\xff'
    .byte 0xFF              ;fc44  ff          DATA '\xff'
    .byte 0xFF              ;fc45  ff          DATA '\xff'
    .byte 0xFF              ;fc46  ff          DATA '\xff'
    .byte 0xFF              ;fc47  ff          DATA '\xff'
    .byte 0xFF              ;fc48  ff          DATA '\xff'
    .byte 0xFF              ;fc49  ff          DATA '\xff'
    .byte 0xFF              ;fc4a  ff          DATA '\xff'
    .byte 0xFF              ;fc4b  ff          DATA '\xff'
    .byte 0xFF              ;fc4c  ff          DATA '\xff'
    .byte 0xFF              ;fc4d  ff          DATA '\xff'
    .byte 0xFF              ;fc4e  ff          DATA '\xff'
    .byte 0xFF              ;fc4f  ff          DATA '\xff'
    .byte 0xFF              ;fc50  ff          DATA '\xff'
    .byte 0xFF              ;fc51  ff          DATA '\xff'
    .byte 0xFF              ;fc52  ff          DATA '\xff'
    .byte 0xFF              ;fc53  ff          DATA '\xff'
    .byte 0xFF              ;fc54  ff          DATA '\xff'
    .byte 0xFF              ;fc55  ff          DATA '\xff'
    .byte 0xFF              ;fc56  ff          DATA '\xff'
    .byte 0xFF              ;fc57  ff          DATA '\xff'
    .byte 0xFF              ;fc58  ff          DATA '\xff'
    .byte 0xFF              ;fc59  ff          DATA '\xff'
    .byte 0xFF              ;fc5a  ff          DATA '\xff'
    .byte 0xFF              ;fc5b  ff          DATA '\xff'
    .byte 0xFF              ;fc5c  ff          DATA '\xff'
    .byte 0xFF              ;fc5d  ff          DATA '\xff'
    .byte 0xFF              ;fc5e  ff          DATA '\xff'
    .byte 0xFF              ;fc5f  ff          DATA '\xff'
    .byte 0xFF              ;fc60  ff          DATA '\xff'
    .byte 0xFF              ;fc61  ff          DATA '\xff'
    .byte 0xFF              ;fc62  ff          DATA '\xff'
    .byte 0xFF              ;fc63  ff          DATA '\xff'
    .byte 0xFF              ;fc64  ff          DATA '\xff'
    .byte 0xFF              ;fc65  ff          DATA '\xff'
    .byte 0xFF              ;fc66  ff          DATA '\xff'
    .byte 0xFF              ;fc67  ff          DATA '\xff'
    .byte 0xFF              ;fc68  ff          DATA '\xff'
    .byte 0xFF              ;fc69  ff          DATA '\xff'
    .byte 0xFF              ;fc6a  ff          DATA '\xff'
    .byte 0xFF              ;fc6b  ff          DATA '\xff'
    .byte 0xFF              ;fc6c  ff          DATA '\xff'
    .byte 0xFF              ;fc6d  ff          DATA '\xff'
    .byte 0xFF              ;fc6e  ff          DATA '\xff'
    .byte 0xFF              ;fc6f  ff          DATA '\xff'
    .byte 0xFF              ;fc70  ff          DATA '\xff'
    .byte 0xFF              ;fc71  ff          DATA '\xff'
    .byte 0xFF              ;fc72  ff          DATA '\xff'
    .byte 0xFF              ;fc73  ff          DATA '\xff'
    .byte 0xFF              ;fc74  ff          DATA '\xff'
    .byte 0xFF              ;fc75  ff          DATA '\xff'
    .byte 0xFF              ;fc76  ff          DATA '\xff'
    .byte 0xFF              ;fc77  ff          DATA '\xff'
    .byte 0xFF              ;fc78  ff          DATA '\xff'
    .byte 0xFF              ;fc79  ff          DATA '\xff'
    .byte 0xFF              ;fc7a  ff          DATA '\xff'
    .byte 0xFF              ;fc7b  ff          DATA '\xff'
    .byte 0xFF              ;fc7c  ff          DATA '\xff'
    .byte 0xFF              ;fc7d  ff          DATA '\xff'
    .byte 0xFF              ;fc7e  ff          DATA '\xff'
    .byte 0xFF              ;fc7f  ff          DATA '\xff'
    .byte 0xFF              ;fc80  ff          DATA '\xff'
    .byte 0xFF              ;fc81  ff          DATA '\xff'
    .byte 0xFF              ;fc82  ff          DATA '\xff'
    .byte 0xFF              ;fc83  ff          DATA '\xff'
    .byte 0xFF              ;fc84  ff          DATA '\xff'
    .byte 0xFF              ;fc85  ff          DATA '\xff'
    .byte 0xFF              ;fc86  ff          DATA '\xff'
    .byte 0xFF              ;fc87  ff          DATA '\xff'
    .byte 0xFF              ;fc88  ff          DATA '\xff'
    .byte 0xFF              ;fc89  ff          DATA '\xff'
    .byte 0xFF              ;fc8a  ff          DATA '\xff'
    .byte 0xFF              ;fc8b  ff          DATA '\xff'
    .byte 0xFF              ;fc8c  ff          DATA '\xff'
    .byte 0xFF              ;fc8d  ff          DATA '\xff'
    .byte 0xFF              ;fc8e  ff          DATA '\xff'
    .byte 0xFF              ;fc8f  ff          DATA '\xff'
    .byte 0xFF              ;fc90  ff          DATA '\xff'
    .byte 0xFF              ;fc91  ff          DATA '\xff'
    .byte 0xFF              ;fc92  ff          DATA '\xff'
    .byte 0xFF              ;fc93  ff          DATA '\xff'
    .byte 0xFF              ;fc94  ff          DATA '\xff'
    .byte 0xFF              ;fc95  ff          DATA '\xff'
    .byte 0xFF              ;fc96  ff          DATA '\xff'
    .byte 0xFF              ;fc97  ff          DATA '\xff'
    .byte 0xFF              ;fc98  ff          DATA '\xff'
    .byte 0xFF              ;fc99  ff          DATA '\xff'
    .byte 0xFF              ;fc9a  ff          DATA '\xff'
    .byte 0xFF              ;fc9b  ff          DATA '\xff'
    .byte 0xFF              ;fc9c  ff          DATA '\xff'
    .byte 0xFF              ;fc9d  ff          DATA '\xff'
    .byte 0xFF              ;fc9e  ff          DATA '\xff'
    .byte 0xFF              ;fc9f  ff          DATA '\xff'
    .byte 0xFF              ;fca0  ff          DATA '\xff'
    .byte 0xFF              ;fca1  ff          DATA '\xff'
    .byte 0xFF              ;fca2  ff          DATA '\xff'
    .byte 0xFF              ;fca3  ff          DATA '\xff'
    .byte 0xFF              ;fca4  ff          DATA '\xff'
    .byte 0xFF              ;fca5  ff          DATA '\xff'
    .byte 0xFF              ;fca6  ff          DATA '\xff'
    .byte 0xFF              ;fca7  ff          DATA '\xff'
    .byte 0xFF              ;fca8  ff          DATA '\xff'
    .byte 0xFF              ;fca9  ff          DATA '\xff'
    .byte 0xFF              ;fcaa  ff          DATA '\xff'
    .byte 0xFF              ;fcab  ff          DATA '\xff'
    .byte 0xFF              ;fcac  ff          DATA '\xff'
    .byte 0xFF              ;fcad  ff          DATA '\xff'
    .byte 0xFF              ;fcae  ff          DATA '\xff'
    .byte 0xFF              ;fcaf  ff          DATA '\xff'
    .byte 0xFF              ;fcb0  ff          DATA '\xff'
    .byte 0xFF              ;fcb1  ff          DATA '\xff'
    .byte 0xFF              ;fcb2  ff          DATA '\xff'
    .byte 0xFF              ;fcb3  ff          DATA '\xff'
    .byte 0xFF              ;fcb4  ff          DATA '\xff'
    .byte 0xFF              ;fcb5  ff          DATA '\xff'
    .byte 0xFF              ;fcb6  ff          DATA '\xff'
    .byte 0xFF              ;fcb7  ff          DATA '\xff'
    .byte 0xFF              ;fcb8  ff          DATA '\xff'
    .byte 0xFF              ;fcb9  ff          DATA '\xff'
    .byte 0xFF              ;fcba  ff          DATA '\xff'
    .byte 0xFF              ;fcbb  ff          DATA '\xff'
    .byte 0xFF              ;fcbc  ff          DATA '\xff'
    .byte 0xFF              ;fcbd  ff          DATA '\xff'
    .byte 0xFF              ;fcbe  ff          DATA '\xff'
    .byte 0xFF              ;fcbf  ff          DATA '\xff'
    .byte 0xFF              ;fcc0  ff          DATA '\xff'
    .byte 0xFF              ;fcc1  ff          DATA '\xff'
    .byte 0xFF              ;fcc2  ff          DATA '\xff'
    .byte 0xFF              ;fcc3  ff          DATA '\xff'
    .byte 0xFF              ;fcc4  ff          DATA '\xff'
    .byte 0xFF              ;fcc5  ff          DATA '\xff'
    .byte 0xFF              ;fcc6  ff          DATA '\xff'
    .byte 0xFF              ;fcc7  ff          DATA '\xff'
    .byte 0xFF              ;fcc8  ff          DATA '\xff'
    .byte 0xFF              ;fcc9  ff          DATA '\xff'
    .byte 0xFF              ;fcca  ff          DATA '\xff'
    .byte 0xFF              ;fccb  ff          DATA '\xff'
    .byte 0xFF              ;fccc  ff          DATA '\xff'
    .byte 0xFF              ;fccd  ff          DATA '\xff'
    .byte 0xFF              ;fcce  ff          DATA '\xff'
    .byte 0xFF              ;fccf  ff          DATA '\xff'
    .byte 0xFF              ;fcd0  ff          DATA '\xff'
    .byte 0xFF              ;fcd1  ff          DATA '\xff'
    .byte 0xFF              ;fcd2  ff          DATA '\xff'
    .byte 0xFF              ;fcd3  ff          DATA '\xff'
    .byte 0xFF              ;fcd4  ff          DATA '\xff'
    .byte 0xFF              ;fcd5  ff          DATA '\xff'
    .byte 0xFF              ;fcd6  ff          DATA '\xff'
    .byte 0xFF              ;fcd7  ff          DATA '\xff'
    .byte 0xFF              ;fcd8  ff          DATA '\xff'
    .byte 0xFF              ;fcd9  ff          DATA '\xff'
    .byte 0xFF              ;fcda  ff          DATA '\xff'
    .byte 0xFF              ;fcdb  ff          DATA '\xff'
    .byte 0xFF              ;fcdc  ff          DATA '\xff'
    .byte 0xFF              ;fcdd  ff          DATA '\xff'
    .byte 0xFF              ;fcde  ff          DATA '\xff'
    .byte 0xFF              ;fcdf  ff          DATA '\xff'
    .byte 0xFF              ;fce0  ff          DATA '\xff'
    .byte 0xFF              ;fce1  ff          DATA '\xff'
    .byte 0xFF              ;fce2  ff          DATA '\xff'
    .byte 0xFF              ;fce3  ff          DATA '\xff'
    .byte 0xFF              ;fce4  ff          DATA '\xff'
    .byte 0xFF              ;fce5  ff          DATA '\xff'
    .byte 0xFF              ;fce6  ff          DATA '\xff'
    .byte 0xFF              ;fce7  ff          DATA '\xff'
    .byte 0xFF              ;fce8  ff          DATA '\xff'
    .byte 0xFF              ;fce9  ff          DATA '\xff'
    .byte 0xFF              ;fcea  ff          DATA '\xff'
    .byte 0xFF              ;fceb  ff          DATA '\xff'
    .byte 0xFF              ;fcec  ff          DATA '\xff'
    .byte 0xFF              ;fced  ff          DATA '\xff'
    .byte 0xFF              ;fcee  ff          DATA '\xff'
    .byte 0xFF              ;fcef  ff          DATA '\xff'
    .byte 0xFF              ;fcf0  ff          DATA '\xff'
    .byte 0xFF              ;fcf1  ff          DATA '\xff'
    .byte 0xFF              ;fcf2  ff          DATA '\xff'
    .byte 0xFF              ;fcf3  ff          DATA '\xff'
    .byte 0xFF              ;fcf4  ff          DATA '\xff'
    .byte 0xFF              ;fcf5  ff          DATA '\xff'
    .byte 0xFF              ;fcf6  ff          DATA '\xff'
    .byte 0xFF              ;fcf7  ff          DATA '\xff'
    .byte 0xFF              ;fcf8  ff          DATA '\xff'
    .byte 0xFF              ;fcf9  ff          DATA '\xff'
    .byte 0xFF              ;fcfa  ff          DATA '\xff'
    .byte 0xFF              ;fcfb  ff          DATA '\xff'
    .byte 0xFF              ;fcfc  ff          DATA '\xff'
    .byte 0xFF              ;fcfd  ff          DATA '\xff'
    .byte 0xFF              ;fcfe  ff          DATA '\xff'
    .byte 0xFF              ;fcff  ff          DATA '\xff'
    .byte 0xFF              ;fd00  ff          DATA '\xff'
    .byte 0xFF              ;fd01  ff          DATA '\xff'
    .byte 0xFF              ;fd02  ff          DATA '\xff'
    .byte 0xFF              ;fd03  ff          DATA '\xff'
    .byte 0xFF              ;fd04  ff          DATA '\xff'
    .byte 0xFF              ;fd05  ff          DATA '\xff'
    .byte 0xFF              ;fd06  ff          DATA '\xff'
    .byte 0xFF              ;fd07  ff          DATA '\xff'
    .byte 0xFF              ;fd08  ff          DATA '\xff'
    .byte 0xFF              ;fd09  ff          DATA '\xff'
    .byte 0xFF              ;fd0a  ff          DATA '\xff'
    .byte 0xFF              ;fd0b  ff          DATA '\xff'
    .byte 0xFF              ;fd0c  ff          DATA '\xff'
    .byte 0xFF              ;fd0d  ff          DATA '\xff'
    .byte 0xFF              ;fd0e  ff          DATA '\xff'
    .byte 0xFF              ;fd0f  ff          DATA '\xff'
    .byte 0xFF              ;fd10  ff          DATA '\xff'
    .byte 0xFF              ;fd11  ff          DATA '\xff'
    .byte 0xFF              ;fd12  ff          DATA '\xff'
    .byte 0xFF              ;fd13  ff          DATA '\xff'
    .byte 0xFF              ;fd14  ff          DATA '\xff'
    .byte 0xFF              ;fd15  ff          DATA '\xff'
    .byte 0xFF              ;fd16  ff          DATA '\xff'
    .byte 0xFF              ;fd17  ff          DATA '\xff'
    .byte 0xFF              ;fd18  ff          DATA '\xff'
    .byte 0xFF              ;fd19  ff          DATA '\xff'
    .byte 0xFF              ;fd1a  ff          DATA '\xff'
    .byte 0xFF              ;fd1b  ff          DATA '\xff'
    .byte 0xFF              ;fd1c  ff          DATA '\xff'
    .byte 0xFF              ;fd1d  ff          DATA '\xff'
    .byte 0xFF              ;fd1e  ff          DATA '\xff'
    .byte 0xFF              ;fd1f  ff          DATA '\xff'
    .byte 0xFF              ;fd20  ff          DATA '\xff'
    .byte 0xFF              ;fd21  ff          DATA '\xff'
    .byte 0xFF              ;fd22  ff          DATA '\xff'
    .byte 0xFF              ;fd23  ff          DATA '\xff'
    .byte 0xFF              ;fd24  ff          DATA '\xff'
    .byte 0xFF              ;fd25  ff          DATA '\xff'
    .byte 0xFF              ;fd26  ff          DATA '\xff'
    .byte 0xFF              ;fd27  ff          DATA '\xff'
    .byte 0xFF              ;fd28  ff          DATA '\xff'
    .byte 0xFF              ;fd29  ff          DATA '\xff'
    .byte 0xFF              ;fd2a  ff          DATA '\xff'
    .byte 0xFF              ;fd2b  ff          DATA '\xff'
    .byte 0xFF              ;fd2c  ff          DATA '\xff'
    .byte 0xFF              ;fd2d  ff          DATA '\xff'
    .byte 0xFF              ;fd2e  ff          DATA '\xff'
    .byte 0xFF              ;fd2f  ff          DATA '\xff'
    .byte 0xFF              ;fd30  ff          DATA '\xff'
    .byte 0xFF              ;fd31  ff          DATA '\xff'
    .byte 0xFF              ;fd32  ff          DATA '\xff'
    .byte 0xFF              ;fd33  ff          DATA '\xff'
    .byte 0xFF              ;fd34  ff          DATA '\xff'
    .byte 0xFF              ;fd35  ff          DATA '\xff'
    .byte 0xFF              ;fd36  ff          DATA '\xff'
    .byte 0xFF              ;fd37  ff          DATA '\xff'
    .byte 0xFF              ;fd38  ff          DATA '\xff'
    .byte 0xFF              ;fd39  ff          DATA '\xff'
    .byte 0xFF              ;fd3a  ff          DATA '\xff'
    .byte 0xFF              ;fd3b  ff          DATA '\xff'
    .byte 0xFF              ;fd3c  ff          DATA '\xff'
    .byte 0xFF              ;fd3d  ff          DATA '\xff'
    .byte 0xFF              ;fd3e  ff          DATA '\xff'
    .byte 0xFF              ;fd3f  ff          DATA '\xff'
    .byte 0xFF              ;fd40  ff          DATA '\xff'
    .byte 0xFF              ;fd41  ff          DATA '\xff'
    .byte 0xFF              ;fd42  ff          DATA '\xff'
    .byte 0xFF              ;fd43  ff          DATA '\xff'
    .byte 0xFF              ;fd44  ff          DATA '\xff'
    .byte 0xFF              ;fd45  ff          DATA '\xff'
    .byte 0xFF              ;fd46  ff          DATA '\xff'
    .byte 0xFF              ;fd47  ff          DATA '\xff'
    .byte 0xFF              ;fd48  ff          DATA '\xff'
    .byte 0xFF              ;fd49  ff          DATA '\xff'
    .byte 0xFF              ;fd4a  ff          DATA '\xff'
    .byte 0xFF              ;fd4b  ff          DATA '\xff'
    .byte 0xFF              ;fd4c  ff          DATA '\xff'
    .byte 0xFF              ;fd4d  ff          DATA '\xff'
    .byte 0xFF              ;fd4e  ff          DATA '\xff'
    .byte 0xFF              ;fd4f  ff          DATA '\xff'
    .byte 0xFF              ;fd50  ff          DATA '\xff'
    .byte 0xFF              ;fd51  ff          DATA '\xff'
    .byte 0xFF              ;fd52  ff          DATA '\xff'
    .byte 0xFF              ;fd53  ff          DATA '\xff'
    .byte 0xFF              ;fd54  ff          DATA '\xff'
    .byte 0xFF              ;fd55  ff          DATA '\xff'
    .byte 0xFF              ;fd56  ff          DATA '\xff'
    .byte 0xFF              ;fd57  ff          DATA '\xff'
    .byte 0xFF              ;fd58  ff          DATA '\xff'
    .byte 0xFF              ;fd59  ff          DATA '\xff'
    .byte 0xFF              ;fd5a  ff          DATA '\xff'
    .byte 0xFF              ;fd5b  ff          DATA '\xff'
    .byte 0xFF              ;fd5c  ff          DATA '\xff'
    .byte 0xFF              ;fd5d  ff          DATA '\xff'
    .byte 0xFF              ;fd5e  ff          DATA '\xff'
    .byte 0xFF              ;fd5f  ff          DATA '\xff'
    .byte 0xFF              ;fd60  ff          DATA '\xff'
    .byte 0xFF              ;fd61  ff          DATA '\xff'
    .byte 0xFF              ;fd62  ff          DATA '\xff'
    .byte 0xFF              ;fd63  ff          DATA '\xff'
    .byte 0xFF              ;fd64  ff          DATA '\xff'
    .byte 0xFF              ;fd65  ff          DATA '\xff'
    .byte 0xFF              ;fd66  ff          DATA '\xff'
    .byte 0xFF              ;fd67  ff          DATA '\xff'
    .byte 0xFF              ;fd68  ff          DATA '\xff'
    .byte 0xFF              ;fd69  ff          DATA '\xff'
    .byte 0xFF              ;fd6a  ff          DATA '\xff'
    .byte 0xFF              ;fd6b  ff          DATA '\xff'
    .byte 0xFF              ;fd6c  ff          DATA '\xff'
    .byte 0xFF              ;fd6d  ff          DATA '\xff'
    .byte 0xFF              ;fd6e  ff          DATA '\xff'
    .byte 0xFF              ;fd6f  ff          DATA '\xff'
    .byte 0xFF              ;fd70  ff          DATA '\xff'
    .byte 0xFF              ;fd71  ff          DATA '\xff'
    .byte 0xFF              ;fd72  ff          DATA '\xff'
    .byte 0xFF              ;fd73  ff          DATA '\xff'
    .byte 0xFF              ;fd74  ff          DATA '\xff'
    .byte 0xFF              ;fd75  ff          DATA '\xff'
    .byte 0xFF              ;fd76  ff          DATA '\xff'
    .byte 0xFF              ;fd77  ff          DATA '\xff'
    .byte 0xFF              ;fd78  ff          DATA '\xff'
    .byte 0xFF              ;fd79  ff          DATA '\xff'
    .byte 0xFF              ;fd7a  ff          DATA '\xff'
    .byte 0xFF              ;fd7b  ff          DATA '\xff'
    .byte 0xFF              ;fd7c  ff          DATA '\xff'
    .byte 0xFF              ;fd7d  ff          DATA '\xff'
    .byte 0xFF              ;fd7e  ff          DATA '\xff'
    .byte 0xFF              ;fd7f  ff          DATA '\xff'
    .byte 0xFF              ;fd80  ff          DATA '\xff'
    .byte 0xFF              ;fd81  ff          DATA '\xff'
    .byte 0xFF              ;fd82  ff          DATA '\xff'
    .byte 0xFF              ;fd83  ff          DATA '\xff'
    .byte 0xFF              ;fd84  ff          DATA '\xff'
    .byte 0xFF              ;fd85  ff          DATA '\xff'
    .byte 0xFF              ;fd86  ff          DATA '\xff'
    .byte 0xFF              ;fd87  ff          DATA '\xff'
    .byte 0xFF              ;fd88  ff          DATA '\xff'
    .byte 0xFF              ;fd89  ff          DATA '\xff'
    .byte 0xFF              ;fd8a  ff          DATA '\xff'
    .byte 0xFF              ;fd8b  ff          DATA '\xff'
    .byte 0xFF              ;fd8c  ff          DATA '\xff'
    .byte 0xFF              ;fd8d  ff          DATA '\xff'
    .byte 0xFF              ;fd8e  ff          DATA '\xff'
    .byte 0xFF              ;fd8f  ff          DATA '\xff'
    .byte 0xFF              ;fd90  ff          DATA '\xff'
    .byte 0xFF              ;fd91  ff          DATA '\xff'
    .byte 0xFF              ;fd92  ff          DATA '\xff'
    .byte 0xFF              ;fd93  ff          DATA '\xff'
    .byte 0xFF              ;fd94  ff          DATA '\xff'
    .byte 0xFF              ;fd95  ff          DATA '\xff'
    .byte 0xFF              ;fd96  ff          DATA '\xff'
    .byte 0xFF              ;fd97  ff          DATA '\xff'
    .byte 0xFF              ;fd98  ff          DATA '\xff'
    .byte 0xFF              ;fd99  ff          DATA '\xff'
    .byte 0xFF              ;fd9a  ff          DATA '\xff'
    .byte 0xFF              ;fd9b  ff          DATA '\xff'
    .byte 0xFF              ;fd9c  ff          DATA '\xff'
    .byte 0xFF              ;fd9d  ff          DATA '\xff'
    .byte 0xFF              ;fd9e  ff          DATA '\xff'
    .byte 0xFF              ;fd9f  ff          DATA '\xff'
    .byte 0xFF              ;fda0  ff          DATA '\xff'
    .byte 0xFF              ;fda1  ff          DATA '\xff'
    .byte 0xFF              ;fda2  ff          DATA '\xff'
    .byte 0xFF              ;fda3  ff          DATA '\xff'
    .byte 0xFF              ;fda4  ff          DATA '\xff'
    .byte 0xFF              ;fda5  ff          DATA '\xff'
    .byte 0xFF              ;fda6  ff          DATA '\xff'
    .byte 0xFF              ;fda7  ff          DATA '\xff'
    .byte 0xFF              ;fda8  ff          DATA '\xff'
    .byte 0xFF              ;fda9  ff          DATA '\xff'
    .byte 0xFF              ;fdaa  ff          DATA '\xff'
    .byte 0xFF              ;fdab  ff          DATA '\xff'
    .byte 0xFF              ;fdac  ff          DATA '\xff'
    .byte 0xFF              ;fdad  ff          DATA '\xff'
    .byte 0xFF              ;fdae  ff          DATA '\xff'
    .byte 0xFF              ;fdaf  ff          DATA '\xff'
    .byte 0xFF              ;fdb0  ff          DATA '\xff'
    .byte 0xFF              ;fdb1  ff          DATA '\xff'
    .byte 0xFF              ;fdb2  ff          DATA '\xff'
    .byte 0xFF              ;fdb3  ff          DATA '\xff'
    .byte 0xFF              ;fdb4  ff          DATA '\xff'
    .byte 0xFF              ;fdb5  ff          DATA '\xff'
    .byte 0xFF              ;fdb6  ff          DATA '\xff'
    .byte 0xFF              ;fdb7  ff          DATA '\xff'
    .byte 0xFF              ;fdb8  ff          DATA '\xff'
    .byte 0xFF              ;fdb9  ff          DATA '\xff'
    .byte 0xFF              ;fdba  ff          DATA '\xff'
    .byte 0xFF              ;fdbb  ff          DATA '\xff'
    .byte 0xFF              ;fdbc  ff          DATA '\xff'
    .byte 0xFF              ;fdbd  ff          DATA '\xff'
    .byte 0xFF              ;fdbe  ff          DATA '\xff'
    .byte 0xFF              ;fdbf  ff          DATA '\xff'
    .byte 0xFF              ;fdc0  ff          DATA '\xff'
    .byte 0xFF              ;fdc1  ff          DATA '\xff'
    .byte 0xFF              ;fdc2  ff          DATA '\xff'
    .byte 0xFF              ;fdc3  ff          DATA '\xff'
    .byte 0xFF              ;fdc4  ff          DATA '\xff'
    .byte 0xFF              ;fdc5  ff          DATA '\xff'
    .byte 0xFF              ;fdc6  ff          DATA '\xff'
    .byte 0xFF              ;fdc7  ff          DATA '\xff'
    .byte 0xFF              ;fdc8  ff          DATA '\xff'
    .byte 0xFF              ;fdc9  ff          DATA '\xff'
    .byte 0xFF              ;fdca  ff          DATA '\xff'
    .byte 0xFF              ;fdcb  ff          DATA '\xff'
    .byte 0xFF              ;fdcc  ff          DATA '\xff'
    .byte 0xFF              ;fdcd  ff          DATA '\xff'
    .byte 0xFF              ;fdce  ff          DATA '\xff'
    .byte 0xFF              ;fdcf  ff          DATA '\xff'
    .byte 0xFF              ;fdd0  ff          DATA '\xff'
    .byte 0xFF              ;fdd1  ff          DATA '\xff'
    .byte 0xFF              ;fdd2  ff          DATA '\xff'
    .byte 0xFF              ;fdd3  ff          DATA '\xff'
    .byte 0xFF              ;fdd4  ff          DATA '\xff'
    .byte 0xFF              ;fdd5  ff          DATA '\xff'
    .byte 0xFF              ;fdd6  ff          DATA '\xff'
    .byte 0xFF              ;fdd7  ff          DATA '\xff'
    .byte 0xFF              ;fdd8  ff          DATA '\xff'
    .byte 0xFF              ;fdd9  ff          DATA '\xff'
    .byte 0xFF              ;fdda  ff          DATA '\xff'
    .byte 0xFF              ;fddb  ff          DATA '\xff'
    .byte 0xFF              ;fddc  ff          DATA '\xff'
    .byte 0xFF              ;fddd  ff          DATA '\xff'
    .byte 0xFF              ;fdde  ff          DATA '\xff'
    .byte 0xFF              ;fddf  ff          DATA '\xff'
    .byte 0xFF              ;fde0  ff          DATA '\xff'
    .byte 0xFF              ;fde1  ff          DATA '\xff'
    .byte 0xFF              ;fde2  ff          DATA '\xff'
    .byte 0xFF              ;fde3  ff          DATA '\xff'
    .byte 0xFF              ;fde4  ff          DATA '\xff'
    .byte 0xFF              ;fde5  ff          DATA '\xff'
    .byte 0xFF              ;fde6  ff          DATA '\xff'
    .byte 0xFF              ;fde7  ff          DATA '\xff'
    .byte 0xFF              ;fde8  ff          DATA '\xff'
    .byte 0xFF              ;fde9  ff          DATA '\xff'
    .byte 0xFF              ;fdea  ff          DATA '\xff'
    .byte 0xFF              ;fdeb  ff          DATA '\xff'
    .byte 0xFF              ;fdec  ff          DATA '\xff'
    .byte 0xFF              ;fded  ff          DATA '\xff'
    .byte 0xFF              ;fdee  ff          DATA '\xff'
    .byte 0xFF              ;fdef  ff          DATA '\xff'
    .byte 0xFF              ;fdf0  ff          DATA '\xff'
    .byte 0xFF              ;fdf1  ff          DATA '\xff'
    .byte 0xFF              ;fdf2  ff          DATA '\xff'
    .byte 0xFF              ;fdf3  ff          DATA '\xff'
    .byte 0xFF              ;fdf4  ff          DATA '\xff'
    .byte 0xFF              ;fdf5  ff          DATA '\xff'
    .byte 0xFF              ;fdf6  ff          DATA '\xff'
    .byte 0xFF              ;fdf7  ff          DATA '\xff'
    .byte 0xFF              ;fdf8  ff          DATA '\xff'
    .byte 0xFF              ;fdf9  ff          DATA '\xff'
    .byte 0xFF              ;fdfa  ff          DATA '\xff'
    .byte 0xFF              ;fdfb  ff          DATA '\xff'
    .byte 0xFF              ;fdfc  ff          DATA '\xff'
    .byte 0xFF              ;fdfd  ff          DATA '\xff'
    .byte 0xFF              ;fdfe  ff          DATA '\xff'
    .byte 0xFF              ;fdff  ff          DATA '\xff'
    .byte 0xFF              ;fe00  ff          DATA '\xff'
    .byte 0xFF              ;fe01  ff          DATA '\xff'
    .byte 0xFF              ;fe02  ff          DATA '\xff'
    .byte 0xFF              ;fe03  ff          DATA '\xff'
    .byte 0xFF              ;fe04  ff          DATA '\xff'
    .byte 0xFF              ;fe05  ff          DATA '\xff'
    .byte 0xFF              ;fe06  ff          DATA '\xff'
    .byte 0xFF              ;fe07  ff          DATA '\xff'
    .byte 0xFF              ;fe08  ff          DATA '\xff'
    .byte 0xFF              ;fe09  ff          DATA '\xff'
    .byte 0xFF              ;fe0a  ff          DATA '\xff'
    .byte 0xFF              ;fe0b  ff          DATA '\xff'
    .byte 0xFF              ;fe0c  ff          DATA '\xff'
    .byte 0xFF              ;fe0d  ff          DATA '\xff'
    .byte 0xFF              ;fe0e  ff          DATA '\xff'
    .byte 0xFF              ;fe0f  ff          DATA '\xff'
    .byte 0xFF              ;fe10  ff          DATA '\xff'
    .byte 0xFF              ;fe11  ff          DATA '\xff'
    .byte 0xFF              ;fe12  ff          DATA '\xff'
    .byte 0xFF              ;fe13  ff          DATA '\xff'
    .byte 0xFF              ;fe14  ff          DATA '\xff'
    .byte 0xFF              ;fe15  ff          DATA '\xff'
    .byte 0xFF              ;fe16  ff          DATA '\xff'
    .byte 0xFF              ;fe17  ff          DATA '\xff'
    .byte 0xFF              ;fe18  ff          DATA '\xff'
    .byte 0xFF              ;fe19  ff          DATA '\xff'
    .byte 0xFF              ;fe1a  ff          DATA '\xff'
    .byte 0xFF              ;fe1b  ff          DATA '\xff'
    .byte 0xFF              ;fe1c  ff          DATA '\xff'
    .byte 0xFF              ;fe1d  ff          DATA '\xff'
    .byte 0xFF              ;fe1e  ff          DATA '\xff'
    .byte 0xFF              ;fe1f  ff          DATA '\xff'
    .byte 0xFF              ;fe20  ff          DATA '\xff'
    .byte 0xFF              ;fe21  ff          DATA '\xff'
    .byte 0xFF              ;fe22  ff          DATA '\xff'
    .byte 0xFF              ;fe23  ff          DATA '\xff'
    .byte 0xFF              ;fe24  ff          DATA '\xff'
    .byte 0xFF              ;fe25  ff          DATA '\xff'
    .byte 0xFF              ;fe26  ff          DATA '\xff'
    .byte 0xFF              ;fe27  ff          DATA '\xff'
    .byte 0xFF              ;fe28  ff          DATA '\xff'
    .byte 0xFF              ;fe29  ff          DATA '\xff'
    .byte 0xFF              ;fe2a  ff          DATA '\xff'
    .byte 0xFF              ;fe2b  ff          DATA '\xff'
    .byte 0xFF              ;fe2c  ff          DATA '\xff'
    .byte 0xFF              ;fe2d  ff          DATA '\xff'
    .byte 0xFF              ;fe2e  ff          DATA '\xff'
    .byte 0xFF              ;fe2f  ff          DATA '\xff'
    .byte 0xFF              ;fe30  ff          DATA '\xff'
    .byte 0xFF              ;fe31  ff          DATA '\xff'
    .byte 0xFF              ;fe32  ff          DATA '\xff'
    .byte 0xFF              ;fe33  ff          DATA '\xff'
    .byte 0xFF              ;fe34  ff          DATA '\xff'
    .byte 0xFF              ;fe35  ff          DATA '\xff'
    .byte 0xFF              ;fe36  ff          DATA '\xff'
    .byte 0xFF              ;fe37  ff          DATA '\xff'
    .byte 0xFF              ;fe38  ff          DATA '\xff'
    .byte 0xFF              ;fe39  ff          DATA '\xff'
    .byte 0xFF              ;fe3a  ff          DATA '\xff'
    .byte 0xFF              ;fe3b  ff          DATA '\xff'
    .byte 0xFF              ;fe3c  ff          DATA '\xff'
    .byte 0xFF              ;fe3d  ff          DATA '\xff'
    .byte 0xFF              ;fe3e  ff          DATA '\xff'
    .byte 0xFF              ;fe3f  ff          DATA '\xff'
    .byte 0xFF              ;fe40  ff          DATA '\xff'
    .byte 0xFF              ;fe41  ff          DATA '\xff'
    .byte 0xFF              ;fe42  ff          DATA '\xff'
    .byte 0xFF              ;fe43  ff          DATA '\xff'
    .byte 0xFF              ;fe44  ff          DATA '\xff'
    .byte 0xFF              ;fe45  ff          DATA '\xff'
    .byte 0xFF              ;fe46  ff          DATA '\xff'
    .byte 0xFF              ;fe47  ff          DATA '\xff'
    .byte 0xFF              ;fe48  ff          DATA '\xff'
    .byte 0xFF              ;fe49  ff          DATA '\xff'
    .byte 0xFF              ;fe4a  ff          DATA '\xff'
    .byte 0xFF              ;fe4b  ff          DATA '\xff'
    .byte 0xFF              ;fe4c  ff          DATA '\xff'
    .byte 0xFF              ;fe4d  ff          DATA '\xff'
    .byte 0xFF              ;fe4e  ff          DATA '\xff'
    .byte 0xFF              ;fe4f  ff          DATA '\xff'
    .byte 0xFF              ;fe50  ff          DATA '\xff'
    .byte 0xFF              ;fe51  ff          DATA '\xff'
    .byte 0xFF              ;fe52  ff          DATA '\xff'
    .byte 0xFF              ;fe53  ff          DATA '\xff'
    .byte 0xFF              ;fe54  ff          DATA '\xff'
    .byte 0xFF              ;fe55  ff          DATA '\xff'
    .byte 0xFF              ;fe56  ff          DATA '\xff'
    .byte 0xFF              ;fe57  ff          DATA '\xff'
    .byte 0xFF              ;fe58  ff          DATA '\xff'
    .byte 0xFF              ;fe59  ff          DATA '\xff'
    .byte 0xFF              ;fe5a  ff          DATA '\xff'
    .byte 0xFF              ;fe5b  ff          DATA '\xff'
    .byte 0xFF              ;fe5c  ff          DATA '\xff'
    .byte 0xFF              ;fe5d  ff          DATA '\xff'
    .byte 0xFF              ;fe5e  ff          DATA '\xff'
    .byte 0xFF              ;fe5f  ff          DATA '\xff'
    .byte 0xFF              ;fe60  ff          DATA '\xff'
    .byte 0xFF              ;fe61  ff          DATA '\xff'
    .byte 0xFF              ;fe62  ff          DATA '\xff'
    .byte 0xFF              ;fe63  ff          DATA '\xff'
    .byte 0xFF              ;fe64  ff          DATA '\xff'
    .byte 0xFF              ;fe65  ff          DATA '\xff'
    .byte 0xFF              ;fe66  ff          DATA '\xff'
    .byte 0xFF              ;fe67  ff          DATA '\xff'
    .byte 0xFF              ;fe68  ff          DATA '\xff'
    .byte 0xFF              ;fe69  ff          DATA '\xff'
    .byte 0xFF              ;fe6a  ff          DATA '\xff'
    .byte 0xFF              ;fe6b  ff          DATA '\xff'
    .byte 0xFF              ;fe6c  ff          DATA '\xff'
    .byte 0xFF              ;fe6d  ff          DATA '\xff'
    .byte 0xFF              ;fe6e  ff          DATA '\xff'
    .byte 0xFF              ;fe6f  ff          DATA '\xff'
    .byte 0xFF              ;fe70  ff          DATA '\xff'
    .byte 0xFF              ;fe71  ff          DATA '\xff'
    .byte 0xFF              ;fe72  ff          DATA '\xff'
    .byte 0xFF              ;fe73  ff          DATA '\xff'
    .byte 0xFF              ;fe74  ff          DATA '\xff'
    .byte 0xFF              ;fe75  ff          DATA '\xff'
    .byte 0xFF              ;fe76  ff          DATA '\xff'
    .byte 0xFF              ;fe77  ff          DATA '\xff'
    .byte 0xFF              ;fe78  ff          DATA '\xff'
    .byte 0xFF              ;fe79  ff          DATA '\xff'
    .byte 0xFF              ;fe7a  ff          DATA '\xff'
    .byte 0xFF              ;fe7b  ff          DATA '\xff'
    .byte 0xFF              ;fe7c  ff          DATA '\xff'
    .byte 0xFF              ;fe7d  ff          DATA '\xff'
    .byte 0xFF              ;fe7e  ff          DATA '\xff'
    .byte 0xFF              ;fe7f  ff          DATA '\xff'
    .byte 0xFF              ;fe80  ff          DATA '\xff'
    .byte 0xFF              ;fe81  ff          DATA '\xff'
    .byte 0xFF              ;fe82  ff          DATA '\xff'
    .byte 0xFF              ;fe83  ff          DATA '\xff'
    .byte 0xFF              ;fe84  ff          DATA '\xff'
    .byte 0xFF              ;fe85  ff          DATA '\xff'
    .byte 0xFF              ;fe86  ff          DATA '\xff'
    .byte 0xFF              ;fe87  ff          DATA '\xff'
    .byte 0xFF              ;fe88  ff          DATA '\xff'
    .byte 0xFF              ;fe89  ff          DATA '\xff'
    .byte 0xFF              ;fe8a  ff          DATA '\xff'
    .byte 0xFF              ;fe8b  ff          DATA '\xff'
    .byte 0xFF              ;fe8c  ff          DATA '\xff'
    .byte 0xFF              ;fe8d  ff          DATA '\xff'
    .byte 0xFF              ;fe8e  ff          DATA '\xff'
    .byte 0xFF              ;fe8f  ff          DATA '\xff'
    .byte 0xFF              ;fe90  ff          DATA '\xff'
    .byte 0xFF              ;fe91  ff          DATA '\xff'
    .byte 0xFF              ;fe92  ff          DATA '\xff'
    .byte 0xFF              ;fe93  ff          DATA '\xff'
    .byte 0xFF              ;fe94  ff          DATA '\xff'
    .byte 0xFF              ;fe95  ff          DATA '\xff'
    .byte 0xFF              ;fe96  ff          DATA '\xff'
    .byte 0xFF              ;fe97  ff          DATA '\xff'
    .byte 0xFF              ;fe98  ff          DATA '\xff'
    .byte 0xFF              ;fe99  ff          DATA '\xff'
    .byte 0xFF              ;fe9a  ff          DATA '\xff'
    .byte 0xFF              ;fe9b  ff          DATA '\xff'
    .byte 0xFF              ;fe9c  ff          DATA '\xff'
    .byte 0xFF              ;fe9d  ff          DATA '\xff'
    .byte 0xFF              ;fe9e  ff          DATA '\xff'
    .byte 0xFF              ;fe9f  ff          DATA '\xff'
    .byte 0xFF              ;fea0  ff          DATA '\xff'
    .byte 0xFF              ;fea1  ff          DATA '\xff'
    .byte 0xFF              ;fea2  ff          DATA '\xff'
    .byte 0xFF              ;fea3  ff          DATA '\xff'
    .byte 0xFF              ;fea4  ff          DATA '\xff'
    .byte 0xFF              ;fea5  ff          DATA '\xff'
    .byte 0xFF              ;fea6  ff          DATA '\xff'
    .byte 0xFF              ;fea7  ff          DATA '\xff'
    .byte 0xFF              ;fea8  ff          DATA '\xff'
    .byte 0xFF              ;fea9  ff          DATA '\xff'
    .byte 0xFF              ;feaa  ff          DATA '\xff'
    .byte 0xFF              ;feab  ff          DATA '\xff'
    .byte 0xFF              ;feac  ff          DATA '\xff'
    .byte 0xFF              ;fead  ff          DATA '\xff'
    .byte 0xFF              ;feae  ff          DATA '\xff'
    .byte 0xFF              ;feaf  ff          DATA '\xff'
    .byte 0xFF              ;feb0  ff          DATA '\xff'
    .byte 0xFF              ;feb1  ff          DATA '\xff'
    .byte 0xFF              ;feb2  ff          DATA '\xff'
    .byte 0xFF              ;feb3  ff          DATA '\xff'
    .byte 0xFF              ;feb4  ff          DATA '\xff'
    .byte 0xFF              ;feb5  ff          DATA '\xff'
    .byte 0xFF              ;feb6  ff          DATA '\xff'
    .byte 0xFF              ;feb7  ff          DATA '\xff'
    .byte 0xFF              ;feb8  ff          DATA '\xff'
    .byte 0xFF              ;feb9  ff          DATA '\xff'
    .byte 0xFF              ;feba  ff          DATA '\xff'
    .byte 0xFF              ;febb  ff          DATA '\xff'
    .byte 0xFF              ;febc  ff          DATA '\xff'
    .byte 0xFF              ;febd  ff          DATA '\xff'
    .byte 0xFF              ;febe  ff          DATA '\xff'
    .byte 0xFF              ;febf  ff          DATA '\xff'
    .byte 0xFF              ;fec0  ff          DATA '\xff'
    .byte 0xFF              ;fec1  ff          DATA '\xff'
    .byte 0xFF              ;fec2  ff          DATA '\xff'
    .byte 0xFF              ;fec3  ff          DATA '\xff'
    .byte 0xFF              ;fec4  ff          DATA '\xff'
    .byte 0xFF              ;fec5  ff          DATA '\xff'
    .byte 0xFF              ;fec6  ff          DATA '\xff'
    .byte 0xFF              ;fec7  ff          DATA '\xff'
    .byte 0xFF              ;fec8  ff          DATA '\xff'
    .byte 0xFF              ;fec9  ff          DATA '\xff'
    .byte 0xFF              ;feca  ff          DATA '\xff'
    .byte 0xFF              ;fecb  ff          DATA '\xff'
    .byte 0xFF              ;fecc  ff          DATA '\xff'
    .byte 0xFF              ;fecd  ff          DATA '\xff'
    .byte 0xFF              ;fece  ff          DATA '\xff'
    .byte 0xFF              ;fecf  ff          DATA '\xff'
    .byte 0xFF              ;fed0  ff          DATA '\xff'
    .byte 0xFF              ;fed1  ff          DATA '\xff'
    .byte 0xFF              ;fed2  ff          DATA '\xff'
    .byte 0xFF              ;fed3  ff          DATA '\xff'
    .byte 0xFF              ;fed4  ff          DATA '\xff'
    .byte 0xFF              ;fed5  ff          DATA '\xff'
    .byte 0xFF              ;fed6  ff          DATA '\xff'
    .byte 0xFF              ;fed7  ff          DATA '\xff'
    .byte 0xFF              ;fed8  ff          DATA '\xff'
    .byte 0xFF              ;fed9  ff          DATA '\xff'
    .byte 0xFF              ;feda  ff          DATA '\xff'
    .byte 0xFF              ;fedb  ff          DATA '\xff'
    .byte 0xFF              ;fedc  ff          DATA '\xff'
    .byte 0xFF              ;fedd  ff          DATA '\xff'
    .byte 0xFF              ;fede  ff          DATA '\xff'
    .byte 0xFF              ;fedf  ff          DATA '\xff'
    .byte 0xFF              ;fee0  ff          DATA '\xff'
    .byte 0xFF              ;fee1  ff          DATA '\xff'
    .byte 0xFF              ;fee2  ff          DATA '\xff'
    .byte 0xFF              ;fee3  ff          DATA '\xff'
    .byte 0xFF              ;fee4  ff          DATA '\xff'
    .byte 0xFF              ;fee5  ff          DATA '\xff'
    .byte 0xFF              ;fee6  ff          DATA '\xff'
    .byte 0xFF              ;fee7  ff          DATA '\xff'
    .byte 0xFF              ;fee8  ff          DATA '\xff'
    .byte 0xFF              ;fee9  ff          DATA '\xff'
    .byte 0xFF              ;feea  ff          DATA '\xff'
    .byte 0xFF              ;feeb  ff          DATA '\xff'
    .byte 0xFF              ;feec  ff          DATA '\xff'
    .byte 0xFF              ;feed  ff          DATA '\xff'
    .byte 0xFF              ;feee  ff          DATA '\xff'
    .byte 0xFF              ;feef  ff          DATA '\xff'
    .byte 0xFF              ;fef0  ff          DATA '\xff'
    .byte 0xFF              ;fef1  ff          DATA '\xff'
    .byte 0xFF              ;fef2  ff          DATA '\xff'
    .byte 0xFF              ;fef3  ff          DATA '\xff'
    .byte 0xFF              ;fef4  ff          DATA '\xff'
    .byte 0xFF              ;fef5  ff          DATA '\xff'
    .byte 0xFF              ;fef6  ff          DATA '\xff'
    .byte 0xFF              ;fef7  ff          DATA '\xff'
    .byte 0xFF              ;fef8  ff          DATA '\xff'
    .byte 0xFF              ;fef9  ff          DATA '\xff'
    .byte 0xFF              ;fefa  ff          DATA '\xff'
    .byte 0xFF              ;fefb  ff          DATA '\xff'
    .byte 0xFF              ;fefc  ff          DATA '\xff'
    .byte 0xFF              ;fefd  ff          DATA '\xff'
    .byte 0xFF              ;fefe  ff          DATA '\xff'
    .byte 0xFF              ;feff  ff          DATA '\xff'
    .byte 0xFF              ;ff00  ff          DATA '\xff'
    .byte 0xFF              ;ff01  ff          DATA '\xff'
    .byte 0xFF              ;ff02  ff          DATA '\xff'
    .byte 0xFF              ;ff03  ff          DATA '\xff'
    .byte 0xFF              ;ff04  ff          DATA '\xff'
    .byte 0xFF              ;ff05  ff          DATA '\xff'
    .byte 0xFF              ;ff06  ff          DATA '\xff'
    .byte 0xFF              ;ff07  ff          DATA '\xff'
    .byte 0xFF              ;ff08  ff          DATA '\xff'
    .byte 0xFF              ;ff09  ff          DATA '\xff'
    .byte 0xFF              ;ff0a  ff          DATA '\xff'
    .byte 0xFF              ;ff0b  ff          DATA '\xff'
    .byte 0xFF              ;ff0c  ff          DATA '\xff'
    .byte 0xFF              ;ff0d  ff          DATA '\xff'
    .byte 0xFF              ;ff0e  ff          DATA '\xff'
    .byte 0xFF              ;ff0f  ff          DATA '\xff'
    .byte 0xFF              ;ff10  ff          DATA '\xff'
    .byte 0xFF              ;ff11  ff          DATA '\xff'
    .byte 0xFF              ;ff12  ff          DATA '\xff'
    .byte 0xFF              ;ff13  ff          DATA '\xff'
    .byte 0xFF              ;ff14  ff          DATA '\xff'
    .byte 0xFF              ;ff15  ff          DATA '\xff'
    .byte 0xFF              ;ff16  ff          DATA '\xff'
    .byte 0xFF              ;ff17  ff          DATA '\xff'
    .byte 0xFF              ;ff18  ff          DATA '\xff'
    .byte 0xFF              ;ff19  ff          DATA '\xff'
    .byte 0xFF              ;ff1a  ff          DATA '\xff'
    .byte 0xFF              ;ff1b  ff          DATA '\xff'
    .byte 0xFF              ;ff1c  ff          DATA '\xff'
    .byte 0xFF              ;ff1d  ff          DATA '\xff'
    .byte 0xFF              ;ff1e  ff          DATA '\xff'
    .byte 0xFF              ;ff1f  ff          DATA '\xff'
    .byte 0xFF              ;ff20  ff          DATA '\xff'
    .byte 0xFF              ;ff21  ff          DATA '\xff'
    .byte 0xFF              ;ff22  ff          DATA '\xff'
    .byte 0xFF              ;ff23  ff          DATA '\xff'
    .byte 0xFF              ;ff24  ff          DATA '\xff'
    .byte 0xFF              ;ff25  ff          DATA '\xff'
    .byte 0xFF              ;ff26  ff          DATA '\xff'
    .byte 0xFF              ;ff27  ff          DATA '\xff'
    .byte 0xFF              ;ff28  ff          DATA '\xff'
    .byte 0xFF              ;ff29  ff          DATA '\xff'
    .byte 0xFF              ;ff2a  ff          DATA '\xff'
    .byte 0xFF              ;ff2b  ff          DATA '\xff'
    .byte 0xFF              ;ff2c  ff          DATA '\xff'
    .byte 0xFF              ;ff2d  ff          DATA '\xff'
    .byte 0xFF              ;ff2e  ff          DATA '\xff'
    .byte 0xFF              ;ff2f  ff          DATA '\xff'
    .byte 0xFF              ;ff30  ff          DATA '\xff'
    .byte 0xFF              ;ff31  ff          DATA '\xff'
    .byte 0xFF              ;ff32  ff          DATA '\xff'
    .byte 0xFF              ;ff33  ff          DATA '\xff'
    .byte 0xFF              ;ff34  ff          DATA '\xff'
    .byte 0xFF              ;ff35  ff          DATA '\xff'
    .byte 0xFF              ;ff36  ff          DATA '\xff'
    .byte 0xFF              ;ff37  ff          DATA '\xff'
    .byte 0xFF              ;ff38  ff          DATA '\xff'
    .byte 0xFF              ;ff39  ff          DATA '\xff'
    .byte 0xFF              ;ff3a  ff          DATA '\xff'
    .byte 0xFF              ;ff3b  ff          DATA '\xff'
    .byte 0xFF              ;ff3c  ff          DATA '\xff'
    .byte 0xFF              ;ff3d  ff          DATA '\xff'
    .byte 0xFF              ;ff3e  ff          DATA '\xff'
    .byte 0xFF              ;ff3f  ff          DATA '\xff'
    .byte 0xFF              ;ff40  ff          DATA '\xff'
    .byte 0xFF              ;ff41  ff          DATA '\xff'
    .byte 0xFF              ;ff42  ff          DATA '\xff'
    .byte 0xFF              ;ff43  ff          DATA '\xff'
    .byte 0xFF              ;ff44  ff          DATA '\xff'
    .byte 0xFF              ;ff45  ff          DATA '\xff'
    .byte 0xFF              ;ff46  ff          DATA '\xff'
    .byte 0xFF              ;ff47  ff          DATA '\xff'
    .byte 0xFF              ;ff48  ff          DATA '\xff'
    .byte 0xFF              ;ff49  ff          DATA '\xff'
    .byte 0xFF              ;ff4a  ff          DATA '\xff'
    .byte 0xFF              ;ff4b  ff          DATA '\xff'
    .byte 0xFF              ;ff4c  ff          DATA '\xff'
    .byte 0xFF              ;ff4d  ff          DATA '\xff'
    .byte 0xFF              ;ff4e  ff          DATA '\xff'
    .byte 0xFF              ;ff4f  ff          DATA '\xff'
    .byte 0xFF              ;ff50  ff          DATA '\xff'
    .byte 0xFF              ;ff51  ff          DATA '\xff'
    .byte 0xFF              ;ff52  ff          DATA '\xff'
    .byte 0xFF              ;ff53  ff          DATA '\xff'
    .byte 0xFF              ;ff54  ff          DATA '\xff'
    .byte 0xFF              ;ff55  ff          DATA '\xff'
    .byte 0xFF              ;ff56  ff          DATA '\xff'
    .byte 0xFF              ;ff57  ff          DATA '\xff'
    .byte 0xFF              ;ff58  ff          DATA '\xff'
    .byte 0xFF              ;ff59  ff          DATA '\xff'
    .byte 0xFF              ;ff5a  ff          DATA '\xff'
    .byte 0xFF              ;ff5b  ff          DATA '\xff'
    .byte 0xFF              ;ff5c  ff          DATA '\xff'
    .byte 0xFF              ;ff5d  ff          DATA '\xff'
    .byte 0xFF              ;ff5e  ff          DATA '\xff'
    .byte 0xFF              ;ff5f  ff          DATA '\xff'
    .byte 0xFF              ;ff60  ff          DATA '\xff'
    .byte 0xFF              ;ff61  ff          DATA '\xff'
    .byte 0xFF              ;ff62  ff          DATA '\xff'
    .byte 0xFF              ;ff63  ff          DATA '\xff'
    .byte 0xFF              ;ff64  ff          DATA '\xff'
    .byte 0xFF              ;ff65  ff          DATA '\xff'
    .byte 0xFF              ;ff66  ff          DATA '\xff'
    .byte 0xFF              ;ff67  ff          DATA '\xff'
    .byte 0xFF              ;ff68  ff          DATA '\xff'
    .byte 0xFF              ;ff69  ff          DATA '\xff'
    .byte 0xFF              ;ff6a  ff          DATA '\xff'
    .byte 0xFF              ;ff6b  ff          DATA '\xff'
    .byte 0xFF              ;ff6c  ff          DATA '\xff'
    .byte 0xFF              ;ff6d  ff          DATA '\xff'
    .byte 0xFF              ;ff6e  ff          DATA '\xff'
    .byte 0xFF              ;ff6f  ff          DATA '\xff'
    .byte 0xFF              ;ff70  ff          DATA '\xff'
    .byte 0xFF              ;ff71  ff          DATA '\xff'
    .byte 0xFF              ;ff72  ff          DATA '\xff'
    .byte 0xFF              ;ff73  ff          DATA '\xff'
    .byte 0xFF              ;ff74  ff          DATA '\xff'
    .byte 0xFF              ;ff75  ff          DATA '\xff'
    .byte 0xFF              ;ff76  ff          DATA '\xff'
    .byte 0xFF              ;ff77  ff          DATA '\xff'
    .byte 0xFF              ;ff78  ff          DATA '\xff'
    .byte 0xFF              ;ff79  ff          DATA '\xff'
    .byte 0xFF              ;ff7a  ff          DATA '\xff'
    .byte 0xFF              ;ff7b  ff          DATA '\xff'
    .byte 0xFF              ;ff7c  ff          DATA '\xff'
    .byte 0xFF              ;ff7d  ff          DATA '\xff'
    .byte 0xFF              ;ff7e  ff          DATA '\xff'
    .byte 0xFF              ;ff7f  ff          DATA '\xff'
    .byte 0xFF              ;ff80  ff          DATA '\xff'
    .byte 0xFF              ;ff81  ff          DATA '\xff'
    .byte 0xFF              ;ff82  ff          DATA '\xff'
    .byte 0xFF              ;ff83  ff          DATA '\xff'
    .byte 0xFF              ;ff84  ff          DATA '\xff'
    .byte 0xFF              ;ff85  ff          DATA '\xff'
    .byte 0xFF              ;ff86  ff          DATA '\xff'
    .byte 0xFF              ;ff87  ff          DATA '\xff'
    .byte 0xFF              ;ff88  ff          DATA '\xff'
    .byte 0xFF              ;ff89  ff          DATA '\xff'
    .byte 0xFF              ;ff8a  ff          DATA '\xff'
    .byte 0xFF              ;ff8b  ff          DATA '\xff'
    .byte 0xFF              ;ff8c  ff          DATA '\xff'
    .byte 0xFF              ;ff8d  ff          DATA '\xff'
    .byte 0xFF              ;ff8e  ff          DATA '\xff'
    .byte 0xFF              ;ff8f  ff          DATA '\xff'
    .byte 0xFF              ;ff90  ff          DATA '\xff'
    .byte 0xFF              ;ff91  ff          DATA '\xff'
    .byte 0xFF              ;ff92  ff          DATA '\xff'
    .byte 0xFF              ;ff93  ff          DATA '\xff'
    .byte 0xFF              ;ff94  ff          DATA '\xff'
    .byte 0xFF              ;ff95  ff          DATA '\xff'
    .byte 0xFF              ;ff96  ff          DATA '\xff'
    .byte 0xFF              ;ff97  ff          DATA '\xff'
    .byte 0xFF              ;ff98  ff          DATA '\xff'
    .byte 0xFF              ;ff99  ff          DATA '\xff'
    .byte 0xFF              ;ff9a  ff          DATA '\xff'
    .byte 0xFF              ;ff9b  ff          DATA '\xff'
    .byte 0xFF              ;ff9c  ff          DATA '\xff'
    .byte 0xFF              ;ff9d  ff          DATA '\xff'
    .byte 0xFF              ;ff9e  ff          DATA '\xff'
    .byte 0xFF              ;ff9f  ff          DATA '\xff'
    .byte 0xFF              ;ffa0  ff          DATA '\xff'
    .byte 0xFF              ;ffa1  ff          DATA '\xff'
    .byte 0xFF              ;ffa2  ff          DATA '\xff'
    .byte 0xFF              ;ffa3  ff          DATA '\xff'
    .byte 0xFF              ;ffa4  ff          DATA '\xff'
    .byte 0xFF              ;ffa5  ff          DATA '\xff'
    .byte 0xFF              ;ffa6  ff          DATA '\xff'
    .byte 0xFF              ;ffa7  ff          DATA '\xff'
    .byte 0xFF              ;ffa8  ff          DATA '\xff'
    .byte 0xFF              ;ffa9  ff          DATA '\xff'
    .byte 0xFF              ;ffaa  ff          DATA '\xff'
    .byte 0xFF              ;ffab  ff          DATA '\xff'
    .byte 0xFF              ;ffac  ff          DATA '\xff'
    .byte 0xFF              ;ffad  ff          DATA '\xff'
    .byte 0xFF              ;ffae  ff          DATA '\xff'
    .byte 0xFF              ;ffaf  ff          DATA '\xff'
    .byte 0xFF              ;ffb0  ff          DATA '\xff'
    .byte 0xFF              ;ffb1  ff          DATA '\xff'
    .byte 0xFF              ;ffb2  ff          DATA '\xff'
    .byte 0xFF              ;ffb3  ff          DATA '\xff'
    .byte 0xFF              ;ffb4  ff          DATA '\xff'
    .byte 0xFF              ;ffb5  ff          DATA '\xff'
    .byte 0xFF              ;ffb6  ff          DATA '\xff'
    .byte 0xFF              ;ffb7  ff          DATA '\xff'
    .byte 0xFF              ;ffb8  ff          DATA '\xff'
    .byte 0xFF              ;ffb9  ff          DATA '\xff'
    .byte 0xFF              ;ffba  ff          DATA '\xff'
    .byte 0xFF              ;ffbb  ff          DATA '\xff'
    .byte 0xFF              ;ffbc  ff          DATA '\xff'
    .byte 0xFF              ;ffbd  ff          DATA '\xff'
    .byte 0xFF              ;ffbe  ff          DATA '\xff'
    .byte 0xFF              ;ffbf  ff          DATA '\xff'
    .word reset_e012        ;ffc0  e0 12       VECTOR callv #0
    .word reset_e012        ;ffc2  e0 12       VECTOR callv #1
    .word reset_e012        ;ffc4  e0 12       VECTOR callv #2
    .word reset_e012        ;ffc6  e0 12       VECTOR callv #3
    .word reset_e012        ;ffc8  e0 12       VECTOR callv #4
    .word reset_e012        ;ffca  e0 12       VECTOR callv #5
    .word reset_e012        ;ffcc  e0 12       VECTOR callv #6
    .word reset_e012        ;ffce  e0 12       VECTOR callv #7
    .word 0xffff            ;ffd0  ff ff       VECTOR irq15 (unused)
    .word 0xffff            ;ffd2  ff ff       VECTOR irq14 (unused)
    .word 0xffff            ;ffd4  ff ff       VECTOR irq13 (unused)
    .word 0xffff            ;ffd6  ff ff       VECTOR irq12 (unused)
    .word 0xffff            ;ffd8  ff ff       VECTOR irq11 (unused)
    .word 0xffff            ;ffda  ff ff       VECTOR irq10 (unused)
    .word 0xffff            ;ffdc  ff ff       VECTOR irqf (unused)
    .word 0xffff            ;ffde  ff ff       VECTOR irqe (unused)
    .word 0xffff            ;ffe0  ff ff       VECTOR irqd (unused)
    .word 0xffff            ;ffe2  ff ff       VECTOR irqc (unused)
    .word reset_e012        ;ffe4  e0 12       VECTOR irqb (unused)
    .word reset_e012        ;ffe6  e0 12       VECTOR irqa (timebase timer)
    .word reset_e012        ;ffe8  e0 12       VECTOR irq9 (a/d converter)
    .word reset_e012        ;ffea  e0 12       VECTOR irq8 (8-bit serial I/O #2)
    .word irq7_e0cb         ;ffec  e0 cb       VECTOR irq7 (8-bit serial I/O #1)
    .word irq6_e0dd         ;ffee  e0 dd       VECTOR irq6 (16-bit timer/counter)
    .word irq5_e0ef         ;fff0  e0 ef       VECTOR irq5 (pulse width count timer)
    .word irq4_e163         ;fff2  e1 63       VECTOR irq4 (8-bit pwm timer)
    .word irq3_e175         ;fff4  e1 75       VECTOR irq3 (external interrupt #3)
    .word irq2_e187         ;fff6  e1 87       VECTOR irq2 (external interrupt #2)
    .word reset_e012        ;fff8  e0 12       VECTOR irq1 (external interrupt #1)
    .word irq0_e199         ;fffa  e1 99       VECTOR irq0 (external interrupt #0)
    .byte 0xFF              ;fffc  ff          DATA '\xff'
    .byte 0x00              ;fffd  00          DATA '\x00'
    .word reset_e012        ;fffe  e0 12       VECTOR reset
