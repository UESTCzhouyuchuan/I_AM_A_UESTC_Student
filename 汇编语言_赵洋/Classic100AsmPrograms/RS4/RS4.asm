;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
; by Loomman, QQ:28077188, MSN: Loomman@hotmail.com QQ裙：30515563
; RS4.asm
;－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
;一个两ＰＣ间的串口通信程序

data segment
	message	 db	'Serial communication via COM2,4800,no p,1 stop,8 bit data.',0ah,0dh
		 db	'Any key press is sent to other PC',0ah,0dh
		 db	'Press ESC to exit','$'
data ends

code segment
	assume	cs:code, ds:data

main proc far

start:
	push	ds
	sub	ax, ax
	push	ax

	mov	ax, data
	mov	ds, ax

	mov	ah, 9
	mov	dx, offset message
	int	21h

	call	ConfigComm

	call	CommAction
	
	ret
main endp

ConfigComm proc near
	
	;Initialize COM2
	mov	ah, 0		;initialize COM port
	mov	dx, 1		;COM2
	mov	al, 0c3h	;4800, n, 1, 8
	int	14h             ;call BIOS

	ret
ConfigComm endp

CommAction proc near
	
	;Checking key press and sending key to COM2 to be transferred
again:
	mov	ah, 01		;get keyboard state
	int	16h		;for checking key press
	jz	next		;if ZF = 1,there is no key press
	mov	ah, 0		;there is a key press, get it
	int	16h		;call BIOS

	;with AH = 0 to get the char itself. AL=ASCII char pressed
	cmp	al, 1bh		;is it ESC key
	je	exit		;yes, exit
	mov	ah, 1		;no, send the char to comm2
	mov	dx, 1		;COM2
	int	14h		;call BIOS

	;Checking COM2 to see there is char, if so get it and display it
next:
	mov	ah, 3		;read COM states to ah
	mov	dx, 1		;COM2
	int	14h		;call BIOS
	and	ah, 1		;mask all bits except D0
	cmp	ah, 1		;check D0 to see if there is a char
	jne	again		;no char, goto monitor keyboard
	mov	ah, 2		;yes, read char from COM2

	mov	dx, 1
	int	14h

	mov	dl, al		;dl get char to be display
	mov	ah, 2		;display char function
	int	21h		;call DOS
	jmp	again		;keep monitoring keyboard

exit:
	ret
		
CommAction endp

code ends

	end start