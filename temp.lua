-- ***************************************************************************
-- DHT22 module for ESP8266 with nodeMCU
--
-- Written by Javier Yanez 
-- but based on a script of Pigs Fly from ESP8266.com forum
--
-- MIT license, http://opensource.org/licenses/MIT
-- ***************************************************************************

local moduleName = ...
local M = {}
_G[moduleName] = M

local temperature

function M.read(pin)
  temperature = 0

  -- Use Markus Gritsch trick to speed up read/write on GPIO
--  gpio_read = gpio.read
  --gpio_write = gpio.write
  

--http://www.esp8266-projects.com/2015/03/internal-adc-esp8266.html

   temperature=readADC_avg(pin)
   
   
  
end
  function readADC_avg(pin)                 -- read 10 consecutive values and calculate average.
           ad1 = 0
           i=0
           while (i<10) do
                ad1=ad1+adc.read(0)*4/978 --calibrate based on your voltage divider AND Vref!
                --print(ad1)
                i=i+1
           end
           ad1 = ad1/10
           print(ad1)
           return ad1
      end

function M.getTemperature()
  return temperature
end

function M.getHumidity()
  return temperature
end

return M