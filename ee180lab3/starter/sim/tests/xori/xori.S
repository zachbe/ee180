###############################################################################
# File         : xor.S
# Project      : EE180 Lab 2: MIPS
#
# Standards/Formatting:
#   MIPS gas, soft tab, 80 column
#
# Description:
#   Test the functionality of the 'xori' instruction.
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
    lui     $t0, 0xdeaf         # A = 0xdeafbeef
    ori     $t0, $t0, 0xbeef
    xori    $t3, $t0, 0xFFFF      # D = xor(A,0x0000FFFF) = {A[31:16,~A[15:0]}
	and		$t3, $t3, $t0 	#D = A & D = upper(A)
	sub     $t5, $t0, $t3 	#E = A - D = ~A[15:0];
	xori 	$t4, $t5, 1		#F = xor(E, 1) = {16{1'b0},~A[15:1], A[0]}	
    xor 	$t4, $t0, $t4	#F = xor(F, A) = {A[31:16],0xFFFE} 
	xori 	$t4, $t4, 0xFFFF	#F = {A[31:16], 0x0001}
	subu 	$t4, $t4, $t3 	#F = F - D = 32'b1

    sw      $t4, 4($s0)         # Set the test result
    sw      $s1, 0($s0)         # Set 'done'

$done:
    j       $done
    nop

    .end boot
