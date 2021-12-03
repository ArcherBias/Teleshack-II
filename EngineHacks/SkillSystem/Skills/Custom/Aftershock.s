@802c874 checks uncounterable
.equ AftershockID, SkillTester+4
@jumptohack at 802c864

.thumb
push {r4-r7}
@original stuff
ldr r4, =0x203a4ec
mov r5, r12
ldr r0, [r4, #0x4c]
ldr r1, [r5, #0x4c] @if EITHER one has uncounterable weapon
orr r0, r1
mov r1, #0x80
and r0, r1
cmp r0, #0
bne Uncounterable

@ check if thunder magic is used
ldrb r0, [r6,#0x12]	@item slot
lsl r0, #1
add r0, #0x1E @item1
ldrb r0, [r4, r0] @equipped item

cmp	r0, #0x10 @Thunder Sword
beq Normal
cmp	r0, #0x39 @Thunder
beq Normal
cmp	r0, #0x3B @Bolting
beq Normal
cmp	r0, #0x3C @Thoron
beq Normal

@otherwise check skill ONLY on the attacker
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, AftershockID
.short 0xf800
cmp r0, #0
beq Normal

Uncounterable:
mov r3, r5
pop {r4-r7}
ldr r1, =0x802c877
bx r1

Normal:
mov r3, r5
pop {r4-r7}
ldr r1, =0x802c887
bx r1

.align
.ltorg
SkillTester:
@POIN SkillTester
@WORD AftershockID
