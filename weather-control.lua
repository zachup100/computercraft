local function GetInstallPath()
  local Program = shell.getRunningProgram()
  local Name = fs.getName(Program)
  return "/"..Program:sub(1, #Program-#Name)
end

local OUTLINE_COLOR = colors.gray
local BACKGROUND_COLOR = colors.lightGray

local ButtonsAPI = GetInstallPath().."/api/buttons.lua"
if not pocket then error("This program can only run on pocket computers.") end
if not fs.exists(ButtonsAPI) or not os.loadAPI(ButtonsAPI) then error("Failed to load Buttons API") end
rednet.open("back")
term.clear()

function DrawWindow()
  local Width, Height = term.getSize()
  --// Outline
  term.setBackgroundColor((type(OUTLINE_COLOR)=="number" and OUTLINE_COLOR) or colors.black)
  for i=1,Height,1 do
    term.setCursorPos(1,i)
    term.write((" "):rep(Width))
  end
  --// Background
  term.setBackgroundColor((type(BACKGROUND_COLOR)=="number" and BACKGROUND_COLOR) or colors.black)
  for i=2,Height-1,1 do
    term.setCursorPos(2,i)
    term.write((" "):rep(Width-2))
  end
end

function DrawSun(X,Y)
  for int=0,3,1 do
    term.setCursorPos(X,Y+int)
    term.setBackgroundColor(colors.orange)
    term.write((" "):rep(5))
  end
  for int=1,2,1 do
    term.setCursorPos(X+1,Y+int)
    term.setBackgroundColor(colors.yellow)
    term.write("   ")
  end
end

function DrawMoon(X,Y)
  for int=0,3,1 do
    term.setCursorPos(X,Y+int)
    term.setBackgroundColor(colors.black)
    term.write((" "):rep(5))
  end
end

function Render()
  while true do
    DrawWindow()
    DrawSun(3,3)
    DrawMoon(6,3)
  end
end

parallel.waitForAll(Render, buttons.listen)
