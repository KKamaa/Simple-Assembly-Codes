%include 'functions.asm'
section .data
design db '***********************',0h
msg db 'Even Numbers',0h

section .text
global _start

_start:

decorate:
mov eax,design
call sprintLF
mov eax,msg
call sprintLF
mov eax,design
call sprintLF
mov ecx,1



even:
cmp ecx,20
je exit
mov eax,ecx
mov ebx,2
div ebx
mov esi,edx
cmp esi,0
je printf
inc ecx
jmp even


printf:
mov eax,ecx
call iprintLF
inc ecx
jmp even

exit:
call quit



