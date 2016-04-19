section .data
cmd db '/usr/bin/wget', 0h
argArray    dd      cmd
            dd      arg               
            dd      0h 
env dd 0h            

section .bss
arg resd 1

section .text
global _start

_start:
pop ecx; first argument is always number of args,we pop it!

main:
pop eax
mov [arg],eax   ;url arg
xor  eax,eax
mov  edx, env     
mov  ecx, argArray 
mov  ebx, cmd      
mov  eax, 11       
int  80h
 
mov  eax,1
int  80h

