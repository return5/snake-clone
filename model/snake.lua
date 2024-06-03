local LinkedList <const> = require('collection.LinkedList')
local setmetatable <const> = setmetatable

local Snake <const> = {}
Snake.__index = Snake

_ENV = Snake

local Segment <const> = {}
Segment.__index = Segment

function Segment:new(x,y)
	return setmetatable({x = x, y = y},self)
end

function Segment:move()
	self.x = self.prev.x
	self.y = self.prev.y
end

function Snake:moveBody()
	self.snake:iterateBackwardsExcludeHead(Segment.move)
end

function Snake:moveHeadUp()
	self:moveBody()
end

function Snake:moveHeadDown()
	self:moveBody()
end

function Snake:moveHeadLeft()
	self:moveBody()
end

function Snake:moveHeadRight()
	self:moveBody()
end

function Snake:grow()

end

function Snake:new(x,y)
	local head = Segment:new(x,y)
	local snake = LinkedList:new()
	snake:add(head)
	return setmetatable({snake = snake},self)
end

return Snake
