print("Setting up WIFI...TEMPv00.00.02")
wifi.setmode(wifi.STATION)
-- damos SSID y su Contrasenna
wifi.sta.config("ssid","contrasenna")


tmr.alarm(0, 1000, 1, function() 
	if wifi.sta.getip()== nil then 
		print("IP no alcanzada. Intentandolo...") 
	else 
		tmr.stop(0)
		print("Configuracion realizada. IP es:  "..wifi.sta.getip())
		h = require("temp")
		getSleepDelay()
	end
end)

function sendUpdate()
	-- first get fresh readings
	h.read(0)
	local temp = h.getTemperature()
	temp = (temp/10)..'.'..(temp%10)
	local hum = h.getHumidity()
	hum = (hum/10)..'.'..(hum%10)
	-- now make a tcp connection to the nodejs service
	conn=net.createConnection(net.TCP, 0)
	conn:connect(5050,'192.168.1.32') 
	local ipp=wifi.sta.getip()
	--print('Enviando temperatura'..hum)
	conn:send("add|"..ipp.."|powerboxhost&&add|"..hum.."|powerboxhumidity&&add|"..temp.."|powerboxtemperature\n")
	--print('Enviando temperatura'..temp)
	conn:send("")
	conn:on("sent",function(conn)
		conn:close()
	end)
	conn:on("disconnection", function(conn)
		getSleepDelay()
	end)
end

function getSleepDelay()
	tmr.alarm(1,6000,1,function()
		print('Intentando obtener retardo para la proxima actualizacion...')
		conn=net.createConnection(net.TCP, 0)
		conn:connect(5050,'192.168.1.32') 
		conn:send("sleepdelay\n")
		conn:on("receive", function(sck, c)
			tmr.stop(1)
			nextUpdate(c)
			conn:close()
		end)
		conn:on("reconnection",function() print('Intentando reconectar para obtener retardo') end )
	end)
end

function nextUpdate(seconds)
	print('Proxima actualizacion realizada en...n '..(seconds*1000)..' segundos.')
	tmr.alarm(2, seconds*10, 0, function()
		sendUpdate()
	end)
end
