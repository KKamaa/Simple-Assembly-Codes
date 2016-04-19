.text
.globl _start
_start:
pushl %ebp
movl %esp,%ebp
subl $20,%esp           #Space for sockaddr_in (16 bytes) and socket descriptor (4 bytes)
pushl $host
call gethostbyname      #Return hostent of "towel.blinkenlights.nl"
movl 16(%eax),%eax      #Get hostent.h_addr_list (array of pointers to in_addr's)
movl (%eax),%eax        #Get h_addr_list[0]
movl (%eax),%eax        #Dereference this pointer to the in_addr
movl %eax,-12(%ebp)     #Put it in our sockaddr_in.sin_addr
movw $2,-16(%ebp)       #sockaddr_in.sin_family = AF_INET
movl $0,%ecx				
movw $666,%cx           #Zero-extended ushort port number
movl %ecx,(%esp)
call htons              #Convert to network-byte order
movw %ax,-14(%ebp)      #Place it in sockaddr_in.sin_port
movl $0,-8(%ebp)			
movl $0,-4(%ebp)        #Zero out sockaddr_in.sin_zero
subl $8,%esp            #More arg space for socket() 
movl $2,(%esp)          #AF_INET
movl $1,4(%esp)         #SOCK_STREAM
movl $6,8(%esp)         #IPPROTO_TCP
call socket             #Create socket
cmpl $-1,%eax
je fail                 #Returns -1 on fail
movl %eax,-20(%ebp)     #Otherwise save socket descriptor.
movl %eax,(%esp)        #It's already in eax, load it as arg for connect
leal -16(%ebp),%ebx     #Address of our sockaddr_in
movl %ebx,4(%esp)       #2nd arg for connect
movl $16,8(%esp)        #Size of sockaddr_in
call connect
cmpl $0,%eax
jnz fail                #If not 0, fail
subl $244,%esp          #16 for sockaddr, 4 for sockfd, 12 for temp func args plus 244 for
movl %esp,%esi          #a 256 byte buffer
movl -20(%ebp),%ebx     #Load socket descriptor
subl $16,%esp           #More arg space on top of 256 byte buffer
movl %ebx,(%esp)        #sockfd
movl %esi,4(%esp)       #buffer pointer
movl $256,8(%esp)       #Length of buffer
movl $0,12(%esp)        #Socket flags
call recv               #recv data 2 times since
call recv               #first data sent by server is not the ascii message
addl $4,%esp            #Pop off sockfd arg to reveal buffer pointer arg on top
call puts               #Print it
movl -20(%ebp),%ebx
movl %ebx,(%esp)        #Load and push sockfd as arg
movl $2,4(%esp)         #Shutdown both send and recv
call shutdown
call close              #sockfd already on top, close this sockfd
movl $0,(%esp)
call exit

fail:
pushl $errmsg
call puts
pushl $1
call exit

.data
host: .asciz "towel.blinkenlights.nl"
errmsg: .asciz "Something bad happened."
