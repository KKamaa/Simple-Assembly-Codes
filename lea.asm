%include 'functions.asm'
section .data
array: db 12,34,45,67

section .bss
num resb 4

section .text
global _start


_start:
mov eax,array
lea eax,[eax*1]
call iprintLF
mov eax,3
mov ebx,2
mov ecx,num
mov edx,5
int 80h

exit:
mov eax,1
int 80h
