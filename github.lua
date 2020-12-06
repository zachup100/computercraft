local Parameters = {...}

local Author = Parameters[1]
local Repository = Parameters[2]
local Branch = string.lower((type(Parameters[3])=="string" and Parameters[3]) or "master")
if Branch == "auto" then Branch = "master" end

if type(Author) ~= "string" or type(Repository) ~= "string" then
  print(string.format("%s: <Author> <Repository> [Branch:Auto] [Path]", shell.getRunningProgram()))
  return
end

if not fs.exists("apis") or fs.exists("apis") and not fs.isDir("apis") then shell.run("mkdir", "apis") end
shell.run("pastebin", "get", "4nRg9CHU", "apis/json.lua")

if not fs.exists("apis/json.lua") then
  shell.run("pastebin", "get", "4nRg9CHU", "apis/json.lua")
  if not fs.exists("apis/json.lua") then
    print(string.format("%s: Failed to download json library", shell.getRunningProgram()))
    return
  end
end

local GIT_INFO_URL = string.format("https://api.github.com/repos/%s/%s/git/trees/%s?recursive=1", Author, Repository, Branch)
local CONTENT_URL = string.format("https://raw.githubusercontent.com/%s/%s/%s/", Author, Repository, Branch)
os.loadAPI("apis/json.lua")

local function HttpGet(URL)
  local Success = http.get(URL)
  if Success then
    local Contents = json.parseValue(Success.readAll())
    Success.close()
    return true, Contents
  end
  return false
end

function GetRepositoryInfo() return HttpGet(GIT_INFO_URL) end
function GetFileContents(path) return HttpGet(CONTENT_URL..path) end

local Success, Contents = GetRepositoryInfo()
if Success then
  for _, Info in ipairs(Contents.tree) do
    if Info.type == "blob" then
      print(string.format("Adding File: %s", Info.path))
      local Success, Data = GetFileContents(Info.path)
      local File = fs.open(Info.path,"w")
      if Success and File then
        File.write(Data)
        File.close()
      end
    elseif Info.type == "tree" then
      print(string.format("Checking for Directory: %s", Info.path))
      if not fs.exists(Info.path) or (fs.exists(Info.path) and not fs.isDir(Info.path)) then
        print(string.format("Creating Directory: %s", Info.path))
        shell.run("mkdir", Info.path)
      end
    end
  end
  print(string.format("%s: File downloads completed.", shell.getRunningProgram()))
  return
else
  print(string.format("%s: Failed to obtain repository info.", shell.getRunningProgram()))
  return
end
