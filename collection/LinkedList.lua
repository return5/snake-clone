local setmetatable <const> = setmetatable

local LinkedList <const> = {}
LinkedList.__index = LinkedList

_ENV = LinkedList

local Node <const> = {}
Node.__index = Node

function Node:new(item)
	return setmetatable({item = item},self)
end

function LinkedList:iterateBackwardsExcludeHead(fn)
	if self.size > 1 then
		local temp = self.tail
		local prev = temp.prev
		while prev do
			if  not fn(temp.item,prev.item) then return false end
			temp = prev
			prev = temp.prev
		end
	end
	return true
end

function LinkedList:addSecondNode(node)
	self.tail = node
	self.tail.prev = self.head
	self.head.next = self.tail
end

function LinkedList:addAt(i,item)
	local node <const> = Node:new(item)
	if self.size == 1 then
		self:addSecondNode(node)
	else
		local index = 1
		local temp = self.head
		while index < i and temp do
			temp = temp.next
			index = index + 1
		end
		temp.prev.next = node
		node.prev = temp.prev
		node.next = temp
		temp.prev = node
	end
	self.size = self.size + 1
end

function LinkedList:add(item)
	local node <const> = Node:new(item)
	if self.size == 0 then
		self.head = node
		self.tail = node
	elseif self.size == 1 then
		self:addSecondNode(node)
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
