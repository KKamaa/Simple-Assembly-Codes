;args passed to an asm prog are loaded in reverse order
;The name of the program is then loaded onto the stack 
;and lastly the total number of arguments is loaded onto the stack.
section .text
global _start

_start:
;The last two stack items for a NASM compiled program 
;are always the name of the program and the number of
;passed arguments,pop the first value, no of args from stack
pop ecx

;iterate through the args
nextarg:
	cmp ecx,0h
	jz exit ;if equal exit program
	pop eax  ; pop the next argument off the stack
	call createdirs ;call createDirs func
	dec ecx ;mov to next arg.You dec ecx by 1
	jmp nextarg ;iterate


;create dirs function
createdirs:

;save registers
push ebx 
push ecx
push eax

mov ebx,eax ;get dirname 
mov ecx,0666 ;add file permission e.g. 0777
mov eax,39 ;sys_mkdir
int 80h;call kernel

;restore registers
pop eax ;pop registers in LIFO order
pop ecx
pop ebx
ret

;exit prog
exit:
mov eax,1
int 80h

