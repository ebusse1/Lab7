
movb $0x80, %al   #command word: mode 0, ports should be output
mov $0x643, %dx   #control register
out  %al, %dx     #write command word to control register

inital:
    mov $2b, ax
    mov $1b, bx
    mov $0b, si
    jmp loop

delay: 
    push %cx
    mov $2000, %cx

d1: 
    nop
    loop d1
    popw %cx
    ret

loop:
    mov $0x6D, %al    #write pattern for "S"
    mov $0x641, %dx   #Port B is segment outputs
    out %al, %dx

    mov %ax, %al    #Select digit 2
    mov $0x640, %dx   #Port A is digit select
    out %al, %dx

    call delay #Call the delay function

    mov $0x76, %al    #write pattern for "H"
    mov $0x641, %dx   #Port B is segment outputs
    out %al, %dx

    mov %bx, %al    #Select digit 1
    mov $0x640, %dx   #Port A is digit select
    out %al, %dx

    call delay #Call the delay function

    mov $0x79, %al    #write pattern for "E"
    mov $0x641, %dx   #Port B is segment outputs
    out %al, %dx

    mov %si, %al    #Select digit 0
    mov $0x640, %dx   #Port A is digit select
    out %al, %dx

    call delay #Call the delay function

    inc %ax #Move position of S
    inc %bx #Move position of H
    inc %si #move position of E

    cmp $7, %ax 
    jg inital
    