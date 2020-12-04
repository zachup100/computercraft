local Height, Width = term.getSize()
if Height ~= 26 or Width ~= 20 then error("This program can only run on a pocket computer.") end
term.clear()

--// Outline
term.setBackgroundColor(colors.blue)
for i=1,Height,1 do
  term.setCursorPos(1,i)
  term.write((""):rep(Width))
end

--// Inner Background
term.setBackgroundColor(colors.lightBlue)
term.setCursorPos(2,2)
for i=2,24,1 do
  term.setCursorPos(2,i)
  term.write((" "):rep(19))
end
