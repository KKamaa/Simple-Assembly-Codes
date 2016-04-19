;------------------------------------------
; void iprint(Integer number)
; Integer printing function (itoa)
iprint:
    push    eax             ; preserve eax on the stack to be restored after function runs
    push    ecx             ; preserve ecx on the stack to be restored after function runs
    push    edx             ; preserve edx on the stack to be restored after function runs
    push    esi             ; preserve esi on the stack to be restored after function runs
    mov     ecx, 0          ; counter of how many bytes we need to print in the end
  
divideLoop:
    inc     ecx             ; count each byte to print - number of characters
    mov     edx, 0          ; empty edx
    mov     esi, 10         ; mov 10 into esi
    idiv    esi             ; divide eax by esi
    add     edx, 48         ; convert edx to it's ascii representation - edx holds the remainder after a divide instruction
    push    edx             ; push edx (string representation of an intger) onto the stack
    cmp     eax, 0          ; can the integer be divided anymore?
    jnz     divideLoop      ; jump if not zero to the label divideLoop
  
printLoop:
    dec     ecx             ; count down each byte that we put on the stack
    mov     eax, esp        ; mov the stack pointer into eax for printing
    call    sprint          ; call our string print function
    pop     eax             ; remove last character from the stack to move esp forward
    cmp     ecx, 0          ; have we printed all bytes we pushed onto the stack?
    jnz     printLoop       ; jump is not zero to the label printLoop
  
    pop     esi             ; restore esi from the value we pushed onto the stack at the start
    pop     edx             ; restore edx from the value we pushed onto the stack at the start
    pop     ecx             ; restore ecx from the value we pushed onto the stack at the start
    pop     eax             ; restore eax from the value we pushed onto the stack at the start
    ret
  
  
;------------------------------------------
; void iprintLF(Integer number)
; Integer printing function with linefeed (itoa)
iprintLF:
    call    iprint          ; call our integer printing function
  
    push    eax             ; push eax onto the stack to preserve it while we use the eax register in this function
    mov     eax, 0Ah        ; move 0Ah into eax - 0Ah is the ascii character for a linefeed
    push    eax             ; push the linefeed onto the stack so we can get the address
    mov     eax, esp        ; move the address of the current stack pointer into eax for sprint
    call    sprint          ; call our sprint function
    pop     eax             ; remove our linefeed character from the stack
    pop     eax             ; restore the original value of eax before our function was called
    ret
  
  
;------------------------------------------
; int slen(String message)
; String length calculation function
slen:
    push    ebx
    mov     ebx, eax
  
nextchar:
    cmp     byte [eax], 0
    jz      finished
    inc     eax
    jmp     nextchar
  
finished:
    sub     eax, ebx
    pop     ebx
    ret
  
  
;------------------------------------------
; void sprint(String message)
; String printing function
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen
  
    mov     edx, eax
    pop     eax
  
    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     80h
  
    pop     ebx
    pop     ecx
    pop     edx
    ret
  
  
;------------------------------------------
; void sprintLF(String message)
; String printing with line feed function
sprintLF:
    call    sprint
  
    push    eax
    mov     eax, 0AH
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax
    pop     eax
    ret
  
  
;------------------------------------------
; void exit()
; Exit program and restore resources
quit:
    mov     ebx, 0
    mov     eax, 1
    int     80h
    ret

;Expected output e.g range=9
;0,1,1,2,3,5,8,13,21,34,55
;
;%include 'functions.asm'
 
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
