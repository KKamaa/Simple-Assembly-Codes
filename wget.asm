SECTION .data
cmd         db      '/usr/bin/wget', 0h     ; command to execute
arg0        db      'https://ftp.mozilla.org/pub/firefox/nightly/latest-mozilla-aurora/firefox-46.0a2.en-US.linux-i686.tar.bz2', 0h
argArray    dd      cmd
            dd      arg0               ; arguments to pass to commandline (in this case just one)
            dd      0h                  ; end the struct
envVar  dd      0h                  ; arguments to pass as environment variables (inthis case none) end the struct
 
SECTION .text
global  _start
 
_start:
 
    mov     edx, envVar   ; address of environment variables
    mov     ecx, argArray ; address of the arguments to pass to the commandline
    mov     ebx, cmd      ; address of the file to execute
    mov     eax, 11       ; invoke SYS_EXECVE (kernel opcode 11)
    int     80h
 
    mov eax,1
    int 80h
