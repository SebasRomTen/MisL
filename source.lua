--[[
This project is entirely made by SebasRomTen
If u give me credit i will be really thankful with u.
3/4/23
Was made on
3/4/23
Added Tweens, Http, Tables and string concat function
It was updated along the year but i forgot to update this lol
5/2/24
Made a better debugger for the newScript function
9/2/24
Added an easier table.remove function

MisL.Tables.remove({}, "value (not necessarily a string)")
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
misc.Instances = {}

misc.Obfuscation.Base64 = nil
misc.Http.returnData = nil
misc.Instances.applyprops = nil

--//Functions

local function returnData(file)
	local lcode
	local s, e = pcall(function()
		local content = HttpService:GetAsync(file)
		local code = loadstring(content)()
		lcode = code
	end)
	if s then
		return lcode
	else
		warn("Failed to load file")
		error(e)
	end
end

local function applyprops(t, obj)
	if t then
		for i, v in next, t do
			if typeof(obj) == "Instance" then
				obj[i] = v
			end
		end
	end
end

function rich(String : string, sub, color : string)
	return String:gsub(sub, ("<font color='rgb(%s)'>%s</font>"):format(color, sub), 1)
end

function number(s, su)
	return rich(s, su, "255, 198, 0")
end

function String(s, su)
	return rich(s, su, "173, 241, 149")
end

function functionName(s, su)
	return rich(s, su, "253, 251, 172")
end

function Error(s, su)
	return rich(s, su, "203,56,42")
end

function Blank(s, su)
	return rich(s, su, "255, 255, 255")
end

NLS = NLS
NS = NS
warnf = warnf
printf = printf

function newScript(Code:string, class:string, par : Instance)
	local MCod = Code
	if class and string.lower(typeof(class)) == "string" then
		if string.lower(class) == "local" then
			if Code:sub(0, 8) == "https://" then
				MCod = game:GetService("HttpService"):GetAsync(Code)
			end
			local scr : Script
			if par then
				scr = NLS(MCod, par)
			else
				scr = NLS(MCod)
			end
			return scr
		elseif string.lower(class) == "server" then
			if Code:sub(0, 8) == "https://" then
				MCod = game:GetService("HttpService"):GetAsync(Code)
			end
			local scr : Script
			if par then
				scr = NS(MCod, par)
			else
				scr = NS(MCod)
			end
			return scr
		end
	else
		if string.lower(typeof(class)) == "string" then
			if par then
				local wf = rich("No class has been given, class and parent: "..class.." "..par:GetFullName() or par.Name, class, "rgb(109,191,219)")
				warnf(wf)
			else
				local wf = rich("No class has been given, class "..class, class, "rgb(109,191,219)")
				warnf(wf)
			end
		else
			local typ = string.lower(typeof(class))
			local txt = ("Invalid argument #2 to newScript (string expected, got %s)"):format(typ)
			local w1 =      functionName(txt, "newScript")
			local w2 =      number(w1, "#2")
			local w3 =      String(w2, "string")
			local w4 =      Error(w3, "Invalid argument")
			local w5 =      Error(w4, "to")
			local w6 =      Error(w5, "expected,")
			local w7 =      Error(w6, "got")
			local w8 =      rich(w7, typ, "132, 214, 247")
			local wf = w8
			printf(wf)
		end
	end
end

--//Lib Coding
local Base64 = returnData("https://raw.githubusercontent.com/SebasRomTen/Lua-Base64-Encription/main/Base64.lua")

misc.Obfuscation.Base64 = Base64
misc.Http.returnData = returnData
misc.Instances.applyprops = applyprops
misc.newScript = newScript

misc.Loops.RS = function(f)
	local new = coroutine.create(function()
		if RunService:IsClient() then
			RunService.RenderStepped:Connect(f)
		elseif RunService:IsServer() then
			RunService.Stepped:Connect(f)
		end
	end)
	coroutine.resume(new)
end

misc.Loops.HB = function(f)
	local new = coroutine.create(function()
		RunService.Heartbeat:Connect(f)
	end)
	coroutine.resume(new)
end

misc.Loops.PS = function(f)
	local new = coroutine.create(function()
		RunService.PostSimulation:Connect(f)
	end)
	coroutine.resume(new)
end

misc.Loops.SL = function(func)
	local new = coroutine.create(function()
		local Bind = Instance.new('BindableEvent')

		for i,v in ipairs({RunService.Heartbeat, RunService.Stepped, RunService.PreRender, RunService.PostSimulation, RunService.PreSimulation}) do
			v.Connect(v, function()
				return Bind.Fire(Bind, tick())
			end)
		end

		local SuperLoop = Bind.Event

		SuperLoop:Connect(func)
	end)
	coroutine.resume(new)
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

misc.String.randomchar = function()
	return string.char(math.random(1, 255))
end

misc.String.spaces = function(s:string)
	local val = "/s"
	return string.gsub(s, val, "\n")
end

misc.Random.RandomPlayerName = function()
	return Players:GetNameFromUserIdAsync(math.floor(math.random(1, 2000000000)))
end

misc.Tweens.INFTween = function(obj:Instance, props, es, ed, wt)
	local TweenService = game:GetService("TweenService")
	return TweenService:Create(obj, TweenInfo.new(wt, es, ed, -1, false), props)
end

misc.Tables.remove = function(t : "Table", v : "Value")
	for i = 1, #t do
		if t[i] == v then
			table.remove(t, i)
		end
	end
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

misc.Chars.mesh = function(Bodypart : "The body part of the mesh", MeshId : "The mesh id for the character mesh", Texture : "The texture of the character mesh", props : "Optional additional properties")
	local Mesh = Instance.new("CharacterMesh")
	Mesh.BodyPart  = nil
	Mesh.MeshId = nil
	Mesh.OverlayTextureId = nil
	return Mesh
end

misc.partToRegion3Size = function(part)
	return part.Position - part.Size/2, part.Position + part.Size/2
end

return misc
