result1=0
result2=0
--configure pins
gpio.mode(5,gpio.OUTPUT)    --  GPIO 14
gpio.mode(6,gpio.OUTPUT)    --  GPIO 12
gpio.mode(7,gpio.INPUT)    -- soil temp  GPIO 13
--set all pins to LOW - no voltage
gpio.write(5,gpio.LOW)
gpio.write(6,gpio.LOW)
gpio.write(7,gpio.LOW)

--  print the ADC value with all pins low
print("\nADC: Both GPIOs LOW start: "..adc.read(0))
--  Send voltage to GPIO 16 completing the circuit for this sensor.
--gpio.write(0,gpio.HIGH)
-- short delay before reading, 100ms
--tmr.delay(100000)
-- Read the ADC pin or assign to varable var = adc.read(0)

--print("\nADC: GPIO 16 HIGH LDR:  "..adc.read(0))
-- Return GPIO 16 to LOW, no voltage.
--gpio.write(0,gpio.LOW)
-- short delay 100ms
--tmr.delay(100000)

-- repeat for the other two sensors
gpio.write(5,gpio.HIGH)
tmr.delay(100000)
result1=adc.read(0)
print("ADC: GPIO 14 D5 HIGH Temp:  "..result1)
gpio.write(5,gpio.LOW)
tmr.delay(100000)

gpio.write(6,gpio.HIGH)
tmr.delay(100000)
result2=adc.read(0)
print("ADC: GPIO 12 D6 HIGH Slider:  "..result2)
gpio.write(6,gpio.LOW)

gpio.read(7)
--tmr.delay(100000)
print("ADC: GPIO 13 D7 HIGH soil temp:  "..gpio.read(7))
--gpio.write(7,gpio.LOW)

tmr.delay(100000)
--  again read ADC, this reading should be very close to the 'start reading'
print("\nADC: Both GPIOs LOW end: "..adc.read(0))
