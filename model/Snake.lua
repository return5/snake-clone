local LinkedList <const> = require('collection.LinkedList')
local Object <const> = require('model.Object')
local Dirs <const> = require('consts.Dirs')
local floor <const> = math.floor
local setmetatable <const> = setmetatable

local Snake <const> = {}
Snake.__index = Snake

_ENV = Snake

local Segment <const> = {}
Segment.__index = Segment

setmetatable(Segment,Object)

local Head <const> = {}
Head.__index = Head
setmetatable(Head,Segment)

function Segment:move(next,board)
	next.prevX = next.x
	next.prevY = next.y
	next.x = self.x
	next.y = self.y
	board:setTileToFalse(next.x,next.y)
	return true
end

function Segment:new(x,y,char)
	local segment <const> = setmetatable(Object:new(x,y,char),self)
	segment.yMove = y
	segment.xMove = x
	segment.prevX = x
	segment.prevY = y
	return segment
end

function Head:move(next,board)
	next.prevX = next.x
	next.prevY = next.y
	next.x = self.prevX
	next.y = self.prevY
	board:setTileToFalse(next.x,next.y)
	return true
end

function Head:moveHead(newX,newY,char)
	self.prevX  = self.x
	self.prevY  = self.y
	self.y = newY
	self.x = newX
	self.char = char
end

function Head:new(x,y,char)
	return setmetatable(Segment:new(x,y,char),self)
end

--used during the checkCollision with self.
function Head:checkCollision()
	return false
end

function Head:checkIfNewLoc()
	return self.x ~= self.prevX or self.y ~= self.prevY
end

function Snake:normalMove(board)
	self.snake:iterateBackwardsExcludeHead(function(prev,next) return prev:move(next,board) end)
end

function Snake:setTailTileToTrue(board)
	self.snake:tailFunc(function(tail) board:setTailTileToTrue(tail.x,tail.y)  end)
end

function Snake:tryMove(char,dir,newX,newY,board)
	self.head:moveHead(newX,newY,char,board)
	self.dir = dir
	if self.head:checkIfNewLoc() then
		self:moveBody(board)
		self:setTailTileToTrue(board)
	end
end

function Snake:moveHeadUp(dt,board)
	self.head.yMove = self.head.yMove - self.speed * dt
	self:tryMove("^",Dirs.UP,self.head.x,floor(self.head.yMove),board)
end

function Snake:moveHeadDown(dt,board)
	self.head.yMove = self.head.yMove + self.speed * dt
	self:tryMove("v",Dirs.DOWN,self.head.x,floor(self.head.yMove),board)
end

function Snake:moveHeadLeft(dt,board)
	self.head.xMove = self.head.xMove - self.speed * dt
	self:tryMove("<",Dirs.LEFT,floor(self.head.xMove),self.head.y,board)
end

function Snake:moveHeadRight(dt,board)
	self.head.xMove = self.head.xMove + self.speed * dt
	self:tryMove(">",Dirs.RIGHT,floor(self.head.xMove),self.head.y,board)
end

local movementMap <const> = {
	[Dirs.UP] = Snake.moveHeadUp,
	[Dirs.DOWN] = Snake.moveHeadDown,
	[Dirs.LEFT] = Snake.moveHeadLeft,
	[Dirs.RIGHT] = Snake.moveHeadRight,
	[Dirs.NONE] = function() end
}

function Snake:update(dt,board)
	movementMap[self.dir](self,dt,board)
end

function Snake:move(moveDir)
	self.dir = moveDir
end

function Snake:moveBodyAfterGrowth()
	local segment <const> = Segment:new(self.head.prevX,self.head.prevY,"+")
	self.snake:addAt(2,segment)
	self.moveBody = Snake.normalMove
end

function Snake:grow()
	self.moveBody = Snake.moveBodyAfterGrowth
	return true
end

function Snake:print()
	self.snake:iterate(function(segment) return segment:print() end)
end

function Snake:returnHeadCollision()
	return function(segment)
		return not segment:checkCollision(self.head)
	end
end

function Snake:checkIfCollideWithSelf()
	return not self.snake:iterateBackwardsExcludeHead(self:returnHeadCollision())
end

function Snake:checkBounds(board)
	return board:checkIfTileAvailable(self.head.x,self.head.y)
end

function Snake:checkCollision(obj)
	return Segment.checkCollision(self.head,obj)
end

function Snake:checkIfMove()
	return self.head.x ~= self.head.prevX or self.head.y ~= self.head.prevY
end

function Snake:size()
	return self.snake.size
end

function Snake:new(x,y)
	local head = Head:new(x,y,">")
	local snake = LinkedList:new()
	snake:add(head)
	return setmetatable({snake = snake,head = head,moveBody = Snake.normalMove,dir = Dirs.NONE,speed = 5},self)
end

return Snake
