function GetModem()
  local Connections = peripheral.getNames()
  for _, Obj in pairs(Connections) do
    local Methods = peripheral.getMethods(Obj)
    for _, Method in pairs(Methods) do
      if Method == "isWireless" and Method() == true then
        return tostring(Obj)
      end
    end
  end
end

print(GetModem())
