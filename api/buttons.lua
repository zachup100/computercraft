local Buttons = {}
--Buttons[Title] = Table

function get(Title)
  if type(Buttons[Title]) == "table" then
    return Buttons[Title]
  end
end

function new(Title, X, Y, SizeX, SizeY, Function)
  if type(X) ~= "number" then return false, "Argument #2 must be a number" end
  if type(Y) ~= "number" then return false, "Argument #3 must be a number" end
  if type(SizeX) ~= "number" then return false, "Argument #4 must be a number" end
  if type(SizeY) ~= "number" then return false, "Argument #5 must be a number" end

  local btn = {}
  btn._Title = ""
  btn._Enabled = true
  btn.Position = {X=1,Y=1}
  btn.Size = {X=1,Y=1}
  btn.Function = (function(Input, X, Y) return true end)

  function btn:getPosition() return btn.Position.X, btn.Position.Y end
  function btn:getSize() return btn.Size.X, btn.Size.Y end
  function btn:getTitle() return tostring(btn._Title) end
  function btn:getEnabled() return btn.Enabled end

  function btn:setEnabled(bool)
    if type(bool) == "boolean" then
      btn._Enabled = bool
      return true
    end
    return false
  end

  function btn:setSize(X, Y)
    if type(X) == "number" and type(Y) == "number" then
      btn.Size = {X=X,Y=Y}
      return true
    end
    return false
  end

  function btn:setPosition(X, Y)
    if type(X) == "number" and type(Y) == "number" then
      btn.Position = {X=X,Y=Y}
      return true
    end
    return false
  end

  if type(Title) ~= "string" then
    for Int=1,100,1 do
      btn._Title = "Buttons"..tostring(Int)
      if type(Buttons[btn._Title]) == nil then
        Buttons[btn._Title] = {}
        btn._Title
        break
      end
    end
  end

  if type(Function) == "function" then btn.Function = Function end
  Buttons[btn._Title] = btn
  return true, get(btn._Title)
end
