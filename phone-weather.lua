local Height, Width = term.getSize()
if Height ~= 26 or Width ~= 20 then error("This program can only run on a pocket computer.") end
term.clear()

--// Draw
term.setBackgroundColor(colors.lightBlue)
term.setCursorPos(3,2)
for i = 3, 22 do
  term.setCursorPos(3,i)
  term.write((" "):rep(22))
end
