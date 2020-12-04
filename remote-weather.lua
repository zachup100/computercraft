function GetModem()
  local Connections = peripheral.getNames()
  for _, Port in pairs(Connections) do
    local Methods = peripheral.getMethods(Port)
    for _, func in pairs(Methods) do
      if func == "isWireless" then
        return tostring(Port)
      end
    end
  end
end

function StopRain()
  redstone.setOutput("top",true)
  sleep(0.1)
  redstone.setOutput("top",false)
end

term.clear()
term.setCursorPos(1,1)
local Modem = GetModem()
if not Modem then error("Failed to identify wireless modem connections!") end
local Methods = peripheral.wrap(Modem)
if not Methods.isWireless() then error("You cannot use a wired modem!") end
rednet.open(Modem)
print("Listening for commands.")
while true do
  Id, Message = rednet.receive()
  if Message == "stop_rain" then
    print("rain_command")
    StopRain()
  end
end
