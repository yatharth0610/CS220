.data
        message1: .asciiz "Enter n: "
        message2: .asciiz "Enter array elements line by line: "
        message3: .asciiz "Enter integer to search for: "
        message4: .asciiz "Found element at zero based index: "
        message5: .asciiz "Element was not found"
        message6: .asciiz "No array to search in"
        arr: .space 48

.text
.globl main

        main: 
                # message requesting n as input
                li $v0, 4 
                la $a0, message1
                syscall

                # read n and store it in $t0
                li $v0, 5
                syscall
                addi $t0 ,$v0, 0

                # check if n == 0
                beqz $t0, finish_n0
                
                # load address of arr in $t1
                la $t1, arr

                # setup counter in $s0
                li $s0, 0

                # message requesting arr as input
                li $v0, 4 
                la $a0, message2
                syscall
        
        arr_in:         
                # read element of arr and store it
                li $v0, 5
                syscall 
                sw $v0, 0($t1)

                # move pointer to arr ahead
                addi $t1, $t1, 4

                # increment counter and check for loop ending
                addi $s0, $s0, 1
                bne $s0, $t0, arr_in 

                # reset counter in $s0 if loop is done
                li $s0, 0
                
                # reset pointer to arr
                la $t1, arr 

        k_in: 
                # message requesting element to look for
                li $v0, 4 
                la $a0, message3
                syscall

                # read k and store it in $t2
                li $v0, 5
                syscall
                addi $t2 ,$v0, 0

                # Preparing to start binary search
                xor $t3, $t3, $t3

                # Storing upper limit in $t4
                add $t4, $t0, -1 

        bin_search: 
                # condition for breaking the search loop
                blt $t4, $t3, not_found 

                # storing the mid in $t5 
                xor $t5, $t5, $t5 
                add $t5, $t3, $t4 
                srl $t5, $t5, 1

                # storing element at mid in $t6 
                xor $t6, $t6, $t6
                sll $t6, $t5, 2
                add $t6, $t1, $t6 
                lw $t6, 0($t6) 

                # check equality
                beq $t6, $t2, found 

                # check more than 
                bge $t6, $t2, greater_than 

        less_than_equal: 
                addi $t3, $t5, 1
                j bin_search 

        greater_than: 
                addi $t4, $t5, -1 
                j bin_search
        found: 
                # message for printing if element is found
                li $v0, 4
                la $a0, message4
                syscall  

                # printing the index
                add $a0, $t5, 0 
                li $v0, 1
                syscall 

                j exit
        
        not_found: 
                # message for printing if element is not found
                li $v0, 4
                la $a0, message5
                syscall  

                j exit              

        finish_n0: 
                # message for printing n == 0
                li $v0, 4
                la $a0, message6
                syscall

        exit: 
                jr $ra