local setmetatable <const> = setmetatable
local write <const> = io.write

local Object <const> = {}
Object.__index = Object

_ENV = Object

function Object:checkCollision(x,y)
	return self.x == x and self.y == y
end

function Object:print()
	write("x: ",self.x," ; y:  ",self.y,"\n")
	return true
end


function Object:new(x,y,char)
	return setmetatable({x = x, y = y, char = char},self)
end

return Object
