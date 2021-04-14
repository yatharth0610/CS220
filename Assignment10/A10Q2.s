.data
        message1: .asciiz "Enter n: "
        message2: .asciiz "Enter X line by line: "
        message3: .asciiz "The value is: "
        message4: .asciiz "No vector. "
        X: .space 60

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
                addi $t0, $v0, 0

                # check if n == 0
                beqz $t0, finish
                
                # load address of X $t1
                la $t1, X 

                # setup counter in $s0
                li $s0, 0

                # message requesting X as input
                li $v0, 4 
                la $a0, message2
                syscall
        
        X_in:         
                # read element of X and store it
                li $v0, 6
                syscall 
                swc1 $f0, 0($t1)

                # move pointer to X ahead
                addi $t1, $t1, 4

                # increment counter and check for loop ending
                addi $s0, $s0, 1
                bne $s0, $t0, X_in

                # reset counter in $s0 if loop is done
                li $s0, 0
                
                # reset pointers to X and Y
                la $t1, X

                # make accumulator f0 for total sum and setup 0 in $f2
                li.s $f0, 0.0
                li.s $f2, 0.0

                # setup multiplier in $f1 (1 for first iteration)
                li.s $f1, 1.0
                

        sum: 

                # load floats
                lwc1 $f3, 0($t1) # load from X
                
                # multiply and add to accumulator
                mul.s $f3, $f3, $f1
                add.s $f0, $f0, $f3

                # calculate the multiplier for next iteration
                sub.s $f1, $f2, $f1

                # increment pointers
                addi $t1, $t1, 4

                # increment counter and check for loop ending
                addi $s0, $s0, 1
                bne $s0, $t0, sum

                # message for printing final output
                li $v0, 4
                la $a0, message3
                syscall

                mov.s $f12, $f0

                li $v0, 2
                syscall

                jr $ra

        finish: 
                # message for printing n == 0
                li $v0, 4
                la $a0, message4
                syscall

                jr $ra