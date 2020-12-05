local Parameters = {...}

local Author = tostring(Parameters[1])
local Repository = tostring(Parameters[2])
local Branch = (type(Parameters[3])=="string" and Parameters[3]) or "master"
