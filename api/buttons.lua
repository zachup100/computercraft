local Buttons = {}

function new(Title, X, Y, Width, Height, Callback)
  local this = {
    Position = {
      X = ((type(X)=="number" and X) or 1),
      Y = ((type(Y)=="number" and X) or 1)
    },
    Size = {
      X = ((type(Width)=="number" and X) or 1),
      Y = ((type(Height)=="number" and X) or 1)
    },
    Callback = (type(Callback)=="function" and Callback) or (function() return true end)
    Enabled = true
  }

  function this.getPosition() return this.Position.X, this.Position.Y end
  function this.getSize() return this.Size.X, this.Size.Y end
  function this.isEnabled() return this.Enabled end

  function this.setPosition(X, Y)
    newX, newY = ((type(X)=="number" and X) or this.Position.X), ((type(Y)=="number" and Y) or this.Position.Y)
    this.Position.X = newX
    this.Position.Y = newY
    return this
  end

  function this.setSize(X, Y)
    newX, newY = ((type(X)=="number" and X) or this.Size.X), ((type(Y)=="number" and Y) or this.Size.Y)
    this.Size.X = newX
    this.Size.Y = newY
    return this
  end

  function this.setEnabled(bool)
    this.Enabled = ((type(bool)=="boolean" and bool) or this.Enabled)
    return this
  end

  function this.ClickedEvent(X, Y)
    if this.Enabled ~= true then return false end
    local pX,pY,sX,sY = this.getPosition(), this.getSize()
    if X >= pX and Y >= pY and X <= (pX+sX) and Y <= (pY+sY) then return true end
    return false
  end

  Buttons[Title] = this
  return this
end

function get(Title)
  return Buttosn[Title]
end

function listen()
  
end
