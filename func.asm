strlen:
mov eax,ecx

len:
add eax,1
cmp eax,0
jmp len
ret

