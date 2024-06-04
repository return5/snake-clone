local Object <const> = require('model.Object')
local tick <const> = require('libs.tick')
local setmetatable <const> = setmetatable

local Food <const> = {}
Food.__index = Food
setmetatable(Food,Object)


_ENV = Food

function Food:cancelTickEvent()
	tick:remove(self.tickEvent)
end

function Food:new(x,y,tickEvent)
	local food <const> = setmetatable(Object:new(x,y,"*"),self)
	food.tickEvent = tickEvent
	return food
end

return Food
