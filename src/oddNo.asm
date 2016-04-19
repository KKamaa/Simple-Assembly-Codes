%include 'functions.asm'

section .data
line db '--------------------------',0h
msg db 'ODD NUMBERS:',0h

section .text
global _start

_start:
mov eax,line
call sprintLF
mov eax,msg
call sprintLF
mov eax,line
call sprintLF

mov ecx,0
mov esi,2

main:
cmp ecx,40
je exit
inc ecx
call checkOddNo
jmp main

checkOddNo:
mov eax,ecx
div esi
mov ebx,edx
cmp ebx,0
je main
xor eax,eax
mov eax,ecx
call iprintLF
ret

exit:
call quit



