local setmetatable = setmetatable

local LinkedList = {}
LinkedList.__index = LinkedList

_ENV = LinkedList

local Node = {}
Node.__index = Node

function Node:new(item)
	return setmetatable({item = item},self)
end

function LinkedList:iterateBackwardsExcludeHead(fn)
	local temp = self.tail
	while temp.prev do
		fn(temp)
		temp = temp.prev
	end
end

function LinkedList:new(item)
	local node = Node:new(item)
	if self.size == 0 then
		self.head = node
		self.tail = node
	elseif self.size == 1 then
		self.tail = node
		self.head.next = node
		self.tail.prev = self.head
	else
		self.tail.next = node
		node.prev = self.tail
		self.tail = node
	end
	self.size = self.size + 1
end


function LinkedList:new()
	return setmetatable({size = 0},self)
end

return LinkedList
