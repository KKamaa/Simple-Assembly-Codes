;functions.asm file
;------------------------------------------
; void iprint(Integer number)
; Integer printing function (itoa)
 
iprint:
    push eax             ; preserve ax on the stack to be restored after function runs
    push ecx             ; preserve cx on the stack to be restored after function runs
    push edx             ; preserve dx on the stack to be restored after function runs
    push esi             ; preserve si on the stack to be restored after function runs
    mov  ecx, 0          ; counter of how many bytes we need to print in the end
 
    divideLoop:
        inc     ecx             ; count each byte to print - number of characters
        mov     edx, 0          ; empty dx
        mov     esi, 10         ; mov 10 into si
        idiv    esi             ; divide ax by si
        add     edx, 48         ; convert dx to it's ascii representation - dx holds the remainder after a divide instruction
        push    edx             ; push dx (string representation of an intger) onto the stack
        cmp     eax, 0          ; can the integer be divided anymore?
        jnz     divideLoop      ; jump if not zero to the label divideLoop
 
    printLoop:
        dec     ecx            ; count down each byte that we put on the stack
        mov     eax, esp       ; mov the stack pointer into ax for printing
        call    sprint         ; call our string print function
        pop     eax            ; remove last character from the stack to move spforward
        cmp     ecx, 0         ; have we printed all bytes we pushed onto the stack?
        jnz     printLoop      ; jump is not zero to the label printLoop
 
    pop     esi             ; restore si from the value we pushed onto the stack at the start
    pop     edx             ; restore dx from the value we pushed onto the stack at the start
    pop     ecx             ; restore cx from the value we pushed onto the stack at the start
    pop     eax             ; restore ax from the value we pushed onto the stack at the start
ret
 
 
;------------------------------------------
; void iprintLF(Integer number)
; Integer printing function with linefeed (itoa)
 
iprintLF:
    call    iprint          ; call our integer printing function
    push    eax             ; push ax onto the stack to preserve it while we use the ax register in this function
    mov     eax, 0Ah        ; move 0Ah into ax - 0Ah is the ascii character for a linefeed
    push    eax             ; push the linefeed onto the stack so we can get the address
    mov     eax, esp        ; move the address of the current stack pointer into ax for sprint
    call    sprint          ; call our sprint function
    pop     eax             ; remove our linefeed character from the stack
    pop     eax             ; restore the original value of ax before our function was called
    ret
 
 
;------------------------------------------
; int slen(String message)
; String length calculation function
 
slen:
    push    ebx
    mov     ebx, eax
 
nextchar:
    ; cmp    ax, 0
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
    push edx
    push ecx
    push ebx
    push eax ; are number
 
 mov [number], eax
 
    ;call    slen            
    mov edx,1       ; length of string
    mov ecx,number     ; arg2, pointer to string
    mov ebx,1       ; write to screen
    mov eax,4       ; sysout
    int 0x80        ; call kernel interupt        
 
    pop eax
    pop ebx
    pop ecx
    pop edx
ret
 
 
;------------------------------------------
; void sprintLF(String message)
; String printing with line feed function
 
sprintLF:
    call    sprint
    push    eax
    mov     eax, 0AH
    push    eax
    ; mov     eax, esp
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
