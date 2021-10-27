# Lab 1 exercise
# This program adds 2 numbers together and print it out
# MUHAMMAD AZRUL BIN NOOR AZMI 1811839 SECTION 1


 .data 
	variable1:	.space 256 #to allocate space if necessary
	hello:		.asciiz "Welcome to Lab 1 exercise! This program will do addition of 2 numbers\n\n" # message string
	promptNum1:	.asciiz "Please enter a number between 0-9\n" #Prompt user to enter input
	promptNum2:	.asciiz "Please enter the next number between 0-9\n" #Prompt user to enter input
	plusSign:	.asciiz " + "  
	equalSign:	.asciiz  " = " 
	continue:	.asciiz "\n\nDo you want to continue? (Y/N) " # asking if the user wants to continue
	answer:		.space 256 #whitespace
	error:		.asciiz "\nWrong input! Please try again" #input validation
 .text
 #step 1. Print the welcome message
 	main: #main procedure to carry out the addition
 	jal PrintString
 	
 	
 #step 2. Prompt user to enter the number 
 	li $v0, 4
 	la $a0, promptNum1
 	syscall
	
#step 3. Get the user's number and store the result in $t0
	li $v0, 5
	syscall
	move $t0, $v0
	
	
#step 4. Prompt user to enter the next number
	li $v0, 4
 	la $a0, promptNum2
 	syscall

#step 5. Get the user's next number and store the result in $t1
	li $v0, 5
	syscall
	move $t1, $v0
	
#step 6. Add both of inputs by ther user
	add $t2, $t0, $t1 # t2 = t0 + t1

#step 7. Print the answer and the input given with the arithmetic expression
 	li $v0, 1		#first input
 	addi $a0, $t0, 0
 	syscall
 	
 	li $v0, 4 		#plus sign
 	la $a0, plusSign
 	syscall
 	
 	li $v0, 1		#second input
 	addi $a0, $t1, 0
 	syscall
 	
 	li $v0, 4 		#equal sign
 	la $a0, equalSign
 	syscall
	
	li $v0, 1		#answer
	add $a0, $zero,$t2
	syscall
	
#step 8 and Step 9. Loop if the user wants to continue
	jal ContinueString

#step 10. End the code
	jal EndProgram

#Procedure to print string
PrintString:
	li $v0, 4 
 	la $a0, hello
 	syscall
 	
 	jr $ra
#Procedure to loop the program
ContinueString:
	li $v0, 4
	la $a0, continue
	syscall
	
	la $a0, answer
	li $a1, 3
	li $v0, 8
	syscall
	move $t3, $v0
	
	lbu   $t3, 0($a0)

   	beq $t3, 'y', main
    	beq $t3, 'Y', main
    	
    	beq $t3, 'N', EndProgram
    	beq $t3, 'n', EndProgram
    	
    	bne $t3, 'y', ErrorCheck
	bne $t3, 'Y', ErrorCheck
	
	
	jr $ra

#Procedure to check error for ContinueString	
ErrorCheck:
	li $v0, 4
	la $a0, error
	syscall	
	jal ContinueString

#Procedure to end program	
EndProgram:
	li $v0, 10
	syscall
	jr $ra
 
