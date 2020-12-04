local StartupParameters = {...}
local FarmSize = {X=(tonumber(StartupParameters[1]) or 2),Z=(tonumber(StartupParameters[1]) or 2)}


local Parameters = {...}
local SizeX, SizeZ = tonumber(Parameters[1]) or 4, tonumber(Parameters[2]) or 4
local Heading = 0

--// North = 0, East = 1, South = 2, West = 3

term.clear()
term.setCursorPos(1,1)

function CanMove()

end
