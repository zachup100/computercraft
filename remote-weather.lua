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

function Morning()
  redstone.setOutput("left",true)
  sleep(0.1)
  redstone.setOutput("left",false)
end

function Goodnight()
  redstone.setOutput("right",true)
  sleep(0.1)
  redstone.setOutput("right",false)
end

term.clear()
term.setCursorPos(1,1)
local Modem = GetModem()
if not Modem then error("Failed to identify wireless modem connections!") end
local Methods = peripheral.wrap(Modem)
if not Methods.isWireless() then error("You cannot use a wired modem!") end
rednet.open(Modem)

print("Started Listener.")
while true do
  Id, Message = rednet.receive()
  Message = string.lower(tostring(Message))
  print("Command received:",Message)
  if Message == "stop_rain" then
    StopRain()
  elseif Message == "morning" then
      Morning()
  elseif Message == "goodnight" then
      Goodnight()
  end
end
