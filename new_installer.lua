local params = {...}
local Author = params[1]
local Repo = params[2]
if not Author or not Repo then error("Invalid repo") end
print("good repo")
