; Fizzbuzz
; Compile with: nasm -f elf fizzbuzz.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 fizzbuzz.o -o fizzbuzz
; Run with: ./fizzbuzz
 
%include        'functions.asm'
 
SECTION .data
fizz        db      'Fizz', 0h     ; a message string
buzz        db      'Buzz', 0h     ; a message string
 
SECTION .text
global  _start
 
_start:
 
    mov     esi, 3          ; initialise our checkFizz boolean variable
    mov     edi, 5         ; initialise our checkBuzz boolean variable
    mov     ecx, 1         ; initialise our counter variable
 
 mainloop:
 mov eax,ecx
 call if_Div3
 cmp ecx,20
 je exit
 inc ecx
 jmp mainloop
 
 
 
 
 
if_Div3:
div esi
mov ebx,edx
cmp ebx,0
jne else_if_Div5
mov eax,fizz
call sprintLF
ret

else_if_Div5:
mov eax,ecx
div edi
mov ebx,edx
cmp ebx,0
jne else
mov eax,buzz
call sprintLF
ret

else:
mov eax,ecx
call iprintLF
ret

exit:
call quit
