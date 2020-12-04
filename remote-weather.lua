function GetModem()
  local Connections = peripheral.getNames()
  for _, Port in pairs(Connections) do
    local Methods = peripheral.getMethods(Port)
    for _, func in pairs(Methods) do
      local funcName = tostring(func)
      if funcName == "isWireless" and func() == true then
        return tostring(Port)
      end
    end
  end
end

print("Found wireless modem port on \""..GetModem().."\"")
