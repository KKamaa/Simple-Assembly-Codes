%include 'functions.asm'

section .data
msg db 'Hello World';string to be encrypted
key db 'abcdefghijk';key
encrypt db 'Encrypted text is:',0h
decrypt db 'Decrypted text is:',0h

section .bss
res resb 11 ;space allocated for encrypted string
des resb 11;

section .text
global _start

_start:
mov ecx,0;loop counter

xorEncrypt:
mov eax,[msg+ecx];byte char of plaintext
mov ebx,[key+ecx];byte char of key
sub eax,48
sub ebx,48
xor eax,ebx      ;Xor encryption on char
add eax,48       ;convert to ascii text
mov [res+ecx],eax;save char on allocated memory per index 0-9
xor eax,eax        ;clear register
inc ecx          ;increment counter by 1
cmp ecx,11       ;compare if counter is equal to 10
jne xorEncrypt   ;if not go back to loop

mov eax,encrypt
call sprint

mov eax,res      ;else print encypted string
call sprintLF

;clear registers
xor eax,eax
xor ebx,ebx
xor ecx,ecx

;reverse,decrypt the text 
xorDecrypt:
mov eax,[res+ecx];byte char of plaintext
mov ebx,[key+ecx];byte char of key
sub eax,48
sub ebx,48
xor eax,ebx      ;Xor encryption on char
add eax,48       ;convert to ascii text
mov [des+ecx],eax;save char on allocated memory per index 0-9
xor eax,eax        ;clear register
inc ecx          ;increment counter by 1
cmp ecx,11       ;compare if counter is equal to 10
jne xorDecrypt   ;if not go back to loop

mov eax,decrypt
call sprint

mov eax,des
call sprintLF

call quit        ;end program





