.data
        message1: .asciiz "Enter n: "
        message2: .asciiz "Enter X line by line: "
        message3: .asciiz "Enter Y line by line: "
        message4: .asciiz "The Product of X and Y is: "
        X: .space 60
        Y: .space 60

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
                
                # load address of X and Y in $t1, $t2
                la $t1, X 
                la $t2, Y

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

                # message requesting Y as input
                li $v0, 4 
                la $a0, message3
                syscall

        Y_in:                 
                # read element of Y and store it
                li $v0, 6
                syscall 
                swc1 $f0, 0($t2)

                # move pointer to Y ahead
                addi $t2, $t2, 4

                # increment counter and check for loop ending
                addi $s0, $s0, 1
                bne $s0, $t0, Y_in

                # reset counter in $s0
                li $s0, 0
                
                # reset pointers to X and Y
                la $t1, X
                la $t2, Y

                # make accumulator f0 for total sum
                li $t3, 0
                mtc1 $t3, $f0

        dot_prod: 
                # load floats
                lwc1 $f1, 0($t1) # load from X
                lwc1 $f2, 0($t2) # load from Y

                # multiply and add to accumulator
                mul.s $f1, $f1, $f2
                add.s $f0, $f0, $f1

                # increment pointers
                addi $t1, $t1, 4
                addi $t2, $t2, 4

                # increment counter and check for loop ending
                addi $s0, $s0, 1
                bne $s0, $t0, dot_prod

                # message for printing final output
                li $v0, 4
                la $a0, message4
                syscall

                mov.s $f12, $f0

                li $v0, 2
                syscall

                jr $ra