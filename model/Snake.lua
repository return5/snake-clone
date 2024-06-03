local LinkedList <const> = require('collection.LinkedList')
local setmetatable <const> = setmetatable
local write <const> = io.write

local Snake <const> = {}
Snake.__index = Snake

_ENV = Snake

local Segment <const> = {}
Segment.__index = Segment

function Segment:new(x,y)
	return setmetatable({x = x, y = y},self)
end

function Segment:move(prev)
	self.x = prev.x
	self.y = prev.y
	return true
end

function Segment:checkCollision(x,y)
	return self.x == x and self.y == y
end

function Segment:print()
	write("x: ",self.x," ; y:  ",self.y,"\n")
	return true
end

function Snake:normalMove()
	self.snake:iterateBackwardsExcludeHead(Segment.move)
end

function Snake:moveHeadUp()
	self:moveBody()
	self.head.y = self.head.y - 1
end

function Snake:moveHeadDown()
	self:moveBody()
	self.head.y = self.head.y + 1
end

function Snake:moveHeadLeft()
	self:moveBody()
	self.head.x = self.head.x - 1
end

function Snake:moveHeadRight()
	self:moveBody()
	self.head.x = self.head.x + 1
end

function Snake:moveAfterGrowth()
	self.moveBody = Snake.normalMove
end

function Snake:grow()
	local segment <const> = Segment:new(self.head.x,self.head.y)
	self.snake:addAt(2,segment)
	self.moveBody = Snake.moveAfterGrowth
end

function Snake:print()
	self.snake:iterateBackwardsExcludeHead(Segment.print)
	self.head:print()
end

function Snake:returnHeadCollision()
	return function(segment)
		return not segment:checkCollision(self.head.x,self.head.y)
	end
end

function Snake:checkIfCollideWithSelf()
	return not self.snake:iterateBackwardsExcludeHead(self:returnHeadCollision())
end

function Snake:checkIfEatFood(food)
	for i =1,#food,1 do
		if food[i]:checkCollision(self.head.x,self.head.y) then self:grow() end
	end
end

function Snake:new(x,y)
	local head = Segment:new(x,y)
	local snake = LinkedList:new()
	snake:add(head)
	return setmetatable({snake = snake,head = head,moveBody = Snake.normalMove},self)
end

return Snake
