local setmetatable <const> = setmetatable
local NcursesIO <const> = require('ncurses.NcurseIO')

local Object <const> = {}
Object.__index = Object

_ENV = Object

function Object:checkCollision(obj2)
	return self.x == obj2.x and self.y == obj2.y
end

function Object:print()
	NcursesIO.print(self.x,self.y,self.char)
	return true
end

function Object:new(x,y,char,color)
	return setmetatable({x = x, y = y, char = char,color},self)
end

return Object
