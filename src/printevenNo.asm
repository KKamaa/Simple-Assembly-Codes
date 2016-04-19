section .bss
res resb 4

section .text
global _start

_start:

mov ecx,0

cloop:
inc ecx
call checkeven
cmp ecx,0x9
jne cloop

exit:
mov eax,1
int 80h

checkeven:
push eax
push ecx
push ebx
mov eax,ecx
mov ebx,0x2
idiv ebx
push edx
mov eax,esp
cmp eax,0x0
jne cloop
mov [res],ecx
call printf
pop ebx
pop edx
pop ecx
pop eax
ret

printf:
mov ecx,res
add ecx,48
mov eax,4
mov ebx,1
mov edx,4
int 80h
ret

