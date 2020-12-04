local Height, Width = term.getSize()
if Height ~= 26 or Width ~= 20 then error("This program can only run on a pocket computer.") end
local REMOTE_ID = 30
rednet.open("back")
term.clear()

local Buttons = {}

function AddButton(Title,X,Y,MX,MY,func)
  if type(func) ~= "function" then return false, 1 end
  Title = tostring(Title)
  if type(Buttons[Title]) ~= "nil" then return false, 2 end
  X,Y,MX,MY = (tonumber(X) or 1),(tonumber(Y) or 1),(tonumber(MX) or 1),(tonumber(MY) or 1)
  local Data = {X=X,Y=Y,MX=MX,MY=MY,func=func}
  Buttons[Title] = Data
  return true
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

--// Stop Rain button
term.setBackgroundColor(colors.cyan)
for i=3,5 do
  term.setCursorPos(4,i)
  term.write((" "):rep(Width))
end
term.setCursorPos((Width/2)-1,4)
term.write("Stop  Rain")

term.setCursorPos(1,1)
term.setBackgroundColor(colors.black)
AddButton("rain",4,3,23,5, (function()
  print("R")
  rednet.send(REMOTE_ID,"stop_rain")
end))

--// Morning button
term.setBackgroundColor(colors.cyan)
for i=7,9 do
  term.setCursorPos(4,i)
  term.write((" "):rep(Width))
end
term.setCursorPos((Width/2),9)
term.write("Morning")

term.setCursorPos(1,1)
term.setBackgroundColor(colors.black)
AddButton("morning",4,7,23,9, (function()
  print("R")
  rednet.send(REMOTE_ID,"morning")
end))

--// Goodnight button
term.setBackgroundColor(colors.cyan)
for i=11,13 do
  term.setCursorPos(4,i)
  term.write((" "):rep(Width))
end
term.setCursorPos((Width/2),9)
term.write("Goodnight")

term.setCursorPos(1,1)
term.setBackgroundColor(colors.black)
AddButton("goodnight",4,11,23,13, (function()
  print("R")
  rednet.send(REMOTE_ID,"goodnight")
end))



while true do
  local Event, Button, PosX, PosY = os.pullEvent("mouse_click")
  if Button == 1 then
    for Button, Data in pairs(Buttons) do
      local Within = WithinButton(Button,PosX,PosY)
      if Within then
        Data.func()
      end
    end
  end
end
