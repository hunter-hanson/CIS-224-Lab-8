.data
array: .word 10, 20, 30, 40, 50  # Example array
size:  .word 5              # Size of the array
.text
main:
    la $t0, array    # Load address of array into $t0
    lw $t1, size     # Load size of array into $t1
    li $t2, 0        # Initialize loop counter to 0

loop:
    beq $t2, $t1, exit  # If counter == size, exit loop
    
    lw $a0, ($t0)    # Load current element into $a0
    li $v0, 1        # System call code for print integer
    syscall
    
    # Print a space or newline (optional)
    li $v0, 11       # System call code for print character
    li $a0, 32       # ASCII code for space
    syscall
    
    addi $t0, $t0, 4 # Move to next element (increment by 4 bytes)
    addi $t2, $t2, 1 # Increment loop counter
    j loop           # Jump back to start of loop

exit:
    # Exit program
    li $v0, 10
    syscall