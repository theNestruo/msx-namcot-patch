
#
# commands & tools
#

ASM=tniasm
EMULATOR=cmd /c start
IPS="bin\x64\Lunar IPS.exe"
REMOVE=cmd /c del

#
# paths and file lists
#

ROMS=\
	rom\DigDug.rom \
	rom\Galaxian.rom \
	rom\TowerOfDruaga.rom

SRCS=\
	src\DigDug_patch.asm \
	src\Galaxian_patch.asm \
	src\TowerOfDruaga_patch.asm

FIXED_ROMS=\
	patch\DigDug_fixed.rom \
	patch\Galaxian_fixed.rom \
	patch\TowerOfDruaga_fixed.rom

IPSS=\
	patch\DigDug_fixed.ips \
	patch\Galaxian_fixed.ips \
	patch\TowerOfDruaga_fixed.ips

# default target
default: patches

#
# phony targets
#

clean:
	$(REMOVE) $(FIXED_ROMS) $(IPSS)
	$(REMOVE) tniasm.sym tniasm.tmp

compile: $(FIXED_ROMS)

patches: $(FIXED_ROMS) $(IPSS)

run: $(FIXED_ROMS)
	$(EMULATOR) $<

#
# main targets
#

patch\DigDug_fixed.rom: src\DigDug_patch.asm rom\DigDug.rom
	$(ASM) $< $@

patch\DigDug_fixed.ips: patch\DigDug_fixed.rom rom\DigDug.rom
	$(IPS) -CreateIPS patch\\DigDug_fixed.ips patch\\DigDug_fixed.rom rom\\DigDug.rom


patch\Galaxian_fixed.rom: src\Galaxian_patch.asm rom\Galaxian.rom
	$(ASM) $< $@

patch\Galaxian_fixed.ips: patch\Galaxian_fixed.rom rom\Galaxian.rom
	$(IPS) -CreateIPS patch\\Galaxian_fixed.ips patch\\Galaxian_fixed.rom rom\\Galaxian.rom


patch\TowerOfDruaga_fixed.rom: src\TowerOfDruaga_patch.asm rom\TowerOfDruaga.rom
	$(ASM) $< $@

patch\TowerOfDruaga_fixed.ips: patch\TowerOfDruaga_fixed.rom rom\TowerOfDruaga.rom
	$(IPS) -CreateIPS patch\\TowerOfDruaga_fixed.ips patch\\TowerOfDruaga_fixed.rom rom\\TowerOfDruaga.rom
