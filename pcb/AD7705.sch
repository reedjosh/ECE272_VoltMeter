EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:74xgxx
LIBS:ac-dc
LIBS:actel
LIBS:Altera
LIBS:analog_devices
LIBS:brooktre
LIBS:cmos_ieee
LIBS:dc-dc
LIBS:diode
LIBS:elec-unifil
LIBS:ESD_Protection
LIBS:ftdi
LIBS:gennum
LIBS:graphic
LIBS:hc11
LIBS:ir
LIBS:Lattice
LIBS:logo
LIBS:maxim
LIBS:microchip_dspic33dsc
LIBS:microchip_pic10mcu
LIBS:microchip_pic12mcu
LIBS:microchip_pic16mcu
LIBS:microchip_pic18mcu
LIBS:microchip_pic32mcu
LIBS:motor_drivers
LIBS:msp430
LIBS:nordicsemi
LIBS:nxp_armmcu
LIBS:onsemi
LIBS:Oscillators
LIBS:powerint
LIBS:Power_Management
LIBS:pspice
LIBS:references
LIBS:relays
LIBS:rfcom
LIBS:sensors
LIBS:silabs
LIBS:SparkFun
LIBS:stm8
LIBS:stm32
LIBS:supertex
LIBS:switches
LIBS:transf
LIBS:ttl_ieee
LIBS:video
LIBS:Xicor
LIBS:Zilog
LIBS:AD7705
LIBS:AD7705-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text GLabel 3250 3500 0    60   Input ~ 0
SCLK
$Comp
L GND #PWR?
U 1 1 5702D9DE
P 4500 3500
F 0 "#PWR?" H 4500 3250 50  0001 C CNN
F 1 "GND" H 4500 3350 50  0001 C CNN
F 2 "" H 4500 3500 50  0000 C CNN
F 3 "" H 4500 3500 50  0000 C CNN
	1    4500 3500
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR?
U 1 1 5702DF09
P 4700 3650
F 0 "#PWR?" H 4700 3500 50  0001 C CNN
F 1 "+3.3V" H 4700 3790 50  0000 C CNN
F 2 "" H 4700 3650 50  0000 C CNN
F 3 "" H 4700 3650 50  0000 C CNN
	1    4700 3650
	1    0    0    -1  
$EndComp
Wire Wire Line
	4500 3650 4700 3650
$Comp
L Crystal Y?
U 1 1 5702E227
P 2750 3650
F 0 "Y?" H 2750 3800 50  0000 C CNN
F 1 "Crystal" H 2750 3500 50  0000 C CNN
F 2 "" H 2750 3650 50  0000 C CNN
F 3 "" H 2750 3650 50  0000 C CNN
	1    2750 3650
	1    0    0    -1  
$EndComp
NoConn ~ 3250 3800
Text GLabel 3250 3950 0    60   Input ~ 0
CS
Text GLabel 3250 4100 0    60   Input ~ 0
Rst
NoConn ~ 3250 4250
NoConn ~ 4500 4250
Text GLabel 4500 3950 2    60   Output ~ 0
Dout
Text GLabel 4500 4100 2    60   Output ~ 0
Drdy
Text GLabel 4500 3800 2    60   Input ~ 0
Din
Text GLabel 3100 4400 0    60   Input ~ 0
Ain+
Text GLabel 3100 4550 0    60   Input ~ 0
Ain-
Wire Wire Line
	2900 3650 3250 3650
$Comp
L LM285-25 D?
U 1 1 5702F1B9
P 2650 2700
F 0 "D?" H 2550 2800 50  0001 C CNN
F 1 "LM285-25" V 2650 2450 50  0000 C CNN
F 2 "TSSOP8" H 2650 2550 50  0001 C CIN
F 3 "" H 2650 2700 50  0000 C CNN
	1    2650 2700
	0    -1   -1   0   
$EndComp
$Comp
L R R?
U 1 1 5702F2B9
P 2650 2300
F 0 "R?" V 2730 2300 50  0001 C CNN
F 1 "1k" V 2650 2300 50  0000 C CNN
F 2 "" V 2580 2300 50  0000 C CNN
F 3 "" H 2650 2300 50  0000 C CNN
	1    2650 2300
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR?
U 1 1 5702F464
P 2650 2150
F 0 "#PWR?" H 2650 2000 50  0001 C CNN
F 1 "+3.3V" H 2650 2290 50  0000 C CNN
F 2 "" H 2650 2150 50  0000 C CNN
F 3 "" H 2650 2150 50  0000 C CNN
	1    2650 2150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5702F520
P 2650 2800
F 0 "#PWR?" H 2650 2550 50  0001 C CNN
F 1 "GND" H 2650 2650 50  0001 C CNN
F 2 "" H 2650 2800 50  0000 C CNN
F 3 "" H 2650 2800 50  0000 C CNN
	1    2650 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 2600 2650 2450
Text GLabel 2800 2550 2    60   Input ~ 0
2.5V
Wire Wire Line
	2800 2550 2650 2550
Connection ~ 2650 2550
Text GLabel 4650 4550 2    60   Input ~ 0
2.5V
$Comp
L GND #PWR?
U 1 1 5702F7EE
P 5050 4450
F 0 "#PWR?" H 5050 4200 50  0001 C CNN
F 1 "GND" H 5050 4300 50  0001 C CNN
F 2 "" H 5050 4450 50  0000 C CNN
F 3 "" H 5050 4450 50  0000 C CNN
	1    5050 4450
	1    0    0    -1  
$EndComp
$Comp
L AD7705 U?
U 1 1 5706C340
P 3900 3900
F 0 "U?" H 3900 4500 60  0001 C CNN
F 1 "AD7705" H 3900 3000 60  0000 C CNN
F 2 "" H 3750 3900 60  0000 C CNN
F 3 "" H 3750 3900 60  0000 C CNN
	1    3900 3900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 5706C431
P 3200 4650
F 0 "#PWR?" H 3200 4400 50  0001 C CNN
F 1 "GND" H 3200 4500 50  0001 C CNN
F 2 "" H 3200 4650 50  0000 C CNN
F 3 "" H 3200 4650 50  0000 C CNN
	1    3200 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	3100 4550 3250 4550
Wire Wire Line
	3200 4550 3200 4650
Connection ~ 3200 4550
Wire Wire Line
	3100 4400 3250 4400
Wire Wire Line
	5050 4450 5050 4400
Wire Wire Line
	5050 4400 4500 4400
Wire Wire Line
	4500 4550 4650 4550
$EndSCHEMATC
