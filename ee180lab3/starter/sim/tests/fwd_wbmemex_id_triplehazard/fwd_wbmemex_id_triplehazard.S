###############################################################################
# File         : add.S
# Project      : EE180 Lab 2: MIPS
#
# Standards/Formatting:
#   MIPS gas, soft tab, 80 column
#
# Description:
#   Test whether 4 or more consecutive data dependencies can be handled for both rs and rt. Forwarding paths involved:
# 	ex->id, mem->id, wb->id.
###############################################################################


    .section .boot, "x"
    .balign 4
    .set    noreorder
    .global boot
    .ent    boot
boot:
    lui     $s0, 0x8002         # Load the base address of the status/test registers
    ori     $s1, $0, 1          # Prepare the 'done' status
    lui     $t0, 0xffff         # A = 0xfffffffd (-3)
    nop
    ori     $t0, $t0, 0xfffd
    ori     $t1, $0, 0x4        # B = 0x4
    add     $t0, $t0, $t1       # C = A+B = 1. Need t1(rt) immediately: ex->id. need t0(rs) one delayed: mem->id
	add		$t1, $t1, $t0		# D = B + C = 5. Need $t1(rs) from ex, but stale result in wb; $t1(rt) needed from mem
	add		$t1, $t1, $t1 		# D = 2D = 10 Need $t1(rs and rt) from ex but stale result in mem
	add 	$t1, $t1, $t1		# D = 2D = 20 Need rs and rt from ex but stale result in both mem and wb
	addi 	$t1, $t1, -19		# return 1 if we succeed
    sw      $t1, 4($s0)         # Set the test result
    sw      $s1, 0($s0)         # Set 'done'

$done:
    j       $done
    nop

    .end boot
