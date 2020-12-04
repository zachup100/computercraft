local Height, Width = term.getSize()
if Height ~= 26 or Width ~= 20 then error("This program can only run on a pocket computer.") end
term.clear()

local Buttons = {}

function AddButton(Title,X,Y,MX,MY,func)
  if type(func) ~= "function" then return end
  Title = tostring(Title)
  if type(Buttons[Title]) ~= "nil" then return end
  X,Y,MX,MY = (tonumber(X) or 1),(tonumber(Y) or 1),(tonumber(MX) or 1),(tonumber(MY) or 1)
  local Data = {X=X,Y=Y,MX=MX,MY=MY,func=func}
  Buttons[Title] = Data
end

function WithinButton(Title, X, Y)
  Title = tostring(Title)
  if type(Buttons[Title]) == "nil" then return false end
  local Data = Buttons[Title]

  if X >= Data.X and Y >= Data.Y and X <= Data.MX and Y <= Data.MY then return true end
  return false
end

--// Outline
term.setBackgroundColor(colors.blue)
for i=1,Height,1 do
  term.setCursorPos(1,i)
  term.write((" "):rep(Width+6))
end

--// Inner Background
term.setBackgroundColor(colors.lightBlue)
term.setCursorPos(2,2)
for i=2,19,1 do
  term.setCursorPos(2,i)
  term.write((" "):rep(Width+4))
end

term.setCursorPos(1,1)
term.setBackgroundColor(colors.black)
local returned = AddButton("test1",1,1,3,3, function() rednet.broadcast("stop_rain") end)
print("got",returned)

while true do
  local Event, PosX, PosY = os.pullEvent("mouse_click")
  for Button, Data in pairs(Buttons) do
    if WithinButton(Button, PosX, PosY) then
      Data.func()
    end
  end
end
