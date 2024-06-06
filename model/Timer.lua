local Ncurses <const> = require('ncurses.Ncurses')
local write = io.write
local setmetatable <const> = setmetatable

local Timer <const> = {}
Timer.__index = Timer

_env = Timer

local timeSt <const> = {}
timeSt.__index = {}

function Timer:diff(sec, nsec)
	return (sec - self.sec) + ((nsec - self.nsec) / 1000000000)
end

function Timer:getDt()
	local nowSec <const>, nowNsec <const> = Ncurses.getTime()
	local dt <const> = self:diff(nowSec,nowNsec)
	self.sec = nowSec
	self.nsec = nowNsec
	return dt
end

function Timer:new()
	local nowSec <const>, nowNsec <const> = Ncurses.getTime()
	return setmetatable({sec = nowSec,nsec = nowNsec},self)
end


return Timer
