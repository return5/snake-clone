local Snake = require('model.Snake')
local Board <const> = require('model.Board')
local FooFactory <const> = require('factory.FoodFactory')
local tick <const> = require('libs.tick')
local NcursesIO <const> = require("ncurses.NcurseIO")
local Ncurses <const> = require('ncurses.Ncurses')
local Timer <const> = require('model.Timer')
local remove <const> = table.remove

local function draw(snake,food)
	NcursesIO.clear()
	snake:print()
	for i=1,#food,1 do
		food[i]:print()
	end
	NcursesIO.refresh()
end

local continue = true

local function checkIfEatFood(snake,food)
	for i =1,#food,1 do
		if snake:checkCollision(food[i]) then
			food[i]:eat()
			remove(food,i)
			return true
		end
	end
	return false
end

local function update(snake,food,board)
	snake:update()
	if not snake:checkBounds(board) then continue = false end
	if checkIfEatFood(snake,food) then snake:grow() end
end

local function input(snake)
	local userInput <const> = NcursesIO.getCh()
	if userInput then snake:move(userInput) end
end

local function gameLoop()
	local board <const> = Board:new(10,10)
	local food <const> = FooFactory.generateFood(board)
	local snakeX <const>,snakeY <const> = 5,10 --board:getAvailableTile()
	local snake <const> = Snake:new(snakeX,snakeY)
	local timer <const> = Timer:new()
	tick.recur(function() draw(snake,food) end,1)
	tick.recur(function() update(snake,food,board) end,1)
	while continue do
		local dt <const> = timer:getDt()
		tick.update(dt)
		input(snake)
	end
end

local function main()
	math.randomseed(os.time())
	Ncurses.init()
	gameLoop()
	Ncurses.tearDown()
end

main()
