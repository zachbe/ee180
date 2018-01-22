#==============================================================================
# File:         mergesort.s (PA 1)
#
# Description:  Skeleton for assembly mergesort routine. 
#
#       To complete this assignment, add the following functionality:
#
#       1. Call mergesort. (See mergesort.c)
#          Pass 3 arguments:
#
#          ARG 1: Pointer to the first element of the array
#          (referred to as "nums" in the C code)
#
#          ARG 2: Number of elements in the array
#
#          ARG 3: Temporary array storage
#                 
#          Remember to use the correct CALLING CONVENTIONS !!!
#          Pass all arguments in the conventional way!
#
#       2. Mergesort routine.
#          The routine is recursive by definition, so mergesort MUST 
#          call itself. There are also two helper functions to implement:
#          merge, and arrcpy.
#          Again, make sure that you use the correct calling conventions!
#
#==============================================================================

.data
HOW_MANY:   .asciiz "How many elements to be sorted? "
ENTER_ELEM: .asciiz "Enter next element: "
ANS:        .asciiz "The sorted list is:\n"
SPACE:      .asciiz " "
EOL:        .asciiz "\n"

.text
.globl main

#==========================================================================
main:
#==========================================================================

    #----------------------------------------------------------
    # Register Definitions
    #----------------------------------------------------------
    # $s0 - pointer to the first element of the array
    # $s1 - number of elements in the array
    # $s2 - number of bytes in the array
    #----------------------------------------------------------
    
    #---- Store the old values into stack ---------------------
    addiu   $sp, $sp, -32
    sw      $ra, 28($sp)

    #---- Prompt user for array size --------------------------
    li      $v0, 4              # print_string
    la      $a0, HOW_MANY       # "How many elements to be sorted? "
    syscall         
    li      $v0, 5              # read_int
    syscall 
    move    $s1, $v0            # save number of elements

    #---- Create dynamic array --------------------------------
    li      $v0, 9              # sbrk
    sll     $s2, $s1, 2         # number of bytes needed
    move    $a0, $s2            # set up the argument for sbrk
    syscall
    move    $s0, $v0            # the addr of allocated memory


    #---- Prompt user for array elements ----------------------
    addu    $t1, $s0, $s2       # address of end of the array
    move    $t0, $s0            # address of the current element
    j       read_loop_cond

read_loop:
    li      $v0, 4              # print_string
    la      $a0, ENTER_ELEM     # text to be displayed
    syscall
    li      $v0, 5              # read_int
    syscall
    sw      $v0, 0($t0)     
    addiu   $t0, $t0, 4

read_loop_cond:
    bne     $t0, $t1, read_loop 

    #---- Call Mergesort ---------------------------------------

    # Create temp array, store pointer at a2
    li      $v0, 9              # sbrk
    move    $a0, $s2            # s2 already contains the number of bytes
    syscall
    move    $a2, $v0            # arg 2 is temp array address
    move    $a0, $s0            # arg 0 is the unsorted array
    move    $a1, $s1            # arg 1 is the number of elements
    jal     mergesort
    # then pass the three arguments in $a0, $a1, and $a2 before
    # calling mergesort

    #---- Print sorted array -----------------------------------
    li      $v0, 4              # print_string
    la      $a0, ANS            # "The sorted list is:\n"
    syscall

    #---- For loop to print array elements ----------------------
    
    #---- Iniliazing variables ----------------------------------
    move    $t0, $s0            # address of start of the array
    addu    $t1, $s0, $s2       # address of end of the array
    j       print_loop_cond

print_loop:
    li      $v0, 1              # print_integer
    lw      $a0, 0($t0)         # array[i]
    syscall
    li      $v0, 4              # print_string
    la      $a0, SPACE          # print a space
    syscall            
    addiu   $t0, $t0, 4         # increment array pointer

print_loop_cond:
    bne     $t0, $t1, print_loop

    li      $v0, 4              # print_string
    la      $a0, EOL            # "\n"
    syscall          

    #---- Exit -------------------------------------------------
    lw      $ra, 28($sp)
    addiu   $sp, $sp, 32
    jr      $ra


# ADD YOUR CODE HERE!
.globl mergesort
.globl merge


mergesort: 
    addiu   $sp, $sp, -20 #int temparr, tempn, tempmid; #allocate 3 words on the stack
    sw      $ra, 16($sp) #store return address 
    sw      $a2, 12($sp) #store temp array address, since a2 is used later
    sw      $a0, 8($sp) #temparr = array #save array pointer across recursive calls
    sw      $a1, 4($sp) #tempn = n; #save n across recursive calls
    addi    $t0, $a1, -2 # subtract 2 from n
    bltz    $t0, mergesort_return #if n < 2, return
    srl     $t1, $a1, 1 #mid = n/2;
    sw      $t1, 0($sp) #tempmid = mid;
    move    $a1, $t1    #set mid as 2nd argument
    jal     mergesort #mergesort(array,mid,temp_array)
    lw      $t2, 0($sp)
    sll     $t4, $t2, 2
    addu    $a0, $a0, $t4 #advance array pointer by mid
    lw      $t3, 4($sp)
    sub     $a1, $t3, $t2 #2nd argument = n - mid
    jal     mergesort #mergesort(array + mid, n - mid, temp_array)
    lw      $a0, 8($sp) #1st arg: array
    lw      $a1, 4($sp) #2nd arg: n
    lw      $a2, 12($sp) #3rd arg: temp_arr
    lw      $a3, 0($sp) #4th arg: mid
    jal     merge
    lw      $ra, 16($sp)
    addiu   $sp, $sp, 20 #restore stack pointer
    jr      $ra

mergesort_return:
    lw      $ra, 16($sp)
    addiu   $sp, $sp, 20 #restore stack pointer
    jr      $ra

#--------------------------------------------------

merge: #ARR, NUM, TEMP, MID
    move $t0, $a2             # tpos
    move $t1, $a0             # lpos
    sll  $t3, $a1, 2
    addu $t3, $a0, $t3        # end of array (rn)
    sll  $t4, $a3, 2
    addu $t4, $a0, $t4        # rpos
    move $t5, $t4             # mid
    j merge_loop_cond

merge_loop:
    lw $t6, 0($t4)               # rarr[rpos]
    lw $t7, 0($t1)               # arr[lpos]
    ble $t6, $t7, right_less     # branch to the less one
left_less:
    sw $t7, 0($t0)                  # t[tpos] = a[lpos]
    addiu $t0, $t0, 4            # tpos++
    addiu $t1, $t1, 4            # lpos ++
    j merge_loop_cond
right_less:
    sw $t6, 0($t0)                  # t[tpos] = ar[rpos]
    addiu $t0, $t0, 4            # tpos++
    addiu $t4, $t4, 4            # rpos ++

merge_loop_cond:
    slt $t6, $t1, $t5           # lpos < mid
    slt $t7, $t4, $t3           # rpos < rn
    and $t6, $t6, $t7           # lpos < mid & rpos < rn
    bnez $t6, merge_loop        # branch is above is not zero

    move $t6, $a0
    move $t7, $a2
    move $t8, $a1               #save these for later

    bge $t1, $t5, lpos_not_less_mid # if lpos < mid
    move $a0, $t0
    move $a1, $t1
    subu $a2, $t5, $t1
    srl $a2, $a2, 2
    move $t9, $ra
    jal arrcpy                      # copy_array(temp + tpos, larr + lpos, mid - lpos)
    move $ra, $t9
lpos_not_less_mid:

    bge $t4, $t3, rpos_not_less_rn  # if rpos < rn
    move $a0, $t0
    move $a1, $t4
    subu $a2, $t3, $t4
    srl $a2, $a2, 2
    move $t9, $ra
    jal arrcpy                      # copy_array(temp + tpos, rarr + rpos, mid - rpos)
    move $ra, $t9

rpos_not_less_rn:

    move $a0, $t6
    move $a1, $t7
    move $a2, $t8
    move $t9, $ra
    jal arrcpy                      # copy_array(arr, temp_arr, n)
    move $ra, $t9

    jr      $ra               

#-------------------------------------------------

arrcpy: #DST, SRC, NUM_ELEMS
    move    $t0, $a0            # start of dest array
    sll     $t2, $a2, 2         # number of bytes in array
    addu    $t1, $a0, $t2       # end of array
    move    $t3, $a1            # start of src array
    j copy_loop_cond

copy_loop:
    lw      $t2, 0($t3)           # load source word
    sw      $t2, 0($t0)            # save source word to dest array
    addiu   $t0, $t0, 4         # increment dest pointer
    addiu   $t3, $t3, 4         # increment source pointer

copy_loop_cond:
    bne     $t0, $t1, copy_loop
    jr      $ra                 # return
