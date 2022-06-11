.data
buffer: .space 100
hello: .asciiz "\nWelcome to Parcel Delivery Alert App\n"
promptUserChoice: .asciiz "Choose your type (1: recipient, 2: rider): " #Prompt user to enter type
promptUsername:	.asciiz "\nUsername: " #Prompt user to enter name
promptPassword: .asciiz "\nPassword: " #Prompt user to enter password
promptMainMenuRec: .asciiz  "\nMain Menu: \n1: Request Form\n2: Track Rider\n3: QR Code\n4: Confirmation\n\nChoose Menu (Choose 1-4, Press any number to end the program): \n" #Prompt user to enter type
usernameInput: .space 80
passwordInput: .space 80
username: .asciiz "husin\n"
password: .asciiz "admin\n"
fullnameInput: .space 80
addressInput: .space 80
typeItemInput: .space 80
fullName: .asciiz "\nFull Name: " 
address: .asciiz "Address: "
typeItem: .asciiz "Type of Item: "
receipt: .asciiz "\n\n######CONFIRMATION OF DELIVERY######\n"
continue:	.asciiz "\n\nDo you want to continue? (Y/N) " # asking if the user wants to continue
answer:		.space 256 #whitespace
error:		.asciiz "\nWrong input! Please try again" #input validation
checking: .asciiz "\ncheck here"
track1: .asciiz "\nYour Parcel Has Been Picked Up --> Your parcel has been transported to delivery hub\n"
track2: .asciiz "\nYour Parcel Has Been Picked Up --> Your parcel has been transported to delivery hub --> The parcel is on delivery\n"
track3: .asciiz "\nAlert! Your Parcel is 5km away"
QRcode: .asciiz "\nYour QR code is:"
errorLogin: .asciiz "\nWrong username and password! Please try again\n"
beep: 		.byte 72
duration: 	.byte 100
volume: 	.byte 127
#data for rider
barcode: .asciiz "\n\n**********SCANNING ITEM**********\n \nThe item code is "
promptMainMenuRider: .asciiz "\nMain Menu: \n1: Scan Barcode \n2: Update Location\n3: Exit\n\nChoose Menu: " #Prompt user to enter type
customerAdress: .asciiz "\n The customer's address is : "
location: .asciiz "\nEnter your current location: "
calculatingRoute: .asciiz "\n***********CALCULATING ROUTE***********\n"
closeRider: .asciiz "\nYou are 5km away from target\n"
arriveRider: .asciiz "\nYou have Arrived. Finish"
thankyou: .asciiz "Thank you for using Parcel Delivery Alert App"

codeQR: .space 80

.text
#Function: main
main:
	jal welcome
	li $v0, 4
	la $a0, promptUserChoice
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0
	
	jal login

#Function: Recipient main function
recipient:																		
	li $v0, 4
	la $a0, promptMainMenuRec	#prompt main menu for recipient
	syscall
	
	li $v0, 5					#User input 
	syscall
	move $t3, $v0
	
								#Recipient Options
	beq $t3, 1, reqForm
	beq $t3, 2, track
	beq $t3, 3, qrcode
	beq $t3, 4, confirmation
	jal EndProgram
	
	jr $ra
	
#Request form for recipient	
reqForm:
	li $v0, 4
	la $a0, fullName			#Prompt user to enter full name
	syscall
	
	li $v0, 8
	la $a0, fullnameInput		#user input full name
	li $a1, 80
	syscall
	
	li $v0, 4
	la $a0, address				#Prompt user to enter address
	syscall
	
	li $v0, 8
	la $a0, addressInput		#user input address
	li $a1, 80
	syscall
	
	li $v0, 4
	la $a0, typeItem			#Prompt user to enter type of item
	syscall
	
	li $v0, 8
	la $a0, typeItemInput		#user input item type
	li $a1, 80
	syscall
	
	jal confirmation			

#Function: Track recipient's parcel		
track:
	li $v0, 4
	la $a0, track1				#display track1
	syscall
	
	jal BeepFunction			#Beeping sound Sensor
	jal ContinueString

#Function: QR Code
qrcode:
	li $v0, 4
	la $a0, QRcode				
	syscall
	
	li $v0, 42					#Syscall service for Random int generator with range
	li $a1, 100000000		
	la $a0, codeQR
	addi $a1, $zero, 80
	syscall
    
    li $v0, 1
    move $s1, $v0 
    syscall
    
	li $v0, 4
	la $a0, codeQR				#Display QR Code
	syscall
	
#Function: Confirmation receipt will call back previous user input
confirmation:
	li $v0, 4
	la $a0, receipt				 
	syscall
	
	li $v0, 4
	la $a0, fullName		
	syscall
	
	li $v0, 4
	la $a0, fullnameInput
	syscall
	
	li $v0, 4
	la $a0, address
	syscall
	
	li $v0, 4
	la $a0, addressInput
	syscall
	
	li $v0, 4
	la $a0, typeItem
	syscall
	
	li $v0, 4
	la $a0, typeItemInput
	syscall
	
	jal ContinueString
	
	
#Function: Rider main function
rider:


 	li $v0, 4
	la $a0, promptMainMenuRider	#prompt main menu
	syscall
	
	li $v0, 5					#User input
	syscall
	move $t3, $v0
	
	beq $t3, 1, riderProcess	
	beq $t3, 2, UpdateLocation
	jal EndProgram
	
	jr $ra
	
#Function: 	Rider scan QR code on the item
riderProcess:
	li $v0, 4
	la $a0, barcode				
	syscall
	
	li $v0, 32
 	la $a0, 5000				#Syscall service for Random int generator with range
 	syscall
	
	li $v0, 1
 	addi $a0, $s1, 0			#Store QR Code
 	syscall
 	
 								#Display all recipients information
 	li $v0, 4
	la $a0, fullName		
	syscall
	
	li $v0, 4
	la $a0, fullnameInput
	syscall
	
	li $v0, 4
	la $a0, address
	syscall
	
	li $v0, 4
	la $a0, addressInput
	syscall
	
	li $v0, 4
	la $a0, typeItem
	syscall
	
	li $v0, 4
	la $a0, typeItemInput
	syscall
	
 	jal rider
 #Function: GPS Update Location
 UpdateLocation:
 	
 	li $v0,4
 	la $a0, location			#Prompt user to enter current location 
 	syscall
 	
 	li $v0, 8
	syscall						#User input location
	move $s3, $v0

 	li $v0,4
 	la $a0, calculatingRoute	#Display GPS
 	syscall
 	
 	li $v0, 32
 	la $a0, 5000				#Syscall service for Random int generator with range
 	syscall
 	
 	li $v0, 4
 	la $a0, closeRider			#Displat alert when 5KM away
 	syscall
 	
 	li $v0, 32
 	la $a0, 5000				#Syscall service for Random int generator with range
 	syscall
 	
 	jal BeepFunction			#Beeping sound
 	
 	li $v0, 4
 	la $a0, arriveRider			#Display alert when rider has arrived
 	syscall
 	
 	jal BeepFunction
 	jal BeepFunction			#Beeping sound
 	
 	jal rider			#Jump to error check
 	
#Function: Login prompt and Store		
login:
	li $v0, 4
	la $a0, promptUsername		#Prompt user to enter username
	syscall
	
	li $v0, 8
	la $a0, usernameInput		#User input Username
	addi $a1, $zero, 80
	syscall
	
	li $v0, 4
	la $a0, promptPassword		#Prompt user to enter password
	syscall
	
	li $v0, 8
	la $a0, passwordInput		#User input Password
	addi $a1, $zero, 80
	syscall
	
	
	la $a0, usernameInput
	la $a1, username
	jal compStr						#Jump to compStr Function to compare user input Username with data
	
   	beq $v0, $zero, verifiedUsername	#jump to verifiedUsername Function to move to Password Checking
   	jal ErrorCheck1
 
 #Function: If Username from data and userinput is the same,  proceed to check password 	  	
verifiedUsername:
	la $a0, passwordInput		
	la $a1, password					#Compare user input with data
	jal compStr							#Jump to compStr Function to compare user input Password with data
	
   	beq $v0, $zero, verifiedLogin
   	
   	jal ErrorCheck1
 
 #Function: Already Verified Logged In  	  	
verifiedLogin:
	beq $s0, 1, recipient
	beq $s0, 2, rider

#Function: Error Checking for "do you want to continue?"	--recipient
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

   	beq $t3, 'y', recipient
    beq $t3, 'Y', recipient
    	
    beq $t3, 'N', main
    beq $t3, 'n', main
    	
    bne $t3, 'y', ErrorCheck	#If user input is not 'Y','y' or 'N','n' -- jump to error check
	bne $t3, 'Y', ErrorCheck
	
	
	jr $ra
	
#Function: Error Checking for "do you want to continue?" --rider	
ContinueString1:
	li $v0, 4
	la $a0, continue
	syscall
	
	la $a0, answer
	li $a1, 3
	li $v0, 8
	syscall
	move $t3, $v0
	
	lbu   $t3, 0($a0)

   	beq $t3, 'y', rider
    beq $t3, 'Y', rider
    	
    beq $t3, 'N', main
    beq $t3, 'n', main
    	
    bne $t3, 'y', ErrorCheck
	bne $t3, 'Y', ErrorCheck	#If user input is not 'Y','y' or 'N','n' -- jump to error check
	
#Procedure to check error for ContinueString	
ErrorCheck:
	li $v0, 4
	la $a0, error
	syscall	
	jal ContinueString

ErrorCheck1:
	li $v0, 4
	la $a0, errorLogin
	syscall	
	jal login

#Function: to end program	
EndProgram:

	li $v0, 4
	la $a0, thankyou
	syscall
	li $v0, 10
	syscall
	jr $ra
 
#Function: compare User Input	
compStr:
	add $t0,$zero,$zero  
    add $t1,$zero,$a0  
    add $t2,$zero,$a1  


loop:  
    lb $t3($t1)         
    lb $t4($t2)  
    beqz $t3,checkt2    
    beqz $t4,missmatch
    slt $t5,$t3,$t4      
    bnez $t5,missmatch  
    addi $t1,$t1,1       
    addi $t2,$t2,1  
    j loop  

missmatch:   
    addi $v0,$zero,1  
    j endfunction  
    
checkt2:  
    bnez $t4,missmatch  
    add $v0,$zero,$zero  
	
endfunction:  
    jr $ra

#Function: Beeping sound goes beep beep
BeepFunction:
	li $v0,31
	la $a0,beep
	addi $t2,$a0,12
	la $a1,duration
	move $t2,$a0
	move $t3,$a1
	syscall
	
	jr $ra

#Function: 	welcome message	
welcome:
	li $v0, 4 
 	la $a0, hello
 	syscall
 	
 	jr $ra
	
