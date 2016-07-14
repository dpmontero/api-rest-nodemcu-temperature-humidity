--init.lua
print("Setting up WIFI...")
wifi.setmode(wifi.STATION)
--modify according your wireless router settings
wifi.sta.config("HUAWEI-E5172-5273","RTEE2351E09")
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function() 
    if wifi.sta.getip()== nil then 
        print("IP unavaiable, Waiting...") 
    else 
        tmr.stop(1)
        print("Config done, IP is "..wifi.sta.getip())
        --dofile("dht11.lua")
        --dofile("senddata.lua")
        --dofile("f28hsoil.lua")
    end
end)
