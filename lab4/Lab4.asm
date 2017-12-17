# Chuong Viet Truong
# November 10th, 2017
# Lab 4
# Prime Finder

.data
	inputMsg:       .asciiz "Please enter a number that is 3 or greater: "
	newLine:        .asciiz "\n"
	comma:          .asciiz ", "
	buffer:         .space  4
	
.text
	main:	
		# Print the input message
		li 			$v0, 4
		la 			$a0, inputMsg
		syscall
	
		# Reads int and saves in $t0
		li 			$v0, 5
		syscall
	
		move 		$t0, $v0
		
		# End program if input is less than 3
		blt 		$t0, 3, endProg
	
		# Print the first prime number
		li 			$v0, 1
		li          $a0, 2
		syscall
		
		# Set outer loop counter to $t1
		addi        $t1, $t1, 2
		
	outerLoop:
		beq 		$t1, $t0, endProg        # End program if counter equals N
		add 		$t1, $t1, 1              # Increment outer loop counter
		
		addi        $t2, $0, 1      		 # Set inner loop counter to $t2
		
		bne 		$t1, $t0, innerLoop      # If counter does not equal N, enter inner loop
	
	innerLoop:
		add 		$t2, $t2, 1              # Increment inner loop counter
		
		srl 		$t3, $t1, 1              # Set $t3 to N/2
		add 		$t3, $t3, 1              # Round N/2 up 
				
		rem 		$t4, $t1, $t2            # Save remainder of $t1/$t2 in $t4
		
		beq 		$t4, $0, outerLoop       # Exit inner loop if N is divisible
		beq 		$t2, $t3, printPrime     # Print prime if inner loop counter = N
		
		j 			innerLoop                # Reloop the inner loop
	
	# Function to print prime
	printPrime:
		li 			$v0, 4
		la 			$a0, comma
		syscall
	
		li 			$v0, 1
		add         $a0, $t1, $0
		syscall
		
		j 			outerLoop                # Jump back to outer loop once prime is printed
		
	# Function to end program
	endProg:	
		li 			$v0, 10
		syscall
	
