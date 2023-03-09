--[[
This project is entirely made by SebasRomTen
If u give me credit i will be really thankful with u.
3/4/23
Was made on
3/4/23
Added Tweens, Http, Tables and string concat function
TODO:
Nothing RN
]]--

--//Framework
local misc = {}

--//Services
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local PathfindingService = game:GetService("PathfindingService")
local animate = loadstring(game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/SebasRomTen/Character-Animator/main/animator.lua"))()

--//Lib Elements
misc.Loops = {}
misc.String = {}
misc.Random = {}
misc.Players = {}
misc.Tweens = {}
misc.Http = {}
misc.Tables = {}
misc.Chars = {}

--//Built-In Functions

function tween(object:Instance, waitTime, style, direction, props)
	local _a = game:GetService("TweenService"):Create(object, TweenInfo.new(waitTime, Enum.EasingStyle[style], Enum.EasingDirection[direction], 0, false), props)
	return _a
end

--//Lib Coding

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
		RunService.Heartbeat:Connect(f)
	end)()
end

misc.String.GetAllCharacters = function(s:string)
	local chars = {}
	for i = 1, #s do
		table.insert(chars, s:sub(i, i))
	end
	return chars
end

misc.String.concat = function(...:string)
	local form = ""
	for i = 1, select("#", ...) do
		form = form.."%s"
	end
	return string.format(form, ...)
end

misc.String.Format = function(text:string)
	return string.upper(text:sub(1,1))..text:sub(2).."."
end

misc.Random.RandomPlayerName = function()
	return Players:GetNameFromUserIdAsync(math.floor(math.random(1, 2000000000)))
end

misc.Tweens.INFTween = function(obj:Instance, props, es, ed, wt)
	local TweenService = game:GetService("TweenService")
	return TweenService:Create(obj, TweenInfo.new(wt, es, ed, -1, false), props)
end

misc.Tables.concat = function(t1, t2)
	local function insert(t, vn, v)
		t[vn] = v
	end
	local merges = {}

	if t1 then
		for i, v in next, t1 do
			if typeof(i) == "string" then
				insert(merges, tostring(i), v)
			else
				insert(merges, tostring(v), v)
			end
		end
	end

	if t2 then
		for i, v in next, t2 do
			if typeof(i) == "string" then
				insert(merges, tostring(i), v)
			else
				insert(merges, tostring(v), v)
			end
		end
	end

	return merges
end

misc.Chars.new = function(props)
	local HumDesc = Instance.new("HumanoidDescription")

	local function applyprops(t, obj)
		if t then
			for i, v in next, t do
				obj[i] = v
			end
		end
	end

	if props then
		applyprops(props, HumDesc)
	else
		applyprops(nil, HumDesc)
	end

	local char = Players:CreateHumanoidModelFromDescription(HumDesc, "R6")
	return char
end

misc.Chars.animate = function(char)
	animate(char)
end

return misc
