--[[
	snake-clone: a simple snake clone running inside a terminal.
            Copyright (C) <2024>  <github/return5>

            This program is free software: you can redistribute it and/or modify
            it under the terms of the GNU General Public License as published by
            the Free Software Foundation, either version 3 of the License, or
            (at your option) any later version.

            This program is distributed in the hope that it will be useful,
            but WITHOUT ANY WARRANTY; without even the implied warranty of
            MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
            GNU General Public License for more details.

            You should have received a copy of the GNU General Public License
            along with this program.  If not, see <https://www.gnu.org/licenses/>.
--]]


local Snake = require('model.Snake')
local Board <const> = require('model.Board')
local FooFactory <const> = require('factory.FoodFactory')
local tick <const> = require('libs.tick')
local NcursesIO <const> = require("ncurses.NcurseIO")
local Ncurses <const> = require('ncurses.Ncurses')
local Timer <const> = require('model.Timer')
local remove <const> = table.remove

local borderWidth,borderHeight

local function draw(snake,food)
	NcursesIO.clear()
	snake:print()
	for i=1,#food,1 do
		food[i]:print()
	end
	NcursesIO.refresh()
	NcursesIO.drawBorder(borderHeight,borderWidth)
	NcursesIO.refresh()
end


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

local function update(snake,food,board,dt)
	snake:update(dt,board)
	if snake:checkIfMove() then
		if not snake:checkBounds(board) then return false end
		if snake:checkIfCollideWithSelf() then return false end
		if checkIfEatFood(snake,food) then snake:grow() end
	end
	return true
end

local function input(snake)
	local userInput <const> = NcursesIO.getCh()
	if userInput then snake:move(userInput) end
end


local function setUp()
	local board <const> = Board:new(10,20)
	borderWidth = board.width + 1
	borderHeight = board.height + 1
	local food <const> = FooFactory.generateFood(board)
	local snakeX <const>,snakeY <const> = board:getAvailableTile()
	local snake <const> = Snake:new(snakeX,snakeY)
	local timer <const> = Timer:new()
	return board,food,snake,timer
end

local function gameLoop(snake,food,board,timer)
	local continue = true
	draw(snake,food)
	while continue do
		local dt <const> = timer:getDt()
		tick.update(dt)
		input(snake)
		continue = update(snake,food,board,dt)
		if  snake:checkIfMove() then
			draw(snake,food)
		end
	end
end

local function main()
	math.randomseed(os.time())
	Ncurses.init()
	local board <const>,food <const>,snake <const>,timer <const> = setUp()
	gameLoop(snake,food,board,timer)
	Ncurses.tearDown()
	io.write("Game Over! score: ",snake:size(),"\n")
end

main()
