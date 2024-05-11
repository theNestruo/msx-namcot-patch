
# Galaxian (Namcot, 1984) patch

This is a compatibility patch for _Galaxian_ for MSX to run on MSX2 or later.

This patch is based on Tiny Yarou's previous work at https://www.tiny-yarou.com/kaizoumsx_galaxian.html:

> ## Let's modify Galaxian (MSX)
>
> The early version of MSX version of Galaxian will not work on MSX2 or newer models, or MSX1 that uses the expansion slot with built-in software, because the stack destroys the expansion slot selection register.
>
> &vellip;
>
> The MSX version of Galaxian sets the stack pointer to 0000H immediately after startup and when an interrupt occurs.
>
> Therefore, when a PUSH or CALL occurs even once, the stack is decremented by 2 and data is stored, so the contents of FFFFH are rewritten, but in reality, this address FFFFH is the MSX's "expansion slot selection" address. It is used as a register.
>
> For models that do not have slot expansion, the behavior itself will not change even if this address is rewritten, but for MSX2 and later models, MSX1 that has internal slot expansion (such as word processor equipped machines, disk For machines with built-in drives, etc., the slot changes the moment a value is written to that address, resulting in almost 100% runaway.
>
> So, this time, I changed the two places where 0000H was specified for the stack pointer and made it use D000H or earlier.
> Only for the modification of the ROM version, I specified FFFDH instead of D000H for the stack, but this was done with the consideration that it would work even on MSX with only 8KB of RAM (E000H-FFFFH).
> (It seems that the new version of Galaxian specifies the stack as FFFDH. However, it is an area that should not be used in this way...)
>
> ### Method 3: Make a ROM version
>
> Dump out the Galaxian ROM and rewrite the following 4 bytes.
>
> | offset | Former | new
> |---     |---     |---
> | +0011H | 00H    | FDH
> | +0012H | 00H    | FFH
> | +0045H | 00H    | FDH
> | +0046H | 00H    | FFH
>
> All you have to do is burn the rewritten binary to ROM.
> I think you can create a ROM that works with all MSXs, from MSX1 to turboR.

The original dump, using TOSEC naming convention, should be named `Galaxian (1984)(Namcot)(JP)(en)[!][GoodMSX].rom` and matches:

- MD5: `7b12aba02cceae5e3a05ce9f0ca9acf3`
- SHA1: `e2abb08abacce57703fc008881279890328f6277`

The fixed version matches:

- MD5: `c94d5f115f27250148677e4495c973c3`
- SHA1: `692fd8a85978adafbb530510fff71848f39d4fbd`

According TOSEC naming convention, should be named `Galaxian (1984)(Namcot)(JP)(en)[f MSX2 TinyYarou].rom`. But the fixed version is a known dump, mislabelled as `[a]`:

> #### Alternate - \[a\]
>
> An alternate ORIGINAL version of another ORIGINAL image, e.g. if a game was released, then re-released later with a small change (and the revision/version number is not known).

<br>

# Dig Dug (Namcot, 1984) patch

This is a compatibility patch for _Dig Dug_ for MSX that fixed a graphical glitch on MSX2 or later.

As [Tiny Yarou pointed me out](https://twitter.com/tiny_yarou/status/1787195954581659678), the problem was already known (https://twitter.com/tiny_yarou/status/579348004852736000):

> ### TINY野郎
>
> 少し前に調べたディグダグは、FILVRMを呼んだ直後に、キャリーがOFFであることを前提にしているのか何も考えずSBC HL,DEしていました。MSX2以降だとFILVRM後にキャリーがONになるようで、残機の表示位置がずれます。
>
> I looked into Dig Dug a while ago, and immediately after calling FILVRM, I was doing SBC HL,DE without thinking about it, probably because it assumed that carry was OFF. On MSX2 and later, carry seems to be ON after FILVRM, so the display position of the remaining lives is shifted.
>
> &mdash; 7:25 PM · Mar 21, 2015

The original dump, using TOSEC naming convention, should be named `Dig Dug (1984)(Namcot)(JP)(en)[!][GoodMSX].rom` and matches:
- MD5: `c0cbfd77ff3cabb9cf44ed53bf0ed14b`
- SHA1: `6e2e5cff4ee4dd935fbe6684f2c54b39eca06092`

The fixed version matches:

- MD5: `24a72a629d5e7a0dd53b422032fded64`
- SHA1: `d0d31b3972bf1ec0af1c0017b8fab0bc1a23bbe9`

And, according TOSEC naming convention, should be named `Dig Dug (1984)(Namcot)(JP)(en)[f MSX2].rom`

<br>

# Tower of Druaga, The (Namcot, 1984) patch

This is a patch for _The Tower of Druaga_ for MSX.

This patch is based on Tiny Yarou's previous work at https://www.tiny-yarou.com/kaizoumsx_druaga.html:

> ## Let's remodel the Tower of Druaga (MSX)
>
> The map for each floor of "Tower of Druaga" is created by simply giving one random number seed value, and then the maze is automatically created by a program.
>
> ...This is a well-known story, but in fact, the MSX version of "Tower of Druaga" does not use random numbers, and all map data is stored in the ROM as is.
>
> It seems like they are copying the map from the Famicom version, but for some reason the data for the 50th floor has been copied onto the 49th floor, which seems like an obvious mistake during development.
>
> So, the 49th floor will be remodeled to have the same shape as the Famicom.
>
> Dump out the ROM image of "Tower of Druaga" and rewrite the offset from the beginning as +6C4DH and onward so that it appears in red.
>
>       OFFSET 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
>       ------ ----------------------- -----------------------
>       +6C40H                                        00 01 02
>       +6C50H 01 02 01 02 01 01 01 01 01 01 01 01 01 03 04 10
>       +6C60H 16 11 0E 11 13 0D 15 11 11 14 12 14 15 11 06 05
>       +6C70H 0D 0D 1A 18 0C 15 11 0F 13 1A 0E 14 16 0E 13 07
>       +6C80H 04 11 11 0F 0F 0F 0E 18 12 10 1A 18 1A 11 13 15
>       +6C90H 06 04 0E 13 0D 15 14 16 18 15 11 13 16 0F 13 15
>       +6CA0H 0E 06 04 0E 14 15 0E 0E 14 16 18 0C 12 14 0D 19
>       +6CB0H 17 16 06 04 0E 0E 13 16 13 16 11 0F 0F 11 13 12
>       +6CC0H 0F 11 11 06 08 0A 0A 09 09 09 09 0A 09 09 0A 09
>       +6CD0H 09 09 0A 0A 0B
>
> This will make 49F the same shape as the Famicom version. Please enjoy using an emulator or burning it to his FLASH ROM.

The original dump, using TOSEC naming convention, should be named `Tower of Druaga, The (1984)(Namcot)(JP)(en)[!][GoodMSX].rom` and matches:

- MD5: `8da49cfb7782c6f6391b61cf66105d69`
- SHA1: `9b815efaa927c11827acfdb0f9b9197b5ac97572`

The fixed version matches:

- MD5: `cdc8c289eb0abf2352240858549fa30e`
- SHA1: `833b20ed7db0f4df9b546702a99761b1246a8f24`

And, according TOSEC naming convention, should be named `Tower of Druaga, The (1984)(Namcot)(JP)(en)[f 49F TinyYarou].rom`.
