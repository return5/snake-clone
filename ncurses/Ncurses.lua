require("libs.ncurses.sluacurses")

local init <const> = init
local endWin <const> = endwin
local getTime <const> = getTime

local Ncurses <const> = {}
Ncurses.__index = Ncurses

_ENv = Ncurses

function Ncurses.tearDown()
	endWin()
end

function Ncurses.getTime()
	return getTime()
end

function Ncurses.init()
	init()
end

return Ncurses
