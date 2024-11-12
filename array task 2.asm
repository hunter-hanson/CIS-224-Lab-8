.data
    input_array:  .word 1, 2, 5,      # Input array
    output_array: .word 0:3                # Output array (initialized with 3 zeros)
    array_size:   .word 3                  # Size of the arrays
    space:        .asciiz " "              # Space for printing

.text
.globl main

main:
    la $t0, input_array    # Load address of input array
    la $t1, output_array   # Load address of output array
    lw $t2, array_size     # Load size of array
    li $t3, 0              # Initialize loop counter

# Loop to calculate squares
square_loop:
    beq $t3, $t2, print_results  # If counter == size, exit loop
    
    lw $t4, ($t0)          # Load current element from input array
    mul $t5, $t4, $t4      # Square the element
    sw $t5, ($t1)          # Store result in output array
    
    addi $t0, $t0, 4       # Move to next element in input array
    addi $t1, $t1, 4       # Move to next position in output array
    addi $t3, $t3, 1       # Increment loop counter
    j square_loop          # Jump back to start of loop

# Print results
print_results:
    la $t1, output_array   # Reset address of output array
    li $t3, 0              # Reset loop counter

print_loop:
    beq $t3, $t2, exit     # If counter == size, exit

    lw $a0, ($t1)          # Load element from output array
    li $v0, 1              # System call for print integer
    syscall

    la $a0, space          # Load address of space
    li $v0, 4              # System call for print string
    syscall

    addi $t1, $t1, 4       # Move to next element in output array
    addi $t3, $t3, 1       # Increment loop counter
    j print_loop           # Jump back to start of print loop

exit:
    li $v0, 10             # System call for exit
    syscall