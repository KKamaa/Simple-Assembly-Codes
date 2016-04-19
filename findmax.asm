%include 'functions.asm'

section .data
msg db "The max value is:",0h
array:
dd 39
dd 80
dd 77
dd 100




section .bss
max resd 1

section .text
global _start

_start:
mov ebx,0
mov dword[max],0

main:
cmp ebx,12
je exit
mov ecx,dword[array+ebx]
cmp ecx,dword[max]
jl next
mov dword[max],ecx
jmp next

next:
add ebx,4
jmp main



exit:
mov eax,msg
call sprint
mov eax,[max]
call iprintLF
call quit



