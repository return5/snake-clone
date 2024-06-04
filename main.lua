local Snake = require('model.Snake')
local Food = require('model.Food')
local Board <const> = require('model.Board')

local board <const> = Board:new(10,10)

for i=1,10,1 do
	for j=1,10,1 do
		board:setTileToFalse(j,i)
	end
end

local map <const> = board.availableTiles


local x <const>, y <const> = board:getAvailableTile()

io.write("x,y is: ",x, " : ",y,"\n")

--local food <const> = {Food:new(3,3)}
--local snake <const> = Snake:new(5,6)
--snake:moveHeadUp()
--snake:grow()
--snake:moveHeadUp()
--io.write("snake collided with self: ",(snake:checkIfCollideWithSelf() and "true" or "false"),"\n")
--snake:grow()
--snake:moveHeadUp()
--snake:moveHeadLeft()
--io.write("snake collided with food: ",(snake:checkIfEatFood(food) and "true" or "false"),"\n")
--snake:moveHeadLeft()
--io.write("snake collided with self: ",(snake:checkIfCollideWithSelf() and "true" or "false"),"\n")
--io.write("snake collided with food: ",(snake:checkIfEatFood(food) and "true" or "false"),"\n")
--snake:print()


