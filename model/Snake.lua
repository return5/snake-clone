local LinkedList <const> = require('collection.LinkedList')
local Object <const> = require('model.Object')
local Dirs <const> = require('consts.Dirs')
local setmetatable <const> = setmetatable

local Snake <const> = {}
Snake.__index = Snake

_ENV = Snake

local Segment <const> = {}
Segment.__index = Segment

setmetatable(Segment,Object)

function Segment:move(prev)
	self.x = prev.x
	self.y = prev.y
	return true
end

function Snake:normalMove()
	self.snake:iterateBackwardsExcludeHead(Segment.move)
end

function Snake:moveHeadUp()
	self:moveBody()
	self.head.y = self.head.y - 1
	self.dir = Dirs.UP
	self.head.char = "^"
end

function Snake:moveHeadDown()
	self:moveBody()
	self.head.y = self.head.y + 1
	self.dir = Dirss.DOWN
	self.head.char = "v"
end

function Snake:moveHeadLeft()
	self:moveBody()
	self.head.x = self.head.x - 1
	self.dir = Dirss.LEFT
	self.head.char = "<"
end

function Snake:moveHeadRight()
	self:moveBody()
	self.head.x = self.head.x + 1
	self.dir = Dirss.RIGHT
	self.hard.char = ">"
end

local movementMap <const> = {
	[Dirs.UP] = Snake.moveHeadUp,
	[Dirs.DOWN] = Snake.moveHeadDown,
	[Dirs.LEFT] = Snake.moveHeadLeft,
	[Dirs.RIGHT] = Snake.moveHeadRight,
	[Dirs.NONE] = function() end
}

function Snake:update()
	movementMap[self.dir](self)
end

function Snake:move(moveDir)
	self.dir = moveDir
end

function Snake:moveAfterGrowth()
	self.moveBody = Snake.normalMove
end

function Snake:grow()
	local segment <const> = Segment:new(self.head.x,self.head.y,"#")
	self.snake:addAt(2,segment)
	self.moveBody = Snake.moveAfterGrowth
	return true
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

function Snake:checkBounds(board)
	return board:checkIfTileAvailable(self.head.x,self.head.y)
end

function Snake:checkCollision(obj)
	return self.head:checkCollision(obj)
end

function Snake:new(x,y)
	local head = Segment:new(x,y,">")
	local snake = LinkedList:new()
	snake:add(head)
	return setmetatable({snake = snake,head = head,moveBody = Snake.normalMove,dir = Dirs.NONE},self)
end

return Snake
