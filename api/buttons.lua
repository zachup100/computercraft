local Buttons = {}
--// Registered[Title] = Data
new(Title, X, Y, SizeX, SizeY)

  

  local btn = {}
  btn.Title = ""
  btn.Enabled = true
  btn.Position = {X=1,Y=1}
  btn.Size = {X=1,Y=SizeY}

  function btn:getName() return tostring(btn.Title) end
  function btn:getSize() return btn.Size.X, btn.Size.Y end
  function btn:getPosition() return btn.Position.X, btn.Position.Y end

  function btn:setSize(X, Y)
    if type(X) ~= "number" and type(Y) ~= "number" then
      btn.Size = {X=X,Y=Y}
      return true
    end
    return false
  end

  function btn:setPosition(X, Y)
    if type(X) ~= "number" and type(Y) ~= "number" then
      btn.Position = {X=X,Y=Y}
      return true
    end
    return false
  end

  return btn
end
