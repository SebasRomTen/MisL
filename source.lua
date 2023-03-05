--[[


This project is entirely made by SebasRomTen
If u give me credit i will be really thankful with u.
3/4/23
MisL was made


]]--


local misc = {}

local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local PathfindingService = game:GetService("PathfindingService")

misc.Loops = {}
misc.String = {}
misc.Random = {}
misc.Players = {}

misc.Loops.RS = function(f)
	coroutine.wrap(function()
		if RunService:IsClient() then
			RunService.RenderStepped:Connect(f)
		elseif RunService:IsServer() then
			RunService.Stepped:Connect(f)
		end
	end)()
end

misc.Loops.HB = function(f)
	coroutine.wrap(function()
		RunService.Stepped:Connect(f)
	end)()
end

misc.String.GetAllCharacters = function(s:string)
	local chars = {}
	for i = 1, #s do
		table.insert(chars, s:sub(i, i))
	end
	return chars
end

misc.String.Format = function(text:string)
	return string.upper(text:sub(1,1))..text:sub(2).."."
end

misc.Random.RandomPlayerName = function()
	return Players:GetNameFromUserIdAsync(math.floor(math.random(1, 2000000000)))--2000000000000
end

return misc
