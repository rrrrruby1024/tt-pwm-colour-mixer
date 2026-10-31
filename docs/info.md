## How it works

Three PWM channels share one counter that counts 0, 1, 2 and starts again, so one period is three clock ticks. A colour's output is high while the counter is below that colour's level. Level 3 is always on, and level 0 is off.

## How to test

Hold rst_n low for a few clock cycles, then raise it. Set each colour's two input bits to a level from 0 to 3 and watch uo[0] to uo[2].

## External hardware

An RGB LED on uo[0], uo[1] and uo[2], with a resistor in series with each colour.
