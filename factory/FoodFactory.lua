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

local function generateFoodItems(food,board)
	return function()
		if rand(1,100)	> 80 then
			local event <const> = tick.delay(removeFoodIem(food,board),5)
			local x <const>, y <const> = board:getAvailableTile()
			local item <const> = Food:new(x,y,event)
			food[#food + 1] = item
			board:setTileToFalse(x,y)
		end
	end
end

function FoodFactory.generateFood(board)
	local food <const> = {}
	local event <const> = tick.delay(removeFoodIem(food,board),10)
	food[3] = Food:new(5,9,event)
	local event2 <const> = tick.delay(removeFoodIem(food,board),10)
	food[2] = Food:new(5,6,event2)
	local event3 <const> = tick.delay(removeFoodIem(food,board),3)
	food[1] = Food:new(5,1,event3)

	--tick.recur(generateFoodItems(food,board),1)
	return food
end

return FoodFactory