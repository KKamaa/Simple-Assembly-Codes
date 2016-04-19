%include 'wap2k.asm'
section .bss
number: resb    1
 
 
section .text
global _start
_start:
 
; Init to 0
xor eax, eax
 
tenloop:
    inc ecx          ; Incriment    
    mov eax, ecx     ; Move CX to AX to comparison 
    and eax,1        ; Test bit 1 (odd number = 1)
    cmp eax, 0       ; Compare to zero
    jne tenloop
    mov eax, ecx
    add eax,48       ; number + 48 = ascii number+index
    call sprintLF    ; call your print function 
    cmp ecx,8       ; did the counter reach 10? 
jne tenloop
 
end:
call quit
