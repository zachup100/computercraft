function GetModem()
  local Connections = peripheral.getNames()
  for _, Obj in pairs(Connections) do
    local Methods = peripheral.getMethods(Obj)
    if Methods.isWireless ~= nil and Methods.isWireless() == true then
      return tostring(Obj)
    end
  end
end

print("Wirelss Modem:",GetModem())
