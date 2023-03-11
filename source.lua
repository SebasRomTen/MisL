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
misc.Obfuscation = {}

misc.Obfuscation.Base64 = nil
misc.Http.returnData = nil

--//Functions

local function returnData(file)
	local lcode
	local s, e = pcall(function()
		local content = HttpService:GetAsync(file)
		local code = loadstring(content)()
		lcode = code
	end)
	if s then
		print("Loaded without errors")
		return lcode
	else
		warn("Failed to load file")
		error(e)
	end
end

--//Lib Coding
local Base64 = returnData("https://raw.githubusercontent.com/SebasRomTen/Lua-Base64-Encription/main/Base64.lua")
misc.Obfuscation.Base64 = Base64
misc.Http.returnData = returnData

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

misc.Loops.SL = function(func)
	local Bind = Instance.new('BindableEvent')

	for i,v in ipairs({RunService.Heartbeat, RunService.Stepped, RunService.PreRender, RunService.PostSimulation, RunService.PreSimulation}) do
		v.Connect(v, function()
			return Bind.Fire(Bind, tick())
		end)
	end

	local SuperLoop = Bind.Event

	SuperLoop:Connect(func)
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
		applyprops({
			HeadColor = Color3.new(1, 1, 1),
			TorsoColor = Color3.new(1, 1, 1),
			RightArmColor = Color3.new(1, 1, 1),
			LeftArmColor = Color3.new(1, 1, 1),
			LeftLegColor = Color3.new(1, 1, 1),
			RightLegColor = Color3.new(1, 1, 1)
		}, HumDesc)
	end

	local char = Players:CreateHumanoidModelFromDescription(HumDesc, "R6")
	return char
end

misc.Chars.animate = function(char)
	animate(char)
end

return misc
