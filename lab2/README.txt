Chuong Viet Truong
Chvtruon@ucsc.edu
1490515
Lab 1
Lab Section 02B

Purpose: The purpose of this lab is to use sequential and combinational logic that allows us to sum or 
subtract a sequence of numbers together.

Methods: The assignment was broken down to 4 parts all written in seperate pages. 

Analysis: Part 1 is the input/output, which uses various devices such as a numberic keypad, toggle 
switch, and buttons. Part 2 is the register, which includes 6 flip flops. Part 3 is addition and that
contains a 6-bit full adder. Part 4 is subtraction, which either inverts or adds one, and that contains
a conditional inverter, which takes the 2's complement of the user's input.

Results: I ended with a running summer that stores a 6 bit binary number. 

QUESTIONS:
1) Discuss issues you had building the circuit. Describe what you added to the minimum specifications to
make debugging easier.

I was able to figure out the register, thanks to the note on piazza, and the subtraction portion quite
well. I did have trouble figuring out the adder though. I took the time to then make sure that 
I fully understood how the component worked before going back and building it on MML.

2) What happens when you subtract a larger number from a smaller number? Does the result make
sense? What happens when you add two numbers that won’t fit in 6 bits?

The result is a hexidecimal number for both. It makes sense since the LED wouldn't be able to display
the actual result from those inputs.