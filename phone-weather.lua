local Height, Width = term.getSize()
if Height ~= 26 or Width ~= 20 then error("This program can only run on a pocket computer.") end
term.clear()

--// Draw

term.setCursorPos(3,3)
for i = 3, 24 do
  term.setCursorPos(3,i)
  term.write((" "):rep(16))
end
