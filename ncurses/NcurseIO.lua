local Dirs <const> = require('consts.Dirs')
local write <const> = io.write

local NcursesIO <const> = {}
NcursesIO.__index = NcursesIO

_ENV = NcursesIO

local keysToDirsMap <const> = {
	w = Dirs.UP,
	s = Dirs.Down,
	a = Dirs.left,
	d = Dirs.right
}

function NcursesIO.print(x,y,char)
	write(x, " : ",y," : ",char,"\n")
end

function NcursesIO.getCh()
	local ch <const> = "w"
	return keysToDirsMap[ch]
end


return NcursesIO
