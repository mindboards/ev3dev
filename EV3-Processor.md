### Essentials
* Texas Instruments AM1808 ARM Microporcessor
* 32-bit
* ARM9
* All internal pullup/pulldown resistors are disabled

### Documentation
* [Official Website](http://www.ti.com/product/am1808)
* [AM1808 ARM® Microprocessor Datasheet (pdf)](http://www.ti.com/lit/ds/sprs653d/sprs653d.pdf)
* [AM1808 Technical Reference Manual (pdf)](http://www.ti.com/lit/ug/spruh82a/spruh82a.pdf)
- [AM1808 Pinmux Utility (pdf)](http://www.ti.com/lit/an/spraba2a/spraba2a.pdf)

### System Components
#### Used by EV3
* 3 - [16550-Type UART Modules](EV3 UART)
* 2 - [Serial Peripheral Interfaces (SPI)](EV3 SPI)
* 2 - [Multimedia Card (MMC)/Secure Digital (SD) Card Interfaces](EV3 SD Card Reader) (using one)
* 2 - [Master/Slave I2C Interfaces](EV3 I2C) (using one)
* [Programmable Real-Time Unit Subsystem (PRUSS)](EV3 PRU)
* [USB 1.1 Host Port (OHCI)](EV3 USB Host Port)
* [USB 2.0 On-The-Go Port (OTG)](EV3 PC USB Port)
* [Real-Time Clock (RTC)](EV3 RTC)
* 1 - [64-bit General-Purpose or Watchdog Timer](EV3 FIQ I2C)
* 2 - [Enhanced High-Resolution Pulse Width Modulators (eHRPWM)](EV3 PWM)
* 3 - [32-bit Enhanced Capture Modules (ePCAP)](EV3 PWM)

#### Not used by EV3
* LCD Controller (EV3 uses an [external controller](EV3 LCD Display))
* 1 - Host Port Interface (HPI)
* 1 - Multichannel Audio Serial Port (EV3 uses [PWM for sound](EV3 PWM))
* 2 - Multichannel Buffered Serial Ports
* 10/100 Mbps Ethernet MAC (EMAC)
* Video Port Interface (VPIF)
* Universal Parallel Port (uPP)
* Serial ATA (SATA) Controller

#### Not sure yet
* Enhanced Direct Memory Access Controller 3 (EDMA3)
* 3 - 64-bit General-Purpose Timers

### Pin Assignments
There are 400 pins on the chip. The pins are multiplexed so that each pin can perform multiple functions. This is how the EV3 uses each pin. See section 10.4.9 in the technical reference manual to see where this came from.

This is based on the lms2012 code and hardware schematic revision J. Both are not 100% reliable representations of the mass produced hardware, so there could be inaccurate information here. You have been warned.

<table">
  <tr>
    <th colspan="2">MUX
    <th>Function
    <th>Schematic Cross-<br>reference
    <th>Usage
  <tr>
    <td rowspan="8">0
    <td>28
    <td>UART2&nbsp;CTS
    <td>CTSMCU_RTSBT
    <td>Bluetooth
  <tr>
    <td>24
    <td>UART2&nbsp;RTS
    <td>RTSMCU_CTSBT
    <td>Bluetooth
  <tr>
    <td>20
    <td>AHCLKX
    <td>PRUCLK
    <td>PRU clock for soft UARTs
  <tr>
    <td>16
    <td>AHCLKR
    <td>PRUCLK
    <td>PRU clock for soft UARTs
  <tr>
    <td>12
    <td>GPIO&nbsp;0-12
    <td>DIGIC0
    <td>Input Port 3 Pin 5 I/O
  <tr>
    <td>8
    <td>GPIO&nbsp;0-13
    <td>DIGIB1
    <td>Input Port 2 Pin 6 I/O / I2C Data
  <tr>
    <td>4
    <td>GPIO&nbsp;0-14
    <td>DIGIB0
    <td>Input Port 2 Pin 5 I/O
  <tr>
    <td>0
    <td>GPIO&nbsp;0-15
    <td>DIGIA1
    <td>Input Port 1 Pin 6 I/O / I2C Data
  <tr>
    <td rowspan="8">1
    <td>28
    <td>ECAP1&nbsp;APWM1
    <td>MDPWM
    <td>Output Port D Motor Driver
  <tr>
    <td>24
    <td>GPIO&nbsp;0-1
    <td>DIGID0
    <td>Input Port 4 Pin 5 I/O
  <tr>
    <td>20
    <td>GPIO&nbsp;0-2
    <td>DIGIA0
    <td>Input Port 1 Pin 5 I/O
  <tr>
    <td>16
    <td>GPIO&nbsp;0-3
    <td>MBIN0
    <td>Output Port B Pin 1 In
  <tr>
    <td>12
    <td>GPIO&nbsp;0-4
    <td>DIRA
    <td>Output Port A Pin 6 In
  <tr>
    <td>8
    <td>GPIO&nbsp;0-5
    <td>BTCLKDIS
    <td>Pull down bluetooth "slow clock" signal
  <tr>
    <td>4
    <td>GPIO&nbsp;0-6
    <td>ADCBATEN
    <td>A/D Converter Battery Enable (switches battery voltage to ADC channel 4)
  <tr>
    <td>0
    <td>ECAP2&nbsp;APWM2
    <td>BTSLOWCLK
    <td>Bluetooth "slow" clock
  <tr>
    <td rowspan="8">2
    <td>28
    <td>ECAP0&nbsp;APWM0
    <td>MCPWM
    <td>Output Port C Motor Driver
  <tr>
    <td>24
    <td>AXR1
    <td>RXIND
    <td>Input Port 4 Pin 6 UART RXD
  <tr>
    <td>20
    <td>AXR2
    <td>RXINC
    <td>Input Port 3 Pin 6 UART RXD
  <tr>
    <td>16
    <td>AXR3/<br>GPIO&nbsp;1-11
    <td>TXIND
    <td>Input Port 4 Pin 5 UART TXD / I2C Clock
  <tr>
    <td>12
    <td>AXR4/<br>GPIO&nbsp;1-12
    <td>TXINC
    <td>Input Port 3 Pin 5 UART TXD / I2C Clock
  <tr>
    <td>8
    <td>GPIO&nbsp;1-13
    <td>BUT1
    <td>Button 1 (Enter)
  <tr>
    <td>4
    <td>GPIO&nbsp;1-14
    <td>DIGIC1
    <td>Input Port 3 Pin 6 I/O / I2C Data
  <tr>
    <td>0
    <td>GPIO&nbsp;1-15
    <td>DIGID1
    <td>Input Port 4 Pin 6 I/O / I2C Data
  <tr>
    <td rowspan="8">3
    <td>28
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>24
    <td>SPI0&nbsp;CS
    <td>ADCCS
    <td>SPI chip select to analog/digital converter
  <tr>
    <td>20
    <td>UART0&nbsp;TXD/<br>GPIO&nbsp;8-3
    <td>TXINB
    <td>Input Port 2 Pin 5 UART TXD / I2C Clock
  <tr>
    <td>16
    <td>UART0&nbsp;RXD
    <td>RXINB
    <td>Input Port 2 Pin 6 UART RXD
  <tr>
    <td>12
    <td>SPI0&nbsp;SIMO
    <td>ADCMOSI<br>FMOSI
    <td>SPI data from analog/digital converter
  <tr>
    <td>8
    <td>SPI0&nbsp;SOMI
    <td>ADCMISO<br>FMISO
    <td>SPI data to analog/digital converter
  <tr>
    <td>4
    <td>EPWM0B
    <td>SOUND_ARMA
    <td>PWM to speaker amplifier
  <tr>
    <td>0
    <td>SPI0&nbsp;CLK
    <td>SPI0_CLK
    <td>SPI Clock to analog/digital converter
  <tr>
    <td rowspan="8">4
    <td>28
    <td>UART1&nbsp;TXD/<br>GPIO&nbsp;1-0
    <td>TXINA
    <td>Input Port 1 Pin 5 UART TXD / I2C Clock
  <tr>
    <td>24
    <td>UART1&nbsp;RXD
    <td>RXINA
    <td>Input Port 1 Pin 5 UART RXD
  <tr>
    <td>20
    <td>UART2&nbsp;TXD
    <td>TXMCU_RXBT
    <td>Bluetooth
  <tr>
    <td>16
    <td>UART2&nbsp;RXD
    <td>RXMCU_TXBT
    <td>Bluetooth
  <tr>
    <td>12
    <td>I2C0&nbsp;SDA
    <td>I2C0_SDA
    <td>EEPROM I2C data
  <tr>
    <td>8
    <td>I2C0&nbsp;SCL
    <td>I2C0_SCL
    <td>EEPROM I2C clock
  <tr>
    <td>4
    <td>SPI0&nbsp;SCS0
    <td>NPCS0
    <td>Flash memory SPI chip select
  <tr>
    <td>0
    <td>?
    <td>PRU_CLK
    <td>
  <tr>
    <td rowspan="8">5
    <td>28
    <td>GPIO&nbsp;2-8
    <td>DIRD
    <td>Output Port D Pin 6 In
  <tr>
    <td>24
    <td>GPIO&nbsp;2-9
    <td>DIRB
    <td>Output Port B Pin 6 In
  <tr>
    <td>20
    <td>SPI1&nbsp;SIMO
    <td>MOSIDIS
    <td>LCD SPI data
  <tr>
    <td>16
    <td>GPIO&nbsp;2-11
    <td>MISODIS
    <td>LCD A0 display data/command selector
  <tr>
    <td>12
    <td>GPIO&nbsp;2-12
    <td>CSDIS
    <td>LCD chip select (active low)
  <tr>
    <td>8
    <td>SPI1&nbsp;CLK
    <td>SCKDIS
    <td>LCD SPI Clock
  <tr>
    <td>4
    <td>EPWM1B
    <td>MAPWM
    <td>Output Port A Motor Driver
  <tr>
    <td>0
    <td>EPWM1A
    <td>MBPWM
    <td>Output Port A Motor Driver
  <tr>
    <td rowspan="8">6
    <td>28
    <td>GPIO&nbsp;2-0
    <td>FHOLD
    <td>Flash memory hold (active low)
  <tr>
    <td>24
    <td>GPIO&nbsp;2-1
    <td>MBIN1
    <td>Output Port B Pin 2 In
  <tr>
    <td>20
    <td>GPIO&nbsp;2-2
    <td>LEGDETA
    <td>Input Port 1 Pin 2 In
  <tr>
    <td>16
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>12
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>8
    <td>GPIO&nbsp;2-5
    <td>DETB0
    <td>Output Port B Pin 5 In
  <tr>
    <td>4
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>0
    <td>GPIO&nbsp;2-7
    <td><i>N/C</i>
    <td>FIQ shadowing (*was TP4 on pre-release hardware)
  <tr>
    <td rowspan="8">7
    <td>28
    <td>GPIO&nbsp;3-8
    <td>DETC0
    <td>Output Port C Pin 5 In
  <tr>
    <td>24
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>20
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>16
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>12
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>8
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>4
    <td>GPIO&nbsp;3-14
    <td>DIRC
    <td>Output Port C Pin 6 In
  <tr>
    <td>0
    <td>GPIO&nbsp;3-15
    <td>MAIN0
    <td>Output Port A Pin 1 In
  <tr>
    <td rowspan="8">8
    <td>28
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>24
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>20
    <td>GPIO&nbsp;3-2
    <td>HWID2
    <td>Hardware ID (not used)
  <tr>
    <td>16
    <td>GPIO&nbsp;3-3
    <td>PIC_EN
    <td>Bluetooth PIC enable
  <tr>
    <td>12
    <td>GPIO&nbsp;3-4
    <td>HWID1
    <td>Hardware ID (not used)
  <tr>
    <td>8
    <td>GPIO&nbsp;3-5
    <td>HWID0
    <td>Hardware ID (not used)
  <tr>
    <td>4
    <td>GPIO&nbsp;3-6
    <td>MAIN1
    <td>Output Port A Pin 2 In
  <tr>
    <td>0
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td rowspan="8">9
    <td>28
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>24
    <td>GPIO&nbsp;4-9
    <td>BTnSHUTD
    <td>Bluetooth enable (active low)
  <tr>
    <td>20
    <td>GPIO&nbsp;4-10
    <td>HWID3
    <td>Hardware ID (not used) 
  <tr>
    <td>16
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>12
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>8
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>4
    <td>GPIO&nbsp;4-14
    <td>PIC_RST
    <td>Bluetooth PIC reset
  <tr>
    <td>0
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td rowspan="8">10
    <td>28
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>24
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>20
    <td>MMCSD0&nbsp;DAT3
    <td>MCI0_DA3
    <td>SD Card Reader
  <tr>
    <td>16
    <td>MMCSD0&nbsp;DAT2
    <td>MCI0_DA2
    <td>SD Card Reader
  <tr>
    <td>12
    <td>MMCSD0&nbsp;DAT1
    <td>MCI0_DA1
    <td>SD Card Reader
  <tr>
    <td>8
    <td>MMCSD0&nbsp;DAT0
    <td>MCI0_DA0
    <td>SD Card Reader
  <tr>
    <td>4
    <td>MMCSD0&nbsp;CMD
    <td>MCI0_CDA
    <td>SD Card Reader
  <tr>
    <td>0
    <td>MMCSD0&nbsp;CLK
    <td>MCI0_CK
    <td>SD Card Reader
  <tr>
    <td rowspan="8">11
    <td>28
    <td>GPIO&nbsp;5-8
    <td>INTB0
    <td>Output Port B Pin 5 In
  <tr>
    <td>24
    <td>GPIO&nbsp;5-9
    <td>MCIN1
    <td>Output Port C Pin 2 In
  <tr>
    <td>20
    <td>GPIO&nbsp;5-10
    <td>MDIN0
    <td>Output Port D Pin 1 In
  <tr>
    <td>16
    <td>GPIO&nbsp;5-11
    <td>INTA0
    <td>Output Port A Pin 5 In
  <tr>
    <td>12
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>8
    <td>GPIO&nbsp;5-13
    <td>INTC0
    <td>Output Port C Pin 5 In
  <tr>
    <td>4
    <td>GPIO&nbsp;5-14
    <td>SD_SW
    <td>SD card detect switch
  <tr>
    <td>0
    <td>GPIO&nbsp;5-15
    <td>DETD0
    <td>Output Port D Pin 5 In
  <tr>
    <td rowspan="8">12
    <td>28
    <td>GPIO&nbsp;5-0
    <td>RSTDIS
    <td>LCD reset (active low)
  <tr>
    <td>24
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>20
    <td>GPIO&nbsp;5-2
    <td>FWP
    <td>Flash memory write protection (active low)
  <tr>
    <td>16
    <td>GPIO&nbsp;5-3
    <td>MDIN1
    <td>Output Port D Pin 2 In
  <tr>
    <td>12
    <td>GPIO&nbsp;5-4
    <td>DETA0
    <td>Output Port A Pin 1 In
  <tr>
    <td>8
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>4
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>0
    <td>GPIO&nbsp;5-7
    <td>CTS_PIC
    <td>Bluetooth CTS
  <tr>
    <td rowspan="8">13
    <td>28
    <td>GPIO&nbsp;6-8
    <td>MCIN0
    <td>Output Port C Pin 1 In
  <tr>
    <td>24
    <td>GPIO&nbsp;6-9
    <td>INTD0
    <td>Output Port D Pin 5 In
  <tr>
    <td>20
    <td>GPIO&nbsp;6-10
    <td>BUT5
    <td>Button 5 (Back)
  <tr>
    <td>16
    <td>GPIO&nbsp;6-11
    <td>5VPENON
    <td>System 5V Power (used to turn off EV3)
  <tr>
    <td>12
    <td>GPIO&nbsp;6-12
    <td>DIODE3
    <td>LED 3 (right, red)
  <tr>
    <td>8
    <td>GPIO&nbsp;6-13
    <td>DIODE0
    <td>LED 0 (left, red)
  <tr>
    <td>4
    <td>GPIO&nbsp;6-14
    <td>DIODE2
    <td>LED 2 (right, green)
  <tr>
    <td>0
    <td>GPIO&nbsp;6-15
    <td>SOUNDEN
    <td>Speaker amplifier enable
  <tr>
    <td rowspan="8">14
    <td>28
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>24
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>20
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>16
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>12
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>8
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>4
    <td>GPIO&nbsp;6-6
    <td>BUT4
    <td>Button 4 (left)
  <tr>
    <td>0
    <td>GPIO&nbsp;6-7
    <td>DIODE1
    <td>LED 1 (left, green)
  <tr>
    <td rowspan="8">15
    <td>28
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>24
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>20
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>16
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>12
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>8
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>4
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>0
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td rowspan="8">16
    <td>28
    <td>GPIO&nbsp;7-10
    <td>RXIND_EN<br>TXIND_EN
    <td>Input Port 4 buffer enable (active low)
  <tr>
    <td>24
    <td>GPIO&nbsp;7-11
    <td>LEGDETC
    <td>Input Port 3 Pin 2 In
  <tr>
    <td>20
    <td>GPIO&nbsp;7-12
    <td>BUT3
    <td>Button 3 (right)
  <tr>
    <td>16
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>12
    <td>GPIO&nbsp;7-14
    <td>BUT2
    <td>Button 2 (down)
  <tr>
    <td>8
    <td>GPIO&nbsp;7-15
    <td>BUT0
    <td>Button 0 (up)
  <tr>
    <td>4
    <td>GPIO&nbsp;6-5
    <td>P_EN
    <td>System power enable
  <tr>
    <td>0
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td rowspan="8">17
    <td>28
    <td>BOOT2
    <td>BOOT2
    <td>Select boot device
  <tr>
    <td>24
    <td>BOOT3
    <td>BOOT3
    <td>Select boot device
  <tr>
    <td>20
    <td>BOOT4
    <td>BOOT4
    <td>Select boot device
  <tr>
    <td>16
    <td>BOOT5
    <td>BOOT5
    <td>Select boot device
  <tr>
    <td>12
    <td>BOOT6
    <td>BOOT6
    <td>Select boot device
  <tr>
    <td>8
    <td>BOOT7
    <td>BOOT7
    <td>Select boot device
  <tr>
    <td>4
    <td>GPIO&nbsp;7-8
    <td>LEGDETD
    <td>Input Port 4 Pin 2 In
  <tr>
    <td>0
    <td>GPIO&nbsp;7-9
    <td>RXINC_EN<br>TXINC_EN
    <td>Input Port 3 buffer enable (active low)
  <tr>
    <td rowspan="8">18
    <td>28
    <td>GPIO&nbsp;8-10
    <td>I_ONA
    <td>Input Port 1 Pin 1 Out
  <tr>
    <td>24
    <td>GPIO&nbsp;8-11
    <td>RXINA_EN<br>TXINA_EN
    <td>Input Port 1 buffer enable (active low)
  <tr>
    <td>20
    <td>GPIO&nbsp;8-12
    <td>I_ONB
    <td>Input Port 2 Pin 1 Out
  <tr>
    <td>16
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>12
    <td>GPIO&nbsp;8-14
    <td>RXINB_EN<br>TXINB_EN
    <td>Input Port 2 buffer enable (active low)
  <tr>
    <td>8
    <td>GPIO&nbsp;8-15
    <td>LEGDETB
    <td>Input Port 2 Pin 2 In
  <tr>
    <td>4
    <td>BOOT0
    <td>BOOT0
    <td>Select boot device
  <tr>
    <td>0
    <td>BOOT1
    <td>BOOT1
    <td>Select boot device
  <tr>
    <td rowspan="8">19
    <td>28
    <td>RTCK
    <td>RTCK1
    <td>Realtime clock output
  <tr>
    <td>24
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>20
    <td>
    <td><i>N/C</i>
    <td>
  <tr>
    <td>16
    <td>GPIO&nbsp;6-2
    <td>ADCACK
    <td>Analog/Digital converter GPIO0
  <tr>
    <td>12
    <td>GPIO&nbsp;6-3
    <td>OC5V
    <td>USB1 overcurrent
  <tr>
    <td>8
    <td>GPIO&nbsp;6-4
    <td>I_OND
    <td>Input Port 4 Pin 1 Out
  <tr>
    <td>4
    <td>GPIO&nbsp;8-8
    <td>SW_RECHARGE
    <td>Rechargable battery indicator
  <tr>
    <td>0
    <td>GPIO&nbsp;8-9
    <td>I_ONC
    <td>Input Port 3 Pin 1 Out
</table>