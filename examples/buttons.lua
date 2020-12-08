--//
--// Determine where we are, and grab the proper API file
--//
local function GetInstallPath()
  local Program = shell.getRunningProgram()
  local Name = fs.getName(Program)
  return "/"..Program:sub(1, #Program-#Name)
end

local function split(input, sep)
  if not sep then sep = "%s" end
  local rtn = {}
  for str in string.gmatch(input, "([^"..sep.."]+)") do table.insert(rtn, str) end
  return rtn
end

local Paths = split(GetInstallPath(), "/")
local Directory = "/"
if #Paths == 1 then
  Directory = Directory..Paths[1].."/"
else
  --//
  --// API is located one directory up.
  --//
  for i, path in pairs(Paths) do
    if i == #Paths then break end
    Directory = Directory .. path .. "/"
  end
end
--//
--// Proper example of api is below, don't edit above unless you have to
--//

os.loadAPI(Directory.."api/buttons.lua")
local Monitor = buttons.new("monitor", 1,1,5,5)
Monitor.setDevice("monitor")
Monitor.setCallback(function() print("Monitor!") end)
local Terminal = buttons.new("terminal", 1,1,5,5)
Terminal.setDevice("terminal")
Terminal.setCallback(function() print("Terminal!") end)
local DisabledButton = buttons.new("DisabledButton", 6,6,5,5)
DisabledButton.setDevice("terminal")
DisabledButton.setCallback(function()
  print("Disabling")
  DisabledButton.setEnabled(false)
end)

parallel.waitForAll(buttons.listen)
