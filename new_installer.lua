local Index = {...}
local Author = Index[1]
local Repository = Index[2]
local _Program = shell.getRunningProgram()
local X,Y = term.getSize()

if not Author or not Repository then
  print(string.format("%s: <Author> <Repository>", _Program))
else
  term.clear()
  term.setCursorPos(1,1)
  term.write("Preparing to install Robert's Garbage.")
  term.setCursorPos(1,2)
  if not fs.exists("temporary") then
    shell.run("mkdir", "temporary")
  end
  term.write("Retreiving APIs...")
  term.setCursorPos(1,3)
  shell.run("pastebin", "get", "4nRg9CHU", "temporary/json.lua")
  os.loadAPI("temporary/json.lua")
  term.write("Loaded APIs.")
  term.setCursorPos(1,4)
  term.write("Obtaining GitHub Repository Info...")
  term.setCursorPos(1,5)
  local Connection = http.get(string.format("https://api.github.com/repos/%s/%s/git/trees/master?recursive=1",Author,Repository))
  local Contents = json.parseValue(Connection.readAll())
  if not Connection then error("Author or Repository does not exist.") end
  Connection.close()
  term.write("Writing GitHub Repository data to Computer...")
  term.setCursorPos(1,6)
  for _, File in pairs(Contents.tree) do
    local Connection = http.get(string.format("https://raw.githubusercontent.com/%s/%s/master/%s",Author,Repository,File.path))
    local Handle = fs.open(File.path,"w")
    if Connection and Handle then
      Handle.write(Connection.readAll())
      Handle.close()
      Connection.close()
    end
  end
  fs.delete("temporary/")
  term.setCursorPos(1,Y-1)
  term.write("Finished downloading repository!")
  term.setCursorPos(1,Y)
  term.write("Rebooting in 3 seconds...")
  term.setCursorPos(1,Y+20)
  sleep(3)
  os.reboot()
end
