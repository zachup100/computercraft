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
  }

  function this.setPosition(X, Y)
    newX, newY = ((type(X)=="number" and X) or this.Position.X), ((type(XY)=="number" and Y) or this.Position.Y)
    this.Position.X = newX
    this.Position.Y = newY
    return this
  end

  function this.setSize(X, Y)
    newX, newY = ((type(X)=="number" and X) or this.Position.X), ((type(XY)=="number" and Y) or this.Position.Y)
    this.Size.X = newX
    this.Size.Y = newY
    return this
  end

end
