-- Simple NodeMCU web server (done is a not so nodeie fashion :-)
--
-- Written by Scott Beasley 2015
-- Open and free to change and use. Enjoy.
--

-- Your Wifi connection data
local SSID = "HUAWEI-E5172-5273"
local SSID_PASSWORD = "RTEE2351E09"



 s:listen(80,function(c)
 c:on("receive",function(c,pl)
  for v,i in pairs{2,8,9} do
   gpio.mode(i,gpio.OUTPUT)
   c:send("\ngpio("..i.."):"..gpio.read(i))
   if string.find(pl,"gpio"..i.."=0") then gpio.write(i,0) end
   if string.find(pl,"gpio"..i.."=1") then gpio.write(i,1) end
   c:send("\nnew_gpio("..i.."):"..gpio.read(i))
   print(i)
  end
  c:send("\nTMR:"..tmr.now().." MEM:"..node.heap())
 c:on("sent",function(c) c:close() end)
 end)
end)

function wait_for_wifi_conn ( )
   tmr.alarm (1, 1000, 1, function ( )
      if wifi.sta.getip ( ) == nil then
         print ("Waiting for Wifi connection")
      else
         tmr.stop (1)
         print ("ESP8266 mode is: " .. wifi.getmode ( ))
         print ("The module MAC address is: " .. wifi.ap.getmac ( ))
         print ("Config done, IP is " .. wifi.sta.getip ( ))
      end
   end)
end



-- Configure the ESP as a station (client)
wifi.setmode (wifi.STATION)
wifi.sta.config (SSID, SSID_PASSWORD)
wifi.sta.autoconnect (1)

-- Hang out until we get a wifi connection before the httpd server is started.
wait_for_wifi_conn ( )

-- Create the httpd server
--svr = net.createServer (net.TCP, 30)

-- Server listening on port 80, call connect function if a request is received
--svr:listen (80, connect)
