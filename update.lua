local Parameters = {...}
local Branch = string.lower((type(Parameters[1])=="string" and Parameters[3]) or "master")

local function GetInstallPath()
  local Program = shell.getRunningProgram()
  local Name = fs.getName(Program)
  return "/"..Program:sub(1, #Program-#Name)
end

print(string.format("Updating from the '%s' branch", Branch))
shell.run("pastebin", "run", "Eky25aPJ", "zachup100", "computercraft", Branch, GetInstallPath())
sleep(3)
os.reboot()
