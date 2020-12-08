local function GetInstallPath()
  local Program = shell.getRunningProgram()
  local Name = fs.getName(Program)
  return "/"..Program:sub(1, #Program-#Name)
end

local Directory = GetInstallPath()

os.loadAPI(Directory.."api/buttons.lua")
local Monitor = buttons.new("monitor", 1,1,5,5)
Monitor.setDevice("monitor")
Monitor.setCallback(function() print("Monitor!") end)
local Terminal = buttons.new("terminal", 1,1,5,5)
Terminal.setDevice("terminal")
Terminal.setCallback(function() print("Terminal!") end)
local DisabledButton = buttons.new("DisabledButton", 1,1,5,5)
DisabledButton.setDevice("terminal")
DisabledButton.setCallback(function()
  print("Disabling")
  DisabledButton.setEnabled(false)
end)

parallel.waitForAll(buttons.listen)
