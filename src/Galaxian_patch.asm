
; -----------------------------------------------------------------------------
; (Comment to verify original ROM)
	PATCHED:
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; "Galaxian (1984)(Namcot)(JP)(en)[!][GoodMSX].rom"
; - MD5: 7b12aba02cceae5e3a05ce9f0ca9acf3
; - SHA1: e2abb08abacce57703fc008881279890328f6277

	org	$4000
BASE:
	incbin	"rom/Galaxian.rom"
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
	forg    $4010 - BASE
	org	$4010

	IFDEF PATCHED
		; (patched code)
		ld	sp, $fffd
	ELSE
		; (original code)
		ld	sp, $0000
	ENDIF ; IFDEF PATCHED

	forg    $4044 - BASE
	org	$4044

	IFDEF PATCHED
		; (patched code)
		ld	sp, $fffd
	ELSE
		; (original code)
		ld	sp, $0000
	ENDIF ; IFDEF PATCHED
; -----------------------------------------------------------------------------

; EOF
