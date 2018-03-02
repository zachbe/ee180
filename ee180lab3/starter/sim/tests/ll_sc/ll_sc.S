###############################################################################
# File         : ll_sc.S
# Project      : EE180 Lab 2: MIPS
#
# Standards/Formatting:
#   MIPS gas, soft tab, 80 column
#
# Description:
#   Test the functionality of the 'lw' instruction.
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
    nop
    ori     $t0, $t0, 0x3210
    nop
    nop
    nop
    sw      $0, 0($t0)
    ori     $t1, $0, 1
    nop
    nop
    nop
    sw      $t1, 0($t0)
    nop
    nop
    nop
    ll      $t2, 0($t0) #load linked
    nop
    nop
    nop
    sw      $0, 0($t0) #should break it
    nop
    nop
    nop
    sc      $t2, 0($t0) #t2 should be zero
    bnez    $t2, $fail
    ori     $t2, $0, 1
    nop
    nop
    nop
    ll      $t2, 0($t0) #load linked
    nop
    nop
    nop
    sc      $t2, 0($t0)         # t2 should be 1
    nop
    nop
    nop
    lw      $t3, 0($t0)         #t3 should be 1
    and     $t2, $t3, $t2       #boht are one
    sw      $t2, 4($s0)         # Set the test result
    sw      $s1, 0($s0)         # Set 'done'

$done:
    j       $done
    nop

$fail:
    sw      $0, 4($s0)         # Set the test result
    sw      $s1, 0($s0)         # Set 'done'
    j       $done

    .end boot
