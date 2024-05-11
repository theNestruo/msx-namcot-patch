
; -----------------------------------------------------------------------------
; (Comment to verify original ROM)
	PATCHED:
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; MSX BIOS entry points and constants
	FILVRM: equ $0056
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; "Dig Dug (1984)(Namcot)(JP)(en)[!][GoodMSX].rom"
; - MD5: c0cbfd77ff3cabb9cf44ed53bf0ed14b
; - SHA1: 6e2e5cff4ee4dd935fbe6684f2c54b39eca06092

	org	$4000
BASE:
	incbin	"rom/DigDug.rom"
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
	forg    $8099 - BASE
	org	$8099
L8099:

; Clears the lives left in the scoreboard
	ld      hl, $3d17       ; (VRAM address)
	ld      a, $24          ; (blank character)
	ld      bc, 8
	call    L8127           ; (FILVRM)

	ld      hl, $3d37       ; (VRAM address)
	ld      bc, 8
	call    L8127           ; (FILVRM)

; Checks lives left
	ld      a, ($e700)
	and     a
	ret     z               ; (no lives left)
; Lives left: starts printing
	ld      b, a
	ld      hl, $3d1d       ; (VRAM address)

.LB0B6:
	push    bc

; Prints one life -------------------------------------------------------------

; Top left character
	ld      a, $68          ; (top left character)
	ld      bc, 1
	call    L8127           ; (FILVRM)
; Moves down
	ld      de, 32
	add     hl, de
; Bottom left character
	inc     a               ; (bottom left character)
	ld      bc, 1
	call    L8127           ; (FILVRM)

; Moves up and right

	IFDEF PATCHED
	; (patched code)
		ld      de, -32 +1
		inc     a               ; (top right character)
		add     hl, de
	; (5 bytes)
		nop			; (padding)
	; (6 bytes)
	ELSE
	; (original code)
		ld      de, 32 -1
		inc     a               ; (top right character)
		sbc     hl, de
	; (6 bytes)
	ENDIF ; IFDEF PATCHED

; Top right character
	ld      bc, 1
	call    L8127           ; (FILVRM)
; Moves down
	ld      de, 32
	add     hl, de
; Bottom right character
	inc     a               ; (bottom right character)
	ld      bc, 1
	call    L8127           ; (FILVRM)

; Moves up and 3x left (next life)
	ld      de, 32 + 3
	and     a
	sbc     hl, de

; Loop
	pop     bc
	djnz    .LB0B6
	ret
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
	forg    $8127 - BASE
	org	$8127
L8127:
	jp      FILVRM
; -----------------------------------------------------------------------------

; EOF
