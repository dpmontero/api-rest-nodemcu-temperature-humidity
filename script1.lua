ip = wifi.sta.getip()
print(ip)
-- nil
wifi.setmode(wifi.STATION)
wifi.sta.config("HUAWEI-E5172-5273","RTEE2351E09")
ip = wifi.sta.getip()
print(ip)
-- 192.168.18.110

-- A simple http server
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
  conn:on("receive",function(conn,payload)
    print(payload)
    conn:send("<h1> Hello, NodeMcu.</h1>")
  end)
  conn:on("sent",function(conn) conn:close() end)
end)
