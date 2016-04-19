%include 'functions.asm'

section .data
title db  "Ceasar Cipher!",0h
format db "-------------------------------------------",0h
msg db "Plaintext string is:",0h
plaintext db  "Love Assembly programming",0h
stringlen db "String length is:",0h
ciphertext db "Encrypted text:",0h
key db 3
alphabet: db 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'
   
section .bss
strlen db 2 
ciphertext db 254     
             
                
section .text
global _start


_start:
;Title of program
mov eax,format
call sprintLF
mov eax,title
call sprintLF
mov eax,format
call sprintLF

;print the plaintext
mov eax,msg
call sprint
mov eax,plaintext
call sprintLF

;get plaintext length and print it
mov eax,plaintext
call slen
push eax
mov eax,stringlen
call sprint
pop eax
mov [strlen],eax
call iprintLF


assign:
mov ebx,0
jmp getpos

getpos:
cmp [alphabet+ebx],eax
je pos
inc ebx
jmp getpos

pos:
push ebx
ret

Encrypt:
mov edx,0
cmp [strlen],ecx
je exit
mov eax,byte[plaintext+edx]
call getpos
pop e


exit:
call quit









   
