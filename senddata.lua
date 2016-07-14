--- thingspeak.com

function response(cu, c)
    --print("respuesta web "..c)
    --print(c:find("#(.*)#"))
    local payload = string.match(c, "{.*}")
    res = nil
    res = cjson.decode(payload)
    local pin = res.pin
    local status = res.status
    print(status)
    if pin ~= nil then
        if pin > 0 then
            -- encender HIGH = 1, apagar LOW = 0
            if status == "HIGH"  then
                gpio.mode(pin, gpio.OUTPUT)
                gpio.write(pin, gpio.HIGH)
                --print(gpio.read(pin))
                pwm.setup(6,1000,1000)
                pwm.start(6)
            else
                gpio.mode(pin, gpio.OUTPUT)
                gpio.write(pin, gpio.LOW)
                --print(gpio.read(pin))
                pwm.stop(6)
            end
        else
            print("no es numérico")
        end
    else
        print("pin es nil")
    end
end



--- Get temp and send data to dpmontero.es
function sendData()
getTemp()
-- conection to dpmontero.es
print("Sending data to dpmontero.es")
conn=net.createConnection(net.TCP, 0)
conn:on("receive", function(conn, payload) print(payload) end)
-- api.dpmontero.es
conn:connect(80,'104.31.93.253')
conn:send("GET /api/temperature_humidity?field1="..Temperature.."."..TemperatureDec.."&field2="..Humidity.."."..HumidityDec.." HTTP/1.1\r\n") 
conn:send("Host: tellmechef.dpmontero.es\r\n")
conn:send("Accept: */*\r\n")
conn:send("User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n")
conn:send("\r\n")
conn:on("sent",function(conn) conn:on("receive", response) end)
conn:on("disconnection", function(conn) print("Got disconnection...") end)
end
-- send data every X ms to thing speak
tmr.alarm(2, 200000, 1, function() sendData() end )
