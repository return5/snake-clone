local Snake = require('model.Snake')
local Food = require('model.Food')

local food <const> = {Food:new(3,3)}
local snake <const> = Snake:new(5,6)
snake:moveHeadUp()
snake:grow()
snake:moveHeadUp()
io.write("snake collided with self: ",(snake:checkIfCollideWithSelf() and "true" or "false"),"\n")
snake:grow()
snake:moveHeadUp()
snake:moveHeadLeft()
snake:moveHeadRight()
io.write("snake collided with self: ",(snake:checkIfCollideWithSelf() and "true" or "false"),"\n")
snake:checkIfEatFood(food)
--snake:print()


