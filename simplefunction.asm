section .bss
res resb 2
numb resb 2

section .text
global _start



_start:
mov eax,3
mov ebx,2
mov ecx,res
mov edx,2
int 80h

call addconst

mov ecx,numb
mov eax,4
mov edx,2
mov ebx,1
int 80h

mov eax,1
int 80h

addconst:
mov eax,0x2
mov ebx,[res]
sub ebx,48
add eax,ebx
add eax,'0'
mov [numb],eax
ret

