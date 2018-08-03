comment $
Life Is Stranger
Luke Clark M. Andrada
$
.model small
.stack 100
include life.txt
.data
	comment $
	set color constants
	$

	black		equ		0h
	white		equ		0fh
	lgray		equ		7h
	dgray		equ		8h
	blue		equ		9h
	cyan		equ		0bh
	lviolet		equ		0dh
	dviolet		equ		5h
	blacktxt	equ		0ffh
	bluetxt		equ		0f6h
	cyantxt		equ		0f4h
	lviolettxt	equ		0f2h

	comment $
	declaration of reference and offset coordinates
	$

	xref		dw		?
	yref		dw		?
	xrefx		dw		?
	yrefx		dw		?

	comment $
	declaration of general status flags
	$

	counth		dw		1
	counthd		dd		0
	face		db		0
	index		dw		0
	level		db		0
	extent		db		0
	go		dw		0
	convox		db		0
	countluna	dw		0
	colorx		db		?
	handle		dw		?
	bufferx		dw		?

	comment $
	declaration of objective strings
	$

	txt00		db		"objective"
	txt01		db		"find her laptop, phone, and list"
	txt02		db		"find the owner, cashier, and buddy"
	txt03		db		"find her"
	txt04		db		"find beyond the cliff, to the stars, and your infinity"
	txt05		db		"find the exit"
	txt06		db		"find you"
	txt07		db		"forget or accept"
	txt08		db		"who are you?"
	txt09		db		"thank you"

	comment $
	declaration of character and find strings
	$

	txt10		db		"you   "

	txt21		db		"faye  "
	txt22		db		"levi  "
	txt23		db		"ynna  "
	txt24		db		"tyler "
	txt25		db		"arya  "
	txt26		db		"fltch "
	txt27		db		"max   "
	txt28		db		"tali  "

	txt31		db		"garus "
	txt32		db		"wrex  "
	txt33		db		"pheob "
	txt34		db		"ellie "
	txt35		db		"bing  "
	txt36		db		"chloe "
	txt37		db		"joey  "
	txt38		db		"beth  "

	txt41		db		"book  "

	txt51		db		"lctr  "

	txt61		db		"laptop"
	txt62		db		"phone"
	txt63		db		"list"
	txt64		db		"owner"
	txt65		db		"cashier"
	txt66		db		"buddy"
	txt67		db		"beyond the cliff"
	txt68		db		"to the stars"
	txt69		db		"your infinity"

	comment $
	declaration of voice strings and files
	declaration of level interaction status flags
	$

	txt001		db		"inst.txt", 0
	txt002		db		"luna.txt", 0
	txt003		db		"lunax.txt", 0

	txt100		db		"you can't interact that far, twit."
	txt100x		db		2655 dup (?)

	txt101		db		"txt101.txt", 0
	txt102		db		"txt102.txt", 0
	txt103		db		"txt103.txt", 0
	txt104		db		"txt104.txt", 0
	txt105		db		"txt105.txt", 0
	txt106		db		"txt106.txt", 0
	txt107		db		"txt107.txt", 0
	txt108		db		"txt108.txt", 0
	txt109		db		"txt109.txt", 0
	txt110		db		"txt110.txt", 0
	txt111		db		"txt111.txt", 0
	txt112		db		"txt112.txt", 0
	txt113		db		"txt113.txt", 0

	level1x		dw		0

	txt201		db		"txt201.txt", 0
	txt202		db		"txt202.txt", 0
	txt203		db		"txt203.txt", 0
	txt204		db		"txt204.txt", 0
	txt205		db		"txt205.txt", 0
	txt206		db		"txt206.txt", 0
	txt207		db		"txt207.txt", 0
	txt208		db		"txt208.txt", 0
	txt209		db		"txt209.txt", 0
	txt210		db		"txt210.txt", 0
	txt211		db		"txt211.txt", 0

	level2x		dw		0

	txt301		db		"txt301.txt", 0
	txt302		db		"txt302.txt", 0
	txt303		db		"txt303.txt", 0
	txt304		db		"txt304.txt", 0
	txt305		db		"txt305.txt", 0
	txt306		db		"txt306.txt", 0
	txt307		db		"txt307.txt", 0
	txt308		db		"txt308.txt", 0
	txt309		db		"txt309.txt", 0
	txt310		db		"txt310.txt", 0
	txt311		db		"txt311.txt", 0
	txt312		db		"txt312.txt", 0
	txt313		db		"txt313.txt", 0

	txt32c		db		"locked!"
	txt32d		db		"no!"
	txt32e		db		"shit!"

	level3x		dw		0

	txt401		db		"txt401.txt", 0
	txt402		db		"txt402.txt", 0
	txt403		db		"txt403.txt", 0
	txt404		db		"txt404.txt", 0
	txt405		db		"txt405.txt", 0
	txt406		db		"txt406.txt", 0
	txt407		db		"txt407.txt", 0
	txt408		db		"txt408.txt", 0
	txt409		db		"txt409.txt", 0

	level4x		dw		0

	txt501		db		"txt501.txt", 0
	txt502		db		"txt502.txt", 0
	txt503		db		"txt503.txt", 0

	level5x		dw		0

	inputx		db		5 dup(32)
	input		db		6, 6 dup(32)
.386
.code
begin proc far
levelz:
	call init
	levelx:
		call hidec
		call clear
		call drawlevelx
		call clicklevelx
	level1:
		call hidec
		call clear
		call drawlevel1
		jmp start
	level2:
		call hidec
		call clear
		call drawlevel2
		jmp start
	level3:
		call hidec
		call clear
		call drawlevel3
		jmp start
	level4:
		call hidec
		call clear
		call drawlevel4
		jmp start
	level5:
		call hidec
		call clear
		call drawlevel5

start:
	getkey:
		mov ah, 11h							; check key buffer
		int 16h
		jz getbutton							; if no content then check button click
		mov counthd, 0							; clear hide cursor delay counter
		mov ah, 10h							; clear key buffer
		int 16h

		cmp ah, 72							; check scan code
		jz upx								; if up then do up
		cmp al, 119							; check ascii code
		jz upx								; if w then go up
		cmp ah, 80							; check scan code
		jz downx							; if down then do down
		cmp al, 115							; check ascii code
		jz downx							; if s then do down
		cmp ah, 75							; check scan code
		jz leftx							; if left then do left
		cmp al, 97							; check ascii code
		jz leftx							; if a then go do left
		cmp ah, 77							; check scan code
		jz rightx							; if right then do right
		cmp al, 100							; check ascii code
		jz rightx							; if d then do right
		cmp ah, 1							; check scan code
		jz escapex							; if escape then go back
		cmp al, 32							; check ascii code
		jz spacex							; if space then show cursor
		cmp ah, 59							; check scan code
		jz level1							; if F1 then go to level1
		cmp ah, 60							; check scan code
		jz level2							; if F2 then go to level2
		cmp ah, 61							; check scan code
		jz level3							; if F3 then go to level3
		cmp ah, 62							; check scan code
		jz level4							; if F4 then go to level4
		cmp ah, 63							; check scan code
		jz level5							; if F5 then go to level5
		jmp getkey							; otherwise check key
	getbutton:
		inc counthd							; increment hide cursor delay counter
		cmp counthd, 01ffffh						; check hide cursor delay counter
		jz spacex							; if extent then show cursor

		mov ax, 5h							; get button click status
		mov bx, 0h							; set left click status
		int 33h
		cmp bl, 1							; check left click
		jz checkproxx							; if left click then check x prox
		jmp getkey							; otherwise check key

	checkproxx:
			ref 20 20						; set offset coordinates
			cmp cx, xrefx						; check x coordinates
			jg xdist						; if greater then subtract
			jmp xdistx						; otherwise reverse subtract
		xdist:
			mov ax, cx						; load x click coordinate
			sub ax, xrefx						; subtract x offset coordinate
			cmp ax, 50						; check distance
			jl checkproxy						; if less then check y coordinates
			jmp writeproxerr					; otherwise write error
		xdistx:
			mov ax, xrefx						; load x offset coordinate
			sub ax, cx						; subtract x click coordinate
			cmp ax, 50						; check distance
			jl checkproxy						; if less then check y coordinates
			jmp writeproxerr					; otherwise write error
	checkproxy:
			cmp dx, yrefx						; check y coordinates
			jg ydist						; if greater then subtract
			jmp ydistx						; otherwise reverse subtract
		ydist:
			mov ax, dx						; load y click coordinate
			sub ax, yrefx						; subtract y offset coordinate
			cmp ax, 50						; check distance
			jl checkxy						; if less then check coordinates
			jmp writeproxerr					; otherwise write error
		ydistx:
			mov ax, yrefx						; load y offset coordinate
			sub ax, dx						; subtract y click coordinate
			cmp ax, 50						; check distance
			jl checkxy						; if less then check y coordinates
			jmp writeproxerr					; otherwise write error
	writeproxerr:
		lea ax, txt100							; load prox error
		setwrite bluetxt txt10 ax 34
		jmp getkey							; check key
	checkxy:
			cmp level, 1						; check level
			jz clicklevel1x						; if level1 then do clicklevel1
			cmp level, 2						; check level
			jz clicklevel2x						; if level2 then do clicklevel2
			cmp level, 3						; check level
			jz clicklevel3x						; if level3 then do clicklevel3
			cmp level, 4						; check level
			jz clicklevel4x						; if level4 then do clicklevel4
			jmp clicklevel5x						; otherwise then do clicklevel5
		clicklevel1x:
			call clicklevel1
			jmp getkey
		clicklevel2x:
			call clicklevel2
			jmp getkey
		clicklevel3x:
			call clicklevel3
			jmp getkey
		clicklevel4x:
			call clicklevel4
			jmp getkey
		clicklevel5x:
			call clicklevel5
			jmp getkey

	upx:
			call hidec
			inc counth						; increment hide cursor counter
			cmp level, 5						; check level
			jnz checkfaceup						; if not level5 then check face
			bt level5x, 0						; otherwise check find bit
			jc checkfaceup						; if set then check face
			bt level5x, 15						; check end bit
			jc checkfaceup						; if set then check face
			or level5x, 1						; otherwise set find bit
			setwritex txt06 8					; write find objective
		checkfaceup:
			cmp face, 1						; check face
			jz gofaceup						; if face then go face
			mov go, 0						; otherwise clear go
			jmp clearfaceup						; clear face
		gofaceup:
			ref 5 0							; set offset coordinates
			cmp level, 3						; check level
			jz checkgrayup						; if level3 then check gray
			checkpix 30 5 xrefx yrefx white					; otherwise check white
			jmp checkextentup					; check extent
		checkgrayup:
			checkpix 30 5 xrefx yrefx white					; check gray
		checkextentup:
			cmp extent, 1						; check extent
			jz skipfaceup						; if extent then skip face
			mov go, 5						; otherwise set go
		clearfaceup:
			ref 5 5							; set offset coordinates
			cmp level, 3						; check level
			jz cleargrayup						; if level3 then clear gray
			draw 30 30 xrefx yrefx white				; otherwise clear white
			jmp drawfaceup						; draw face
		cleargrayup:
			draw 30 30 xrefx yrefx white				; clear gray
		drawfaceup:
			call drawface1						; draw face
			mov face, 1						; set face
			jmp getkey						; check key
		skipfaceup:
			mov extent, 0						; clear extent
			jmp getkey						; check key
	downx:
			call hidec
			inc counth						; increment hide cursor counter
			cmp level, 5						; check level
			jnz checkfacedown					; if not level5 then check face
			bt level5x, 0						; otherwise check find bit
			jc checkfacedown					; if set then check face
			bt level5x, 15						; check end bit
			jc checkfacedown					; if set then check face
			or level5x, 1						; otherwise set find bit
			setwritex txt06 8					; write find objective
		checkfacedown:
			cmp face, 2						; check face
			jz gofacedown						; if face then go face
			mov go, 0						; otherwise clear go
			jmp clearfacedown					; clear face
		gofacedown:
			ref 5 35						; set offset coordinates
			cmp level, 3						; check level
			jz checkgraydown					; if level3 then check gray
			checkpix 30 5 xrefx yrefx white					; otherwise check white
			jmp checkextendown					; check extent
		checkgraydown:
			checkpix 30 5 xrefx yrefx white				; check gray
		checkextendown:
			cmp extent, 1						; check extent
			jz skifacedown						; if extent then skip face
			mov go, 5						; otherwise set go
		clearfacedown:
			ref 5 5							; set offset coordinates
			cmp level, 3						; check level
			jz cleargraydown					; if level3 then clear gray
			draw 30 30 xrefx yrefx white				; otherwise clear white
			jmp drawfacedown					; draw face
		cleargraydown:
			draw 30 30 xrefx yrefx white				; clear gray
		drawfacedown:
			call drawface2						; draw face
			mov face, 2						; set face
			jmp getkey						; check key
		skifacedown:
			mov extent, 0						; clear extent
			jmp getkey						; check key
	leftx:
			call hidec
			inc counth						; increment hide cursor counter
			cmp level, 5						; check level
			jnz checkfaceleft					; if not level5 then check face
			bt level5x, 0						; otherwise check find bit
			jc checkfaceleft					; if set then check face
			bt level5x, 15						; check end bit
			jc checkfaceleft					; if set then check face
			or level5x, 1						; otherwise set find bit
			setwritex txt06 8					; write find objective
		checkfaceleft:
			cmp face, 3						; check face
			jz gofaceleft						; if face then go face
			mov go, 0 						; otherwise clear go
			jmp clearfaceleft					; clear face
		gofaceleft:
			ref 0 5							; set offset coordinates
			cmp level, 3						; check level
			jz checkgrayleft					; if level3 then check gray
			checkpix 5 30 xrefx yrefx white				; otherwise check white
			jmp checkextentleft					; check extent
		checkgrayleft:
			checkpix 5 30 xrefx yrefx white				; check gray
		checkextentleft:
			cmp extent, 1						; check extent
			jz skipfaceleft						; if extent then skip face
			mov go, 5						; otherwise set go
		clearfaceleft:
			ref 5 5							; set offset coordinates
			cmp level, 3						; check level
			jz cleargrayleft					; if level3 then clear gray
			draw 30 30 xrefx yrefx white				; otherwise clear white
			jmp drawfaceleft					; draw face
		cleargrayleft:
			draw 30 30 xrefx yrefx white				; clear gray
		drawfaceleft:
			call drawface3						; draw face
			mov face, 3						; set face
			jmp getkey						; check key
		skipfaceleft:
			mov extent, 0						; clear extent
			jmp getkey						; check key
	rightx:
			call hidec
			inc counth						; increment hide cursor counter
			cmp level, 5						; check level
			jnz checkfaceright					; if not level5 then check face
			bt level5x, 0						; otherwise check find bit
			jc checkfaceright					; if set then check face
			bt level5x, 15						; check end bit
			jc checkfaceright					; if set then check face
			or level5x, 1						; otherwise set find bit
			setwritex txt06 8					; write find objective
		checkfaceright:
			cmp face, 4						; check face
			jz gofaceright						; if face then go face
			mov go, 0						; otherwise clear go
			jmp clearfaceright					;  clear face
		gofaceright:
			ref 35 5						; set offset coordinates
			cmp level, 3						; check level
			jz checkgrayright					; if level3 then check gray
			checkpix 5 30 xrefx yrefx white				; otherwise check white
			jmp checkextentright					; check extent
		checkgrayright:
			checkpix 5 30 xrefx yrefx white				; check gray
		checkextentright:
			cmp extent, 1						; check extent
			jz skipfaceright					; if extent then skip face
			mov go, 5						; otherwise set go
		clearfaceright:
			ref 5 5							; set offset coordinates
			cmp level, 3						; check level
			jz cleargrayright					; if level 3 then clear gray
			draw 30 30 xrefx yrefx white				; otherwise clear white
			jmp drawfaceright					; draw face
		cleargrayright:
			draw 30 30 xrefx yrefx white				; clear gray
		drawfaceright:
			call drawface4						; draw  face
			mov face, 4h						; set face
			jmp getkey						; check key
		skipfaceright:
			mov extent, 0h						; clear extent
			jmp getkey						; check key

	spacex:
			call showc
			cmp level, 5						; check level
			jnz skipspacex						; if not level5 then check key
			bt level5x, 0						; check find bit
			jnc skipspacex						; if cleared then check key
			and level5x, 65534					; otherwise clear find bit
			setwritex txt03 8					; write find objective
		skipspacex:
			jmp getkey						; check key
	escapex:
		call hidec
		jmp levelx							; go back

exit:
	mov ah, 4ch
	int 21h
begin endp

init proc far
	comment $
	initialize code
	$

	mov ax, @data								; load data segment location
	mov ds, ax								; save to data segment
	mov es, ax								; save to extra segment
	mov ax, 12h								; set video mode to 12h at 640 x 480 px with 16 colors
	int 10h
	ret
init endp

hidec proc far
	comment $
	hide cursor
	$

	cmp counth, 0								; check hide cursor counter
	jnz exithidec								; if not 0 then skip hide cursor
	mov ax, 2h								; otherwise hide cursor
	int 33h
	inc counth								; increment hide cursor counter
	exithidec:
		ret
hidec endp

showc proc far
	comment $
	show cursor
	$

	mov cx, counth								; load hide cursor counter
	cmp cx, 0								; check hide cursor counter
	jz showcloop2								; if 0 then skip show cursor
	showcloop1:
		mov ax, 1h							; otherwise show cursor
		int 33h
		loop showcloop1							; loop show cursor
		mov counth, 0							; clear hide cursor counter
	showcloop2:
		mov counthd, 0							; clear hide cursor delay counter
		ret
showc endp

clear proc far
	comment $
	clear screen
	$

	mov ax, 600h								; scroll the entire pixels up
	mov bh, white								; set the color attribute to white
	mov cx, 0h								; set the upper left coordinate to upper left corner
	mov dx, 1d4fh								; set the lower right coordinate to lower right corner
	int 10h
	ret
clear endp

drawz proc far
	comment $
	draw pixels
	$

	drawzloop2:
		mov si, dx							; set starting x coordinate
		push cx								; save y loop count
		mov cx, bx							; set x loop count
	drawzloop1:
		pusha
		mov ah, 0ch							; draw pixels
		mov al, colorx							; set color attribute
		mov bh, 0h							; set video page
		mov cx, si							; set x coordinate
		mov dx, di							; set y coordinate
		int 10h
		popa
		inc si								; increment x coordinate
		loop drawzloop1							; loop x draw
		pop cx								; load y loop count
		inc di								; increment y coordinate
		loop drawzloop2							; loop y draw
		ret
drawz endp

refz proc far
	comment $
	set offset coordinates
	$

	mov ax, xref								; load x reference coordinates
	add ax, bx								; set x offset coordinates
	mov xrefx, ax								; save x offset coordinates
	mov ax, yref								; load y reference coordinates
	add ax, dx								; set y offset coordinates
	mov yrefx, ax								; save y offset coordinates
	ret
refz endp

checkpixz proc far
	comment $
	check pixels
	$

	checkpixloop2:
		cmp di, 0							; check starting y coordinate
		jle checkpixloop3x						; if or less than 0 then set extent
		cmp di, 400							; check starting y coordinate
		jge checkpixloop3x						; if or greater than 479 then set extent
		mov si, dx							; set starting x coordinate
		push cx								; save y loop count
		mov cx, bx							; set x loop count
	checkpixloop1:
		cmp si, 0							; check starting x coordinate
		jle checkpixloop3						; if or less than 0 then set extent
		cmp si, 639							; check starting x coordinate
		jge checkpixloop3						; if or greater than 639 then set extent
		push bx
		push cx
		push dx
		mov ah, 0dh							; read pixels
		mov bh, 0h							; set video page
		mov cx, si							; set x coordinate
		mov dx, di							; set y coordinate
		int 10h
		pop dx
		pop cx
		pop bx
		cmp al, colorx							; check color attribute
		jnz checkpixloop3						; if not colorx then set extent
		inc si								; increment x coordinate
		loop checkpixloop1						; loop x check
		pop cx								; load y loop count
		inc di								; increment y coordinate
		loop checkpixloop2						; loop y check
		jmp checkpixloop4						; clear extent

	checkpixloop3:
		pop cx								; load y loop count
	checkpixloop3x:
		mov extent, 1							; set extent
		jmp checkpixloop5						; exit
	checkpixloop4:
		mov extent, 0							; clear extent
	checkpixloop5:
		ret
checkpixz endp

drawface1 proc far
	comment $
	draw up character
	$

	push bx									; save bx
	mov bx, go								; load go status
	ref 5 19								; set offset coordinates
	sub yrefx, bx								; go effect
	draw 30 11 xrefx yrefx black							; draw body
	ref 8 22								; set offset coordinates
	sub yrefx, bx								; go effect
	draw 24 5 xrefx yrefx cyan							; draw body
	ref 10 14								; set offset coordinates
	sub yrefx, bx								; go effect
	draw 20 21 xrefx yrefx black							; draw body
	ref 13 5								; set offset coordinates
	sub yrefx, bx								; go effect
	draw 14 9 xrefx yrefx black							; draw body
	ref 16 8								; set offset coordinates
	sub yrefx, bx								; go effect
	draw 8 6 xrefx yrefx blue							; draw head
	sub yref, bx								; go effect
	pop bx									; load bx
	ret
drawface1 endp

drawface2 proc far
	comment $
	draw down character
	$

	push bx									; save bx
	mov bx, go								; load go status
	ref 5 10								; set offset coordinates
	add yrefx, bx								; go effect
	draw 30 11 xrefx yrefx black							; draw body
	ref 8 13								; set offset coordinates
	add yrefx, bx								; go effect
	draw 24 5 xrefx yrefx cyan							; draw body
	ref 10 5								; set offset coordinates
	add yrefx, bx								; go effect
	draw 20 21 xrefx yrefx black							; draw body
	ref 13 26								; set offset coordinates
	add yrefx, bx								; go effect
	draw 14 9 xrefx yrefx black							; draw body
	ref 16 26								; set offset coordinates
	add yrefx, bx								; go effect
	draw 8 6 xrefx yrefx blue							; draw head
	add yref, bx								; go effect
	pop bx									; load bx
	ret
drawface2 endp

drawface3 proc far
	comment $
	draw left character
	$

	push bx									; save bx
	mov bx, go								; load go status
	ref 19 5								; set offset coordinates
	sub xrefx, bx								; go effect
	draw 11 30 xrefx yrefx black							; draw body
	ref 22 8								; set offset coordinates
	sub xrefx, bx								; go effect
	draw 5 24 xrefx yrefx cyan							; draw body
	ref 14 10								; set offset coordinates
	sub xrefx, bx								; go effect
	draw 21 20 xrefx yrefx black							; draw body
	ref 5 13								; set offset coordinates
	sub xrefx, bx								; go effect
	draw 9 14 xrefx yrefx black							; draw body
	ref 8 16								; set offset coordinates
	sub xrefx, bx								; go effect
	draw 6 8 xrefx yrefx blue							; draw head
	sub xref, bx								; go effect
	pop bx									; load bx
	ret
drawface3 endp

drawface4 proc far
	comment $
	draw right character
	$

	push bx									; save bx
	mov bx, go								; load go status
	ref 10 5								; set offset coordinates
	add xrefx, bx								; go effect
	draw 11 30 xrefx yrefx black							; draw body
	ref 13 8								; set offset coordinates
	add xrefx, bx								; go effect
	draw 5 24 xrefx yrefx cyan							; draw body
	ref 5 10								; set offset coordinates
	add xrefx, bx								; go effect
	draw 21 20 xrefx yrefx black							; draw body
	ref 26 13								; set offset coordinates
	add xrefx, bx								; go effect
	draw 9 14 xrefx yrefx black							; draw body
	ref 26 16								; set offset coordinates
	add xrefx, bx								; go effect
	draw 6 8 xrefx yrefx blue							; draw head
	add xref, bx								; go effect
	pop bx									; load bx
	ret
drawface4 endp

openfile proc far
	comment $
	open conversation and luna files
	$

	pusha
	mov ah, 3dh								; open file
	mov al, 2								; read and write access
	int 21h
	jnc skipcreatefile							; if no error then skip createfile
	call createfile								; otherwise do createfile
	skipcreatefile:
	mov handle, ax								; save file handle
	popa
	ret
openfile endp

createfile proc far
	comment $
	create luna file
	$

	mov ah, 3ch								; create file
	mov cx, 0								; standard mode
	int 21h
	ret
createfile endp

readfile proc far
	comment $
	read conversation and luna files
	$

	pusha
	mov ah, 3fh								; read file
	mov bx, handle								; load file handle
	mov cx, 2655								; set read size
	lea dx, txt100x								; set read buffer
	int 21h
	mov bufferx, ax								; save read size
	popa
	ret
readfile endp

writefile proc far
	comment $
	write luna file
	$

	mov ah, 40h								; write file
	mov bx, handle								; load file handle
	mov cx, 5								; set write size
	lea dx, inputx								; load input string
	int 21h
	ret
writefile endp

closefile proc far
	comment $
	close conversation and luna files
	$

	pusha
	mov ah, 3eh								; close file
	mov bx, handle								; load file handle
	int 21h
	popa
	ret
closefile endp

setfile proc far
	comment $
	initialize conversation with files
	$

	lea bx, txt100x								; set conversation buffer
	mov index, bx								; save conversation buffer
	call openfile
	call readfile
	call closefile
	ret
setfile endp

write proc far
	comment $
	write character and conversation string
	$

	mov ah, 13h								; write character string
	mov al, 1h								; string only
	mov bh, 0h								; set video page
	mov cx, 6								; set size
	mov dx, 1907h								; set coordinates
	int 10h
	mov ah, 13h								; write conversation string
	mov al, 1h								; string only
	mov bh, 0h								; set video page
	mov bl, blacktxt							; set color attribute
	mov cx, di								; set size
	mov dx, 190dh								; set coordinates
	mov bp, si								; load conversation buffer
	int 10h
	ret
write endp

writex proc far
	comment $
	write objective and objectivex string
	$

	mov ah, 13h								; write objective string
	mov al, 1h								; string only
	mov bh, 0h								; set video page
	mov bl, lviolettxt							; set color attribute
	mov cx, 9								; set size
	mov dx, 1b07h								; set coordinates
	lea bp, txt00								; load objective buffer
	int 10h
	mov ah, 13h								; write objectivex string
	mov al, 1h								; string only
	mov bh, 0h								; set video page
	mov bl, blacktxt							; set color attribute
	mov cx, di								; set size
	mov dx, 1c07h								; set coordinates
	mov bp, si								; load objectivex buffer
	int 10h
	ret
writex endp

writey proc far
	comment $
	write find string
	$

	mov ax, 600h								; scroll the entire pixels up
	mov bh, white								; set the color attribute to white
	int 10h
	mov ah, 13h								; write find string
	mov al, 1h								; string only
	mov bh, 0h								; set video page
	mov bl, cyantxt								; set color attribute
	mov cx, si								; set size
	mov dx, di								; set coordinates
	int 10h
	ret
writey endp

writez proc far
	comment $
	write string
	$

	mov ah, 13h								; write string
	mov al, 1h								; string only
	mov bh, 0h								; set video page
	mov bp, index								; load string buffer
	int 10h
	ret
writez endp

clearwrite proc far
	comment $
	clear character and conversation string
	$

	mov ax, 600h								; scroll the entire pixels up
	mov bh, white								; set color attribute
	mov cx, 1907h								; set upper left coordinates
	mov dx, 1948h								; set lower right coordinates
	int 10h
	ret
clearwrite endp

clearwritex proc far
	comment $
	clear objective and objectivex string
	$

	mov ax, 600h								; scroll the entire pixels up
	mov bh, white								; set color attribute
	mov cx, 1b07h								; set upper left coordinates
	mov dx, 1c48h								; set lower right coordinates
	int 10h
	ret
clearwritex endp

clicklevelx proc far
	comment $
	interaction for level x
	$

	getkeyx:
		mov ah, 11h							; check key buffer
		int 16h
		jz getbuttonx							; if no content then check button click
		mov ah, 10h							; clear key buffer
		int 16h

		cmp ah, 59							; check scan code
		jz level1							; if F1 then go to level1
		cmp ah, 60							; check scan code
		jz level2							; if F2 then go to level2
		cmp ah, 61							; check scan code
		jz level3							; if F3 then go to level3
		cmp ah, 62							; check scan code
		jz level4							; if F4 then go to level4
		cmp ah, 63							; check scan code
		jz level5							; if F5 then go to level
		jmp getkeyx							; check key
	getbuttonx:
		mov ax, 5h							; get button click status
		mov bx, 0h							; set left click status
		int 33h
		cmp bl, 1							; check left click
		jz play								; if left click then check play
		jmp getkeyx							; otherwise check key

	play:
		cmp cx, 71							; check x coordinate begin
		jl getbuttonx							; if without then check button click
		cmp cx, 148							; check x coordinate end
		jg instructions							; if without then check instruction
		cmp dx, 290							; check y coordinate begin
		jl getbuttonx							; if without then check button click
		cmp dx, 307							; check x coordinate end
		jg instructions							; if without then check instruction
		ret								; if within then start play
	instructions:
		cmp cx, 289							; check x coordinate end
		jg getbuttonx							; if without then check button click
		cmp dx, 314							; check y coordinate begin
		jl getbuttonx							; if without then check button click
		cmp dx, 331							; check y coordinate end
		jg list								; if without then check list
		jmp instructionsx						; if within then view instructions
	list:
		cmp cx, 279							; check x coordinate end
		jg getbuttonx							; if without then check button click
		cmp dx, 338							; check y coordinate begin
		jl getbuttonx							; if without then check button click
		cmp dx, 355							; check y coordinate end
		jg exitx							; if without then check exit
		jmp listx							; if within then view list
	exitx:
		cmp cx, 137							; check x coordinate end
		jg getbuttonx							; if without then check button click
		cmp dx, 362							; check y coordinate begin
		jl getbuttonx							; if without then check button click
		cmp dx, 378							; check y coordinate end
		jg getbuttonx							; if without then check button click
		jmp exit							; if within then exit

	instructionsx:
		call drawinst
		jmp getbuttonx							; check button click
	listx:
		call drawluna
		jmp getbuttonx							; check button click
	ret
clicklevelx endp

clicklevel1 proc far
	comment $
	interaction for level 1
	$

	checklevel1door:
		cmp cx, 32							; check x coordinate begin
		jl exitclicklevel1						; if without then exit
		cmp cx, 47							; check x coordinate end
		jg checkkey							; if without then check key
		cmp dx, 186							; check y coordinate begin
		jl checkkey							; if without then check key
		cmp dx, 227							; check y coordinate end
		jg checkchocolate						; if without then check chocolate
		jmp clicklevel1door						; if within then do door
	checkkey:
		cmp cx, 55							; check x coordinate begin
		jl exitclicklevel1						; if without then exit
		cmp cx, 87							; check x coordinate end
		jg checkchocolate						; if without then check chocolate
		cmp dx, 96							; check y coordinate begin
		jl checkring							; if without then check ring
		cmp dx, 112							; check y coordinate end
		jg checkchocolate						; if without then check chocolate
		jmp clickkey							; if within then do key
	checkchocolate:
		cmp cx, 143							; check x coordinate begin
		jl exitclicklevel1						; if without then exit
		cmp cx, 172							; check x coordinate end
		jg checklist							; if without then check list
		cmp dx, 336							; check y coordinate begin
		jl checklist							; if without then check list
		cmp dx, 350							; check y coordinate end
		jg exitclicklevel1						; if without then exit
		jmp clickchocolate						; if within then do chocolate
	checklist:
		cmp cx, 232							; check x coordinate begin
		jl exitclicklevel1						; if without then exit
		cmp cx, 256							; check x coordinate end
		jg checkring							; if without then check ring
		cmp dx, 281							; check y coordinate begin
		jl checkring							; if without then check ring
		cmp dx, 315							; check y coordinate end
		jg exitclicklevel1						; if without then exit
		jmp clicklist							; if within then do list
	checkring:
		cmp cx, 359							; check x coordinate begin
		jl exitclicklevel1						; if without then exit
		cmp cx, 373							; check x coordinate end
		jg checkphoto							; if without then check photo
		cmp dx, 53							; check y coordinate begin
		jl checkphone							; if without then check phone
		cmp dx, 67							; check y coordinate end
		jg checkphone							; if without then check phone
		jmp clickring							; if within then do ring
	checkphoto:
		cmp cx, 381							; check x coordinate begin
		jl exitclicklevel1						; if without then exit
		cmp cx, 440							; check x coordinate end
		jg checkphone							; if without then check phone
		cmp dx, 218							; check y coordinate begin
		jl checkphone							; if without then check phone
		cmp dx, 227							; check y coordinate end
		jg checklaptop							; if without then check laptop
		jmp clickphoto							; if within then do photo
	checklaptop:
		cmp cx, 389							; check x coordinate begin
		jl exitclicklevel1						; if without then exit
		cmp cx, 432							; check x coordinate end
		jg checkphone							; if without then check phone
		cmp dx, 273							; check y coordinate begin
		jl checkphone							; if without then check phone
		cmp dx, 304							; check y coordinate end
		jg checkstrange							; if without then check strange
		jmp clicklaptop							; if within then do laptop
	checkphone:
		cmp cx, 438							; check x coordinate begin
		jl exitclicklevel1						; if without then exit
		cmp cx, 470							; check x coordinate end
		jg checkstrange							; if without then check strange
		cmp dx, 44							; check y coordinate begin
		jl exitclicklevel1						; if without then exit
		cmp dx, 76							; check y coordinate end
		jg checkstrange							; if without then check strange
		jmp clickphone							; if within then do phone
	checkstrange:
		cmp cx, 555							; check x coordinate begin
		jl exitclicklevel1						; if without then exit
		cmp cx, 575							; check x coordinate end
		jg exitclicklevel1						; if without then exit
		cmp dx, 277							; check y coordinate begin
		jl exitclicklevel1						; if without then exit
		cmp dx, 305							; check y coordinate end
		jg exitclicklevel1						; if without then exit
		jmp clickstrange						; if within then do strange

	clicklevel1door:
		bt level1x, 2							; check list bit
		jnc nolevel1							; if cleared then write no
		bt level1x, 5							; check laptop bit
		jnc nolevel1							; if cleared then write no
		bt level1x, 6							; check phone bit
		jnc nolevel1							; if cleared then write no

		call hidec
		lea dx, txt113							; load exit conversation
		call setfile
		setwrite cyantxt txt10 index 11
		setwrite bluetxt txt10 index 36
		setwrite cyantxt txt10 index 49
		setwrite bluetxt txt10 index 13
		setwrite bluetxt txt10 index 4
		call showc
		jmp level2							; go to next level

		nolevel1:
			call hidec
			lea dx, txt112						; load no conversation
			call setfile
			setwrite cyantxt txt10 index 29
			setwrite bluetxt txt10 index 23
			setwrite cyantxt txt10 index 10
			call showc
			jmp exitclicklevel1					; exit interaction
	clickkey:
		bt level1x, 0							; check key bit
		jc exitclicklevel1						; if set then exit
		or level1x, 1							; otherwise set key bit

		call hidec
		draw 40 18 52 96 cyan						; clear key
		lea dx, txt102							; load key conversation
		call setfile
		setwrite cyantxt txt10 index 5
		setwrite bluetxt txt10 index 27
		setwrite cyantxt txt10 index 6
		setwrite bluetxt txt10 index 22
		call showc
		jmp exitclicklevel1						; exit interaction
 	clickchocolate:
		bt level1x, 1							; check chocolate bit
		jc exitclicklevel1						; if set then exit
		or level1x, 2							; otherwise set chocolate bit

		call hidec
		draw 24 9 146 339 white						; clear chocolate
		lea dx, txt103							; load chocolate conversation
		call setfile
		setwrite cyantxt txt10 index 23
		setwrite bluetxt txt10 index 35
		setwrite cyantxt txt10 index 32
		setwrite bluetxt txt10 index 36
		setwrite cyantxt txt10 index 11
		setwrite cyantxt txt10 index 22
		call showc
		jmp exitclicklevel1						; exit interaction
	clicklist:
		bt level1x, 2							; check list bit
		jc exitclicklevel1						; if set then exit
		or level1x, 4							; otherwise set list bit

		call hidec
		draw 25 35 232 282 blue						; clear list
		setwritey 1c23h 1c26h 4 txt63						; load find objective
		lea dx, txt104							; load list conversation
		call setfile
		setwrite bluetxt txt10 index 29
		setwrite cyantxt txt10 index 33
		setwrite bluetxt txt10 index 8
		setwrite bluetxt txt10 index 39
		setwrite cyantxt txt10 index 12
		setwrite cyantxt txt10 index 33
		setwrite cyantxt txt10 index 51
		setwrite bluetxt txt10 index 6
		setwrite cyantxt txt10 index 17
		setwrite bluetxt txt10 index 8
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 13
		setwrite cyantxt txt10 index 41
		setwrite bluetxt txt10 index 45
		setwrite cyantxt txt10 index 16
		setwrite cyantxt txt10 index 4
		call showc
		jmp exitclicklevel1						; exit interaction
	clickring:
		bt level1x, 3							; check ring bit
		jc exitclicklevel1						; if set then exit
		or level1x, 8							; otherwise set ring bit

		call hidec
		draw 9 9 362 57 white						; clear ring
		lea dx, txt105							; load ring conversation
		call setfile
		setwrite bluetxt txt10 index 13
		setwrite bluetxt txt10 index 11
		setwrite cyantxt txt10 index 5
		setwrite bluetxt txt10 index 13
		setwrite cyantxt txt10 index 12
		setwrite bluetxt txt10 index 8
		setwrite cyantxt txt10 index 8
		setwrite bluetxt txt10 index 18
		setwrite cyantxt txt10 index 43
		setwrite bluetxt txt10 index 12
		setwrite bluetxt txt10 index 3
		setwrite bluetxt txt10 index 13
		setwrite bluetxt txt10 index 22
		setwrite cyantxt txt10 index 56
		setwrite cyantxt txt10 index 36
		setwrite bluetxt txt10 index 5
		setwrite bluetxt txt10 index 23
		setwrite cyantxt txt10 index 35
		setwrite bluetxt txt10 index 12
		setwrite bluetxt txt10 index 35
		setwrite cyantxt txt10 index 52
		setwrite bluetxt txt10 index 27
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 46
		setwrite bluetxt txt10 index 37
		setwrite cyantxt txt10 index 19
		setwrite cyantxt txt10 index 31
		call showc
		jmp exitclicklevel1						; exit interaction
	clickphoto:
		bt level1x, 4							; check photo bit
		jc exitclicklevel1						; if set then exit
		or level1x, 16							; otherwise set photo bit

		call hidec
		draw 54 4 384 222 white						; clear photo
		lea dx, txt106							; load photo conversation
		call setfile
		setwrite cyantxt txt10 index 14
		setwrite bluetxt txt10 index 30
		setwrite cyantxt txt10 index 22
		setwrite cyantxt txt10 index 45
		setwrite bluetxt txt10 index 41
		setwrite cyantxt txt10 index 34
		setwrite bluetxt txt10 index 3
		setwrite bluetxt txt10 index 42
		setwrite cyantxt txt10 index 13
		setwrite bluetxt txt10 index 31
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 8
		call showc
		jmp exitclicklevel1						; exit interaction
	clicklaptop:
		bt level1x, 5							; check laptop bit
		jc exitclicklevel1						; if set then exit
		bt level1x, 3							; check ring bit
		jnc nolaptop							; if cleared then write no
		or level1x, 32							; otherwise set laptop bit

		call hidec
		draw 38 26 392 277 white					; clear laptop
		draw 7 7 408 289 black
		draw 3 3 410 286 black
		setwritey 1c10h 1c15h 6 txt61					; load find objective
		lea dx, txt108							; load laptop conversation
		call setfile
		setwrite cyantxt txt10 index 36
		setwrite bluetxt txt10 index 42
		setwrite cyantxt txt10 index 43
		setwrite bluetxt txt10 index 52
		setwrite cyantxt txt10 index 23
		setwrite cyantxt txt10 index 19
		setwrite cyantxt txt10 index 21
		setwrite bluetxt txt10 index 37
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 29
		setwrite bluetxt txt10 index 8
		setwrite bluetxt txt10 index 33
		setwrite cyantxt txt10 index 46
		setwrite cyantxt txt10 index 45
		setwrite bluetxt txt10 index 32
		setwrite cyantxt txt10 index 13
		setwrite bluetxt txt10 index 50
		setwrite cyantxt txt10 index 8
		setwrite cyantxt txt10 index 28
		setwrite cyantxt txt10 index 27
		setwrite bluetxt txt10 index 5
		setwrite cyantxt txt10 index 25
		setwrite bluetxt txt10 index 50
		setwrite cyantxt txt10 index 8
		setwrite bluetxt txt10 index 8
		setwrite cyantxt txt10 index 47
		setwrite bluetxt txt10 index 19
		setwrite cyantxt txt10 index 5
		setwrite bluetxt txt10 index 41
		setwrite cyantxt txt10 index 37
		setwrite bluetxt txt10 index 22
		setwrite cyantxt txt10 index 16
		call showc
		jmp exitclicklevel1						; exit interaction

		nolaptop:
			bt level1x, 15						; check no laptop bit
			jc exitclicklevel1					; if set then exit
			or level1x, 32768					; otherwise set no laptop bit

			call hidec
			lea dx, txt107						; load no conversation
			call setfile
			setwrite bluetxt txt10 index 13
			setwrite bluetxt txt10 index 36
			setwrite cyantxt txt10 index 56
			setwrite cyantxt txt10 index 30
			setwrite cyantxt txt10 index 39
			setwrite bluetxt txt10 index 8
			setwrite cyantxt txt10 index 37
			setwrite cyantxt txt10 index 30
			setwrite bluetxt txt10 index 37
			setwrite cyantxt txt10 index 14
			call showc
			jmp exitclicklevel1					; exit interaction
	clickphone:
		bt level1x, 6							; check phone bit
		jc exitclicklevel1						; if set then exit
		bt level1x, 0							; check key bit
		jnc nophone							; if cleared then write no
		or level1x, 64							; otherwise set phone bit

		call hidec
		draw 27 27 441 48 white						; clear phone
		setwritey 1c18h 1c1ch 5 txt62					; load find objective
		lea dx, txt110							; load phone conversation
		call setfile
		setwrite cyantxt txt10 index 17
		setwrite bluetxt txt10 index 26
		setwrite cyantxt txt10 index 45
		setwrite bluetxt txt10 index 27
		setwrite bluetxt txt10 index 4
		setwrite cyantxt txt10 index 51
		setwrite bluetxt txt10 index 54
		setwrite cyantxt txt10 index 47
		setwrite bluetxt txt10 index 27
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 21
		setwrite cyantxt txt10 index 57
		setwrite bluetxt txt10 index 13
		setwrite cyantxt txt10 index 39
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 52
		setwrite bluetxt txt10 index 10
		setwrite cyantxt txt10 index 5
		setwrite bluetxt txt10 index 5
		setwrite bluetxt txt10 index 10
		setwrite cyantxt txt10 index 5
		setwrite bluetxt txt10 index 21
		setwrite cyantxt txt10 index 25
		setwrite bluetxt txt10 index 3
		setwrite cyantxt txt10 index 32
		call showc
		jmp exitclicklevel1						; exit interaction

		nophone:
			bt level1x, 14						; check no phone bit
			jc exitclicklevel1					; if set then exit
			or level1x, 16384					; otherwise set no phone bit

			call hidec
			lea dx, txt109						; load no conversation
			call setfile
			setwrite cyantxt txt10 index 12
			setwrite bluetxt txt10 index 18
			call showc
			jmp exitclicklevel1					; exit interaction
	clickstrange:
		bt level1x, 7							; check strange bit
		jc exitclicklevel1						; if set then exit
		or level1x, 128							; otherwise set strange bit

		call hidec
		draw 15 23 558 281 white					; clear strange
		draw 11 10 560 284 black
		lea dx, txt111							; load strange conversation
		call setfile
		setwrite cyantxt txt10 index 36
		setwrite cyantxt txt10 index 47
		setwrite bluetxt txt10 index 55
		setwrite bluetxt txt10 index 49
		setwrite cyantxt txt10 index 12
		call showc
		jmp exitclicklevel1						; exit interaction

	exitclicklevel1:
		ret
clicklevel1 endp

clicklevel2 proc far
	comment $
	interaction for level 2
	$

	checklevel2door:
		cmp cx, 274							; check x coordinate begin
		jl checklevel2body1						; if without then check body1
		cmp cx, 363							; check x coordinate end
		jg checklevel2body4						; if without then check body4
		cmp dx, 331							; check y coordinate begin
		jl checklevel2body1						; if without then check body1
		cmp dx, 347							; check y coordinate end
		jg exitclicklevel2						; if without then exit
		jmp clicklevel2door						; if within then do door
	checklevel2body1:
		cmp cx, 59							; check x coordinate begin
		jl exitclicklevel2						; if without then exit
		cmp cx, 78							; check x coordinate end
		jg checklevel2body2						; if without then check body2
		cmp dx, 260							; check y coordinate begin
		jl checklevel2body2						; if without then check body2
		cmp dx, 278							; check y coordinate end
		jg exitclicklevel2						; if without then exit
		jmp clicklevel2body1						; if within then do body1
	checklevel2body2:
		cmp cx, 134							; check x coordinate begin
		jl exitclicklevel2						; if without then exit
		cmp cx, 152							; check x coordinate end
		jg checklevel2body3						; if without then check body3
		cmp dx, 195							; check y coordinate begin
		jl checklevel2body3						; if without then check body3
		cmp dx, 214							; check y coordinate end
		jg checklevel2body4						; if without then check body4
		jmp clicklevel2body2						; if within then do body2
	checklevel2body3:
		cmp cx, 179							; check x coordinate begin
		jl exitclicklevel2						; if without then exit
		cmp cx, 198					 		; check x coordinate end
		jg checkcashier							; if without then check cashier
		cmp dx, 112							; check y coordinate begin
		jl checkcashier							; if without then check cashier
		cmp dx, 130							; check y coordinate end
		jg checkowner							; if without then check owner
		jmp clicklevel2body3						; if within then do body3
	checkcashier:
		cmp cx, 305							; check x coordinate begin
		jl exitclicklevel2						; if without then exit
		cmp cx, 334					 		; check x coordinate end
		jg checklevel2body4						; if without then check cashier
		cmp dx, 103							; check y coordinate begin
		jl exitclicklevel2						; if without then exit
		cmp dx, 135							; check y coordinate end
		jg checkowner							; if without then check owner
		jmp clickcashier						; if within then do cashier
	checkowner:
		cmp cx, 310							; check x coordinate begin
		jl exitclicklevel2						; if without then exit
		cmp cx, 329					 		; check x coordinate end
		jg checklevel2body4						; if without then check body4
		cmp dx, 262							; check y coordinate begin
		jl checklevel2body4						; if without exit check body4
		cmp dx, 280							; check y coordinate end
		jg exitclicklevel2						; if without then exit
		jmp clickowner							; if within then do owner
	checklevel2body4:
		cmp cx, 393							; check x coordinate begin
		jl exitclicklevel2						; if without then exit
		cmp cx, 411					 		; check x coordinate end
		jg checklevel2body5						; if without then check body5
		cmp dx, 215							; check y coordinate begin
		jl checklevel2body5						; if without then exit body5
		cmp dx, 234							; check y coordinate end
		jg exitclicklevel2						; if without then exit
		jmp clicklevel2body4						; if within then do body4
	checklevel2body5:
		cmp cx, 487							; check x coordinate begin
		jl exitclicklevel2						; if without then exit
		cmp cx, 505					 		; check x coordinate end
		jg checkbuddy							; if without then check buddy
		cmp dx, 117							; check y coordinate begin
		jl exitclicklevel2						; if without exit
		cmp dx, 136							; check y coordinate end
		jg checkbuddy							; if without then exit buddy
		jmp clicklevel2body5						; if within then do body5
	checkbuddy:
		cmp cx, 561							; check x coordinate begin
		jl exitclicklevel2						; if without then exit
		cmp cx, 580					 		; check x coordinate end
		jg exitclicklevel2						; if without then exit
		cmp dx, 166							; check y coordinate begin
		jl exitclicklevel2						; if without exit
		cmp dx, 184							; check y coordinate end
		jg exitclicklevel2						; if without then exit
		jmp clickbuddy							; if within then do buddy

	clicklevel2door:
		bt level2x, 5							; check cashier bit
		jnc nolevel2							; if cleared then write no
		bt level2x, 6							; check buddy bit
		jnc nolevel2							; if cleared then write no
		bt level2x, 7							; check owner bit
		jnc nolevel2							; if cleared then write no

		call hidec
		lea dx, txt211							; load door conversation
		call setfile
		setwrite cyantxt txt10 index 11
		setwrite bluetxt txt10 index 27
		setwrite cyantxt txt10 index 26
		setwrite bluetxt txt10 index 8
		call showc
		jmp level3							; go to next level

		nolevel2:
			call hidec
			lea dx, txt210						; load no conversation
			call setfile
			setwrite cyantxt txt10 index 29
			setwrite bluetxt txt10 index 28
			setwrite cyantxt txt10 index 20
			call showc
			jmp exitclicklevel2					; exit interaction
	clicklevel2body1:
		bt level2x, 0							; check body1 bit
		jc exitclicklevel2						; if set then exit
		or level2x, 1							; otherwise set body1 bit

		call hidec
		draw 14 13 62 263 cyan						; clear faye
		lea dx, txt202							; load faye conversation
		call setfile
		setwrite cyantxt txt10 index 3
		setwrite lviolettxt txt21 index 0
		setwrite cyantxt txt10 index 10
		setwrite lviolettxt txt21 index 0
		setwrite cyantxt txt10 index 4
		setwrite lviolettxt txt21 index 38
		setwrite lviolettxt txt21 index 49
		setwrite cyantxt txt10 index 10
		call showc
		jmp exitclicklevel2						; exit interaction
	clicklevel2body2:
		bt level2x, 1							; check body2 bit
		jc exitclicklevel2						; if set then exit
		or level2x, 2							; otherwise set body2 bit

		call hidec
		draw 13 14 137 198 cyan						; clear levi
		lea dx, txt203							; load levi conversation
		call setfile
		setwrite cyantxt txt10 index 3
		setwrite lviolettxt txt22 index 3
		setwrite lviolettxt txt22 index 4
		setwrite cyantxt txt10 index 3
		setwrite cyantxt txt10 index 5
		setwrite bluetxt txt10 index 22
		setwrite cyantxt txt10 index 19
		call showc
		jmp exitclicklevel2						; exit interaction
	clicklevel2body3:
		bt level2x, 2							; check body3 bit
		jc exitclicklevel2						; if set then exit
		or level2x, 4							; otherwise set body3 bit

		call hidec
		draw 14 13 182 115 cyan						; clear ynna
		lea dx, txt204							; load ynna conversation
		call setfile
		setwrite cyantxt txt10 index 3
		setwrite lviolettxt txt23 index 3
		setwrite cyantxt txt10 index 50
		setwrite lviolettxt txt23 index 10
		setwrite cyantxt txt10 index 58
		setwrite lviolettxt txt23 index 28
		setwrite lviolettxt txt23 index 49
		setwrite cyantxt txt10 index 9
		setwrite cyantxt txt10 index 33
		setwrite lviolettxt txt23 index 8
		setwrite lviolettxt txt23 index 20
		call showc
		jmp exitclicklevel2						; exit interaction
	clicklevel2body4:
		bt level2x, 3							; check body4 bit
		jc exitclicklevel2						; if set then exit
		or level2x, 8							; otherwise set body4 bit

		call hidec
		draw 13 14 396 218 cyan						; clear tyler
		lea dx, txt205							; laod tyler conversation
		call setfile
		setwrite cyantxt txt10 index 3
		setwrite lviolettxt txt24 index 54
		setwrite cyantxt txt10 index 5
		setwrite lviolettxt txt24 index 19
		setwrite lviolettxt txt24 index 22
		setwrite lviolettxt txt24 index 47
		setwrite lviolettxt txt24 index 29
		setwrite lviolettxt txt24 index 39
		setwrite cyantxt txt10 index 5
		setwrite lviolettxt txt24 index 19
		setwrite cyantxt txt10 index 5
		setwrite lviolettxt txt24 index 22
		setwrite cyantxt txt10 index 19
		setwrite lviolettxt txt24 index 21
		call showc
		jmp exitclicklevel2						; exit interaction
	clicklevel2body5:
		bt level2x, 4							; check body5 bit
		jc exitclicklevel2						; if set then exit
		or level2x, 16							; otherwise set body5 bit

		call hidec
		draw 13 14 490 120 cyan						; clear arya
		lea dx, txt206							; loar arya conversation
		call setfile
		setwrite cyantxt txt10 index 3
		setwrite lviolettxt txt25 index 16
		setwrite cyantxt txt10 index 25
		setwrite lviolettxt txt25 index 10
		setwrite cyantxt txt10 index 15
		setwrite lviolettxt txt25 index 0
		setwrite lviolettxt txt25 index 4
		setwrite cyantxt txt10 index 51
		setwrite lviolettxt txt25 index 19
		setwrite cyantxt txt10 index 5
		setwrite lviolettxt txt25 index 19
		setwrite cyantxt txt10 index 21
		setwrite cyantxt txt10 index 28
		setwrite lviolettxt txt25 index 23
		call showc
		jmp exitclicklevel2						; exit interaction
	clickcashier:
		bt level2x, 5							; check cashiet bit
		jc exitclicklevel2						; if set then exit
		or level2x, 32							; otherwise set cashiet bit

		call hidec
		draw 24 19 308 106 white					; clear fletcher
		draw 24 5 308 128 blue
		setwritey 1c17h 1c1dh 7 txt65					; load find objective
		lea dx, txt207							; load fletcher conversation
		call setfile
		setwrite cyantxt txt10 index 7
		setwrite cyantxt txt10 index 18
		setwrite lviolettxt txt26 index 9
		setwrite lviolettxt txt26 index 52
		setwrite lviolettxt txt26 index 24
		setwrite cyantxt txt10 index 15
		setwrite lviolettxt txt26 index 23
		setwrite cyantxt txt10 index 9
		setwrite lviolettxt txt26 index 0
		setwrite lviolettxt txt26 index 13
		setwrite cyantxt txt10 index 6
		setwrite lviolettxt txt26 index 38
		setwrite cyantxt txt10 index 15
		setwrite lviolettxt txt26 index 15
		setwrite cyantxt txt10 index 10
		setwrite lviolettxt txt26 index 29
		setwrite cyantxt txt10 index 22
		setwrite lviolettxt txt26 index 0
		setwrite cyantxt txt10 index 41
		setwrite lviolettxt txt26 index 14
		setwrite lviolettxt txt26 index 25
		setwrite cyantxt txt10 index 10
		setwrite lviolettxt txt26 index 12
		setwrite cyantxt txt10 index 8
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 49
		setwrite lviolettxt txt26 index 5
		setwrite cyantxt txt10 index 21
		setwrite lviolettxt txt26 index 24
		setwrite cyantxt txt10 index 22
		setwrite lviolettxt txt26 index 26
		setwrite lviolettxt txt26 index 51
		setwrite cyantxt txt10 index 4
		setwrite lviolettxt txt26 index 15
		setwrite cyantxt txt10 index 33
		setwrite lviolettxt txt26 index 56
		setwrite lviolettxt txt26 index 43
		setwrite cyantxt txt10 index 10
		setwrite lviolettxt txt26 index 21
		setwrite bluetxt txt10 index 31
		setwrite cyantxt txt10 index 20
		setwrite lviolettxt txt26 index 3
		setwrite cyantxt txt10 index 20
		setwrite lviolettxt txt26 index 44
		setwrite lviolettxt txt26 index 35
		setwrite cyantxt txt10 index 16
		setwrite lviolettxt txt26 index 8
		setwrite bluetxt txt10 index 25
		setwrite bluetxt txt10 index 14
		setwrite cyantxt txt10 index 20
		setwrite cyantxt txt10 index 35
		setwrite bluetxt txt10 index 17
		call showc
		jmp exitclicklevel2						; exit interaction
	clickbuddy:
		bt level2x, 6							; check buddy bit
		jc exitclicklevel2						; if set then exit
		or level2x, 64							; otherwise set buddy bit

		call hidec
		draw 14 13 564 169 cyan						; clear max
		setwritey 1c24h 1c28h 5 txt66					; load find objective
		lea dx, txt208							; load max conversation
		call setfile
		setwrite cyantxt txt10 index 3
		setwrite lviolettxt txt27 index 3
		setwrite cyantxt txt10 index 25
		setwrite lviolettxt txt27 index 5
		setwrite cyantxt txt10 index 51
		setwrite lviolettxt txt27 index 24
		setwrite lviolettxt txt27 index 11
		setwrite cyantxt txt10 index 5
		setwrite lviolettxt txt27 index 26
		setwrite cyantxt txt10 index 15
		setwrite lviolettxt txt27 index 26
		setwrite lviolettxt txt27 index 41
		setwrite lviolettxt txt27 index 37
		setwrite cyantxt txt10 index 29
		setwrite lviolettxt txt27 index 32
		setwrite lviolettxt txt27 index 50
		setwrite lviolettxt txt27 index 11
		setwrite cyantxt txt10 index 15
		setwrite lviolettxt txt27 index 47
		setwrite cyantxt txt10 index 42
		setwrite lviolettxt txt27 index 19
		setwrite lviolettxt txt27 index 58
		setwrite lviolettxt txt27 index 31
		setwrite lviolettxt txt27 index 41
		setwrite lviolettxt txt27 index 43
		setwrite cyantxt txt10 index 23
		setwrite lviolettxt txt27 index 33
		setwrite lviolettxt txt27 index 25
		setwrite lviolettxt txt27 index 22
		setwrite cyantxt txt10 index 21
		setwrite lviolettxt txt27 index 37
		setwrite lviolettxt txt27 index 34
		setwrite cyantxt txt10 index 17
		setwrite lviolettxt txt27 index 19
		setwrite lviolettxt txt27 index 44
		setwrite lviolettxt txt27 index 27
		setwrite cyantxt txt10 index 8
		setwrite lviolettxt txt27 index 23
		setwrite bluetxt txt10 index 21
		setwrite cyantxt txt10 index 8
		setwrite lviolettxt txt27 index 20
		setwrite lviolettxt txt27 index 47
		setwrite lviolettxt txt27 index 30
		setwrite lviolettxt txt27 index 50
		setwrite cyantxt txt10 index 51
		setwrite lviolettxt txt27 index 40
		setwrite cyantxt txt10 index 11
		setwrite lviolettxt txt27 index 14
		setwrite cyantxt txt10 index 15
		call showc
		jmp exitclicklevel2						; exit interaction
	clickowner:
		bt level2x, 7							; check owner bit
		jc exitclicklevel2						; if set then exit
		bt level2x, 8							; check draw bit
		jnc exitclicklevel2						; if cleared then exit
		or level2x, 128							; otherwise set owner bit

		call hidec
		draw 14 13 313 265 cyan						; clear tali
		setwritey 1c10h 1c14h 5 txt64					; load find objective
		lea dx, txt209							; load tali conversation
		call setfile
		setwrite cyantxt txt10 index 3
		setwrite lviolettxt txt28 index 4
		setwrite cyantxt txt10 index 25
		setwrite lviolettxt txt28 index 38
		setwrite cyantxt txt10 index 57
		setwrite lviolettxt txt28 index 45
		setwrite lviolettxt txt28 index 54
		setwrite lviolettxt txt28 index 28
		setwrite lviolettxt txt28 index 47
		setwrite cyantxt txt10 index 33
		setwrite lviolettxt txt28 index 45
		setwrite lviolettxt txt28 index 39
		setwrite lviolettxt txt28 index 27
		setwrite cyantxt txt10 index 18
		setwrite lviolettxt txt28 index 18
		setwrite cyantxt txt10 index 9
		setwrite lviolettxt txt28 index 54
		setwrite lviolettxt txt28 index 23
		setwrite lviolettxt txt28 index 39
		setwrite cyantxt txt10 index 40
		setwrite lviolettxt txt28 index 45
		setwrite lviolettxt txt28 index 52
		setwrite cyantxt txt10 index 35
		setwrite lviolettxt txt28 index 4
		setwrite lviolettxt txt28 index 27
		setwrite cyantxt txt10 index 17
		setwrite cyantxt txt10 index 33
		setwrite lviolettxt txt28 index 56
		setwrite lviolettxt txt28 index 50
		setwrite cyantxt txt10 index 32
		setwrite lviolettxt txt28 index 54
		setwrite cyantxt txt10 index 46
		setwrite lviolettxt txt28 index 38
		setwrite cyantxt txt10 index 35
		setwrite lviolettxt txt28 index 31
		setwrite lviolettxt txt28 index 50
		setwrite cyantxt txt10 index 30
		setwrite lviolettxt txt28 index 24
		setwrite lviolettxt txt28 index 43
		setwrite lviolettxt txt28 index 43
		setwrite lviolettxt txt28 index 53
		setwrite lviolettxt txt28 index 57
		setwrite lviolettxt txt28 index 26
		setwrite lviolettxt txt28 index 22
		setwrite lviolettxt txt28 index 37
		setwrite lviolettxt txt28 index 31
		setwrite lviolettxt txt28 index 54
		setwrite lviolettxt txt28 index 54
		setwrite bluetxt txt10 index 39
		setwrite bluetxt txt10 index 41
		setwrite cyantxt txt10 index 17
		setwrite lviolettxt txt28 index 7
		setwrite lviolettxt txt28 index 15
		setwrite cyantxt txt10 index 19
		setwrite lviolettxt txt28 index 15
		setwrite lviolettxt txt28 index 41
		setwrite cyantxt txt10 index 14
		setwrite lviolettxt txt28 index 48
		setwrite lviolettxt txt28 index 32
		setwrite lviolettxt txt28 index 30
		setwrite cyantxt txt10 index 29
		setwrite lviolettxt txt28 index 36
		setwrite cyantxt txt10 index 25
		setwrite bluetxt txt10 index 40
		setwrite cyantxt txt10 index 31
		call showc
		jmp exitclicklevel2						; exit interaction

	exitclicklevel2:
		cmp level2x, 127						; check everybody
		jnz exitclicklevel2x						; if not everybody then exit
		bt level2x, 8							; check draw bit
		jc exitclicklevel2x						; if set then exit
		or level2x, 256							; otherwise set draw bit
	drawowner:
		draw 30 11 305 316 black
		draw 20 19 310 312 black
		draw 14 13 313 315 lviolet
		call delay
		draw 30 19 305 312 white
		draw 30 11 305 306 black
		draw 20 19 310 302 black
		draw 14 13 313 305 lviolet
		call delay
		draw 30 19 305 302 white
		draw 30 11 305 296 black
		draw 20 19 310 292 black
		draw 14 13 313 295 lviolet
		call delay
		draw 30 19 305 292 white
		draw 30 11 305 286 black
		draw 20 19 310 282 black
		draw 14 13 313 285 lviolet
		call delay
		draw 30 19 305 282 white
		draw 30 11 305 276 black
		draw 20 19 310 272 black
		draw 14 13 313 275 lviolet
		call delay
		draw 30 19 305 272 white
		draw 30 11 305 266 black
		draw 20 19 310 262 black
		draw 14 13 313 265 lviolet

	exitclicklevel2x:
		ret
clicklevel2 endp

clicklevel3 proc far
	comment $
	interaction for level 3
	$

	checklevel3door4:
		cmp cx, 450							; check x coordinate begin
		jl checklevel3door2						; if without then check door2
		cmp cx, 499							; check x coordinate end
		jg exitclicklevel3						; if without then exit
		cmp dx, 366							; check y coordinate begin
		jl checklevel3door3						; if without then check door3
		cmp dx, 387							; check y coordinate end
		jg exitclicklevel3						; if without then exit
		jmp clicklevel3door4						; if within then do door4
	checklevel3door3:
		cmp cx, 450							; check x coordinate begin
		jl checklevel3door2						; if without then check door2
		cmp cx, 499							; check x coordinate end
		jg exitclicklevel3						; if without then exit
		cmp dx, 30							; check y coordinate begin
		jl exitclicklevel3						; if without then exit
		cmp dx, 51							; check y coordinate end
		jg checklevel3door2						; if without then check door2
		jmp clicklevel3door3						; if within then do door3
	checklevel3door2:
		cmp cx, 27							; check x coordinate begin
		jl exitclicklevel3						; if without then exit
		cmp cx, 48							; check x coordinate end
		jg checklevel3body1						; if without then check body1
		cmp dx, 297							; check y coordinate begin
		jl checklevel3door1						; if without then check door1
		cmp dx, 346							; check y coordinate end
		jg exitclicklevel3						; if without then exit
		jmp clicklevel3door2						; if within then do door2
	checklevel3door1:
		cmp cx, 27							; check x coordinate begin
		jl exitclicklevel3						; if without then exit
		cmp cx, 48							; check x coordinate end
		jg checklevel3body1						; if without then check body1
		cmp dx, 74							; check y coordinate begin
		jl exitclicklevel3						; if without then exit
		cmp dx, 123							; check y coordinate end
		jg checklevel3body1						; if without then check body1
		jmp clicklevel3door1						; if within then do door1
	checklevel3body1:
		cmp cx, 123							; check x coordinate begin
		jl exitclicklevel3						; if without then exit
		cmp cx, 141							; check x coordinate end
		jg checklevel3body3						; if without then check body3
		cmp dx, 112							; check y coordinate begin
		jl exitclicklevel3						; if without then exit
		cmp dx, 131							; check y coordinate end
		jg checklevel3body2						; if without then check body2
		jmp clicklevel3body1						; if within then do body1
	checklevel3body2:
		cmp cx, 123							; check x coordinate begin
		jl exitclicklevel3						; if without then exit
		cmp cx, 141							; check x coordinate end
		jg checklevel3body3						; if without then check body3
		cmp dx, 247							; check y coordinate begin
		jl checklevel3body3						; if without then check body3
		cmp dx, 266							; check y coordinate end
		jg checklevel3body4						; if without then check body4
		jmp clicklevel3body2						; if within then do body2
	checklevel3body3:
		cmp cx, 195							; check x coordinate begin
		jl exitclicklevel3						; if without then exit
		cmp cx, 213							; check x coordinate end
		jg checklevel3body5						; if without then check body5
		cmp dx, 157							; check y coordinate begin
		jl checklevel3body8						; if without then check body8
		cmp dx, 176							; check y coordinate end
		jg checklevel3body4						; if without then check body4
		jmp clicklevel3body3						; if within then do body3
	checklevel3body4:
		cmp cx, 195							; check x coordinate begin
		jl exitclicklevel3						; if without then exit
		cmp cx, 213							; check x coordinate end
		jg checklevel3body5						; if without then check body5
		cmp dx, 292							; check y coordinate begin
		jl checklevel3body5						; if without then check body5
		cmp dx, 311							; check y coordinate end
		jg exitclicklevel3						; if without then exit
		jmp clicklevel3body4						; if within then do body4
	checklevel3body5:
		cmp cx, 267							; check x coordinate begin
		jl exitclicklevel3						; if without then exit
		cmp cx, 285							; check x coordinate end
		jg checklevel3body7						; if without then check body7
		cmp dx, 202							; check y coordinate begin
		jl checklevel3body7						; if without then check body7
		cmp dx, 221							; check y coordinate end
		jg checklevel3body6						; if without then check body6
		jmp clicklevel3body5						; if within then do body5
	checklevel3body6:
		cmp cx, 267							; check x coordinate begin
		jl exitclicklevel3						; if without then exit
		cmp cx, 285							; check x coordinate end
		jg checklevel3body7						; if without then check body7
		cmp dx, 247							; check y coordinate begin
		jl checklevel3body7						; if without then check body7
		cmp dx, 266							; check y coordinate end
		jg checklevel3body9						; if without then check body9
		jmp clicklevel3body6						; if within then do body6
	checklevel3body7:
		cmp cx, 339							; check x coordinate begin
		jl exitclicklevel3						; if without then exit
		cmp cx, 357							; check x coordinate end
		jg checklevel3body8						; if without then check body8
		cmp dx, 157							; check y coordinate begin
		jl checklevel3body8						; if without then check body8
		cmp dx, 176							; check y coordinate end
		jg checklevel3body9						; if without then check body9
		jmp clicklevel3body7						; if within then do body7
	checklevel3body8:
		cmp cx, 411							; check x coordinate begin
		jl exitclicklevel3						; if without then exit
		cmp cx, 429							; check x coordinate end
		jg exitclicklevel3						; if without then exit
		cmp dx, 112							; check y coordinate begin
		jl exitclicklevel3						; if without then exit
		cmp dx, 131							; check y coordinate end
		jg checklevel3body9						; if without then check body9
		jmp clicklevel3body8						; if within then do body8
	checklevel3body9:
		cmp cx, 411							; check x coordinate begin
		jl exitclicklevel3						; if without then exit
		cmp cx, 429							; check x coordinate end
		jg exitclicklevel3						; if without then exit
		cmp dx, 292							; check y coordinate begin
		jl exitclicklevel3						; if without then exit
		cmp dx, 311							; check y coordinate end
		jg exitclicklevel3						; if without then exit
		jmp clicklevel3body9						; if within then do body9

	clicklevel3door4:
		bt level3x, 15							; check door bit
		jnc nolevel3							; if cleared then write no

		call hidec
		lea ax, txt32c							; load door conversation
		setwrite cyantxt txt10 ax 7
		call showc
		jmp exitclicklevel3x						; exit interaction
	clicklevel3door3:
		bt level3x, 15							; check door bit
		jnc nolevel3							; if cleared then write no

		call hidec
		lea ax, txt32d							; load door conversation
		setwrite cyantxt txt10 ax 3
		call showc
		jmp exitclicklevel3x						; exit interaction
	clicklevel3door2:
		bt level3x, 15							; check door bit
		jnc nolevel3							; if cleared then write no

		call hidec
		lea ax, txt32e							; load door conversation
		setwrite cyantxt txt10 ax 5
		call showc
		jmp exitclicklevel3x						; exit interaction
	clicklevel3door1:
		cmp level3x, 33279						; check everything
		jnz nolevel3							; if not everything then exit

		call hidec
		lea dx, txt313							; load door conversation
		call setfile
		setwrite cyantxt txt10 index 13
		setwrite bluetxt txt10 index 3
		call showc
		jmp level4							; go to next level
	clicklevel3body1:
		bt level3x, 0							; check body1 bit
		jc exitclicklevel3						; if set then exit
		or level3x, 1							; otherwise set body1 bit

		call hidec
		draw 5 2 130 110 black						; clear garrus
		draw 13 14 126 115 cyan
		draw 5 2 130 132 black
		lea dx, txt302							; load garrus conversation
		call setfile
		setwrite cyantxt txt10 index 3
		setwrite lviolettxt txt31 index 19
		setwrite cyantxt txt10 index 10
		call showc
		jmp exitclicklevel3						; exit interaction
	clicklevel3body2:
		bt level3x, 1							; check body2 bit
		jc exitclicklevel3						; if set then exit
		or level3x, 2							; otherwise set body2 bit

		call hidec
		draw 5 2 130 245 black						; clear wrex
		draw 13 14 126 250 cyan
		draw 5 2 130 267 black
		lea dx, txt303							; load wrex conversation
		call setfile
		setwrite cyantxt txt10 index 4
		setwrite lviolettxt txt32 index 31
		setwrite bluetxt txt10 index 9
		setwrite lviolettxt txt32 index 20
		setwrite lviolettxt txt32 index 7
		setwrite cyantxt txt10 index 5
		call showc
		jmp exitclicklevel3						; exit interaction
	clicklevel3body3:
		bt level3x, 2							; check body3 bit
		jc exitclicklevel3						; if set then exit
		or level3x, 4							; otherwise set body3 bit

		call hidec
		draw 5 2 202 155 black						; clear pheobe
		draw 13 14 198 160 cyan
		draw 5 2 202 177 black
		lea dx, txt304							; load pheobe conversation
		call setfile
		setwrite cyantxt txt10 index 3
		setwrite lviolettxt txt33 index 42
		setwrite cyantxt txt10 index 10
		call showc
		jmp exitclicklevel3						; exit interaction
	clicklevel3body4:
		bt level3x, 3							; check body4 bit
		jc exitclicklevel3						; if set then exit
		or level3x, 8							; otherwise set body4 bit

		call hidec
		draw 5 2 202 290 black						; clear ellie
		draw 13 14 198 295 cyan
		draw 5 2 202 312 black
		lea dx, txt305							; load ellie conversation
		call setfile
		setwrite cyantxt txt10 index 5
		setwrite lviolettxt txt34 index 29
		setwrite cyantxt txt10 index 5
		setwrite lviolettxt txt34 index 21
		setwrite lviolettxt txt34 index 11
		setwrite cyantxt txt10 index 9
		call showc
		jmp exitclicklevel3						; exit interaction
	clicklevel3body5:
		bt level3x, 4							; check body5 bit
		jc exitclicklevel3						; if set then exit
		or level3x, 16							; otherwise set body5 bit

		call hidec
		draw 5 2 274 200 black						; clear bing
		draw 13 14 270 205 cyan
		draw 5 2 274 222 black
		lea dx, txt306							; load bing conversation
		call setfile
		setwrite cyantxt txt10 index 4
		setwrite lviolettxt txt35 index 54
		setwrite lviolettxt txt35 index 48
		setwrite cyantxt txt10 index 0
		call showc
		jmp exitclicklevel3						; exit interaction
	clicklevel3body6:
		bt level3x, 5							; check body6 bit
		jc exitclicklevel3						; if set then exit
		or level3x, 32							; otherwise set body6 bit

		call hidec
		draw 5 2 274 245 black						; clear bing
		draw 13 14 270 250 cyan
		draw 5 2 274 267 black
		lea dx, txt307							; load bing conversation
		call setfile
		setwrite cyantxt txt10 index 3
		setwrite lviolettxt txt35 index 31
		setwrite lviolettxt txt35 index 32
		setwrite cyantxt txt10 index 0
		call showc
		jmp exitclicklevel3						; exit interaction
	clicklevel3body7:
		bt level3x, 6							; check body7 bit
		jc exitclicklevel3						; if set then exit
		or level3x, 64							; otherwise set body7 bit

		call hidec
		draw 5 2 346 155 black						; clear chloe
		draw 13 14 342 160 cyan
		draw 5 2 346 177 black
		lea dx, txt308							; load chloe conversation
		call setfile
		setwrite cyantxt txt10 index 3
		setwrite lviolettxt txt36 index 4
		setwrite cyantxt txt10 index 3
		setwrite lviolettxt txt36 index 39
		setwrite bluetxt txt10 index 11
		setwrite cyantxt txt10 index 8
		call showc
		jmp exitclicklevel3						; exit interaction
	clicklevel3body8:
		bt level3x, 7							; check body8 bit
		jc exitclicklevel3						; if set then exit
		or level3x, 128							; otherwise set body8 bit

		call hidec
		draw 5 2 418 110 black						; clear joey
		draw 13 14 414 115 cyan
		draw 5 2 418 132 black
		lea dx, txt309							; load joey conversation
		call setfile
		setwrite cyantxt txt10 index 4
		setwrite lviolettxt txt37 index 4
		setwrite cyantxt txt10 index 0
		setwrite lviolettxt txt37 index 14
		setwrite cyantxt txt10 index 0
		call showc
		jmp exitclicklevel3						; exit interaction
	clicklevel3body9:
		bt level3x, 8							; check body9 bit
		jc exitclicklevel3						; if set then exit
		or level3x, 256							; otherwise set body9 bit

		call hidec
		draw 5 2 418 290 black						; clear beth
		draw 13 14 414 295 cyan
		draw 5 2 418 312 black
		lea dx, txt310							; load beth conversation
		call setfile
		setwrite cyantxt txt10 index 3
		setwrite lviolettxt txt38 index 43
		setwrite cyantxt txt10 index 5
		setwrite lviolettxt txt38 index 0
		setwrite cyantxt txt10 index 0
		setwrite lviolettxt txt38 index 22
		setwrite cyantxt txt10 index 26
		call showc
		jmp exitclicklevel3						; exit interaction

	exitclicklevel3:
		cmp level3x, 511						; check everybody
		jnz exitclicklevel3x						; if not everybody then exit
		or level3x, 32768						; otherwise set door bit
	drawwalkers:
		call hidec
		checkpix 30 19 114 61 white
		cmp extent, 1							; check extent
		jz skipwhite1							; if extent is set then skip white
		call delay							; otherwise draw white
		draw 30 11 114 65 black
		draw 20 19 119 61 black
		draw 14 13 122 64 white
	skipwhite1:
		checkpix 30 19 258 61 white
		cmp extent, 1							; check extent
		jz skipwhite2							; if extent is set then skip white
		call delay							; otherwise draw white
		draw 20 19 263 61 black
		draw 30 11 258 65 black
		draw 14 13 266 64 white
	skipwhite2:
		checkpix 30 19 402 61 white
		cmp extent, 1							; check extent
		jz skipwhite3							; if extent is set then skip white
		call delay							; otherwise draw white
		draw 30 11 402 65 black
		draw 20 19 407 61 black
		draw 14 13 410 64 white
	skipwhite3:
		checkpix 19 30 56 124 white
		cmp extent, 1							; check extent
		jz skipwhite4							; if extent is set then skip white
		call delay							; otherwise draw white
		draw 19 20 56 129 black
		draw 11 30 60 124 black
		draw 13 14 59 132 white
	skipwhite4:
		checkpix 19 30 81 196 white
		cmp extent, 1							; check extent
		jz skipwhite5							; if extent is set then skip white
		call delay							; otherwise draw white
		draw 19 20 81 201 black
		draw 11 30 85 196 black
		draw 13 14 84 204 white
	skipwhite5:
		checkpix 19 30 56 267 white
		cmp extent, 1							; check extent
		jz skipwhite6							; if extent is set then skip white
		call delay							; otherwise draw white
		draw 19 20 56 272 black
		draw 11 30 60 267 black
		draw 13 14 59 275 white
	skipwhite6:
		checkpix 19 30 486 124 white
		cmp extent, 1							; check extent
		jz skipwhite7							; if extent is set then skip white
		call delay							; otherwise draw white
		draw 19 20 486 129 black
		draw 11 30 490 124 black
		draw 13 14 489 132 white
	skipwhite7:
		checkpix 19 30 446 195 white
		cmp extent, 1							; check extent
		jz skipwhite8							; if extent is set then skip white
		call delay							; otherwise draw white
		draw 19 20 446 200 black
		draw 11 30 450 195 black
		draw 13 14 449 203 white
	skipwhite8:
		checkpix 19 30 486 267 white
		cmp extent, 1							; check extent
		jz skipwhite9							; if extent is set then skip white
		call delay							; otherwise draw white
		draw 19 20 486 272 black
		draw 11 30 490 267 black
		draw 13 14 489 275 white
	skipwhite9:
		checkpix 30 19 186 343 white
		cmp extent, 1							; check extent
		jz skipwhitea							; if extent is set then skip white
		call delay							; otherwise draw white
		draw 30 11 186 347 black
		draw 20 19 191 343 black
		draw 14 13 194 346 white
	skipwhitea:
		checkpix 30 19 330 343 white
		cmp extent, 1							; check extent
		jz skipwhiteb							; if extent is set then skip white
		call delay							; otherwise draw white
		draw 30 11 330 347 black
		draw 20 19 335 343 black
		draw 14 13 338 346 white
	skipwhiteb:
		lea dx, txt311							; load white conversation
		call setfile
		setwrite bluetxt txt10 index 30
		setwrite bluetxt txt10 index 21
		setwrite bluetxt txt10 index 26
		setwrite cyantxt txt10 index 5
		setwritex txt05 13
		call showc
		jmp getkey							; check key

	nolevel3:
		call hidec
		lea dx, txt312							; load no conversation
		call setfile
		setwrite cyantxt txt10 index 25
		setwrite bluetxt txt10 index 26
		setwrite cyantxt txt10 index 9
		call showc

	exitclicklevel3x:
		ret
clicklevel3 endp

clicklevel4 proc far
	comment $
	interaction for level 4
	$

	checklevel4door:
		cmp cx, 274							; check x coordinate begin
		jl checkstar							; if without then check star
		cmp cx, 363							; check x coordinate end
		jg checkbook2							; if without then check book2
		cmp dx, 331							; check y coordinate begin
		jl checkstar							; if without then check star
		cmp dx, 347							; check y coordinate end
		jg exitclicklevel4						; if without then exit
		jmp clicklevel4door						; if within then do door
	checkstar:
		cmp cx, 70							; check x coordinate begin
		jl exitclicklevel4						; if without then exit
		cmp cx, 89							; check x coordinate end
		jg checkcliff							; if without then check cliff
		cmp dx, 274							; check y coordinate begin
		jl checkcliff							; if without then check cliff
		cmp dx, 298							; check y coordinate end
		jg exitclicklevel4						; if without then exit
		jmp clickstar							; if within then do star
	checkcliff:
		cmp cx, 133							; check x coordinate begin
		jl exitclicklevel4						; if without then exit
		cmp cx, 152							; check x coordinate end
		jg checkbook1							; if without then check book1
		cmp dx, 88							; check y coordinate begin
		jl exitclicklevel4						; if without then exit
		cmp dx, 112							; check y coordinate end
		jg checkbook1							; if without then check book1
		jmp clickcliff							; if within then do cliff
	checkbook1:
		cmp cx, 180							; check x coordinate begin
		jl exitclicklevel4						; if without then exit
		cmp cx, 204							; check x coordinate end
		jg checkbook2							; if without then check book2
		cmp dx, 169							; check y coordinate begin
		jl checkbook2							; if without then check book2
		cmp dx, 188							; check y coordinate end
		jg checkbook3							; if without then check book3
		jmp clickbook1							; if within then do book1
	checkbook2:
		cmp cx, 351							; check x coordinate begin
		jl exitclicklevel4						; if without then exit
		cmp cx, 375							; check x coordinate end
		jg checkbook3							; if without then check book3
		cmp dx, 109							; check y coordinate begin
		jl exitclicklevel4						; if without then exit
		cmp dx, 128							; check y coordinate end
		jg checkbook3							; if without then check book3
		jmp clickbook2							; if within then do book2
	checkbook3:
		cmp cx, 423							; check x coordinate begin
		jl exitclicklevel4						; if without then exit
		cmp cx, 442							; check x coordinate end
		jg checkinfinity						; if without then check infinity
		cmp dx, 252							; check y coordinate begin
		jl checkinfinity						; if without then check infinity
		cmp dx, 276							; check y coordinate end
		jg exitclicklevel4						; if without then exit
		jmp clickbook3							; if within then do book3
	checkinfinity:
		cmp cx, 568							; check x coordinate begin
		jl exitclicklevel4						; if without then exit
		cmp cx, 592							; check x coordinate end
		jg exitclicklevel4						; if without then exit
		cmp dx, 212							; check y coordinate begin
		jl exitclicklevel4						; if without then exit
		cmp dx, 231							; check y coordinate end
		jg exitclicklevel4						; if without then exit
		jmp clickinfinity						; if within then do infinity

	clicklevel4door:
		bt level4x, 0							; check star bit
		jnc nolevel4							; if cleared then write no
		bt level4x, 1							; check cliff bit
		jnc nolevel4							; if clear then write no
		bt level4x, 5							; check infinity bit
		jnc nolevel4							; if clear then write no

		call hidec
		lea dx, txt408							; load door conversation
		call setfile
		setwrite cyantxt txt10 index 17
		setwrite bluetxt txt10 index 21
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 32
		setwrite bluetxt txt10 index 20
		setwrite cyantxt txt10 index 35
		setwrite bluetxt txt10 index 16
		setwrite cyantxt txt10 index 3
		setwrite bluetxt txt10 index 11
		call showc
		jmp level5							; go to next level

		nolevel4:
			call hidec
			lea dx, txt409						; load no conversation
			call setfile
			setwrite cyantxt txt10 index 29
			setwrite bluetxt txt10 index 23
			setwrite bluetxt txt10 index 28
			setwrite bluetxt txt10 index 31
			setwrite cyantxt txt10 index 0
			setwrite cyantxt txt10 index 3
			call showc
			jmp exitclicklevel4					; exit interaction
	clickstar:
		bt level4x, 0							; check star bit
		jc exitclicklevel4						; if set then exit
		or level4x, 1							; otherwise set star bit

		call hidec
		draw 20 25 70 274 black						; clear to the stars
		draw 14 19 73 277 cyan
		draw 10 3 75 289 black
		setwritey 1c1eh 1c29h 12 txt68					; load find objective
		lea dx, txt402							; load to the stars conversation
		call setfile
		setwrite lviolettxt txt41 index 59
		setwrite lviolettxt txt41 index 49
		setwrite lviolettxt txt41 index 26
		setwrite lviolettxt txt41 index 32
		setwrite lviolettxt txt41 index 42
		setwrite lviolettxt txt41 index 30
		setwrite lviolettxt txt41 index 22
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 10
		setwrite cyantxt txt10 index 31
		setwrite bluetxt txt10 index 5
		setwrite cyantxt txt10 index 16
		setwrite bluetxt txt10 index 3
		setwrite cyantxt txt10 index 11
		setwrite bluetxt txt10 index 21
		setwrite cyantxt txt10 index 0
		setwrite bluetxt txt10 index 13
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 13
		call showc
		jmp exitclicklevel4						; exit interaction
	clickcliff:
		bt level4x, 1							; check cliff bit
		jc exitclicklevel4						; if set then exit
		or level4x, 2							; otherwise set cliff bit

		call hidec
		draw 20 25 133 88 black						; clear beyond the cliff
		draw 14 19 136 91 cyan
		draw 10 3 138 95 black
		setwritey 1c0ch 1c1bh 16 txt67					; load find objective
		lea dx, txt403							; load beyond the cliff conversation
		call setfile
		setwrite lviolettxt txt41 index 19
		setwrite lviolettxt txt41 index 32
		setwrite lviolettxt txt41 index 32
		setwrite lviolettxt txt41 index 31
		setwrite lviolettxt txt41 index 27
		setwrite lviolettxt txt41 index 14
		setwrite lviolettxt txt41 index 39
		setwrite lviolettxt txt41 index 51
		setwrite lviolettxt txt41 index 33
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 29
		setwrite bluetxt txt10 index 45
		setwrite cyantxt txt10 index 10
		setwrite bluetxt txt10 index 37
		setwrite bluetxt txt10 index 31
		setwrite bluetxt txt10 index 10
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 12
		setwrite bluetxt txt10 index 0
		call showc
		jmp exitclicklevel4						; exit interaction
	clickbook1:
		bt level4x, 2							; check book1 bit
		jc exitclicklevel4						; if set then exit
		or level4x, 4							; otherwise set book1 bit

		call hidec
		draw 25 20 180 169 black					; clear to kill a mockingbird
		draw 19 14 183 172 cyan
		draw 3 10 195 174 black
		lea dx, txt404							; load to kill a mockingbird conversation
		call setfile
		setwrite lviolettxt txt41 index 40
		setwrite lviolettxt txt41 index 41
		setwrite lviolettxt txt41 index 40
		setwrite lviolettxt txt41 index 32
		setwrite lviolettxt txt41 index 49
		setwrite lviolettxt txt41 index 59
		setwrite lviolettxt txt41 index 37
		setwrite cyantxt txt10 index 13
		setwrite bluetxt txt10 index 15
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 21
		setwrite bluetxt txt10 index 34
		setwrite cyantxt txt10 index 24
		call showc
		jmp exitclicklevel4						; exit interaction
	clickbook2:
		bt level4x, 3							; check book2 bit
		jc exitclicklevel4						; if set then exit
		or level4x, 8							; otherwise set book1 bit

		call hidec
		draw 25 20 351 109 black					; clear the little prince
		draw 19 14 354 112 cyan
		draw 3 10 358 114 black
		lea dx, txt405							; load the little prince conversation
		call setfile
		setwrite lviolettxt txt41 index 48
		setwrite lviolettxt txt41 index 51
		setwrite lviolettxt txt41 index 42
		setwrite cyantxt txt10 index 7
		setwrite bluetxt txt10 index 19
		setwrite bluetxt txt10 index 13
		setwrite cyantxt txt10 index 7
		setwrite bluetxt txt10 index 18
		setwrite cyantxt txt10 index 3
		setwrite bluetxt txt10 index 21
		setwrite cyantxt txt10 index 18
		setwrite bluetxt txt10 index 13
		call showc
		jmp exitclicklevel4						; exit interaction
	clickbook3:
		bt level4x, 4							; check book3 bit
		jc exitclicklevel4						; if set then exit
		or level4x, 16							; otherwise set book1 bit

		call hidec
		draw 20 25 423 252 black					; clear life is strange
		draw 14 19 426 255 cyan
		draw 10 3 428 259 black
		lea dx, txt406							; load life is strange conversation
		call setfile
		setwrite lviolettxt txt41 index 29
		setwrite lviolettxt txt41 index 20
		setwrite lviolettxt txt41 index 39
		setwrite lviolettxt txt41 index 27
		setwrite cyantxt txt10 index 16
		setwrite bluetxt txt10 index 8
		call showc
		jmp exitclicklevel4						; exit interaction
	clickinfinity:
		bt level4x, 5							; check infinity bit
		jc exitclicklevel4						; if set then exit
		or level4x, 32							; otherwise set infinity bit

		call hidec
		draw 25 20 568 212 black					; clear your infinity
		draw 19 14 571 215 cyan
		draw 3 10 575 217 black
		setwritey 1c30h 1c3ch 13 txt69					; load find objective
		lea dx, txt407							; load your infinity conversation
		call setfile
		setwrite lviolettxt txt41 index 41
		setwrite lviolettxt txt41 index 53
		setwrite lviolettxt txt41 index 38
		setwrite lviolettxt txt41 index 24
		setwrite lviolettxt txt41 index 10
		setwrite lviolettxt txt41 index 21
		setwrite lviolettxt txt41 index 19
		setwrite lviolettxt txt41 index 12
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 4
		setwrite bluetxt txt10 index 14
		setwrite cyantxt txt10 index 18
		setwrite cyantxt txt10 index 21
		setwrite bluetxt txt10 index 5
		call showc
		jmp exitclicklevel4						; exit interaction

	exitclicklevel4:
		ret
clicklevel4 endp

clicklevel5 proc far
	comment $
	interaction for level 5
	$

	checkyou:
		bt level5x, 15							; check end bit
		jc checkforget							; if set then check forget
		ref 10 14							; set reference coordinates
		cmp cx, xrefx							; check x coordinate begin
		jl exitclicklevel5						; if without then exit
		cmp dx, yrefx							; check y coordinate begin
		jl exitclicklevel5						; if without then exit
		ref 29 34							; set reference coordinates
		cmp cx, xrefx							; check x coordinate end
		jg exitclicklevel5						; if without then exit
		cmp dx, yrefx							; check y coordinate end
		jg exitclicklevel5						; if without then exit
		jmp clickyou							; if within then do you
	checkforget:
		cmp cx, 30					 		; check x coordinate begin
		jl exitclicklevel5						; if without then exit
		cmp cx, 204							; check y coordinate begin
		jg checkaccept							; if without then check accept
		cmp dx, 254							; check x coordinate end
		jl exitclicklevel5						; if without then exit
		cmp dx, 278							; check y coordinate end
		jg exitclicklevel5						; if without then exit
		jmp clickforget							; if within then do forget
	checkaccept:
		cmp cx, 435							; check x coordinate begin
		jl exitclicklevel5						; if without then exit
		cmp cx, 609							; check y coordinate begin
		jg exitclicklevel5						; if without then exit
		cmp dx, 254							; check x coordinate end
		jl exitclicklevel5						; if without then exit
		cmp dx, 278							; check y coordinate end
		jg exitclicklevel5						; if without then exit
		jmp clickaccept							; if within then do accept

	clickyou:
		bt level5x, 15							; check end bit
		jc exitclicklevel5						; if set then exit
		or level5x, 32768						; otherwise set end bit

	startend:
		call hidec
		ref 5 5
		draw 30 30 xrefx yrefx white

		mov cx, 50
		delaylevel52:
		call delay
		loop delaylevel52

		mov go, 0
		mov xref, 125
		mov yref, 245
		call drawface1

		lea dx, txt502
		call setfile

		mov cx, 10
		delaylevel53:
		call delay
		loop delaylevel53

		setwrite cyantxt txt10 index 22
		setwrite cyantxt txt10 index 0

		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface4
		setwrite cyantxt txt10 index 5
		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface3
		setwrite cyantxt txt10 index 5

		setwrite cyantxt txt10 index 0

		draw 11 30 625 250 black
		draw 19 20 621 255 black
		draw 13 14 624 258 white
		call delay
		draw 19 30 621 250 white
		draw 11 30 615 250 black
		draw 19 20 611 255 black
		draw 13 14 614 258 white
		call delay
		draw 19 30 611 250 white
		draw 11 30 605 250 black
		draw 19 20 601 255 black
		draw 13 14 604 258 white
		call delay
		draw 19 30 601 250 white
		draw 11 30 595 250 black
		draw 19 20 591 255 black
		draw 13 14 594 258 white
		call delay
		draw 19 30 591 250 white
		draw 11 30 585 250 black
		draw 19 20 581 255 black
		draw 13 14 584 258 white
		call delay
		draw 19 30 581 250 white
		draw 11 30 575 250 black
		draw 19 20 571 255 black
		draw 13 14 574 258 white
		call delay
		draw 19 30 571 250 white
		draw 11 30 565 250 black
		draw 19 20 561 255 black
		draw 13 14 564 258 white
		call delay
		draw 19 30 561 250 white
		draw 11 30 555 250 black
		draw 19 20 551 255 black
		draw 13 14 554 258 white
		call delay
		draw 19 30 551 250 white
		draw 11 30 545 250 black
		draw 19 20 541 255 black
		draw 13 14 544 258 white
		call delay
		draw 19 30 541 250 white
		draw 11 30 535 250 black
		draw 19 20 531 255 black
		draw 13 14 534 258 white
		call delay
		draw 19 30 531 250 white
		draw 11 30 525 250 black
		draw 19 20 521 255 black
		draw 13 14 524 258 white
		call delay
		draw 19 30 521 250 white
		draw 11 30 515 250 black
		draw 19 20 511 255 black
		draw 13 14 514 258 white
		call delay
		draw 19 30 511 250 white
		draw 11 30 505 250 black
		draw 19 20 501 255 black
		draw 13 14 504 258 white
		call delay
		draw 19 30 501 250 white
		draw 11 30 495 250 black
		draw 19 20 491 255 black
		draw 13 14 494 258 white
		setwrite lviolettxt txt51 index 10

		setwrite lviolettxt txt51 index 15

		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface4
		setwrite cyantxt txt10 index 4
		setwrite cyantxt txt10 index 10
		setwrite cyantxt txt10 index 22
		setwrite lviolettxt txt51 index 37
		setwrite cyantxt txt10 index 12
		setwrite cyantxt txt10 index 14
		setwrite cyantxt txt10 index 37
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 9
		setwrite lviolettxt txt51 index 0
		setwrite lviolettxt txt51 index 3
		setwrite cyantxt txt10 index 18
		setwrite cyantxt txt10 index 37
		setwrite cyantxt txt10 index 18
		setwrite cyantxt txt10 index 11
		setwrite cyantxt txt10 index 25
		setwrite lviolettxt txt51 index 13
		setwrite cyantxt txt10 index 5
		setwrite lviolettxt txt51 index 34
		setwrite lviolettxt txt51 index 20
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 4

		draw 19 30 491 250 white

		draw 30 11 486 260 black
		draw 20 19 491 256 black
		draw 14 13 494 259 white
		setwrite lviolettxt txt51 index 21

		setwrite lviolettxt txt51 index 40
		setwrite cyantxt txt10 index 16
		setwrite bluetxt txt10 index 8
		setwrite bluetxt txt10 index 14
		setwrite cyantxt txt10 index 29

		draw 30 19 486 256 white

		draw 11 30 495 250 black
		draw 19 20 491 255 black
		draw 13 14 494 258 white
		setwrite lviolettxt txt51 index 23

		setwrite cyantxt txt10 index 8
		setwrite bluetxt txt10 index 25
		setwrite bluetxt txt10 index 15
		setwrite bluetxt txt10 index 14
		setwrite cyantxt txt10 index 5
		setwrite cyantxt txt10 index 20
		setwrite cyantxt txt10 index 5
		setwrite bluetxt txt10 index 2
		setwrite bluetxt txt10 index 4
		setwrite lviolettxt txt51 index 13
		setwrite lviolettxt txt51 index 32
		setwrite lviolettxt txt51 index 7
		setwrite cyantxt txt10 index 5
		setwrite lviolettxt txt51 index 16
		setwrite cyantxt txt10 index 0
		setwrite lviolettxt txt51 index 21
		setwrite cyantxt txt10 index 17
		setwrite lviolettxt txt51 index 18
		setwrite lviolettxt txt51 index 22
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 35
		setwrite cyantxt txt10 index 21
		setwrite cyantxt txt10 index 17

		draw 19 30 491 250 white

		draw 11 30 485 250 black
		draw 19 20 481 255 black
		draw 13 14 484 258 white
		setwrite lviolettxt txt51 index 3

		setwrite cyantxt txt10 index 10
		setwrite lviolettxt txt51 index 5
		setwrite lviolettxt txt51 index 0
		setwrite lviolettxt txt51 index 17
		setwrite lviolettxt txt51 index 25
		setwrite lviolettxt txt51 index 7
		setwrite cyantxt txt10 index 27
		setwrite bluetxt txt10 index 21
		setwrite bluetxt txt10 index 28
		setwrite bluetxt txt10 index 25

		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface1
		setwrite cyantxt txt10 index 31

		setwrite cyantxt txt10 index 15
		setwrite bluetxt txt10 index 16
		setwrite bluetxt txt10 index 23
		setwrite cyantxt txt10 index 8

		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface4
		setwrite lviolettxt txt51 index 24

		setwrite lviolettxt txt51 index 28
		setwrite lviolettxt txt51 index 0
		setwrite lviolettxt txt51 index 6
		setwrite lviolettxt txt51 index 25
		setwrite lviolettxt txt51 index 40
		setwrite cyantxt txt10 index 4
		setwrite lviolettxt txt51 index 16
		setwrite cyantxt txt10 index 0
		setwrite bluetxt txt10 index 5
		setwrite cyantxt txt10 index 16
		setwrite lviolettxt txt51 index 37

		mov go, 5
		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface4
		call delay
		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface4
		setwrite cyantxt txt10 index 17

		setwrite lviolettxt txt51 index 0
		setwrite lviolettxt txt51 index 5
		setwrite lviolettxt txt51 index 0
		setwrite lviolettxt txt51 index 28
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 34
		setwrite lviolettxt txt51 index 9
		setwrite lviolettxt txt51 index 15

		mov cx, 33
		draw5loop1:
		push cx
		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface4
		call delay
		pop cx
		loop draw5loop1
		mov go, 0
		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface1
		setwrite cyantxt txt10 index 0

		setwrite cyantxt txt10 index 5
		setwrite cyantxt txt10 index 0
		setwrite lviolettxt txt51 index 6
		setwrite cyantxt txt10 index 0

		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface2
		setwrite cyantxt txt10 index 5

		setwrite cyantxt txt10 index 3
		setwrite cyantxt txt10 index 0

		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface1
		setwrite cyantxt txt10 index 5
		setwrite cyantxt txt10 index 5
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 3
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 5
		setwrite cyantxt txt10 index 0
		setwrite bluetxt txt10 index 35
		setwrite bluetxt txt10 index 35
		setwrite cyantxt txt10 index 6
		setwrite bluetxt txt10 index 44
		setwrite cyantxt txt10 index 0
		setwrite bluetxt txt10 index 32

		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface4
		setwrite lviolettxt txt51 index 19

		setwrite lviolettxt txt51 index 21
		setwrite cyantxt txt10 index 9
		setwrite lviolettxt txt51 index 59
		setwrite lviolettxt txt51 index 23
		setwrite lviolettxt txt51 index 19
		setwrite lviolettxt txt51 index 0
		setwrite lviolettxt txt51 index 24
		setwrite lviolettxt txt51 index 14
		setwrite cyantxt txt10 index 0
		setwrite lviolettxt txt51 index 30
		setwrite cyantxt txt10 index 0

		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface1
		setwrite cyantxt txt10 index 14

		setwrite cyantxt txt10 index 9
		setwrite lviolettxt txt51 index 31
		setwrite bluetxt txt10 index 43
		setwrite bluetxt txt10 index 30
		setwrite bluetxt txt10 index 0
		setwrite bluetxt txt10 index 31
		setwrite bluetxt txt10 index 29
		setwrite cyantxt txt10 index 13
		setwrite lviolettxt txt51 index 20

		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface4
		setwrite cyantxt txt10 index 7

		setwrite bluetxt txt10 index 25
		setwrite bluetxt txt10 index 26
		setwrite bluetxt txt10 index 23
		setwrite bluetxt txt10 index 0

		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface1
		setwrite bluetxt txt10 index 25
		setwrite bluetxt txt10 index 28
		setwrite bluetxt txt10 index 29
		setwrite bluetxt txt10 index 28
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 5
		setwrite cyantxt txt10 index 5
		setwrite cyantxt txt10 index 0

		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface4

		draw 19 30 481 250 white
		draw 11 30 475 250 black
		draw 19 20 471 255 black
		draw 13 14 474 258 white
		call delay
		draw 19 30 471 250 white
		draw 11 30 465 250 black
		draw 19 20 461 255 black
		draw 13 14 464 258 white
		call delay
		draw 19 30 461 250 white
		draw 11 30 455 250 black
		draw 19 20 451 255 black
		draw 13 14 454 258 white
		call delay
		draw 19 30 451 250 white
		draw 11 30 445 250 black
		draw 19 20 441 255 black
		draw 13 14 444 258 white
		call delay
		draw 19 304 441 250 white
		draw 11 30 435 250 black
		draw 19 20 431 255 black
		draw 13 14 434 258 white
		call delay
		draw 19 30 431 250 white
		draw 11 30 425 250 black
		draw 19 20 421 255 black
		draw 13 14 424 258 white
		call delay
		draw 19 30 421 250 white
		draw 11 30 415 250 black
		draw 19 20 411 255 black
		draw 13 14 414 258 white
		call delay
		draw 19 30 411 250 white
		draw 11 30 405 250 black
		draw 19 20 401 255 black
		draw 13 14 404 258 white
		call delay
		draw 19 30 401 250 white
		draw 11 30 395 250 black
		draw 19 20 391 255 black
		draw 13 14 394 258 white
		call delay
		draw 19 30 391 250 white
		draw 11 30 385 250 black
		draw 19 20 381 255 black
		draw 13 14 384 258 white
		call delay
		draw 19 30 381 250 white
		draw 11 30 375 250 black
		draw 19 20 371 255 black
		draw 13 14 374 258 white
		call delay
		draw 19 30 371 250 white
		draw 11 30 365 250 black
		draw 19 20 361 255 black
		draw 13 14 364 258 white
		call delay
		draw 19 30 361 250 white
		draw 11 30 355 250 black
		draw 19 20 351 255 black
		draw 13 14 354 258 white
		setwrite lviolettxt txt51 index 5

		setwrite lviolettxt txt51 index 33
		setwrite lviolettxt txt51 index 32
		setwrite cyantxt txt10 index 0

		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface1
		setwrite cyantxt txt10 index 59
		setwrite cyantxt txt10 index 49
		setwrite cyantxt txt10 index 0
		setwrite cyantxt txt10 index 26
		setwrite cyantxt txt10 index 0
		setwrite lviolettxt txt51 index 0
		setwrite lviolettxt txt51 index 39
		setwrite cyantxt txt10 index 0
		setwrite lviolettxt txt51 index 22
		setwrite lviolettxt txt51 index 15
		setwrite lviolettxt txt51 index 0
		setwrite lviolettxt txt51 index 36
		setwrite bluetxt txt10 index 31
		setwrite bluetxt txt10 index 18
		setwrite bluetxt txt10 index 0
		setwrite bluetxt txt10 index 29
		setwrite cyantxt txt10 index 0

		mov cx, 30
		draw5loop2:
		call delay
		loop draw5loop2

		draw 19 30 351 250 white

		call delay

		draw 10 22 30 257 blue
		draw 22 5 33 254 blue
		draw 10 5 39 264 blue

		draw 10 19 60 257 blue
		draw 20 5 63 254 blue
		draw 10 19 76 257 blue
		draw 20 5 63 274 blue

		draw 10 25 90 254 blue
		draw 23 5 90 254 blue
		draw 9 7 106 257 blue
		draw 7 25 105 254 blue
		draw 6 4 100 265 blue
		draw 10 10 105 269 blue

		draw 10 19 120 257 blue
		draw 22 5 123 254 blue
		draw 12 5 133 264 blue
		draw 22 5 123 274 blue
		draw 10 15 135 264 blue

		draw 10 19 150 257 blue
		draw 22 5 153 254 blue
		draw 13 5 155 264 blue
		draw 22 5 153 274 blue

		draw 25 5 180 254 blue
		draw 9 25 188 254 blue

		draw 10 22 435 257 lviolet
		draw 20 5 438 254 lviolet
		draw 10 22 450 257 lviolet
		draw 8 4 444 265 lviolet

		draw 10 19 465 257 lviolet
		draw 22 5 468 254 lviolet
		draw 22 5 468 274 lviolet

		draw 10 19 495 257 lviolet
		draw 22 5 498 254 lviolet
		draw 22 5 498 274 lviolet

		draw 10 19 525 257 lviolet
		draw 22 5 528 254 lviolet
		draw 13 5 530 264 lviolet
		draw 22 5 528 274 lviolet

		draw 10 25 555 254 lviolet
		draw 23 5 555 254 lviolet
		draw 8 15 570 254 lviolet
		draw 10 11 570 256 lviolet
		draw 16 4 562 265 lviolet

		draw 25 5 585 254 lviolet
		draw 9 25 593 254 lviolet

		setwritex txt07 16
		call showc
		jmp exitclicklevel5						; exit interaction
	clickforget:
		call hidec
		call clear
		call drawlevelforget						; go to next level
		jmp exitclicklevel5						; exit interaction
	clickaccept:
		call hidec
		call clear
		call drawlevelaccept						; go to next level
		jmp exitclicklevel5						; exit interaction

	exitclicklevel5:
		ret
clicklevel5 endp

clickconvo proc far
	comment $
	interaction for conversation
	$

	getkeyconvo:
		mov ah, 11h							; check key buffer
		int 16h
		jz getbuttonconvo						; if no content then go to getbuttonconvo
		mov ah, 10h							; clear key buffer
		int 16h

		cmp ah, 1							; check scan code
		jz escapex							; if escape then go back
		cmp ah, 15							; check scan code
		jz tabx								; if tab then skip conversation
		cmp al, 13							; check ascii code
		jz enterx							; if enter then exit
		jmp getkeyconvo							; otherwise check key conversation
	getbuttonconvo:
		mov ax, 5h							; check button status
		mov bx, 0h							; set left click status
		int 33h
		cmp bl, 1							; check left click status
		jz enterx							; if clicked then go on
		jmp getkeyconvo							; otherwise check key conversation

	tabx:
		cmp convox, 0							; check skip conversation status
		jz getkeyconvo							; if 0 then check key conversation
		call clearwrite
		call showc
		jmp getkey							; check key

	enterx:
		call clearwrite
		ret
clickconvo endp

drawinst proc far
	comment $
	draw instructions
	$

	call hidec
	mov ax, 600h								; scroll the entire pixels up
	mov bh, white								; set the color attribute to white
	mov cx, 0e00h								; set upper left coordinates
	mov dx, 1d4fh								; set lower right coordinates
	int 10h

	drawinstx:
		lea dx, txt001							; load instructions
		call setfile
		call delay
		setwritez blacktxt 12 0e09h
		call delay
		setwritez cyantxt 42 0f09h
		call delay
		setwritez blacktxt 10 1109h
		call delay
		setwritez cyantxt 22 1209h
		call delay
		setwritez blacktxt 10 1309h
		call delay
		setwritez cyantxt 23 1409h
		call delay
		setwritez blacktxt 5 1509h
		call delay
		setwritez cyantxt 30 1609h
		call delay
		setwritez blacktxt 6 1709h
		call delay
		setwritez cyantxt 10 1809h
		call showc
	getinst:
		mov ah, 11h							; check key buffer
		int 16h
		jz getinst							; if no content then check key
		mov ah, 10h							; clear key buffer
		int 16h

		cmp ah, 1							; check scan code
		jnz getinst							; if not escape then check key
		call hidec
		mov ax, 600h							; scroll the entire pixels up
		mov bh, white							; set the color attribute to white
		mov cx, 0e00h							; set upper left coordinates
		mov dx, 1d4fh							; set lower right coordinates
		int 10h
		jmp drawhalflevelx						; otherwise draw half of levelx
		call clicklevelx
	ret
drawinst endp

drawluna proc far
	comment $
	draw list of luna
	$

	call hidec
	mov ax, 600h								; scroll the entire pixels up
	mov bh, white								; set the color attribute to white
	mov cx, 0e00h								; set upper left coordinates
	mov dx, 1d4fh								; set lower right coordinates
	int 10h

	drawlunax:
		lea dx, txt003							; load lunax
		call setfile
		call delay
		setwritez blacktxt 12 0e09h
		call delay
		setwritez cyantxt 30 0f09h
		call delay
		call readluna
		call showc
	getluna:
		mov ah, 11h							; check key buffer
		int 16h
		jz getluna							; if no content then check key
		mov ah, 10h							; clear key buffer
		int 16h

		cmp ah, 1							; check scan code
		jnz getluna							; if not escape then check key
		call hidec
		mov ax, 600h							; scroll the entire pixels up
		mov bh, white							; set the color attribute to white
		mov cx, 0e00h							; set the upper left coordinate to upper left corner
		mov dx, 1d4fh							; set the lower right coordinate to lower right corner
		int 10h
		jmp drawhalflevelx						; otherwise draw half of levelx
		call clicklevelx
	ret
drawluna endp

drawlevelx proc far
	comment $
	draw level x
	$

	startlevelx:
		mov level, 0
		draw 17 42 71 113 black
		draw 25 8 88 147 black

		draw 17 42 121 113 black

		draw 38 8 150 113 black
		draw 17 38 146 117 black
		draw 13 8 163 130 black

		draw 38 8 200 113 black
		draw 17 34 196 117 black
		draw 13 8 213 130 black
		draw 38 8 200 147 black

		draw 17 42 71 173 black

		draw 38 8 100 173 black
		draw 17 17 96 177 black
		draw 34 8 100 190 black
		draw 17 17 121 194 black
		draw 38 8 96 206 black

		draw 38 8 175 173 black
		draw 17 17 171 177 black
		draw 34 8 175 190 black
		draw 17 17 196 194 black
		draw 38 8 171 206 black

		draw 42 8 221 173 black
		draw 18 35 233 180 black

		draw 17 42 271 173 black
		draw 21 8 288 173 black
		draw 17 12 296 178 black
		draw 21 8 288 190 black
		draw 17 17 296 198 black

		draw 34 8, 325 173 black
		draw 17 38 321 177 black
		draw 17 38 346 177 black
		draw 8 8 338 190 black

		draw 38 8 371 173 black
		draw 17 34 371 181 black
		draw 17 38 396 177 black

		draw 38 8 425 173 black
		draw 17 34 421 177 black
		draw 38 8 425 207 black
		draw 17 9 446 198 black
		draw 22 8 441 190 black

		draw 38 8 475 173 black
		draw 17 34 471 177 black
		draw 13 8 488 190 black
		draw 38 8 475 207 black

		draw 17 42 521 173 black
		draw 21 8 538 173 black
		draw 17 12 546 178 black
		draw 21 8 538 190 black
		draw 17 17 546 198 black

	drawhalflevelx:
		draw 16 3 71 290 black
		draw 7 17 71 290 black
		draw 16 3 71 297 black
		draw 7 6 81 292 black

		draw 7 17 91 290 black
		draw 17 3 91 304 black

		draw 7 15 111 292 black
		draw 7 15 121 292 black
		draw 15 3 112 290 black
		draw 5 3 117 297 black

		draw 7 9 131 290 black
		draw 7 9 141 290 black
		draw 15 4 132 297 black
		draw 7 10 136 297 black

		draw 7 17 71 314 black

		draw 7 17 81 314 black
		draw 16 4 81 314 black
		draw 7 16 90 315 black

		draw 16 4 102 314 black
		draw 7 8 101 315 black
		draw 15 3 102 321 black
		draw 7 8 111 322 black
		draw 16 4 101 327 black

		draw 17 4 121 314 black
		draw 7 17 126 314 black

		draw 7 17 141 314 black
		draw 16 4 141 314 black
		draw 10 4 147 321 black
		draw 7 6 151 315 black
		draw 7 8 151 323 black

		draw 8 16 161 314 black
		draw 14 4 163 327 black
		draw 8 16 171 314 black

		draw 8 15 181 315 black
		draw 16 4 183 314 black
		draw 16 4 183 327 black

		draw 18 4 201 314 black
		draw 8 15 206 316 black

		draw 8 17 221 314 black

		draw 18 15 231 315 black
		draw 14 17 233 314 black
		draw 4 11 238 317 white

		draw 7 17 252 314 black
		draw 16 4 252 314 black
		draw 7 16 261 315 black

		draw 16 4 273 314 black
		draw 7 8 272 315 black
		draw 15 3 273 321 black
		draw 7 8 282 322 black
		draw 16 4 272 327 black

		draw 7 17 71 338 black
		draw 17 3 71 352 black

		draw 7 17 91 338 black

		draw 16 3 102 338 black
		draw 7 7 101 340 black
		draw 15 3 102 345 black
		draw 7 8 111 346 black
		draw 16 3 101 352 black

		draw 17 3 121 338 black
		draw 7 15 126 340 black

		draw 18 14 151 340 black
		draw 14 17 153 338 black
		draw 4 11 158 341 white

		draw 8 15 171 340 black
		draw 16 3 173 338 black
		draw 7 3 177 345 black

		draw 8 17 201 338 black
		draw 11 3 208 352 black

		draw 8 16 221 338 black
		draw 14 3 223 352 black
		draw 8 16 231 338 black

		draw 8 17 241 338 black
		draw 16 3 241 338 black
		draw 8 15 251 340 black

		draw 7 15 262 340 black
		draw 15 3 263 338 black
		draw 7 15 272 340 black
		draw 6 3 267 345 black

		draw 7 14 71 364 black
		draw 16 3 72 362 black
		draw 6 3 77 369 black
		draw 16 3 72 376 black

		draw 7 7 91 362 black
		draw 7 7 101 362 black
		draw 15 3 92 369 black
		draw 7 7 91 372 black
		draw 7 7 101 372 black

		draw 7 17 111 362 black

		draw 17 3 121 362 black
		draw 7 14 126 365 black
	call showc
	ret
drawlevelx endp

drawlevel1 proc far
	comment $
	draw level home
	$

	mov xref, 389								; set x reference coordinate
	mov yref, 156								; set y reference coordinate
	mov level, 1								; save level
	mov level1x, 0								; clear level interaction status
	mov convox, 0								; clear skip conversation status

	startlevel1:
	mov cx, 50
	delaylevel11:
	call delay
	loop delaylevel11

	lea dx, txt101
	call setfile
	setwrite bluetxt txt10 index 13
	setwrite cyantxt txt10 index 0
	setwrite bluetxt txt10 index 12
	setwrite cyantxt txt10 index 5

	drawlevel1x:
		draw 468 11 34 34 black
		draw 11 348 34 34 black
		draw 95 45 45 126 black
		draw 174 11 45 171 black
		draw 84 34 45 137 cyan
		draw 68 11 208 108 black
		draw 43 74 276 45 black
		draw 32 63 287 45 cyan
		draw 11 115 318 45 black
		draw 11 184 491 45 black
		draw 285 11 319 208 black
		draw 68 11 45 234 black
		draw 570 11 34 371 black
		draw 11 10 491 361 black
		draw 11 152 593 219 black

		draw 16 42 32 187 cyan

		draw 17 41 45 45 black
		draw 11 32 48 48 cyan
		draw 32 32 62 48 black
		draw 29 26 62 51 white

		draw 53 44 45 83 black
		draw 47 38 48 86 cyan

		draw 17 17 55 96 black
		draw 11 11 58 99 lviolet
		draw 16 9 72 100 black
		draw 16 3 69 103 lviolet
		draw 9 4 79 109 black
		draw 3 4 82 106 lviolet

		draw 44 63 232 45 black
		draw 38 6 235 48 cyan
		draw 38 48 235 57 white

		draw 33 33 350 45 black
		draw 27 27 353 48 cyan
		draw 15 15 359 54 black
		draw 9 9 362 57 lviolet

		draw 61 107 380 45 black
		draw 55 6 383 48 cyan
		draw 55 18 383 57 white
		draw 55 71 383 78 blue

		draw 30 33 441 45 black
		draw 27 27 441 48 lviolet

		draw 79 52 44 245 black
		draw 36 46 47 248 blue
		draw 24 46 86 248 white
		draw 7 46 113 248 white

		draw 58 77 44 294 black
		draw 36 71 47 297 blue
		draw 13 71 86 297 cyan
		draw 41 42 99 329 black
		draw 38 36 99 332 cyan

		draw 42 42 137 329 black
		draw 36 26 140 332 white
		draw 30 15 143 336 black
		draw 24 9 146 339 lviolet
		draw 36 7 140 361 blue

		draw 81 42 176 329 black
		draw 39 36 179 332 cyan
		draw 53 102 218 269 black
		draw 47 96 221 272 blue

		draw 25 35 232 282 black
		draw 19 29 235 285 lviolet
		draw 15 3 237 289 black

		draw 30 102 268 269 black
		draw 24 96 271 272 cyan

		draw 20 26 298 289 black
		draw 11 20 298 292 cyan
		draw 3 20 312 292 blue

		draw 20 26 298 326 black
		draw 11 20 298 329 cyan
		draw 3 20 312 329 blue

		draw 60 10 381 219 black
		draw 54 4 384 222 lviolet

		draw 109 42 357 269 black
		draw 103 36 360 272 cyan

		draw 44 32 389 274 black
		draw 38 26 392 277 lviolet
		draw 7 7 408 289 black
		draw 3 3 410 286 black

		draw 12 34 353 337 black
		draw 9 28 356 340 blue
		draw 93 37 365 334 black
		draw 87 18 368 337 cyan
		draw 87 10 368 358 blue
		draw 12 35 458 336 black
		draw 9 29 458 339 blue

		draw 45 119 548 235 black
		draw 30 113 551 238 cyan
		draw 6 113 584 238 blue

		draw 21 29 555 278 black
		draw 15 23 558 281 lviolet
		draw 11 10 560 284 black

	bt level5x, 13
	jc backforget
	bt level5x, 14
	jc backaccept

	call drawface2
	setwrite bluetxt txt10 index 22

	mov go, 5
	call delay
	ref 5 5
	draw 30 30 xrefx yrefx white
	call drawface2
	mov cx, 31
	draw1loop1:
		push cx
		call delay
		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface3
		pop cx
		loop draw1loop1
	setwrite cyantxt txt10 index 5

	mov cx, 7
	draw1loop2:
		push cx
		call delay
		ref 5 5
		draw 30 30 xrefx yrefx white
		call drawface2
		pop cx
		loop draw1loop2
	call delay
	ref 5 5
	draw 30 30 xrefx yrefx white
	call drawface4
	mov go, 0
	setwrite cyantxt txt10 index 5

	setwrite bluetxt txt10 index 39
	setwrite cyantxt txt10 index 8
	setwrite bluetxt txt10 index 8
	setwrite cyantxt txt10 index 0
	setwrite cyantxt txt10 index 24
	setwrite bluetxt txt10 index 46
	setwrite cyantxt txt10 index 26
	setwrite bluetxt txt10 index 14
	setwrite cyantxt txt10 index 0
	setwrite bluetxt txt10 index 22
	setwrite bluetxt txt10 index 7
	setwrite cyantxt txt10 index 23
	setwrite bluetxt txt10 index 41
	setwrite cyantxt txt10 index 31
	setwrite bluetxt txt10 index 28
	setwrite cyantxt txt10 index 3
	setwrite bluetxt txt10 index 6
	setwrite cyantxt txt10 index 8
	setwrite bluetxt txt10 index 5
	setwritex txt01 32
	call showc
	mov convox, 1								; set skip conversation status
	ret
drawlevel1 endp

drawlevel2 proc far
	comment $
	draw level stopify
	$

	mov xref, 300								; set x reference coordinate
	mov yref, 286								; set y reference coordinate
	mov level, 2								; save level
	mov level2x, 0								; clear level interaction status
	mov convox, 0								; clear skip conversation status

	startlevel2:
	mov cx, 50
	delaylevel21:
	call delay
	loop delaylevel21

	lea dx, txt201
	call setfile
	setwrite bluetxt txt10 index 26

	drawlevel2x:
		draw 8 124 90 66 black
		draw 460 10 90 66 black
		draw 80 9 10 121 black
		draw 7 193 10 130 black
		draw 9 98 90 246 black
		draw 73 8 17 315 black
		draw 8 124 542 66 black
		draw 79 9 550 121 black
		draw 8 193 621 130 black
		draw 71 8 550 315 black
		draw 10 98 540 246 black

		draw 443 12 98 334 blue

		draw 90 17 274 331 cyan

		draw 73 30 17 130 black
		draw 31 158 17 157 black
		draw 42 30 48 285 black
		draw 6 179 20 133 blue
		draw 58 24 29 133 cyan
		draw 16 155 29 157 cyan
		draw 42 24 45 288 cyan

		draw 5 11 54 264 black
		draw 20 19 59 260 black
		draw 14 13 62 263 lviolet
		draw 5 11 79 264 black

		draw 30 114 98 76 black
		draw 129 30 128 76 black
		draw 156 24 101 79 cyan
		draw 24 84 101 103 cyan

		draw 5 11 174 116 black
		draw 20 19 179 112 black
		draw 14 13 182 115 lviolet
		draw 5 11 199 116 black

		draw 60 120 159 163 black
		draw 9 114 185 166 blue
		draw 20 114 162 166 cyan
		draw 19 114 197 166 cyan

		draw 11 5 138 190 black
		draw 19 20 134 195 black
		draw 13 14 137 198 lviolet
		draw 11 5 138 215 black

		draw 126 60 257 76 black
		draw 28 27 260 79 cyan
		draw 45 27 260 106 cyan
		draw 59 24 291 79 white
		draw 24 19 308 106 lviolet
		draw 24 5 308 128 dviolet
		draw 27 27 353 79 cyan
		draw 45 27 335 106 cyan

		draw 5 11 305 86 black
		draw 20 19 310 82 black
		draw 14 13 313 85 cyan
		draw 5 11 330 86 black

		draw 80 60 279 196 black
		draw 73 53 282 199 blue

		draw 159 30 383 76 black
		draw 30 84 512 106 black
		draw 156 24 383 79 cyan
		draw 24 84 515 103 cyan

		draw 11 5 491 112 black
		draw 19 20 487 117 black
		draw 13 14 490 120 lviolet
		draw 11 5 491 137 black

		draw 60 120 418 163 black
		draw 9 114 444 166 blue
		draw 20 114 421 166 cyan
		draw 19 114 456 166 cyan

		draw 11 5 397 210 black
		draw 19 20 393 215 black
		draw 13 14 396 218 lviolet
		draw 11 5 397 235 black

		draw 71 30 550 130 black
		draw 30 155 591 160 black
		draw 41 30 550 285 black
		draw 56 24 553 133 cyan
		draw 15 155 594 157 cyan
		draw 41 24 555 288 cyan
		draw 6 179 612 133 blue

		draw 5 11 556 170 black
		draw 20 19 561 166 black
		draw 14 13 564 169 lviolet
		draw 5 11 581 170 black

	call drawface1
	setwrite bluetxt txt10 index 43
	setwrite cyantxt txt10 index 28
	setwrite bluetxt txt10 index 30
	setwrite cyantxt txt10 index 41
	setwrite bluetxt txt10 index 15
	setwrite cyantxt txt10 index 21
	setwrite bluetxt txt10 index 8
	setwritex txt02 34
	call showc
	mov convox, 1								; set skip conversation status
	ret
drawlevel2 endp

drawlevel3 proc far
	comment $
	draw level netfilx
	$

	mov xref, 60								; set x reference coordinate
	mov yref, 301								; set y reference coordinate
	mov level, 3								; save level
	mov level3x, 0								; clear level interaction status
	mov convox, 0								; clear skip conversation status

	startlevel3:
	mov cx, 50
	delaylevel31:
	call delay
	loop delaylevel31

	lea dx, txt301
	call setfile
	setwrite bluetxt txt10 index 19

	drawlevel3x:
		draw 579 13 32 34 black
		draw 11 349 32 34 black
		draw 12 349 599 34 black
		draw 579 10 32 373 black

		draw 22 50 27 74 cyan
		draw 50 22 450 30 cyan
		draw 22 50 27 297 cyan
		draw 50 22 450 366 cyan

		draw 38 245 110 90 black
		draw 32 9 113 93 blue
		draw 4 34 113 105 cyan
		draw 25 34 120 105 cyan
		draw 32 5 113 142 blue
		draw 4 34 113 150 cyan
		draw 25 34 120 150 cyan
		draw 32 5 113 187 blue
		draw 4 34 113 195 cyan
		draw 25 34 120 195 cyan
		draw 32 5 113 232 blue
		draw 4 34 113 240 cyan
		draw 25 34 120 240 cyan
		draw 32 5 113 277 blue
		draw 4 34 113 285 cyan
		draw 25 34 120 285 cyan
		draw 32 10 113 322 blue

		draw 11 5 127 107 black
		draw 19 20 123 112 black
		draw 13 14 126 115 lviolet
		draw 11 5 127 132 black

		draw 11 5 127 242 black
		draw 19 20 123 247 black
		draw 13 14 126 250 lviolet
		draw 11 5 127 267 black

		draw 38 245 182 90 black
		draw 32 9 185 93 blue
		draw 4 34 185 105 cyan
		draw 25 34 192 105 cyan
		draw 32 5 185 142 blue
		draw 4 34 185 150 cyan
		draw 25 34 192 150 cyan
		draw 32 5 185 187 blue
		draw 4 34 185 195 cyan
		draw 25 34 192 195 cyan
		draw 32 5 185 232 blue
		draw 4 34 185 240 cyan
		draw 25 34 192 240 cyan
		draw 32 5 185 277 blue
		draw 4 34 185 285 cyan
		draw 25 34 192 285 cyan
		draw 32 10 185 322 blue

		draw 11 5 199 152 black
		draw 19 20 195 157 black
		draw 13 14 198 160 lviolet
		draw 11 5 199 177 black

		draw 11 5 199 287 black
		draw 19 20 195 292 black
		draw 13 14 198 295 lviolet
		draw 11 5 199 312 black

		draw 38 245 254 90 black
		draw 32 9 257 93 blue
		draw 4 34 257 105 cyan
		draw 25 34 264 105 cyan
		draw 32 5 257 142 blue
		draw 4 34 257 150 cyan
		draw 25 34 264 150 cyan
		draw 32 5 257 187 blue
		draw 4 34 257 195 cyan
		draw 25 34 264 195 cyan
		draw 32 5 257 232 blue
		draw 4 34 257 240 cyan
		draw 25 34 264 240 cyan
		draw 32 5 257 277 blue
		draw 4 34 257 285 cyan
		draw 25 34 264 285 cyan
		draw 32 10 257 322 blue

		draw 11 5 271 197 black
		draw 19 20 267 202 black
		draw 13 14 270 205 lviolet
		draw 11 5 271 222 black

		draw 11 5 271 242 black
		draw 19 20 267 247 black
		draw 13 14 270 250 lviolet
		draw 11 5 271 267 black

		draw 38 245 326 90 black
		draw 32 9 329 93 blue
		draw 4 34 329 105 cyan
		draw 25 34 336 105 cyan
		draw 32 5 329 142 blue
		draw 4 34 329 150 cyan
		draw 25 34 336 150 cyan
		draw 32 5 329 187 blue
		draw 4 34 329 195 cyan
		draw 25 34 336 195 cyan
		draw 32 5 329 232 blue
		draw 4 34 329 240 cyan
		draw 25 34 336 240 cyan
		draw 32 5 329 277 blue
		draw 4 34 329 285 cyan
		draw 25 34 336 285 cyan
		draw 32 10 329 322 blue

		draw 11 5 343 152 black
		draw 19 20 339 157 black
		draw 13 14 342 160 lviolet
		draw 11 5 343 177 black

		draw 38 245 398 90 black
		draw 32 9 401 93 blue
		draw 4 34 401 105 cyan
		draw 25 34 408 105 cyan
		draw 32 5 401 142 blue
		draw 4 34 401 150 cyan
		draw 25 34 408 150 cyan
		draw 32 5 401 187 blue
		draw 4 34 401 195 cyan
		draw 25 34 408 195 cyan
		draw 32 5 401 232 blue
		draw 4 34 401 240 cyan
		draw 25 34 408 240 cyan
		draw 32 5 401 277 blue
		draw 4 34 401 285 cyan
		draw 25 34 408 285 cyan
		draw 32 10 401 322 blue

		draw 11 5 415 107 black
		draw 19 20 411 112 black
		draw 13 14 414 115 lviolet
		draw 11 5 415 132 black

		draw 11 5 415 287 black
		draw 19 20 411 292 black
		draw 13 14 414 295 lviolet
		draw 11 5 415 312 black

		draw 13 326 515 47 black
		draw 7 326 518 47 blue
		draw 71 326 528 47 cyan

		draw 10 252 543 81 black
		draw 15 1 545 80 black
		draw 15 1 548 79 black
		draw 15 1 552 78 black
		draw 15 1 556 77 black
		draw 15 1 559 76 black
		draw 15 1 563 75 black
		draw 11 1 567 74 black
		draw 7 1 571 73 black
		draw 4 1 574 72 black
		draw 3 266 575 76 black
		draw 9 1 545 333 black
		draw 9 1 547 334 black
		draw 10 1 549 335 black
		draw 9 1 552 336 black
		draw 10 1 554 337 black
		draw 10 1 556 338 black
		draw 10 1 559 339 black
		draw 10 1 561 340 black
		draw 10 1 563 341 black
		draw 12 1 566 342 black
		draw 10 1 568 343 black
		draw 7 1 571 344 black
		draw 5 1 573 345 black
		draw 2 1 576 346 black
		draw 29 248 546 83 white
		draw 26 1 549 82 white
		draw 22 1 553 81 white
		draw 18 1 557 80 white
		draw 14 1 561 79 white
		draw 11 1 564 78 white
		draw 7 1 568 77 white
		draw 3 1 572 76 white
		draw 27 1 548 331 white
		draw 24 1 551 332 white
		draw 22 1 553 333 white
		draw 20 1 555 334 white
		draw 17 1 558 335 white
		draw 15 1 560 336 white
		draw 13 1 562 337 white
		draw 10 1 565 338 white
		draw 8 1 567 339 white
		draw 6 1 569 340 white
		draw 3 1 572 341 white
		draw 1 1 574 342 white

	call drawface4
	setwrite cyantxt txt10 index 19
	setwrite bluetxt txt10 index 21
	setwrite bluetxt txt10 index 43
	setwrite cyantxt txt10 index 34
	setwrite bluetxt txt10 index 27
	setwrite cyantxt txt10 index 6
	setwrite cyantxt txt10 index 7
	setwritex txt03 8
	call showc
	mov convox, 1								; set skip conversation status
	ret
drawlevel3 endp

drawlevel4 proc far
	comment $
	draw level bookshelf
	$

	mov xref, 300								; set x reference coordinate
	mov yref, 286								; set y reference coordinate
	mov level, 4								; save level
	mov level4x, 0								; clear level interaction status
	mov convox, 0								; clear skip conversation status

	startlevel4:
	mov cx, 50
	delaylevel41:
	call delay
	loop delaylevel41

	lea dx, txt401
	call setfile
	setwrite cyantxt txt10 index 23

	drawlevel4x:
		draw 11 66 90 66 black
		draw 460 10 90 66 black
		draw 80 11 10 121 black
		draw 8 202 10 121 black
		draw 9 32 90 312 black
		draw 72 11 18 312 black
		draw 11 66 542 66 black
		draw 71 11 550 121 black
		draw 8 202 621 121 black
		draw 79 11 550 312 black
		draw 9 32 541 312 black

		draw 443 12 98 334 blue

		draw 90 17 274 331 cyan

		draw 30 114 98 76 black
		draw 129 30 128 76 black
		draw 156 24 101 79 cyan
		draw 24 84 101 103 cyan

		draw 20 25 133 88 black
		draw 14 19 136 91 lviolet
		draw 10 3 138 95 black

		draw 126 60 257 76 black
		draw 28 27 260 79 cyan
		draw 45 27 260 106 cyan
		draw 59 24 291 79 white
		draw 24 19 308 106 white
		draw 24 5 308 128 blue
		draw 27 27 353 79 cyan
		draw 45 27 335 106 cyan

		draw 5 11 305 86 black
		draw 20 19 310 82 black
		draw 14 13 313 85 cyan
		draw 5 11 330 86 black

		draw 25 20 351 109 black
		draw 19 14 354 112 lviolet
		draw 3 10 358 114 black

		draw 83 28 18 132 black
		draw 80 8 18 132 blue
		draw 80 15 18 142 cyan

		draw 26 77 45 184 black
		draw 20 4 48 186 blue
		draw 20 9 48 193 cyan
		draw 40 40 38 202 black
		draw 36 36 40 204 blue
		draw 20 9 48 242 cyan
		draw 20 4 48 254 blue

		draw 11 30 88 207 black
		draw 19 20 84 212 black
		draw 13 14 87 215 cyan

		draw 81 27 18 285 black
		draw 78 15 18 288 cyan
		draw 78 6 18 306 blue

		draw 20 25 70 274 black
		draw 14 19 73 277 lviolet
		draw 10 3 75 289 black

		draw 60 120 159 163 black
		draw 26 114 162 166 blue
		draw 25 114 191 166 cyan

		draw 25 20 180 169 black
		draw 19 14 183 172 lviolet
		draw 3 10 195 174 black

		draw 20 19 238 216 black
		draw 30 11 233 220 black
		draw 14 13 241 219 cyan

		draw 80 60 279 196 black
		draw 73 53 282 199 blue

		draw 20 25 310 213 black
		draw 14 19 313 216 cyan
		draw 10 3 315 220 black

		draw 159 30 383 76 black
		draw 30 84 512 106 black
		draw 156 24 383 79 cyan
		draw 24 84 515 103 cyan

		draw 20 19 438 138 black
		draw 30 11 433 142 black
		draw 14 13 441 141 cyan

		draw 60 120 418 163 black
		draw 25 114 421 166 cyan
		draw 26 114 449 166 blue

		draw 20 25 423 252 black
		draw 14 19 426 255 lviolet
		draw 10 3 428 259 black

		draw 19 20 484 249 black
		draw 11 30 488 244 black
		draw 13 14 487 252 cyan

		draw 79 28 542 132 black
		draw 79 8 542 132 blue
		draw 79 15 542 142 cyan

		draw 26 77 567 184 black
		draw 20 3 570 187 blue
		draw 20 9 570 193 cyan
		draw 40 40 560 202 black
		draw 36 36 562 204 blue
		draw 20 9 570 242 cyan
		draw 20 4 570 254 blue

		draw 25 20 568 212 black
		draw 19 14 571 215 lviolet
		draw 3 10 575 217 black

		draw 80 27 541 286 black
		draw 77 15 544 288 cyan
		draw 77 6 544 306 blue

	call drawface1
	setwrite bluetxt txt10 index 53
	setwrite bluetxt txt10 index 54
	setwrite cyantxt txt10 index 9
	setwrite bluetxt txt10 index 17
	setwrite cyantxt txt10 index 0
	setwrite cyantxt txt10 index 16
	setwrite bluetxt txt10 index 14
	setwrite cyantxt txt10 index 25
	setwrite bluetxt txt10 index 34
	setwrite cyantxt txt10 index 0
	setwrite cyantxt txt10 index 24
	setwrite bluetxt txt10 index 22
	setwrite cyantxt txt10 index 24
	setwrite cyantxt txt10 index 37
	setwrite cyantxt txt10 index 19
	setwrite bluetxt txt10 index 10
	setwritex txt04 54
	call showc
	mov convox, 1								; set skip conversation status
	ret
drawlevel4 endp

drawlevel5 proc far
	comment $
	draw level cliff
	$

	mov xref, 39								; set x reference coordinate
	mov yref, 245								; set y reference coordinate
	mov level, 5								; save level
	mov level5x, 0								; clear level interaction status
	mov convox, 0								; clear skip conversation status

	startlevel5:
	mov cx, 50
	delaylevel51:
	call delay
	loop delaylevel51

	lea dx, txt501
	call setfile
	setwrite cyantxt txt10 index 11

	drawlevel5x:
		draw 640 11 0 178 black

		draw 75 25 282 202 black
		draw 69 19 285 205 blue
		draw 40 17 300 227 black
		draw 34 14 303 227 cyan

		draw 175 40 232 289 black
		draw 169 22 235 292 white
		draw 169 9 235 317 black

		draw 9 9 68 41 blue
		draw 9 9 47 125 blue
		draw 9 9 127 117 blue
		draw 9 9 185 28 blue
		draw 9 9 201 127 blue
		draw 9 9 286 41 blue
		draw 9 9 294 143 blue
		draw 9 9 346 48 blue
		draw 9 9 337 147 blue
		draw 9 9 432 24 blue
		draw 9 9 425 139 blue
		draw 9 9 474 153 blue
		draw 9 9 509 50 blue
		draw 9 9 522 105 blue
		draw 9 9 581 154 blue

		draw 7 7 36 68 cyan
		draw 7 7 94 153 cyan
		draw 7 7 167 86 cyan
		draw 7 7 250 107 cyan
		draw 7 7 320 30 cyan
		draw 7 7 432 99 cyan
		draw 7 7 395 159 cyan
		draw 7 7 486 30 cyan
		draw 7 7 551 67 cyan
		draw 7 7 594 39 cyan

		draw 5 5 168 28 black
		draw 5 5 189 56 black
		draw 5 5 188 98 black
		draw 5 5 185 123 black
		draw 5 5 231 57 black
		draw 5 5 236 137 black
		draw 5 5 272 132 black
		draw 5 5 288 62 black
		draw 5 5 301 115 black
		draw 5 5 357 65 black
		draw 5 5 349 117 black
		draw 5 5 339 132 black
		draw 5 5 395 83 black
		draw 5 5 402 121 black
		draw 5 5 362 150 black
		draw 5 5 436 44 black
		draw 5 5 432 120 black
		draw 5 5 488 80 black
		draw 5 5 490 95 black
		draw 5 5 477 115 black
		draw 5 5 568 24 black
		draw 5 5 550 89 black
		draw 5 5 571 102 black
		draw 5 5 591 140 black
		draw 5 5 20 95 black
		draw 5 5 45 49 black
		draw 5 5 67 139 black
		draw 5 5 84 95 black
		draw 5 5 108 49 black
		draw 5 5 114 136 black

		draw 5 5 10 18 lgray
		draw 5 5 5 143 lgray
		draw 5 5 11 162 lgray
		draw 5 5 45 25 lgray
		draw 5 5 57 66 lgray
		draw 5 5 86 134 lgray
		draw 5 5 107 16 lgray
		draw 5 5 113 120 lgray
		draw 5 5 121 150 lgray
		draw 5 5 127 87 lgray
		draw 5 5 151 103 lgray
		draw 5 5 162 151 lgray
		draw 5 5 183 72 lgray
		draw 5 5 206 20 lgray
		draw 5 5 221 117 lgray
		draw 5 5 226 156 lgray
		draw 5 5 255 132 lgray
		draw 5 5 285 122 lgray
		draw 5 5 293 88 lgray
		draw 5 5 319 54 lgray
		draw 5 5 326 123 lgray
		draw 5 5 336 72 lgray
		draw 5 5 343 21 lgray
		draw 5 5 384 136 lgray
		draw 5 5 394 18 lgray
		draw 5 5 412 139 lgray
		draw 5 5 414 117 lgray
		draw 5 5 489 62 lgray
		draw 5 5 507 21 lgray
		draw 5 5 512 157 lgray
		draw 5 5 531 37 lgray
		draw 5 5 558 105 lgray
		draw 5 5 566 78 lgray
		draw 5 5 609 149 lgray
		draw 5 5 612 86 lgray
		draw 5 5 624 16 lgray

	call drawface4
	setwrite cyantxt txt10 index 4
	setwrite cyantxt txt10 index 10
	setwrite cyantxt txt10 index 0
	setwritex txt03 8
	call showc
	ret
drawlevel5 endp

delay proc far
	comment $
	delay
	$

	push cx
	mov cx, 0ffffh								; set delay
	delayx:
		nop								; do nothing
		loop delayx							; loop delay
	pop cx
	ret
delay endp

drawlevelforget proc far
	comment $
	draw level forget
	$

	mov xref, 389								; set x reference coordinate
	mov yref, 156								; set y reference coordinate
	or level5x, 8192							; set forget bit

	startlevelforget:
	mov cx, 50
	delayforget1:
	call delay
	loop delayforget1

	lea dx, txt101
	call setfile
	setwrite bluetxt txt10 index 13
	jmp drawlevel1x
	backforget:
	call drawface2
	setwrite bluetxt txt10 index 12
	setwrite cyantxt txt10 index 5
	setwrite bluetxt txt10 index 22
	call drawlevelwhite

	setwrite cyantxt txt10 index 0
	setwrite cyantxt txt10 index 5
	setwrite cyantxt txt10 index 0
	setwrite cyantxt txt10 index 5
	setwrite cyantxt txt10 index 0
	call clearwrite

	mov cx, 50
	delayforget3:
	call delay
	loop delayforget3

	call clear

	mov cx, 50
	delayforget4:
	call delay
	loop delayforget4

	call writeluna

	mov cx, 50
	delayforget5:
	call delay
	loop delayforget5

	mov level5x, 0								; clear level interaction status
	jmp escapex								; go back
drawlevelforget endp

drawlevelaccept proc far
	comment $
	draw level accept
	$

	mov xref, 389								; set x reference coordinate
	mov yref, 156								; set y reference coordinate
	or level5x, 16384							; set accept bit

	startlevelaccept:
	mov cx, 50
	delayaccept1:
	call delay
	loop delayaccept1

	lea dx, txt503
	call setfile
	setwrite cyantxt txt10 index 0
	jmp drawlevel1x
	backaccept:
	call drawface2
	setwrite cyantxt txt10 index 5
	setwrite cyantxt txt10 index 0
	setwrite cyantxt txt10 index 5
	setwrite cyantxt txt10 index 0
	call drawlevelwhite

	setwrite cyantxt txt10 index 0
	setwrite cyantxt txt10 index 16
	setwrite cyantxt txt10 index 0
	call clearwrite

	mov cx, 50
	delayaccept3:
	call delay
	loop delayaccept3

	call clear

	mov cx, 50
	delayaccept4:
	call delay
	loop delayaccept4

	call writeluna

	mov cx, 50
	delayaccept5:
	call delay
	loop delayaccept5

	mov level5x, 0								; clear level interaction status
	jmp escapex								; go back
drawlevelaccept endp

drawlevelwhite proc far
	comment $
	clear level
	$

	call delay
		draw 16 42 32 187 white
		draw 468 11 34 34 white
		draw 11 348 34 34 white
		draw 95 45 45 126 white
		draw 174 11 45 171 white
		draw 68 11 208 108 white
		draw 43 74 276 45 white
		draw 11 115 318 45 white
		draw 11 184 491 45 white
		draw 285 11 319 208 white
		draw 68 11 45 234 white
		draw 570 11 34 371 white
		draw 11 10 491 361 white
		draw 11 152 593 219 white
	call delay
		draw 17 41 45 45 white
		draw 32 32 62 48 white
	call delay
		draw 53 44 45 83 white
	call delay
		draw 44 63 232 45 white
	call delay
		draw 33 33 350 45 white
	call delay
		draw 61 107 380 45 white
	call delay
		draw 30 33 441 45 white
	call delay
		draw 79 52 44 245 white
	call delay
		draw 58 77 44 294 white
		draw 41 42 99 329 white
	call delay
		draw 42 42 137 329 white
		draw 30 15 143 336 white
	call delay
		draw 81 42 176 329 white
		draw 53 102 218 269 white
	call delay
		draw 25 35 232 282 white
	call delay
		draw 30 102 268 269 white
	call delay
		draw 20 26 298 289 white
		draw 20 26 298 326 white
	call delay
		draw 60 10 381 219 white
	call delay
		draw 109 42 357 269 white
	call delay
		draw 44 32 389 274 white
	call delay
		draw 12 34 353 337 white
		draw 93 37 365 334 white
		draw 12 35 458 336 white
	call delay
		draw 45 119 548 235 white
	call delay
		draw 21 29 555 278 white
	ret
drawlevelwhite endp

writeluna proc far
	comment $
	write luna file
	$

	mov ah, 13h								; write who string
	mov al, 1h								; string only
	mov bh, 0h								; set video page
	mov bl, lviolettxt							; set color attribute
	mov cx, 12								; set size
	mov dx, 0e21h								; set coordinates
	lea bp, txt08								; load who buffer
	int 10h
	mov ah, 2h								; set cursor
	mov bh, 0h								; set video page
	mov dx, 0f21h								; set coordinates
	int 10h

	mov cx, 5								; set size
	lea bx, inputx								; load input buffer
	clearinput:
	mov byte ptr [bx], 32
	inc bx
	loop clearinput
	mov ah, 0ah
	lea dx, input
	int 21h
	cld
	lea si, input[2]
	lea di, inputx
	xor cx, cx
	mov cl, input[1]
	rep movsb

	lea dx, txt002								; load luna buffer
	call openfile
	call readfile
	call writefile
	call closefile

	mov ah, 13h								; write thank string
	mov al, 1h								; string only
	mov bh, 0h								; set video page
	mov bl, cyantxt								; set color attribute
	mov cx, 9								; set size
	mov dx, 1121h								; set coordinates
	lea bp, txt09								; load thank buffer
	int 10h

	mov cx, 30
	delayluna1:
	call delay
	loop delayluna1

	mov ax, 600h								; scroll the entire pixels up
	mov bh, white								; set the color attribute to white
	mov cx, 0e21h								; set upper left coordinates
	mov dx, 0e2ch								; set lower right coordinates
	int 10h
	call delay
	mov ax, 600h								; scroll the entire pixels up
	mov bh, white								; set the color attribute to white
	mov cx, 1121h								; set upper left coordinates
	mov dx, 112ch								; set lower right coordinates
	int 10h
	ret
writeluna endp

readluna proc far
	comment $
	read luna file
	$

	lea dx, txt002								; load luna buffer
	call openfile
	call readfile
	call closefile

	mov ax, bufferx								; load read size
	cmp ax, 0								; check read size
	jz exitreadluna								; if 0 then exit
	mov dl, 5								; otherwise set divisor
	div dl									; divide read size
	mov cx, ax								; set display counter
	mov si, 1109h								; set starting coordinates
	lea di, txt100x								; load read buffer
	readlunax:
		push cx								; save display counter
		mov ah, 13h							; write luna string
		mov al, 1h							; string only
		mov bh, 0h							; set video page
		mov bl, blacktxt						; set color attribute
		mov cx, 5							; set size
		mov dx, si							; set coordinates
		mov bp, di							; load luna buffer
		int 10h
		inc countluna							; increment luna counter
		add di, 5							; increment luna buffer index
		cmp countluna, 4						; check luna counter
		jz nextluna							; if 4 then increment y coordinate
		add si, 17							; otherwise increment x coordinate
		pop cx								; load display counter
		loop readlunax							; loop display
		jmp exitreadluna						; exit
	nextluna:
		mov countluna, 0						; clear luna counter
		sub si, 51							; set starting x coordinate
		add si, 100h							; increment y coordinate
		pop cx								; load display counter
		loop readlunax							; loop display

	exitreadluna:
		mov countluna, 0						; clear luna counter
		ret
readluna endp
end begin