CR		EQU	0DH
LF		EQU	0AH
MAX_SIZE	EQU	10
.MODEL	SMALL
.STACK		100H
.DATA

array 		DW	10 DUP (?)
prompt_msg	DB	'Enter single digit non-zero integers to be sorted.', CR, LF     ; CR=13 and LF=10 are defined in the first two statements
		DB	'Enter zero to terminate the input (at most 10).', CR, LF, '$'
output_msg	DB	'Array of numbers in sorted order:', CR, LF, '$'  
nwln        	DB  	CR, LF, '$'

.CODE

main	PROC
	.STARTUP  	
	
	mov 	ah, 09h
	lea 	dx, prompt_msg
	int 	21h
		
	mov	bx, OFFSET array        	; load address of array to bx
	mov	cx, MAX_SIZE
	sub	dx, dx                  		; clear dx     
	
rd_loop: 
    	mov 	ah, 01h
    	int 	21h 
   	sub 	al, 30h                 	; converting char to num
    	mov 	ah, 0                   		; clearing ah, so that value of ax is the same as value of al.
	
	cmp	ax, 0                   		; if value is not 0, continue reading else exit
	je	stop_read
	mov	[bx], ax
	add	bx, 2
	inc	dx		                ; increment no. of integers
	loop	rd_loop    
	
stop_read:
	push	dx		            	; push no. of integers (pass by value)  
	mov	cx, dx 
	push	OFFSET array	    	; push array pointer (pass by reference)
	call	bubble_sort	        	; call bubble sort procedure
	
	mov 	ah, 09h
	lea 	dx, output_msg
	int 	21h
	
	
	mov	bx, OFFSET array
                    
	
prt_loop:			; print sorted array
	mov 	ah, 02h
	mov 	dx, [bx]                ; since it is a single-digit number value of dx is same as value of dl 
	add 	dl, 30h
	int 	21h
	
	mov 	ah, 09h
	lea 	dx, nwln
	int 	21h
	
	add	bx, 2                   		; increment bx by 2 because every array location is of 2 bytes
	loop	prt_loop

	mov 	ah ,4ch
       	mov 	al ,0
       	int 	21h
main	ENDP

SORTED		EQU	0
UNSORTED	EQU	1
bubble_sort	PROC
	pusha				; push all register values
	mov	bp, sp
	mov	cx, [bp+20]		; transfer no. of integers to cx
	mov	bx, [bp+18]		; and integer array address to bx
; Bottom 16 locations in stack are occupied by the saved 
; contents of 8 registers (ax, bx, cx, dx, sp, bp, si, di)

lp_outer:
	dec	cx
	jz	done			; if cx=0, done
	mov	di, cx			; else another iteration
	mov	dx, SORTED		; assume status of array as sorted
	mov	si, bx			; transfer array address to si

lp_inner:
	mov	ax, [si]
	cmp	ax, [si+2]
	jg	swap			; swap if integer at [si]> at [si+2]

resume:
	add	si, 2
	dec	di
	jnz	lp_inner
	cmp	dx, SORTED
	je	done
	jmp	lp_outer

swap:	
	xchg	ax, [si+2]		; swap integers at [si] and [si+2]
	mov	[si], ax
	mov	dx, UNSORTED		; mark status of array as unsorted
	jmp	resume

done:
	popa				; pop to respective register locations
	ret	4
bubble_sort	ENDP

END main
