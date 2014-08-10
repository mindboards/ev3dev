The [AM1808 SoC](EV3 Processor) has 2 Enhanced High Resolution Pulse Width
Modulators (eHRPWMs) and 3 Enhanced Capture Modules (eCAPs) that can be configured as PWMs.

The EHRPWMs actually have 2 PWM outputs (A/B) per device for a total of 4 PWMs.

##Usage
<table>
<tr><th>Device<th>Connection
<tr><td>EHRPWM0A<td>Not used/connected
<tr><td>EHROWM0B<td>Drives the EV3 [speaker](EV3 Sound) to produce sound
<tr><td>EHRPWM1A<td>Output port B motor driver
<tr><td>EHRPWM1B<td>Output port A motor driver
<tr><td>ECAP0<td>Output port D motor driver
<tr><td>ECAP1<td>Output port C motor driver
<tr><td>ECAP2<td>Bluetooth "slow clock" @ 32.767kHz
</table>