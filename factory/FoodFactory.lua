local tick <const> = require('libs.tick')
local Food <const> = require('model.Food')
local remove = table.remove
local rand = math.random


local FoodFactory <const> = {}
FoodFactory.__index = FoodFactory

_ENV = FoodFactory


local function removeFoodIem(food,board)
	return function()
		food[1]:endTickEvent()
		board:setTileToTrue(food[1].x,food[1].y)
		remove(food,1)
	end
end

local function createNewFoodItem(food,board)
	local event <const> = tick.delay(removeFoodIem(food,board),10)
	local x <const>, y <const> = board:getAvailableTile()
	local item <const> = Food:new(x,y,event)
	food[#food + 1] = item
	board:setTileToFalse(x,y)
end

local function generateFoodItems(food,board)
	return function()
		if rand(1,100)	> 60 then
			createNewFoodItem(food,board)
		end
	end
end

function FoodFactory.generateFood(board)
	local food <const> = {}
	createNewFoodItem(food,board)
	tick.recur(generateFoodItems(food,board),1)
	return food
end

return FoodFactory
