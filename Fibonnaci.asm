%include 'functions.asm'
 
section .data
input db "Enter range:",0h
fiboseries db "Fibonacci series of range: ",0h
line db "-----------------------------------",0h
comma db ","
end db "",0h
 
section .bss
;reservered variables spaces
first   resd 1
second  resd 1
next    resw 1
range   resw 1
count   resw 1
section .text
global _start
 
_start:
 
; User prompt
;mov eax,input
;call sprint
 
; Print range message and input
	mov eax,fiboseries
	call sprint
; Get Input failed manually enter range
	mov eax, 10
	mov [range], eax
	mov ecx,range
	call iprintLF
 
; initilise primes
	mov ebx,0
	mov dword[first],0
	mov dword[second],1
 
main_loop:
	inc ebx
 
		mov eax, dword[first]
		call iprint
		mov eax,comma
		call sprint
 
		mov eax, dword[second]
		call iprint
		mov eax,comma
		call sprint
 
		mov eax, dword[second]
		add dword[first],eax
 
		mov eax, dword[first]
		add dword[second],eax
 
	cmp ebx,[range] 
jne main_loop
 
 
exit:
	mov eax,end
	call sprintLF
	call quit
 
getInput:
	mov eax,3
	mov ebx,2
	mov ecx,range
	mov edx,2
	int 80h
ret
