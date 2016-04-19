;Program to print Fibonacci series
%include 'functions.asm'

section .data
input db "Enter range:",0h
fiboseries db "Fibonacci series of range ",0h
line db "-----------------------------------",0h

section .bss
;reservered variables spaces
first 	resb 2
second 	resb 2
next   	resb 2
range	resb 2




section .text
global _start

_start:
;------------------------------------
;User prompt
mov eax,input
call sprint
;------------------------------------
;user input range
call getInput
;------------------------------------
;range display
mov eax,fiboseries
call sprint
;------------------------------------
;display user range
mov eax,range
call sprintLF
;------------------------------------
;formatting line
mov eax,line
call sprintLF
;------------------------------------

;conver range to integer and re-assign
mov eax,[range]
sub eax,48
mov [range],eax

;assign prime values
mov ecx,0
mov byte[first],0
mov byte[second],1

main:
;compare if we have reached the range.
cmp ecx,[range]
je exit      ;if equal exit program
;if not, lets loop making fibonnacci series :-)
;assign values of the first,second to the next
mov ebx,[first]
mov edx,[second]

;save the values on the stack for future assignment
push ebx
push edx

;get the next value by adding first+second=next
add edx,ebx
mov [next],edx

;print 
mov eax,[next]

;save the "next" value on the stack for future assigning
push eax

;iprintLF only prints integers not string chars
call iprintLF


;restore all the values
;first,second,next for assinging

pop eax
pop edx
pop ebx

;re-assign the values interchanging
;first=second
;second=next
;loop!

mov [first],edx	;first=second
mov [second],eax;second=next
inc ecx			;increment counter by one
jmp main    	;loop again for comparison  


;end the program
exit:
call quit

;function to get user input for the range
getInput:
mov eax,3
mov ebx,2
mov ecx,range
mov edx,2
int 80h
ret
