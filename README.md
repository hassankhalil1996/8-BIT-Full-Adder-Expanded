# 8-BIT-Full-Adder-Expanded
Expanded 8-Bit Full Adder with Interface and Control Logic Design in Verilog

This project implements an 8-bit full adder in Verilog with two versions:

1. **Basic 8-bit Full Adder:** The initial version simply adds two 8-bit binary numbers, utilizing eight individual 1-bit full adder modules. The design includes a testbench to validate the functionality of the adder.

2. **Expanded 8-bit Full Adder:** The enhanced version includes additional control functionality. It supports offset addition and integrates an interface to handle external read/write transactions. The expanded adder can handle control register updates and read/write operations to and from various registers, allowing for more complex operations.

The design is validated using a detailed testbench that simulates various test cases, including different input combinations and control commands. The testbench verifies correct functionality, including scenarios for adding offsets and handling both read and write transactions. This project highlights the use of Verilog in designing scalable, modular digital circuits.
