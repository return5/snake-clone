local Object <const> = require('model.Object')
local setmetatable <const> = setmetatable

local Food <const> = {}
Food.__index = Food
setmetatable(Food,Object)


_ENV = Food


function Food:new(x,y)
	return setmetatable(Object:new(x,y,"*"),self)
end

return Food
