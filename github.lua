--//
--// Github Content Fetcher by zachup100
--// https://pastebin.com/mvEWLReZ
--//
--// JSON Library by ElvishJerricco
--// http://www.computercraft.info/forums2/index.php?/topic/5854-json-api-v201-for-computercraft/
--//

local Parameters = {...}

local Author = Parameters[1]
local Repository = Parameters[2]
local Branch = string.lower((type(Parameters[3])=="string" and Parameters[3]) or "master")
if Branch == "auto" then Branch = "master" end
local WritePath = Parameters[4] or "/"

local function split(input, sep)
  if not sep then sep = "%s" end
  local rtn = {}
  for str in string.gmatch(input, "([^"..sep.."]+)") do table.insert(rtn, str) end
  return rtn
end

local function makedir(path)
  if not fs.exists(path) or fs.exists(path) and not fs.isDir(path) then
    shell.run("mkdir", path)
  end
end

if WritePath ~= "/" then
  local RawPath = split(Parameters[4], "/")
  if #RawPath == 0 then
    WritePath = "/"
  elseif #RawPath == 1 then
    WritePath = "/"..RawPath[1].."/"
    makedir(WritePath)
  else
    WritePath = "/"
    for _, dir in ipairs(RawPath) do
      WritePath = WritePath .. "/"..dir
    end
    WritePath = WritePath .. "/"
    makedir(WritePath)
  end
end

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
if not os.loadAPI("apis/json.lua") then
  print(string.format("%s: Failed to load json library", shell.getRunningProgram()))
  return
end

local function HttpGet(URL)
  local Success = http.get(URL)
  if Success then
    local Contents = Success.readAll()
    Success.close()
    return true, Contents
  end
  return false
end

function GetRepositoryInfo() return HttpGet(GIT_INFO_URL) end
function GetFileContents(path) return HttpGet(CONTENT_URL..path) end

local Success, Contents = GetRepositoryInfo()
if Success then
  Contents = json.parseValue(Contents)
  for _, Info in ipairs(Contents.tree) do
    if Info.type == "blob" then
      local Success, Data = GetFileContents(Info.path)
      local File = fs.open(WritePath..Info.path,"w")
      if Success and File then
        print(string.format("Writing: %s", Info.path))
        File.write(Data)
        File.close()
      end
    elseif Info.type == "tree" then
      makedir(WritePath..Info.path)
      --if not fs.exists(Info.path) or (fs.exists(Info.path) and not fs.isDir(Info.path)) then
      --  print(string.format("Creating Directory: %s", Info.path))
      --end
    end
  end
  print(string.format("%s: File downloads completed.", shell.getRunningProgram()))
  return
else
  print(string.format("%s: Failed to obtain repository info.", shell.getRunningProgram()))
  return
end
