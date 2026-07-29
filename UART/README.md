\# UART



\## Overview



A parameterized UART subsystem implemented in Verilog HDL, consisting of a transmitter, receiver, and top-level module. The design is verified using dedicated testbenches for the transmitter, receiver, and loopback communication.



\## Files



\- uart\_tx.v

\- uart\_rx.v

\- uart\_top\_module.v

\- tb\_uart\_tx.v

\- tb\_uart\_rx.v

\- tb\_uart\_top\_module.v



\## Features



\- Parameterized clock frequency

\- Parameterized baud rate

\- UART transmitter

\- UART receiver

\- Loopback verification

\- FSM-based implementation



\## Simulation Instructions



1\. Open the project in Xilinx Vivado.

2\. Set one of the following as the simulation top module:

&#x20;  - `tb\_uart\_tx.v` – Verifies the UART transmitter.

&#x20;  - `tb\_uart\_rx.v` – Verifies the UART receiver.

&#x20;  - `tb\_uart\_top\_module.v` – Verifies end-to-end UART loopback communication.

3\. Run \*\*Run Simulation → Run Behavioral Simulation\*\*.

4\. In the simulation window, click \*\*Run All\*\* to execute the complete testbench.

5\. Compare the generated waveform with the corresponding waveform shown below.



\## Simulation



\### UART Transmitter



!\[UART TX Waveform](images/uart\_tx\_waveform.png)



\### UART Receiver



!\[UART RX Waveform](images/uart\_rx\_waveform.png)



\### UART Loopback



!\[UART Loopback Waveform](images/uart\_loopback\_waveform.png)

