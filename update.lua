local function GetInstallPath()
  local Program = shell.getRunningProgram()
  local Name = fs.getName(Program)
  return Program:sub(1, #Program-#Name)
end

print(GetInstallPath())
shell.run("pastebin", "run", "Eky25aPJ", "zachup100", "computercraft", "master", "/")
sleep(3)
os.reboot()
