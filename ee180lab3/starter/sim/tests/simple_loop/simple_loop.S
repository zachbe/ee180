		###############################################################################
# File         : lbu.S
# Project      : EE180 Lab 2: MIPS
#
# Standards/Formatting:
#   MIPS gas, soft tab, 80 column
#
# Description:
#   Test the functionality of the 'lbu' instruction.
#
###############################################################################


    .section .boot, "x"
    .balign 4
    .set    noreorder
    .global boot
    .ent    boot
boot:
    lui     $s0, 0x8002         # Load the base address of the status/test registers
    ori     $s1, $0, 1          # Prepare the 'done' status
    lui     $t0, 0              # Load some valid address 0x00003210 to register $t0
    ori     $t0, $t0, 0x3210
	addiu	$t1, $0, $0 		#t1 = 0
	addiu 	$t6, $0, -1			#set index to -1 (becomes 0 after first delayed branch)
	lui		$t7, 0x0000
	ori		$t7, 0x000F			#set max index to 16
	j loop_cond
	nop

loop:							#for i = 0; i < 16; i++ {t1 = t1 + i}
    lw      $t1, 0($t0)			#t1
	sll		$t1, $t1, 1			#t1 = 2*t1
	addu	$t1, $t6, $t1
	addu	$t1, $t1, $t6		#t1 = t1 + 2*i
	srl		$t1, $t1, 1			$t1 = t1/2
	sw		$t1, 0($t0)

loop_cond: 
	bne		$t7, $t6, loop
	addiu	$t6, $t6, 1
	lw 		$t1, 0($t0)
	addiu 	$v0, $t1, -127
    sw      $v0, 4($s0)         # Set the test result
    sw      $s1, 0($s0)         # Set 'done'

$done:
    j       $done
    nop

    .end boot
