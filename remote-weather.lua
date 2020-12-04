

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

local Modem = GetModem()
if not Modem then error("Failed to identify wireless modem connections!") end
local Methods = peripheral.getMethods(Modem)
if not Methods.isWireless() then error("You cannot use a wired modem!") end
print("Success")
