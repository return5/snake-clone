local tick <const> = require('libs.tick')
local Food <const> = require('model.Food')
local remove = table.remove
local rand = math.random


local FoodFactory <const> = {}
FoodFactory.__index = FoodFactory

_ENV = FoodFactory


local function removeFoodIem(food)
	return function()
		food[1]:endTickEvent()
		remove(food,1)
	end
end

local function generateFoodItems(food,head)
	return function()
		if rand(1,100)	> 80 then
			local event <const> = tick:delay(removeFoodIem(food),5)
			--TODO bounds check x and y
			local item <const> = Food:new(rand(1,50),rand(1,50),event)
			food[#food + 1] = item
		end
	end
end

function FoodFactory.generateFood(head)
	--TODO check boundary size
	local food <const> = {}
	tick:recur(generateFoodItems(food,head),1)
	return food
end

return FoodFactory
