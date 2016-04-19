%include 'functions.asm'

section .text
global _start

_start:
mov ecx,9
mov esi,2

prime:
inc ecx
call checkPrime
cmp ecx,50
jne prime
call quit





checkPrime:
mov eax,ecx
div esi
mov ebx,edx
cmp ebx,0
je prime
cmp esi,ecx
jne nextvalue
mov eax,ecx
call iprintLF
ret

nextvalue:
inc esi
jmp checkPrime
