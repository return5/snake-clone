local setmetatable <const> = setmetatable

local Food <const> = {}
Food.__index = Food

_ENV = Food

function Food:checkCollision(x,y)
	return self.x == x and self.y == y
end

function Food:new(x,y)
	return setmetatable({x = x, y = y},self)
end

return Food
