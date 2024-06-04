local setmetatable <const> = setmetatable
local rand <const> = math.random
local pairs <const> = pairs

local Board <const> = {}
Board.__index = Board

_ENV = Board

function Board:removeTile(x,y)
	if self.availableTiles[y] and self.availableTiles[y][x] then
		self.availableTiles[y][x] = nil
		if #self.availableTiles[y] == 0 then self.availableTiles[y] = nil end
	end
end

function Board:addTile(x,y)
	if not self.availableTiles[y] then
		self.availableTiles[y] = {}
	end
	self.availableTiles[y][x] = true
end

function Board:getAvailableTile()
	local tiles <const> = {}
	local yIndexes <const> = {}
	for y,xArr in pairs(self.availableTiles) do
		yIndexes[#yIndexes + 1] = y
		tiles[#tiles + 1] = {}
		for x in pairs(xArr) do
			tiles[#tiles][#tiles[#tiles] + 1] = x
		end
	end
	local yIndex <const> = rand(1,#yIndexes)
	return tiles[yIndex][rand(1,#tiles[yIndex])],yIndexes[yIndex]
end

local function setAvailableTiles(height,width)
	local tiles <const> = {}
	for i=1,height,1 do
		tiles[i] = {}
		for j =1,width,1 do
			tiles[i][j] = true
		end
	end
	return tiles
end

function Board:new(height,width)
	return setmetatable({ height = height, width = width, availableTiles = setAvailableTiles(height,width)},self)
end

return Board

