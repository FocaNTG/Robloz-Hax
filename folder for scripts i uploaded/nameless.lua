-- Thanks to 0866 for making the whole ui work, this admin script was actually made in 2019 lol but was modified by qipu
-- For the commands thanks to IY, Fates Admin, HomeBrew, CMD-X for some of the code and command ideas!
-- For the people thanks to Digitality, i_db, rouxhaver, spec and the v3rmillion community, if you see your script in the source and want credits please dm qipu#9312
-- ! Make sure to have an executor that supports firetouchinterest for the tool commands !
loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))();



-- [[ 

in case anything happens and script gets removed from github or sum, ill enable this one.

local game = game
local GetService = game.GetService
if (not game.IsLoaded(game)) then
    local Loaded = game.Loaded
    Loaded.Wait(Loaded);
    wait(1.5)
end -- executes when game has loaded

local opt = {
	prefix = ';',			-- change ';' to anything u want the prefix to be
	tupleSeparator = ',',	-- ;ff me,others,all | ;ff me/others/all
	ui = {					-- never did anything with this
		
	},
	keybinds = {			-- never did anything with this
		
	},
}

-- [[ Version ]] -- 
currentversion = 1.03

-- [[ Adonis ]] -- 
local Encrypt = function(str, key)
    local byte = string.byte
    local sub = string.sub
    local char = string.char

    local endStr = {}

    for i = 1, #str do
        local keyPos = (i % #key) + 1
        endStr[i] = char(((byte(sub(str, i, i)) + byte(sub(key, keyPos, keyPos)))%126) + 1)
    end

    endStr = table.concat(endStr)
    return endStr
end

local Require = function(received)
    local client_loader = getcallingscript()
    local client_values = received.Parent.Special
    local client_remote = string.split(client_values.Value, "\\")[1]
    local client_encode = string.split(client_values.Value, "\\")[2]
    local client_module = received
    local client_signal = Instance.new("BindableEvent")
    local client_handle = nil

    local client_args = {
        Mode = "Fire",
        Module = client_module,
        Loader = client_loader,
        Sent = 0,
        Received = 0
    }

    client_remote = game:FindFirstChild(client_remote, true)

    client_handle = client_remote.OnClientEvent:Connect(function(_, name, key)
        if string.find(name, "GIVE_KEY") then
            client_handle:Disconnect()
            client_handle = nil
            client_signal:Fire(key)
            client_signal:Destroy()
            client_signal = nil
        end
    end)

    client_remote:FireServer(client_args, client_encode .. "GET_KEY")

    client_signal.Event:Once(function(client_key)
        local client_code = Encrypt("ClientCheck", client_key)

        while true do
            client_args.Sent = client_args.Sent + 1

            local args = {
                [1] = client_args,
                [2] = client_code,
                [3] = {
                    Received = client_args.Received,
                    Sent = client_args.Sent - 1
                },
                [4] = client_encode,
                -- [5] = math.random()
            }

            client_remote:FireServer(unpack(args))
            task.wait(3)
        end
    end)
end


local old
old = hookfunction(getrenv().require, function(module, ...)
    if module.Name == "Client" and module.Parent:FindFirstChild("Special") then
        task.spawn(Require, module)
        return coroutine.yield()
    end
    return old(module, ...)
end)

--[[ VARIABLES ]]--
PlaceId, JobId = game.PlaceId, game.JobId
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local RunService2 = game:FindService("RunService")
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")
sethidden = sethiddenproperty or set_hidden_property or set_hidden_prop
local Player = game.Players.LocalPlayer
local IYLOADED = false -- This is used for the ;iy command that executes infinite yield commands using this admin command script (BTW)
local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
local Character = game.Players.LocalPlayer.Character
local Clicked = true
local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/FE/main/notificationtest"))();
local Notify = AkaliNotif.Notify;
_G.Spam = false
--[[ FOR LOOP COMMANDS ]]--
view = false
anniblockspam = false
control = false
FakeLag = false
Loopvoid = false
Loopkill = false
Loopbring = false
Loopbanish = false
Loopvoid = false
Loopcuff = false
loopgrab = false
Loopstand = false
Looptornado = false
Loopmute = false
Loopglitch = false
Watch = false

-- [[ HAT ORBIT ]]
local Offset = 10
local Rotation = 0
local Speed = 1
local Height = 2

local EditingPos = false

local Power = 50000
local Damping = 500

local Mode = 1

local NormalSpin = true


--[[ END OF THE BASIC STUFF ]]--

local localPlayer = Players.LocalPlayer
local LocalPlayer = Players.LocalPlayer
local character = localPlayer.Character
local mouse = localPlayer:GetMouse()
local camera = workspace.CurrentCamera
local camtype = camera.CameraType
local Commands, Aliases = {}, {}
player, plr, lp = localPlayer, localPlayer, localPlayer, localPlayer

localPlayer.CharacterAdded:Connect(function(c)
	character = c
end)

local bringc = {}

--[[ COMMAND FUNCTIONS ]]--
cmd = {}
cmd.add = function(...)
	local vars = {...}
	local aliases, info, func = vars[1], vars[2], vars[3]
	for i, cmdName in pairs(aliases) do
		if i == 1 then
			Commands[cmdName:lower()] = {func, info}
		else
			Aliases[cmdName:lower()] = {func, info}
		end
	end
end

cmd.run = function(args)
	local caller, arguments = args[1], args; table.remove(args, 1);
	local success, msg = pcall(function()
		if Commands[caller:lower()] then
			Commands[caller:lower()][1](unpack(arguments))
		elseif Aliases[caller:lower()] then
			Aliases[caller:lower()][1](unpack(arguments))
		end
	end)
	if not success then
	print(msg)
	end
end

--[[ LIBRARY FUNCTIONS ]]--
lib = {}
lib.wrap = function(f)
	return coroutine.wrap(f)()
end
wrap = lib.wrap

lib.messageOut = function(title, msg)
	StarterGui:SetCore("SendNotification", 
		{
			Title = title,
			Text = msg
		}
	)
end

local wait = function(int)
	if not int then int = 0 end
	local t = tick()
	repeat
		RunService.Heartbeat:Wait(0)
	until (tick() - t) >= int
	return (tick() - t), t
end
spawn(function()
    -- Gui to Lua
-- Version: 3.2

-- Instances:

local uhhhh = Instance.new("ScreenGui")
local lalala = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")

--Properties:

uhhhh.Name = "boomb"
uhhhh.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
uhhhh.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
uhhhh.ResetOnSpawn = false

lalala.Parent = uhhhh
lalala.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
lalala.BackgroundTransparency = 1
lalala.Size = UDim2.new(0, 1846, 0, 904)

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(5, 0, 8))}
UIGradient.Rotation = 90
UIGradient.Parent = lalala

local StarterGui = uhhhh
StarterGui.IgnoreGuiInset = true
-- Gui to Lua
-- Version: 3.2

-- Instances:

local StartUp = Instance.new("ScreenGui")
local AdminName = Instance.new("TextLabel")
local Version = Instance.new("TextLabel")

--Properties:

StartUp.Name = "StartUp"
StartUp.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
StartUp.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

AdminName.Name = "AdminName"
AdminName.Parent = StartUp
AdminName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
AdminName.BackgroundTransparency = 1.000
AdminName.Position = UDim2.new(0.321999997, 0, 0.416000009, 0)
AdminName.Size = UDim2.new(0, 546, 0, 56)
AdminName.Font = Enum.Font.SourceSans
AdminName.Text = "Nameless Admin"
AdminName.TextColor3 = Color3.fromRGB(255, 255, 255)
AdminName.TextSize = 100.000
AdminName.TextStrokeTransparency = 0.000

Version.Name = "Version"
Version.Parent = StartUp
Version.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Version.BackgroundTransparency = 1.000
Version.Position = UDim2.new(0.418, 0,0.469, 0)
Version.Size = UDim2.new(0, 249, 0, 45)
Version.Font = Enum.Font.SourceSans
Version.Text = currentversion
Version.TextColor3 = Color3.fromRGB(255, 255, 255)
Version.TextSize = 70.000
Version.TextTransparency = 1.000

-- Scripts:

local function GOOBRM_fake_script() -- StartUp.Start 
	local script = Instance.new('LocalScript', StartUp)

	local AdminName = script.Parent.AdminName
	local VersionName = script.Parent.Version
	AdminName.Position = UDim2.new(0.315, 0,0, -92)
	wait(0.2)
	AdminName:TweenPosition(UDim2.new(0.315, 0,0.407, 0), "Out", "Quint",1,true)
	wait(0.2)
	VersionName:TweenPosition(UDim2.new(0.418, 0,0.509, 0), "Out", "Quint",1,true)
	for i=1, 10 do
		wait(0.02)
		VersionName.TextTransparency -= 0.1
		VersionName.TextStrokeTransparency -= 0.1
	end
	wait(1)
	for i=1, 10 do
		wait(0.02)
		VersionName.TextTransparency += 0.1
		VersionName.TextStrokeTransparency += 0.1
		AdminName.TextTransparency += 0.1
		AdminName.TextStrokeTransparency += 0.1
	end
	wait(1)
	AdminName:Destroy()
	VersionName:Destroy()
	script.Parent:Destroy()
	
	
end
coroutine.wrap(GOOBRM_fake_script)()
local function UKVHYKU_fake_script() -- StartUp.LocalScript 
	local script = Instance.new('LocalScript', StartUp)

	local Blur = Instance.new("BlurEffect")
	Blur.Name = "kewlblur"
	Blur.Parent = game.Lighting
	Blur.Size = 0
	for i=1, 10 do
		wait(0.05)
		Blur.Size += 1
	end
	wait(1.44)
	for i=1, 10 do
		wait(0.05)
		Blur.Size -= 1
	end
	wait(1)
	Blur:Destroy()
end
coroutine.wrap(UKVHYKU_fake_script)()

wait();

Notify({
Description = "Ty MastersMZ for showcasing Nameless Admin! If you are using a mobile device this script won't work, you will have to use chat";
Title = "Nameless Admin";
Duration = 4;

});
wait(1);

Notify({
Description = "Join the discord for Change Logs! https://discord.gg/mW442YxE4j";
Duration = 3;

});
end)

	function r15(plr)
		if game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').RigType == Enum.HumanoidRigType.R15 then
			return true
		end
	end
	
	function getRoot(char)
	local rootPart = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart') or game.Players.LocalPlayer.Character:FindFirstChild('Torso') or game.Players.LocalPlayer.Character:FindFirstChild('UpperTorso')
	return rootPart
end

local getPlr = function(Name)
	if Name:lower() == "random" then
		return Players:GetPlayers()[math.random(#Players:GetPlayers())]
	else
		Name = Name:lower():gsub("%s", "")
		for _, x in next, Players:GetPlayers() do
			if x.Name:lower():match(Name) then
				return x
			elseif x.DisplayName:lower():match("^" .. Name) then
				return x
			end
		end
	end
end

plr = game.Players.LocalPlayer

COREGUI = game:GetService("CoreGui")

speaker = game.Players.LocalPlayer

char = plr.Character

RunService = game:GetService("RunService")

game:GetService('RunService').Stepped:connect(function()
if anniblockspam then
game.workspace.Tools.Chest_Invisibility_Cloak.Part.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)

if game.Players.LocalPlayer.Backpack:FindFirstChild("InvisibilityCloak") then
game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack.InvisibilityCloak)
end

for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if (v:IsA("Tool")) then
v.Handle.Mesh:Destroy()
end
end

for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if (v:IsA("Tool")) then
v.Parent = workspace
end
end

end
end)

function x(v)
	if v then
		for _,i in pairs(workspace:GetDescendants()) do
			if i:IsA("BasePart") and not i.Parent:FindFirstChild("Humanoid") and not i.Parent.Parent:FindFirstChild("Humanoid") then
				i.LocalTransparencyModifier = 0.5
			end
		end
	else
		for _,i in pairs(workspace:GetDescendants()) do
			if i:IsA("BasePart") and not i.Parent:FindFirstChild("Humanoid") and not i.Parent.Parent:FindFirstChild("Humanoid") then
				i.LocalTransparencyModifier = 0
			end
		end
	end
end

local function getChar()
	return game.Players.LocalPlayer.Character
end

local function getBp()
	return game.Players.LocalPlayer.Backpack
end

local cmdlp = game.Players.LocalPlayer

plr = cmdlp

workspace = game.workspace

cmdm = plr:GetMouse()

function sFLY(vfly)
	FLYING = false
	speedofthefly = 10
	speedofthevfly = 10
	while not cmdlp or not cmdlp.Character or not cmdlp.Character:FindFirstChild('HumanoidRootPart') or not cmdlp.Character:FindFirstChild('Humanoid') or not cmdm do
		 wait()
	end 
	local T = cmdlp.Character.HumanoidRootPart
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0
	local function FLY()
		FLYING = true
		local BG = Instance.new('BodyGyro', T)
		local BV = Instance.new('BodyVelocity', T)
		BG.P = 9e4
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		spawn(function()
			while FLYING do
				if not vfly then
					cmdlp.Character:FindFirstChild("Humanoid").PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
				wait()
			end
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:destroy()
			BV:destroy()
			cmdlp.Character.Humanoid.PlatformStand = false
		end)
	end
	cmdm.KeyDown:connect(function(KEY)
		if KEY:lower() == 'w' then
			if vfly then
				CONTROL.F = speedofthevfly
			else
				CONTROL.F = speedofthefly
			end
		elseif KEY:lower() == 's' then
			if vfly then
				CONTROL.B = - speedofthevfly
			else
				CONTROL.B = - speedofthefly
			end
		elseif KEY:lower() == 'a' then
			if vfly then
				CONTROL.L = - speedofthevfly
			else
				CONTROL.L = - speedofthefly
			end
		elseif KEY:lower() == 'd' then
			if vfly then
				CONTROL.R = speedofthevfly
			else
				CONTROL.R = speedofthefly
			end
		elseif KEY:lower() == 'y' then
			if vfly then
				CONTROL.Q = speedofthevfly*2
			else
				CONTROL.Q = speedofthefly*2
			end
		elseif KEY:lower() == 't' then
			if vfly then
				CONTROL.E = -speedofthevfly*2
			else
				CONTROL.E = -speedofthefly*2
			end
		end
	end)
	cmdm.KeyUp:connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		elseif KEY:lower() == 'y' then
			CONTROL.Q = 0
		elseif KEY:lower() == 't' then
			CONTROL.E = 0
		end
	end)
	FLY()
end


local tool = getBp():FindFirstChildOfClass("Tool") or getChar():FindFirstChildOfClass("Tool")

local function attachTool(tool,cf)
	for i,v in pairs(tool:GetDescendants()) do
		if not (v:IsA("BasePart") or v:IsA("Mesh") or v:IsA("SpecialMesh")) then
			v:Destroy()
		end
	end
	wait()
game.Players.LocalPlayer.Character.Humanoid.Name = 1
local l = game.Players.LocalPlayer.Character["1"]:Clone()
l.Parent = game.Players.LocalPlayer.Character
l.Name = "Humanoid"
			
game.Players.LocalPlayer.Character["1"]:Destroy()
game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
game.Players.LocalPlayer.Character.Animate.Disabled = true
wait()
game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType = "None"

tool.Parent = getChar()
end

local nc = false
local ncLoop
ncLoop = game:GetService("RunService").Stepped:Connect(function()
	if nc and getChar() ~= nil then
		for _, v in pairs(getChar():GetDescendants()) do
			if v:IsA("BasePart") and v.CanCollide == true then
				v.CanCollide = false
			end
		end
	end
end)

local netsleepTargets = {}
local nsLoop
nsLoop = game:GetService("RunService").Stepped:Connect(function()
    if #netsleepTargets == 0 then return end
    for i,v in pairs(netsleepTargets) do
        if v.Character then
            for i,v in pairs(v.Character:GetChildren()) do
                if v:IsA("BasePart") == false and v:IsA("Accessory") == false then continue end
                if v:IsA("BasePart") then
                    sethiddenproperty(v,"NetworkIsSleeping",true)
                elseif v:IsA("Accessory") and v:FindFirstChild("Handle") then
                    sethiddenproperty(v.Handle,"NetworkIsSleeping",true)
                end
            end
        end
    end
end)

local lp = game:GetService("Players").LocalPlayer

lib.lock = function(instance, par)
	locks[instance] = true
	instance.Parent = par or instance.Parent
	instance.Name = "RightGrip"
end
lock = lib.lock
locks = {}
if hookfunction then	-- i believe this was for hiding stuff like bodyvelocity
	local pseudo = Instance.new("Motor6D")
	_1 = hookfunction(pseudo.IsA, function(...)
		local p, ret = ({...})[1], _1(...)
		if checkcaller() then return ret end
		if locks[p] then
			return false
		end
		return ret
	end)
	_2 = hookfunction(pseudo.FindFirstChildWhichIsA, function(...)
		local p = _2(...)
		if checkcaller() then return p end
		if locks[p] then
			return nil
		end
		return p
	end)
	_3 = hookfunction(pseudo.FindFirstChildOfClass, function(...)
		local p = _3(...)
		if checkcaller() then return p end
		if locks[p] then
			return nil
		end
		return p
	end)
	_4 = hookfunction(pseudo.Destroy, function(...)
		local args = {...}
		if checkcaller() then return _4(...) end
		if locks[args[1]] then return end
		return
	end)
	
	local mt = getrawmetatable(game)
	local _ni = mt.__newindex
	local _nc = mt.__namecall
	local _i = mt.__index
	setreadonly(mt, false)
	
	mt.__index = newcclosure(function(t, i)
		if locks[t] and not checkcaller() then
			return _i(pseudo, i)
		end
		return _i(t, i)
	end)
	mt.__newindex = newcclosure(function(t, i, v)
		if locks[t] and not checkcaller() then
			return _ni(pseudo, i, v)
		end
		return _ni(t, i, v)
	end)
	mt.__namecall = newcclosure(function(t, ...)
		if locks[t] and not checkcaller() then
			return _nc(pseudo, ...)
		end
		return _nc(t, ...)
	end)
end

lib.find = function(t, v)	-- mmmmmm
	for i, e in pairs(t) do
		if i == v or e == v then
			return i
		end
	end
	return nil
end

lib.parseText = function(text, watch)
	local parsed = {}
	if not text then return nil end
	for arg in text:gmatch("[^" .. watch .. "]+") do
		arg = arg:gsub("-", "%%-")
		local pos = text:find(arg)
		arg = arg:gsub("%%", "")
		if pos then
			local find = text:sub(pos - opt.prefix:len(), pos - 1)
			if (find == opt.prefix and watch == opt.prefix) or watch ~= opt.prefix then
				table.insert(parsed, arg)
			end
		else
			table.insert(parsed, nil)
		end
	end
	return parsed
end

lib.parseCommand = function(text)
	wrap(function()
		local commands = lib.parseText(text, opt.prefix)
		for _, parsed in pairs(commands) do
			local args = {}
			for arg in parsed:gmatch("[^ ]+") do
				table.insert(args, arg)
			end
			cmd.run(args)
		end
	end)
end

local connections = {}

lib.connect = function(name, connection)	-- no :(
	connections[name .. tostring(math.random(1000000, 9999999))] = connection
	return connection
end

lib.disconnect = function(name)
	for title, connection in pairs(connections) do
		if title:find(name) == 1 then
			connection:Disconnect()
		end
	end
end

m = math			-- prepare for annoying and unnecessary tool grip math
rad = m.rad
clamp = m.clamp
sin = m.sin
tan = m.tan
cos = m.cos

--[[ PLAYER FUNCTIONS ]]--
argument = {}
argument.getPlayers = function(str)
	local playerNames, players = lib.parseText(str, opt.tupleSeparator), {}
	for _, arg in pairs(playerNames or {"me"}) do
		arg = arg:lower()
		local playerList = Players:GetPlayers()
		if arg == "me" or arg == nil then
			table.insert(players, localPlayer)
			
		elseif arg == "all" then
			for _, plr in pairs(playerList) do
				table.insert(players, plr)
			end
			
		elseif arg == "others" then
			for _, plr in pairs(playerList) do
				if plr ~= localPlayer then
					table.insert(players, plr)
				end
			end
			
		elseif arg == "random" then
			table.insert(players, playerList[math.random(1, #playerList)])
			
		elseif arg:find("%%") == 1 then
			local teamName = arg:sub(2)
			for _, plr in pairs(playerList) do
				if tostring(plr.Team):lower():find(teamName) == 1 then
					table.insert(players, plr)
				end
			end
			
		else
			for _, plr in pairs(playerList) do
				if plr.Name:lower():find(arg) == 1 or (plr.DisplayName and plr.DisplayName:lower():find(arg) == 1) or (tostring(plr.UserId):lower():find(arg) == 1) then
					table.insert(players, plr)
				end
			end
		end
	end
	return players
end

--[[ COMMANDS ]]--

--[ SCRIPT ]--
cmd.add({"script", "ls", "s", "run"}, {"script <source> (ls, s, run)", "Run the code requested"}, function(source)
	loadstring(source)()
end)

cmd.add({"stand"}, {"stand <player>", "Makes a player your stand"}, function(...)
    	  Username = (...)
 
local target = getPlr(Username)
local THumanoidPart
local plrtorso
local TargetCharacter = target.Character
   if TargetCharacter:FindFirstChild("Torso") then
		   plrtorso = TargetCharacter.Torso
	   elseif TargetCharacter:FindFirstChild("UpperTorso") then
		   plrtorso = TargetCharacter.UpperTorso
	   end
        local old = getChar().HumanoidRootPart.CFrame
        local tool = getBp():FindFirstChildOfClass("Tool") or getChar():FindFirstChildOfClass("Tool")
	    if target == nil or tool == nil then return end
        local attWeld = attachTool(tool,CFrame.new(0,0,0))
        attachTool(tool,CFrame.new(0,0,0.2) * CFrame.Angles(math.rad(-90),0,0))
		   tool.Grip = plrtorso.CFrame
	wait(0.2)
	    tool.Grip = CFrame.new(0, 3, -1) 
        firetouchinterest(target.Character.Humanoid.RootPart,tool.Handle,0)
        firetouchinterest(target.Character.Humanoid.RootPart,tool.Handle,1)
     wait(1.3)
end)

cmd.add({"valk"}, {"valk", "Only works on dollhouse"}, function()
repeat game:GetService("RunService").Stepped:wait()
until game:IsLoaded() and game:GetService("Players").LocalPlayer

pcall(function()
   local plr = game:GetService("Players").LocalPlayer
   local giver = workspace:WaitForChild("Valkyrie Helm giver")

   local head = plr.Character:WaitForChild("Head")
   firetouchinterest(head, giver, 0)

   plr.CharacterAdded:Connect(function(char)
       head = char:WaitForChild("Head")
       firetouchinterest(head, giver, 0)
   end)
end)
end)

cmd.add({"httpget", "hl", "get"}, {"httpget <url> (hl, get)", "Run the contents of a given URL"}, function(url)
	loadstring(game:HttpGet(url, true))()
end)

--[ UTILITY ]--

cmd.add({"chatlogs", "clogs"}, {"chatlogs (clogs)", "Open the chat logs"}, function()
	gui.chatlogs()
end)

cmd.add({"gotocampos", "tocampos", "tcp"}, {"gotocampos (tocampos, tcp)", "Teleports you to your camera position works with free cam but freezes you"}, function()
local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- function to teleport the player to the camera's position
local function teleportPlayer()
    local character = player.Character or player.CharacterAdded:wait(1)
    local camera = game.Workspace.CurrentCamera
    local cameraPosition = camera.CFrame.Position
    character:SetPrimaryPartCFrame(CFrame.new(cameraPosition))
end


        local camera = game.Workspace.CurrentCamera
        repeat wait() until camera.CFrame ~= CFrame.new()

        teleportPlayer()
 
end)

cmd.add({"kanye"}, {"kanye", "Random kanye quote"}, function()
   local check = "https://api.kanye.rest/"
        local final = game:HttpGet(check)
        local final2 = string.gsub(final,'"quote"',"")
        local final3 = string.gsub(final2,"[%{%:%}]","")
         game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(final3.." - Kanye West", 'All')
end)

cmd.add({"hatorbit", "ho"}, {"hatorbit (ho)", "Hat orbit"}, function()
	


wait();

Notify({
Description = "Hat orbit loaded, if you wanna orbit other people type in the chat .orbit playername";
Title = "Nameless Admin";
Duration = 10;

});
	local LC = game.Players.LocalPlayer
local Name = LC.Name
local Char = LC.Character

local Humanoid = Char:FindFirstChildWhichIsA("Humanoid")
local Root = Humanoid.RootPart

local Accessories = Humanoid:GetAccessories()

local Target = Char
local TargetPos = Target.Humanoid.RootPart.Position

		function findName(pname)
			for i, v in ipairs(game.Players:GetPlayers()) do
				if pname then
					if string.match(v.Name:lower(), pname:lower()) or string.match(v.Character.Humanoid.DisplayName:lower(), pname:lower()) then
						return v.Name
					end
				else
				end
			end
		end
	
		function findChar(pname)
			return game.Players:FindFirstChild(findName(pname)).Character
		end
	
		local hats = {}
	
		if Target then
			-- Loop through each hat in the target player's character
			local character = Target
			for _, hat in ipairs(character:GetChildren()) do
				if hat:IsA("Accessory") then
					hats[#hats+1] = hat
				end
			end
		end
	
		local hatCount = #hats
		if hatCount > 0 then
			local angle = math.pi * 2 / hatCount
			-- Loop through each hat again to add bodyposition and move hats
			for i, hat in ipairs(hats) do
				-- Add bodyposition to the handle and make it massless
				local handle = hat.Handle
				handle.AccessoryWeld:Remove()
	
				if handle then
					local bodyPosition = Instance.new("BodyPosition", handle)
					bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					bodyPosition.P = Power
					bodyPosition.D = Damping
	
					local bodyGyro = Instance.new("BodyGyro", handle)
					bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
					bodyGyro.P = Power
					bodyGyro.D = Damping
	
					-- Calculate position based on angle and Offset
					local x = math.sin(Rotation + angle * (i-1)) * Offset
					local z = math.cos(Rotation + angle * (i-1)) * Offset
	
					-- Set position of bodyposition
					bodyPosition.Position = TargetPos + Vector3.new(x, Height, z)
				end
			end
	
			-- Rotate hats around target player
			local function myCoroutine()
				while wait(-9e999) do
					Rotation = Rotation + (Speed / 20)
					if Rotation >= math.pi * 2 then
						Rotation = 0
					end
	
					for i, hat in ipairs(hats) do
						local handle = hat.Handle
						local x = math.sin(Rotation + angle * (i-1)) * Offset
						local z = math.cos(Rotation + angle * (i-1)) * Offset
	
						handle.BodyPosition.P = Power
						handle.Velocity = Vector3.new(0, 5, 0)
						handle.Massless = true
						handle.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
	
						handle.BodyGyro.CFrame = CFrame.lookAt(handle.Position + Vector3.new(0, handle.Position.Y, 0), Root.Position)
	
						if NormalSpin == true then
							handle.BodyPosition.Position = TargetPos + Vector3.new(x + Target.Humanoid.MoveDirection.X, Height, z + Target.Humanoid.MoveDirection.Z)
						end
	
						if EditingPos == false then
							TargetPos = Target.Humanoid.RootPart.Position
						end
					end
				end
			end
	
			local myWrappedCoroutine = coroutine.wrap(myCoroutine)
	
			myWrappedCoroutine()
		end
	
		function Mode2()
			if Mode == 2 then
				local Angle = math.pi * 2 / #hats -- number of hats in the circle
	
				function Loop()
					if Mode == 2 then
						-- Get the orientation of the root part
						local RootOrientation = Target.Humanoid.RootPart.CFrame - Target.Humanoid.RootPart.Position
						local RootRotation = RootOrientation
	
						for i, Hat in ipairs(hats) do
							local HatRotation = RootRotation.Y + Angle * (i - 1) + Speed * tick()
							local x = math.sin(HatRotation) * Offset
							local z = math.cos(HatRotation) * Offset
	
							local HatPos = TargetPos + RootOrientation * Vector3.new(x, z, -Height)
							Hat.Handle.BodyPosition.Position = HatPos
						end
	
						wait()
						Loop()
					end
				end
	
				Loop()
	
				for i, Hat in ipairs(hats) do
					local Handle = Hat.Handle
	
					Hat.Handle.BodyPosition.Position = TargetPos
				end
			end
		end
	
	
		function Mode3()
			if Mode == 3 then
				for i = 1, #Accessories do
					Accessories[i].Handle.BodyPosition.Position = TargetPos + Vector3.new(0, Height, 0)
					wait(.1)
				end
				wait()
				Mode3()
			end
		end
	
		function Mode4 ()
			if Mode == 4 then
				if not LC:GetMouse().Target then else
					TargetPos = LC:GetMouse().Hit.Position
				end
				wait(-9e999)
				Mode4()
			end
		end
	
		function Mode5 ()
			local spiralPitch = 0
			local spiralAngle = 0
	
			function Loop ()
				if Mode == 5 then
					spiralAngle = spiralAngle + Speed / 300
					if spiralAngle >= math.pi * 10 then
						spiralAngle = 0
					end
	
					for i, hat in ipairs(hats) do
						local handle = hat.Handle
						if handle then
							local x = math.sin(spiralAngle + i * spiralPitch) * (i * Offset / 8)
							local y = i * (Height / 3)
							local z = math.cos(spiralAngle + i * spiralPitch) * (i * Offset / 8)
							handle.BodyPosition.Position = TargetPos - Vector3.new(0, 2, 0) + Vector3.new(x, y, z)
						end
					end
				end
				spiralPitch += Speed / 70
				wait(-9e999)
				Loop()
			end
	
			Loop()
		end
	
		function Mode6 ()
			local stack1 = {}
			local stack2 = {}
	
			for i = 1, #Accessories do
				if i <= #Accessories / 2 then
					stack1[#stack1 + 1] = Accessories[i]
				else
					stack2[#stack2 + 1] = Accessories[i]
				end
			end
	
			function Loop()
				if Mode == 6 then
					local angle = tick() * Speed
					local x = math.sin(angle) * Offset
					local z = math.cos(angle) * Offset
	
					for i, v in ipairs(stack1) do
						v.Handle.BodyPosition.Position = TargetPos + Vector3.new(x, i+Height,-z)
					end
	
					for i, v in ipairs(stack2) do
						v.Handle.BodyPosition.Position = TargetPos + Vector3.new(-x, i+Height,z)
					end
					wait()
					Loop()
				end
			end
	
			Loop()
		end
	
		function Mode7()
			local stack1 = {}
			local stack2 = {}
			local stack3 = {}
	
			for i = 1, #Accessories do
				if i < #Accessories / 3 then
					stack1[#stack1 + 1] = Accessories[i]
				elseif i < #Accessories / 3 * 2 or i == #Accessories then
					stack2[#stack2 + 1] = Accessories[i]
				else
					stack3[#stack3 + 1] = Accessories[i]
				end
			end
	
	
			function Loop()
				if Mode == 7 then
					local angle = tick() * Speed
					local x = math.sin(angle) * Offset
					local z = math.cos(angle) * Offset
	
					for i, v in ipairs(stack1) do
						v.Handle.BodyPosition.Position = TargetPos + Vector3.new(x, i+Height, -z)
					end
	
					for i, v in ipairs(stack2) do
						v.Handle.BodyPosition.Position = TargetPos + Vector3.new(x, i+Height, z)
					end
	
					for i, v in ipairs(stack3) do
						v.Handle.BodyPosition.Position = TargetPos + Vector3.new(-x, i+Height, -z)
					end
					wait()
					Loop()
				end
			end
	
			Loop()
		end
	
		function Mode8()
			if Mode == 8 then
				local forward = workspace.CurrentCamera.CFrame.LookVector
				local right = workspace.CurrentCamera.CFrame.RightVector
				local up = workspace.CurrentCamera.CFrame.UpVector
				local angle = math.pi * 2 / #hats * tick()
	
				for i, hat in ipairs(hats) do
					local handle = hat.Handle
					local x = right * (math.sin(angle * (i-1)) * Offset)
					local y = up * (math.cos(angle * (i-1)) * Offset)
					local z = forward * (Height+10)
					local pos = workspace.CurrentCamera.CFrame.LookVector + z + x + y
					local look = (workspace.CurrentCamera.CFrame.LookVector - pos).unit
	
					handle.BodyPosition.Position = pos + TargetPos + Vector3.new(0, 2, 0)
				end
	
				wait()
				Mode8()
			end
		end
	
		function Mode9 ()
			local Left = {}
			local Right = {}
	
			for i, v in pairs(Accessories) do
				if (#Left < #Accessories / 2) then
					Left[#Left + 1] = v
				else
					Right[#Right + 1] = v
				end
			end
	
	
			function Loop ()
				if Mode == 9 then
					for i, v in ipairs(Left) do
						local angle = tick() * Speed
						local x = math.sin(angle + i) * Offset
						local z = math.cos(angle + i) * Offset
	
	
						v.Handle.BodyPosition.Position = TargetPos + Vector3.new(x, Height, z)
					end
	
					for i, v in ipairs(Right) do
						local angle = tick() * Speed
						local x = math.sin(angle + i) * Offset
						local z = math.cos(angle + i) * Offset
	
						v.Handle.BodyPosition.Position = TargetPos + Vector3.new(z, Height, x)
					end
	
					wait()
					Loop()
				end
			end
	
			Loop()
		end
	
		function Mode10 ()
			local Left = {}
			local Right = {}
	
			for i, v in pairs(Accessories) do
				if (#Left < #Accessories / 2) then
					Left[#Left + 1] = v
				else
					Right[#Right + 1] = v
				end
			end
	
	
			function Loop ()
				if Mode == 10 then
					for i, v in ipairs(Left) do
						local angle = tick() * Speed
						local x = math.sin(angle + i) * Offset
						local z = math.cos(angle + i) * Offset
	
						v.Handle.BodyPosition.Position = TargetPos + Vector3.new(z, x + Height, -x)
					end
	
					for i, v in ipairs(Right) do
						local angle = tick() * Speed
						local x = math.sin(angle + i) * Offset
						local z = math.cos(angle + i) * Offset
	
						v.Handle.BodyPosition.Position = TargetPos + Vector3.new(-x, x + Height, -z)
					end
					wait()
					Loop()
				end
			end
	
			Loop()
		end
	
		function Mode11 ()
			local OldOffset = Offset
	
			local Circle1 = {}
			local Circle2 = {}
			for i, v in pairs(Accessories) do
				if (#Circle1 < #Accessories / 2) then
					Circle1[#Circle1 + 1] = v
				else
					Circle2[#Circle2 + 1] = v
				end
			end
	
			function Loop ()
				if Mode == 11 then
					for i = 1, #Circle1 do
						local angle = tick() * Speed
						local x = -math.sin(angle + (i * angle)) * Offset
						local y = math.cos(angle) / 2 * OldOffset
						local z = math.cos(angle + (i * -angle)) * Offset
	
						Offset = math.sin(angle) / 2 * OldOffset
	
						local offset = CFrame.Angles(0,math.rad( Target.Humanoid.RootPart.Orientation.Y), 0) * Vector3.new(x, Height+y, z)
						Circle1[i].Handle.BodyPosition.Position = TargetPos + offset
					end
	
					for i = 1, #Circle2 do
						local angle = tick() * Speed
						local x = -math.sin(angle + (i * angle)) * Offset
						local y = -math.cos(angle) / 2 * OldOffset
						local z = math.cos(angle + (i * angle)) * Offset
	
						Offset = math.sin(angle) / 2 * OldOffset
	
						local offset = CFrame.Angles(0, math.rad(Target.Humanoid.RootPart.Orientation.Y), 0) * Vector3.new(x, Height+y, z)
						Circle2[i].Handle.BodyPosition.Position = TargetPos + offset
					end
					wait()
					Loop()
				end
			end
	
			Loop()
		end
	
		function Mode12 ()
			local Circle1 = {}
			local Circle2 = {}
			for i, v in pairs(Accessories) do
				if (#Circle1 < #Accessories / 2) then
					Circle1[#Circle1 + 1] = v
				else
					Circle2[#Circle2 + 1] = v
				end
			end
	
			function Loop ()
				if Mode == 12 then
					for i = 1, #Circle1 do
						local angle = tick() * Speed
						local x = math.sin(angle + (i * 5)) * Offset
						local z = math.cos(angle + (i * 5)) * Offset
						local offset = CFrame.Angles(0, math.rad(Target.Humanoid.RootPart.Orientation.Y), 0) * Vector3.new(x, Height, z)
						Circle1[i].Handle.BodyPosition.Position = TargetPos + offset
					end
	
					for i = 1, #Circle2 do
						local angle = tick() * Speed
						local x = math.sin(angle + (i * 5)) * Offset
						local z = math.cos(angle + (i * 5)) * Offset
						local offset = CFrame.Angles(0, math.rad(-Target.Humanoid.RootPart.Orientation.Y), 0) * Vector3.new(x, Height + 2, z)
						Circle2[i].Handle.BodyPosition.Position = TargetPos + offset
					end
					wait()
					Loop()
				end
			end
	
			Loop()
		end
	
		function Mode13 ()
			local Circle1 = {}
			local Circle2 = {}
			for i, v in pairs(Accessories) do
				if (#Circle1 < #Accessories / 2) then
					Circle1[#Circle1 + 1] = v
				else
					Circle2[#Circle2 + 1] = v
				end
			end
	
			function Loop ()
				if Mode == 13 then
					for i = 1, #Circle1 do
						local angle = tick() * Speed
						local x = math.sin(angle + (i * 5)) * Offset
						local z = math.cos(angle + (i * 5)) * Offset
						local offset = CFrame.Angles(0, math.rad(Target.Humanoid.RootPart.Orientation.Y), 0) * Vector3.new(x + Offset * 2, Height, z)
						Circle1[i].Handle.BodyPosition.Position = TargetPos + offset
					end
	
					for i = 1, #Circle2 do
						local angle = tick() * Speed
						local x = math.sin(angle + (i * 5)) * Offset
						local z = math.cos(angle + (i * 5)) * Offset
						local offset = CFrame.Angles(0, math.rad(Target.Humanoid.RootPart.Orientation.Y), 0) * Vector3.new(x - Offset * 2, Height, z)
						Circle2[i].Handle.BodyPosition.Position = TargetPos + offset
					end
					wait()
					Loop()
				end
			end
	
			Loop()
		end
	
		function Mode14 ()
			local Circle1 = {}
			local Circle2 = {}
			for i, v in pairs(Accessories) do
				if (#Circle1 < #Accessories / 2) then
					Circle1[#Circle1 + 1] = v
				else
					Circle2[#Circle2 + 1] = v
				end
			end
	
			function Loop ()
				if Mode == 14 then
					for i = 1, #Circle1 do
						local angle = tick() * Speed
						local x = math.sin(angle + (i * 5)) * Offset
						local z = math.cos(angle + (i * 5)) * Offset
						local offset = CFrame.Angles(0, math.rad(Target.Humanoid.RootPart.Orientation.Y), 0) * Vector3.new(x + Offset * 2, Height, z)
						Circle1[i].Handle.BodyPosition.Position = TargetPos + offset
					end
	
					for i = 1, #Circle2 do
						local angle = tick() * Speed
						local x = math.sin(angle + (i * 5)) * Offset
						local z = math.cos(angle + (i * 5)) * Offset
						local offset = CFrame.Angles(0, math.rad(-Target.Humanoid.RootPart.Orientation.Y), 0) * Vector3.new(x - Offset * 2, Height, z)
						Circle2[i].Handle.BodyPosition.Position = TargetPos + offset
					end
					wait()
					Loop()
				end
			end
	
			Loop()
		end
	
		function Mode15()
			Height = -1
			function Loop ()
				if Mode == 15 then
					for i = 1, #Accessories do
						local offset = CFrame.Angles(0, math.rad(Target.Humanoid.RootPart.Orientation.Y), 0) * Vector3.new(0, Height, -i * Offset / 5)
						Accessories[i].Handle.BodyPosition.Position = TargetPos + offset
					end
	
					wait()
					Loop()
				end
			end
	
			Loop()
			wait()
		end
	
		function Mode16()
			local function Loop()
				if Mode == 16 then
					for i, v in pairs(Accessories) do
						local x = math.cos(math.random(1, 255) + (i + 1)) * Offset
						local z = math.sin(math.random(1, 255) + (i + 1)) * Offset
	
						local m = math.random(1, 13)
						if m == 1 then
							v.Handle.BodyPosition.Position = TargetPos + Vector3.new(x, Height, z)
						elseif m == 2 then
							v.Handle.BodyPosition.Position = TargetPos + Vector3.new(z, Height, x)
						elseif m == 3 then
							v.Handle.BodyPosition.Position = TargetPos + Vector3.new(-x, Height, z)
						elseif m == 4 then
							v.Handle.BodyPosition.Position = TargetPos + Vector3.new(x, Height, -z)
						elseif m == 5 then
							v.Handle.BodyPosition.Position = TargetPos + Vector3.new(x, z, z)
						elseif m == 6 then
							v.Handle.BodyPosition.Position = TargetPos + Vector3.new(x, x, z)
						elseif m == 7 then
							v.Handle.BodyPosition.Position = TargetPos + Vector3.new(-x, x, z)
						elseif m == 8 then
							v.Handle.BodyPosition.Position = TargetPos + Vector3.new(x, -x, z)
						elseif m == 9 then
							v.Handle.BodyPosition.Position = TargetPos + Vector3.new(x, x, -z)
						elseif m == 10 then
							v.Handle.BodyPosition.Position = TargetPos + Vector3.new(-x, z, z)	
						elseif m == 11 then
							v.Handle.BodyPosition.Position = TargetPos + Vector3.new(x, -z, z)	
						elseif m == 12 then
							v.Handle.BodyPosition.Position = TargetPos + Vector3.new(x, z, -z)	
						elseif m == 13 then
							v.Handle.BodyPosition.Position = TargetPos + Vector3.new(z, z, z)		
						end
					end
				end
				wait()
				Loop()
			end
	
			Loop()
		end
	
		function Mode17()
			local OldOffset = Offset
			local OldHeight = Height
	
			local Circle1 = {}
			local Circle2 = {}
			for i, v in pairs(Accessories) do
				if (#Circle1 < #Accessories / 2) then
					Circle1[#Circle1 + 1] = v
				else
					Circle2[#Circle2 + 1] = v
				end
			end
	
			function Loop ()
				if Mode == 17 then
					for i = 1, #Circle1 do
						local angle = tick() * Speed
						local x = math.sin(angle + (i * #hats)) * Offset
						local z = math.cos(angle + (i * #hats)) * Offset
	
						Offset = math.sin(angle) * OldOffset
						Height = math.cos(angle) * OldHeight
	
						Circle1[i].Handle.BodyPosition.Position = TargetPos + Vector3.new(x, -Height, z)
					end
	
					for i = 1, #Circle2 do
						local angle = tick() * Speed+1
						local x = math.cos(angle + (i * #hats)) * Offset
						local z = math.sin(angle + (i * #hats)) * Offset
	
						Offset = math.sin(angle ) * OldOffset
						Height = math.cos(angle) * OldHeight
	
						Circle2[i].Handle.BodyPosition.Position = TargetPos + Vector3.new(x, Height, z)
					end
					wait()
					Loop()
				end
			end
	
			Loop()
		end
	
		local connect = LC.Chatted:Connect(function(chat)
			local Split = chat:lower():split(" ")
	
			local C1 = Split[1]
			local C2 = Split[2]
	
			if C1 == ".mode" then
				Mode = tonumber(C2)
				if C2 == "1" then
					EditingPos = false
					NormalSpin = true
				elseif C2 == "2" then
					EditingPos = false
					NormalSpin = false
					Mode2()		
				elseif C2 == "3" then
					EditingPos = false
					NormalSpin = false
					Mode3()
				elseif C2 == "4" then
					EditingPos = true
					NormalSpin = true
					Mode4()
				elseif C2 == "5" then
					EditingPos = false
					NormalSpin = false
					Mode5()
				elseif C2 == "6" then
					EditingPos = false
					NormalSpin = false
					Mode6()
				elseif C2 == "7" then
					EditingPos = false
					NormalSpin = false
					Mode7()
				elseif C2 == "8" then
					EditingPos = false
					NormalSpin = false
					Mode8()
				elseif C2 == "9" then
					EditingPos = false
					NormalSpin = false
					Mode9()
				elseif C2 == "10" then
					EditingPos = false
					NormalSpin = false
					Mode10()
				elseif C2 == "11" then
					EditingPos = false
					NormalSpin = false
					Mode11()
				elseif C2 == "12" then
					EditingPos = false
					NormalSpin = false
					Mode12()
				elseif C2 == "13" then
					EditingPos = false
					NormalSpin = false
					Mode13()
				elseif C2 == "14" then
					EditingPos = false
					NormalSpin = false
					Mode14()
				elseif C2 == "15" then
					EditingPos = false
					NormalSpin = false
					Mode15()
				elseif C2 == "16" then
					EditingPos = false
					NormalSpin = false
					Mode16()
				elseif C2 == "17" then
					EditingPos = false
					NormalSpin = false
					Mode17()
				end
	
			elseif C1 == ".offset" then
				Offset = tonumber(C2)
			elseif C1 == ".speed" then
				Speed = tonumber(C2)
			elseif C1 == ".height" then
				Height = tonumber(C2)
			elseif C1 == ".power" then
				Power = tonumber(C2)
			elseif C1 == ".orbit" then
				if C2 == "me" then
					Target = Char
				elseif C2 == "random" then
					local randomPlayer = game.Players:GetPlayers()[math.random(1, #game.Players:GetPlayers())]
					Target = randomPlayer.Character	
				elseif C2 == "nearest" then
					local minDistance = math.huge
					for _, player in pairs(game.Players:GetPlayers()) do
						if player.Character and player.Character ~= Char then
							local distance = (player.Character.HumanoidRootPart.Position - Char.HumanoidRootPart.Position).magnitude
							if distance < minDistance then
								minDistance = distance
								Target = player.Character
							end
						end
					end
				elseif C2 == "farthest" then
					local maxDistance = -math.huge
					for _, player in pairs(game.Players:GetPlayers()) do
						if player.Character and player.Character ~= Char then
							local distance = (player.Character.HumanoidRootPart.Position - Char.HumanoidRootPart.Position).magnitude
							if distance > maxDistance then
								maxDistance = distance
								Target = player.Character
							end
						end
					end
				else
					Target = findChar(C2)
				end
			elseif C1 == ".blockhats" then
				for i, v in pairs(Accessories) do
					if v.Handle:FindFirstChild("Mesh") then
						v.Handle:FindFirstChild("Mesh"):Remove()
					else
						v.Handle:FindFirstChild("SpecialMesh"):Remove()
					end
				end
			elseif C1 == ".cmds" then
				for i = 1, #Commands do
					print(Commands[i])
					wait()
				end
			end
		end)
	
		Humanoid.Died:Connect(function()
			connect:Disconnect()
		end)
	
		Root.CFrame += Vector3.new(0, 10, 0)
		Root.Anchored = true
		for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then game:GetService("RunService").Heartbeat:connect(function() v.Velocity = Vector3.new(-30, 0, 0) v.Massless = true end) end  end
		wait(1)
		Root.Anchored = false
end)

cmd.add({"ospeed", "orbitspeed"}, {"orbitspeed <speed> (ospeed)", "Hat orbit command"}, function(...)
		Speed = tonumber(...)
end)

cmd.add({"omode", "orbitmode"}, {"orbitmode <1-17> (omode)", "Hat orbit command"}, function(...)
		Mode = tonumber(...)
		if (...) == "1" then
			EditingPos = false
			NormalSpin = true
		elseif (...) == "2" then
			EditingPos = false
			NormalSpin = false
			Mode2()		
		elseif (...) == "3" then
			EditingPos = false
			NormalSpin = false
			Mode3()
		elseif (...) == "4" then
			EditingPos = true
			NormalSpin = true
			Mode4()
		elseif (...) == "5" then
			EditingPos = false
			NormalSpin = false
			Mode5()
		elseif (...) == "6" then
			EditingPos = false
			NormalSpin = false
			Mode6()
		elseif (...) == "7" then
			EditingPos = false
			NormalSpin = false
			Mode7()
		elseif (...) == "8" then
			EditingPos = false
			NormalSpin = false
			Mode8()
		elseif (...) == "9" then
			EditingPos = false
			NormalSpin = false
			Mode9()
		elseif (...) == "10" then
			EditingPos = false
			NormalSpin = false
			Mode10()
		elseif (...) == "11" then
			EditingPos = false
			NormalSpin = false
			Mode11()
		elseif (...) == "12" then
			EditingPos = false
			NormalSpin = false
			Mode12()
		elseif (...) == "13" then
			EditingPos = false
			NormalSpin = false
			Mode13()
		elseif (...) == "14" then
			EditingPos = false
			NormalSpin = false
			Mode14()
		elseif (...) == "15" then
			EditingPos = false
			NormalSpin = false
			Mode15()
		elseif (...) == "16" then
			EditingPos = false
			NormalSpin = false
			Mode16()
		elseif (...) == "17" then
			EditingPos = false
			NormalSpin = false
			Mode17()
		end
end)

cmd.add({"orbitpower", "opower"}, {"orbitpower <power> (opower)", "Hat orbit command"}, function(...)
		Power = tonumber(...)
end)

cmd.add({"orbitheight", "oheight"}, {"orbitheight <height> (oheight)", "Hat orbit command"}, function(...)
		Height = tonumber(...)
end)

cmd.add({"orbitoffset", "offset"}, {"orbitoffset <height> (offset)", "Hat orbit command"}, function(...)
		Offset = tonumber(...)
end)

cmd.add({"godmode", "god"}, {"godmode (god)", "Makes you unable to be killed"}, function()
	loadstring(game:HttpGet(('https://pastebin.com/raw/bbyuynM1'),true))()
end)

cmd.add({"commands", "cmds"}, {"commands (cmds)", "Open the command list"}, function()
	gui.commands()
end)

cmd.add({"rejoin", "rj"}, {"rejoin (rj)", "Rejoin the game"}, function()
	game:GetService("TeleportService"):Teleport(game.PlaceId)
	wait()
	


wait();

Notify({
Description = "Rejoining...";
Title = "Nameless Admin";
Duration = 5;

});
end)

wrap(function()
	--i am so not putting an emulator as a command here
end)

--[ LOCALPLAYER ]--
local function respawn()
	character:ClearAllChildren()
	local newChar = Instance.new("Model", workspace)
	local hum = Instance.new("Humanoid", newChar)
	local torso = Instance.new("Part", newChar)
	newChar.Name = "respawn_"
	torso.Name = "Torso"
	torso.Transparency = 1
	player.Character = newChar
	newChar:MoveTo(Vector3.new(999999, 999999, 999999))
	torso.Name = ""
	torso.CanCollide = false
end

local function refresh()
	local cf, p = CFrame.new(), character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
	if p then
		cf = p.CFrame
	end
	respawn()
	player.CharacterAdded:wait(1); wait(0.2);
	character:WaitForChild("HumanoidRootPart").CFrame = cf
end

local abort = 0
local function getTools(amt)
	if not amt then amt = 1 end
	local toolAmount, grabbed = 0, {}
	local lastCF = character.PrimaryPart.CFrame
	local ab = abort
	
	for i, v in pairs(localPlayer:FindFirstChildWhichIsA("Backpack"):GetChildren()) do
		if v:IsA("BackpackItem") then
			toolAmount = toolAmount + 1
		end
	end
	if toolAmount >= amt then return localPlayer:FindFirstChildWhichIsA("Backpack"):GetChildren() end
	if not localPlayer:FindFirstChildWhichIsA("Backpack"):FindFirstChildWhichIsA("BackpackItem") then return end
	
	repeat
		repeat wait() until localPlayer:FindFirstChildWhichIsA("Backpack") or ab ~= abort
		backpack = localPlayer:FindFirstChildWhichIsA("Backpack")
		wrap(function()
			repeat wait() until backpack:FindFirstChildWhichIsA("BackpackItem")
			for _, tool in pairs(backpack:GetChildren()) do
				if #grabbed >= amt or ab ~= abort then break end
				if tool:IsA("BackpackItem") then
					tool.Parent = localPlayer
					table.insert(grabbed, tool)
				end
			end
		end)
		
		respawn()
		wait(.1)
	until
		#grabbed >= amt or ab ~= abort
	
	repeat wait() until localPlayer.Character and tostring(localPlayer.Character) ~= "respawn_" and localPlayer.Character == character
	wait(.2)
	
	repeat wait() until localPlayer:FindFirstChildWhichIsA("Backpack") or ab ~= abort
	local backpack = localPlayer:FindFirstChildWhichIsA("Backpack")
	for _, tool in pairs(grabbed) do
		if tool:IsA("BackpackItem") then
			tool.Parent = backpack
		end
	end
	wrap(function()
		repeat wait() until character.PrimaryPart
		wait(.2)
		character:SetPrimaryPartCFrame(lastCF)
	end)
	wait(.2)
	return grabbed
end

cmd.add({"joke"}, {"joke", "Random joke generator"}, function()
  coroutine.wrap(function()
        local HttpService = game:GetService('HttpService')
        local check = "https://official-joke-api.appspot.com/jokes/programming/random"
        local final1 = game:HttpGet(check)
        local final = string.gsub(final1, "[%[%]]", "")
        local decoded = HttpService:JSONDecode(final)
        
             game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(decoded.setup, 'All')
        wait(2)
             game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(decoded.punchline, 'All')
  end)()

end)
cmd.add({"idiot"}, {"idiot <player>", "Tell someone that they are an idiot"}, function(...)
			local old = getChar().HumanoidRootPart.CFrame

Username = (...)

	Players = game:GetService("Players")
		HRP = game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored
		

target = getPlr(Username)

	getChar().HumanoidRootPart.CFrame = target.Character.Humanoid.RootPart.CFrame * CFrame.new(0, 1, 4)
local message = "Hey " .. target.Name .. ""
 game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, 'All')
wait(1)
 game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer('Sorry to tell you this, but..', 'All')
wait(1)
 game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer('You are an idiot!', 'All')
 wait(1)
  game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer('HAHAHA!', 'All')
wait(1)
	getChar():WaitForChild("HumanoidRootPart").CFrame = old


end)

cmd.add({"bringto"}, {"bringto (playertobring] [playertobringto]", "Brings a player to another player"}, function(h, d)
local target1 = getPlr(h)
local target2 = getPlr(d)

local old = getChar().HumanoidRootPart.CFrame
local tool = getBp():FindFirstChildOfClass("Tool") or getChar():FindFirstChildOfClass("Tool")

-- Calculate the position of the tool grip based on the second player's character
local distance = 1
local gripPosition = target2.Character.HumanoidRootPart.Position - target2.Character.HumanoidRootPart.CFrame.lookVector * distance
wait(0.2)

local Target = target1
local Character = Player.Character        
local PlayerGui = Player:waitForChild("PlayerGui")
local Backpack = Player:waitForChild("Backpack")
local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
local RootPart = Character and Humanoid and Humanoid.RootPart or false
local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
if not Humanoid or not RootPart or not RightArm then
	return
end
Humanoid:UnequipTools()
local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
if not MainTool or not MainTool:FindFirstChild("Handle") then
	return
end
local TPlayer = getPlr(Target)
local TCharacter = TPlayer and TPlayer.Character
local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
if not THumanoid or not TRootPart then
	return
end
Character.Humanoid.Name = "DAttach"
local l = Character["DAttach"]:Clone()
l.Parent = Character
l.Name = "Humanoid"
wait()
Character["DAttach"]:Destroy()
game.Workspace.CurrentCamera.CameraSubject = Character
Character.Animate.Disabled = true
wait()
Character.Animate.Disabled = false
Character.Humanoid:EquipTool(MainTool)
wait()
CF = Player.Character.PrimaryPart.CFrame
if firetouchinterest then
	local flag = false
	task.defer(function()
		MainTool.Handle.AncestryChanged:wait()
		flag = true
	end)
	repeat
		firetouchinterest(MainTool.Handle, TRootPart, 0)
		firetouchinterest(MainTool.Handle, TRootPart, 1)
		wait()
		Player.Character.HumanoidRootPart.CFrame = CF
	until flag
else
	Player.Character.HumanoidRootPart.CFrame =
	TCharacter.HumanoidRootPart.CFrame
	wait()
	Player.Character.HumanoidRootPart.CFrame =
	TCharacter.HumanoidRootPart.CFrame
	wait()
	Player.Character.HumanoidRootPart.CFrame = CF
	wait()
end
wait(.3)
Player.Character:SetPrimaryPartCFrame(CF)
if Humanoid.RigType == Enum.HumanoidRigType.R6 then
	Character["Right Arm"].RightGrip:Destroy()
else
	Character["RightHand"].RightGrip:Destroy()
	Character["RightHand"].RightGripAttachment:Destroy()
end
	
wait(4)
CF = Player.Character.HumanoidRootPart.CFrame
player.CharacterAdded:wait(1):waitForChild("HumanoidRootPart").CFrame = CF

-- Teleport the first player to the position next to the second player
getChar().HumanoidRootPart.CFrame = CFrame.new(gripPosition) + Vector3.new(0, 3, 0)

-- Tween the first player to the second player's position
local tween = game:GetService("TweenService"):Create(getChar().HumanoidRootPart, TweenInfo.new(1), {CFrame = target2.Character.HumanoidRootPart.CFrame})
tween:Play()

tool.AncestryChanged:Wait() 
if plr.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
    --plr.Character["Right Arm"]:Destroy()
    game.Players.LocalPlayer.Character["Right Arm"].RightGrip:Destroy() --r6
elseif plr.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
    --plr.Character["RightHand"]:Destroy()
    game.Players.LocalPlayer.Character.RightHand.RightGrip:Destroy() --r15
end
wait(0.07)
respawn()
end)

cmd.add({"accountage", "accage"}, {"accountage <player> (accage)", "Tells the account age of a player in the server"}, function(...)
Username = (...)

target = getPlr(Username)
teller = target.AccountAge
accountage = "The account age of " .. target.Name .. " is " .. teller


		


wait();

Notify({
Description = accountage;
Title = "Nameless Admin";
Duration = 7;

});
end)

cmd.add({"notoolscripts", "nts"}, {"notoolscripts (nts)", "Destroy all scripts in backpack"}, function()
	print("test")
	local bp = player:FindFirstChildWhichIsA("Backpack")
	for _, item in pairs(bp:GetChildren()) do
		for _, obj in pairs(item:GetDescendants()) do
			if obj:IsA("LocalScript") or obj:IsA("Script") then
				obj.Disabled = true
				obj:Destroy()
			end
		end
	end
end)

cmd.add({"spblockspam", "starterblockscam"}, {"spblockspam (starterblockspam)", "Spam blocks in any game that has the starter place"}, function()
anniblockspam = true
end)

cmd.add({"febtools"}, {"febtools", "Move parts that are your hats"}, function()
-- ty rouxhaver
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

if not getgenv().Network then
	getgenv().Network = {
		BaseParts = {};
		FakeConnections = {};
		Connections = {};
		Output = {
			Enabled = true;
			Prefix = "[NETWORK] ";
			Send = function(Type,Output,BypassOutput)
				if typeof(Type) == "function" and (Type == print or Type == warn or Type == error) and typeof(Output) == "string" and (typeof(BypassOutput) == "nil" or typeof(BypassOutput) == "boolean") then
					if Network["Output"].Enabled == true or BypassOutput == true then
						Type(Network["Output"].Prefix..Output);
					end;
				elseif Network["Output"].Enabled == true then
					error(Network["Output"].Prefix.."Output Send Error : Invalid syntax.");
				end;
			end;
		};
		CharacterRelative = false;
	}

	Network["Output"].Send(print,": Loading.")
	Network["Velocity"] = Vector3.new(14.46262424,14.46262424,14.46262424); --exactly 25.1 magnitude
	Network["RetainPart"] = function(Part,ReturnFakePart) --function for retaining ownership of unanchored parts
		assert(typeof(Part) == "Instance" and Part:IsA("BasePart") and Part:IsDescendantOf(workspace),Network["Output"].Prefix.."RetainPart Error : Invalid syntax: Arg1 (Part) must be a BasePart which is a descendant of workspace.")
		assert(typeof(ReturnFakePart) == "boolean" or typeof(ReturnFakePart) == "nil",Network["Output"].Prefix.."RetainPart Error : Invalid syntax: Arg2 (ReturnFakePart) must be a boolean or nil.")
		if not table.find(Network["BaseParts"],Part) then
			if Network.CharacterRelative == true then
				local Character = LocalPlayer.Character
				if Character and Character.PrimaryPart then
					local Distance = (Character.PrimaryPart.Position-Part.Position).Magnitude
					if Distance > 1000 then
						Network["Output"].Send(warn,"RetainPart Warning : PartOwnership not applied to BasePart "..Part:GetFullName()..", as it is more than "..gethiddenproperty(LocalPlayer,"MaximumSimulationRadius").." studs away.")
						return false
					end
				else
					Network["Output"].Send(warn,"RetainPart Warning : PartOwnership not applied to BasePart "..Part:GetFullName()..", as the LocalPlayer Character's PrimaryPart does not exist.")
					return false
				end
			end
			table.insert(Network["BaseParts"],Part)
			Part.CustomPhysicalProperties = PhysicalProperties.new(0,0,0,0,0)
			Network["Output"].Send(print,"PartOwnership Output : PartOwnership applied to BasePart "..Part:GetFullName()..".")
			if ReturnFakePart == true then
				return FakePart
			end
		else
			Network["Output"].Send(warn,"RetainPart Warning : PartOwnership not applied to BasePart "..Part:GetFullName()..", as it already active.")
			return false
		end
	end

	Network["RemovePart"] = function(Part) --function for removing ownership of unanchored part
		assert(typeof(Part) == "Instance" and Part:IsA("BasePart"),Network["Output"].Prefix.."RemovePart Error : Invalid syntax: Arg1 (Part) must be a BasePart.")
		local Index = table.find(Network["BaseParts"],Part)
		if Index then
			table.remove(Network["BaseParts"],Index)
			Network["Output"].Send(print,"RemovePart Output: PartOwnership removed from BasePart "..Part:GetFullName()..".")
		else
			Network["Output"].Send(warn,"RemovePart Warning : BasePart "..Part:GetFullName().." not found in BaseParts table.")
		end
	end

	Network["SuperStepper"] = Instance.new("BindableEvent") --make super fast event to connect to
	for _,Event in pairs({RunService.Stepped,RunService.Heartbeat}) do
		Event:Connect(function()
			return Network["SuperStepper"]:Fire(Network["SuperStepper"],tick())
		end)
	end

	Network["PartOwnership"] = {};
	Network["PartOwnership"]["PreMethodSettings"] = {};
	Network["PartOwnership"]["Enabled"] = false;
	Network["PartOwnership"]["Enable"] = coroutine.create(function() --creating a thread for network stuff
		if Network["PartOwnership"]["Enabled"] == false then
			Network["PartOwnership"]["Enabled"] = true --do cool network stuff before doing more cool network stuff
			Network["PartOwnership"]["PreMethodSettings"].ReplicationFocus = LocalPlayer.ReplicationFocus
			LocalPlayer.ReplicationFocus = workspace
			Network["PartOwnership"]["PreMethodSettings"].SimulationRadius = gethiddenproperty(LocalPlayer,"SimulationRadius")
			Network["PartOwnership"]["Connection"] = Network["SuperStepper"].Event:Connect(function() --super fast asynchronous loop
				sethiddenproperty(LocalPlayer,"SimulationRadius",1/0)
				for _,Part in pairs(Network["BaseParts"]) do --loop through parts and do network stuff
					coroutine.wrap(function()
						if Part:IsDescendantOf(workspace) then
							if Network.CharacterRelative == true then
								local Character = LocalPlayer.Character;
								if Character and Character.PrimaryPart then
									local Distance = (Character.PrimaryPart.Position - Part.Position).Magnitude
									if Distance > 1000 then
										Network["Output"].Send(warn,"PartOwnership Warning : PartOwnership not applied to BasePart "..Part:GetFullName()..", as it is more than "..gethiddenproperty(LocalPlayer,"MaximumSimulationRadius").." studs away.")
										Lost = true;
										Network["RemovePart"](Part)
									end
								else
									Network["Output"].Send(warn,"PartOwnership Warning : PartOwnership not applied to BasePart "..Part:GetFullName()..", as the LocalPlayer Character's PrimaryPart does not exist.")
								end
							end
							Part.Velocity = Network["Velocity"]+Vector3.new(0,math.cos(tick()*10)/100,0) --keep network by sending physics packets of 30 magnitude + an everchanging addition in the y level so roblox doesnt get triggered and fuck your ownership
						else
							Network["RemovePart"](Part)
						end
					end)()
				end
			end)
			Network["Output"].Send(print,"PartOwnership Output : PartOwnership enabled.")
		else
			Network["Output"].Send(warn,"PartOwnership Output : PartOwnership already enabled.")
		end
	end)
	Network["PartOwnership"]["Disable"] = coroutine.create(function()
		if Network["PartOwnership"]["Connection"] then
			Network["PartOwnership"]["Connection"]:Disconnect()
			LocalPlayer.ReplicationFocus = Network["PartOwnership"]["PreMethodSettings"].ReplicationFocus
			sethiddenproperty(LocalPlayer,"SimulationRadius",Network["PartOwnership"]["PreMethodSettings"].SimulationRadius)
			Network["PartOwnership"]["PreMethodSettings"] = {}
			for _,Part in pairs(Network["BaseParts"]) do
				Network["RemovePart"](Part)
			end
			Network["PartOwnership"]["Enabled"] = false
			Network["Output"].Send(print,"PartOwnership Output : PartOwnership disabled.")
		else
			Network["Output"].Send(warn,"PartOwnership Output : PartOwnership already disabled.")
		end
	end)
	Network["Output"].Send(print,": Loaded.")
end

coroutine.resume(Network["PartOwnership"]["Enable"])



local lp = game.Players.LocalPlayer -- local player var
local char = lp.Character -- char var

lp.Character = nil -- nil character for pdeath
lp.Character = char -- newvar

local hrp = char:FindFirstChild("HumanoidRootPart") -- hrp check
if hrp == nil then return end -- return if no hrp

wait(game.Players.RespawnTime + .3) -- nil wait

hrp:Destroy() -- rip hrp
char.Torso:Destroy() -- rip torso
local clone = char["Body Colors"]:Clone() -- body colors clone
char["Body Colors"]:Destroy() -- delete any instances from char that replicates deletion
clone.Parent = char -- parent back in clone in case some script uses it




player = game:GetService("Players").LocalPlayer
Gui = player.PlayerGui
Backpack = player.Backpack
Mouse = player:GetMouse()

Parts_Folder = Instance.new("Folder",workspace)

for i,v in pairs(player.Character:GetChildren()) do
	if v:IsA("Accessory") then
		local Part = Instance.new("Part",Parts_Folder)
		Part.Name = v.Name
		Part.Anchored = true
		Part.Size = v.Handle.Size - Vector3.new(0.001,0.001,0.001)
		Part.Position = player.Character.Head.Position + Vector3.new(math.random(-5,5),math.random(-1,1),math.random(-5,5))
		Part:SetAttribute("Moveable",true)
		Part.Material = Enum.Material.SmoothPlastic
		Part.CanCollide = false
		Part.Color = Color3.new(1,0,0)
        
        local Hat = v.Handle
        local vbreak = false
        Network.RetainPart(Hat)
        Hat.CustomPhysicalProperties = PhysicalProperties.new(0,0,0,0,0)
        coroutine.wrap(function()
            while task.wait() do
                if vbreak == true then break end
                Hat.CFrame = Part.CFrame
            end
        end)()
        Hat:FindFirstChildWhichIsA("SpecialMesh"):Destroy()
	end
end


Move_Tool = Instance.new("Tool",Backpack)
Rotate_Tool = Instance.new("Tool",Backpack)
MHandle = Instance.new("Part",Move_Tool)
RHandle = Instance.new("Part",Rotate_Tool)
Mgrabs = Instance.new("Handles",Gui)
Rgrabs = Instance.new("ArcHandles",Gui)
Outline = Instance.new("Highlight")

Move_Tool.Name = "Move"
Move_Tool.CanBeDropped = false

Rotate_Tool.Name = "Rotate"
Rotate_Tool.CanBeDropped = false

MHandle.Name = "Handle"
MHandle.Transparency = 1

RHandle.Name = "Handle"
RHandle.Transparency = 1

Mgrabs.Visible = false
Mgrabs.Color3 = Color3.new(1, 0.8, 0)
Mgrabs.Style = "Movement"

Rgrabs.Visible = false

Outline.FillTransparency = 1
Outline.OutlineTransparency = 0
Outline.OutlineColor = Color3.new(1, 0.8, 0)

Active_Part = nil

Move_Tool.AncestryChanged:Connect(function()
	if Move_Tool.Parent == char and Active_Part ~= nil then
		Mgrabs.Visible = true
		Mgrabs.Adornee = Active_Part
	end
end)

Move_Tool.AncestryChanged:Connect(function()
	if Move_Tool.Parent ~= char then
		Mgrabs.Visible = false
		Mgrabs.Adornee = nil
	end
end)

Mouse.Button1Down:Connect(function()
	if Move_Tool.Parent == char and Mouse.Target:GetAttribute("Moveable") then
		Active_Part = Mouse.Target
		Mgrabs.Visible = true
		Mgrabs.Adornee = Active_Part
		Outline.Parent = Active_Part
	end
	if Rotate_Tool.Parent == char and Mouse.Target:GetAttribute("Moveable") then
		Active_Part = Mouse.Target
		Rgrabs.Visible = true
		Rgrabs.Adornee = Active_Part
		Outline.Parent = Active_Part
	end
end)

Rotate_Tool.AncestryChanged:Connect(function()
	if Rotate_Tool.Parent == char and Active_Part ~= nil then
		Rgrabs.Visible = true
		Rgrabs.Adornee = Active_Part
	end
end)

Rotate_Tool.AncestryChanged:Connect(function()
	if Rotate_Tool.Parent ~= char then
		Rgrabs.Visible = false
		Rgrabs.Adornee = nil
	end
end)

MOGCFrame = CFrame.new()

Mgrabs.MouseButton1Down:Connect(function()
	MOGCFrame = Active_Part.CFrame
end)

Mgrabs.MouseDrag:Connect(function(knob, pos)
	if knob == Enum.NormalId.Front then
		Active_Part.CFrame = MOGCFrame + MOGCFrame.LookVector * pos
	end
	if knob == Enum.NormalId.Back then
		Active_Part.CFrame = MOGCFrame + MOGCFrame.LookVector * -pos
	end
	if knob == Enum.NormalId.Top then
		Active_Part.CFrame = MOGCFrame + MOGCFrame.UpVector * pos
	end
	if knob == Enum.NormalId.Bottom then
		Active_Part.CFrame = MOGCFrame + MOGCFrame.UpVector * -pos
	end
	if knob == Enum.NormalId.Left then
		Active_Part.CFrame = MOGCFrame + MOGCFrame.RightVector * -pos
	end
	if knob == Enum.NormalId.Right then
		Active_Part.CFrame = MOGCFrame + MOGCFrame.RightVector * pos
	end
end)

ROGCFrame = CFrame.new()

Rgrabs.MouseButton1Down:Connect(function()
	ROGCFrame = Active_Part.CFrame
end)

Rgrabs.MouseDrag:Connect(function(knob, angle)
	if knob == Enum.Axis.Y then
		Active_Part.CFrame = ROGCFrame * CFrame.Angles(0,angle,0)
	end
	if knob == Enum.Axis.X then
		Active_Part.CFrame = ROGCFrame * CFrame.Angles(angle,0,0)
	end
	if knob == Enum.Axis.Z then
		Active_Part.CFrame = ROGCFrame * CFrame.Angles(0,0,angle)
	end
end)



Mouse.TargetFilter = player.Character



camera = workspace.CurrentCamera
input = game:GetService("UserInputService")

Camera_Part = Instance.new("Part",workspace)
Camera_Part.Anchored = true
Camera_Part.Transparency = 0.85
Camera_Part.Shape = Enum.PartType.Ball
Camera_Part.Size = Vector3.new(0.5,0.5,0.5)
Camera_Part.Material = Enum.Material.SmoothPlastic

current_position = char.Head.Position

camera.CameraSubject = Camera_Part



for i,v in pairs(char:GetDescendants()) do
	if v:IsA("BasePart") and v.Parent:IsA("Accessory") == false then
		v:Destroy()
	end
end

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "FE BTools Loaded",
	Text = "Made by rouxhaver",
	Icon = "rbxassetid://12561999923"
})
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Network Credit:",
	Text = "thanks to 4eyes for network stuff",
	Icon = "rbxassetid://12562053596"
})

while wait() do
	if vbreak == true then
		break
	end
	if input:IsKeyDown(Enum.KeyCode.D) then
		current_position += camera.CFrame.RightVector * speed
	end
	if input:IsKeyDown(Enum.KeyCode.A) then
		current_position += camera.CFrame.RightVector * -speed
	end
	if input:IsKeyDown(Enum.KeyCode.W) then
		current_position += camera.CFrame.LookVector * speed
	end
	if input:IsKeyDown(Enum.KeyCode.S) then
		current_position += camera.CFrame.LookVector * -speed
	end
	if input:IsKeyDown(Enum.KeyCode.E) then
		current_position += camera.CFrame.UpVector * speed
	end
	if input:IsKeyDown(Enum.KeyCode.Q) then
		current_position += camera.CFrame.UpVector * -speed
	end
	if input:IsKeyDown(Enum.KeyCode.LeftShift) then do
			speed = 1.5
		end else
		speed = 0.75
	end
	Camera_Part.Position = current_position
end
    end)

cmd.add({"unspblockspam", "unstarterblockscam"}, {"unspblockspam (unstarterblockspam)", "Stops the starterblockspam command"}, function()
anniblockspam = false
end)

cmd.add({"blockspam"}, {"blockspam [amount]", "Spawn blocks by the given amount"}, function(amt)
	amt = tonumber(amt) or 1
	local hatAmount, grabbed = 0, {}
	local lastCF = character.PrimaryPart.CFrame
	character:ClearAllChildren()
	respawn()
	repeat
		if character.Name ~= "respawn_" then
			local c = character
			repeat wait() until c:FindFirstChildWhichIsA("Accoutrement")
			c:MoveTo(lastCF.p)
			wait(1)
			for i, v in pairs(c:GetChildren()) do
				if v:IsA("Accoutrement") then
					v:WaitForChild("Handle")
					v.Handle.CanCollide = true
					if v:FindFirstChildWhichIsA("DataModelMesh", true) then
						v:FindFirstChildWhichIsA("DataModelMesh", true):Destroy()
					end
					v.Parent = workspace
					table.insert(grabbed, v)
				end
			end
			hatAmount = hatAmount + 1
		end
		character:ClearAllChildren()
		respawn()
		wait()
	until
		hatAmount >= amt
	
	repeat wait() until tostring(localPlayer.Character) ~= "respawn_" and localPlayer.Character
	wait(0.5)
	
	spawn(function()
		repeat wait() until character.PrimaryPart
		wait(0.2)
		character:SetPrimaryPartCFrame(lastCF)
		
		for _, item in pairs(grabbed) do
			if item:IsA("Accoutrement") and item:FindFirstChild("Handle") then
				item.Parent = workspace
				wait()
			end
		end
	end)
end)

cmd.add({"hitboxes"}, {"hitboxes", "shows all the hitboxes"}, function()
settings():GetService("RenderSettings").ShowBoundingBoxes = true
end)

cmd.add({"unhitboxes"}, {"unhitboxes", "removes the hitboxes outline"}, function()
settings():GetService("RenderSettings").ShowBoundingBoxes = false
end)

cmd.add({"punch"}, {"punch", "punch tool that flings"}, function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/FE/main/punch",true))()
end)

cmd.add({"vfly", "vehiclefly"}, {"vehiclefly (vfly)", "be able to fly vehicles"}, function(...)
FLYING = false
	cmdlp.Character.Humanoid.PlatformStand = false
	wait()

		
		
		wait();
		
		Notify({
		Description = "Vehicle fly enabled";
		Title = "Nameless Admin";
		Duration = 5;
	
});
	sFLY(true)
	speedofthevfly = (...)
	if (...) == nil then
	    speedofthevfly = 2
	    end
end)

cmd.add({"unvfly", "unvehiclefly"}, {"unvehiclefly (unvfly)", "disable vehicle fly"}, function()

		
		
		wait();
		
		Notify({
		Description = "Vehicle fly disabled";
		Title = "Nameless Admin";
		Duration = 5;
	
});
FLYING = false
	cmdlp.Character.Humanoid.PlatformStand = false
end)

cmd.add({"kill"}, {"kill [player]", "after a while i have added a working kill script thats almost instant to this admin"}, function(...)
	Target = (...)

if Target == "all" or Target == "others" then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Kill%20All'))()
else
local function Kill()
            if not getPlr(Target) then
            end
            
            repeat game:FindService("RunService").Heartbeat:wait() until getPlr(Target).Character and getPlr(Target).Character:FindFirstChildOfClass("Humanoid") and getPlr(Target).Character:FindFirstChildOfClass("Humanoid").Health > 0
            local Character
            local Humanoid
            local RootPart
            local Tool
            local Handle
            
            local TPlayer = getPlr(Target)
            local TCharacter = TPlayer.Character
            local THumanoid
            local TRootPart
            
            if Player.Character and Player.Character and Player.Character.Name == Player.Name then
                Character = Player.Character
            else
            end
            if Character:FindFirstChildOfClass("Humanoid") then
                Humanoid = Character:FindFirstChildOfClass("Humanoid")
            else
            end
            if Humanoid and Humanoid.RootPart then
                RootPart = Humanoid.RootPart
            else
            end
            if Character:FindFirstChildOfClass("Tool") then
                Tool = Character:FindFirstChildOfClass("Tool")
            elseif Player.Backpack:FindFirstChildOfClass("Tool") and Humanoid then
                Tool = Player.Backpack:FindFirstChildOfClass("Tool")
                Humanoid:EquipTool(Player.Backpack:FindFirstChildOfClass("Tool"))
            else
            end
            if Tool and Tool:FindFirstChild("Handle") then
                Handle = Tool.Handle
            else
            end
            
            --Target
            if TCharacter:FindFirstChildOfClass("Humanoid") then
                THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
            else
                return Message("Error",">   Missing Target Humanoid")
            end
            if THumanoid.RootPart then
                TRootPart = THumanoid.RootPart
            else
                return Message("Error",">   Missing Target RootPart")
            end
            
            if THumanoid.Sit then
                return Message("Error",">   Target is seated")
            end
            
            local OldCFrame = RootPart.CFrame
            
            Humanoid:Destroy()
            local NewHumanoid = Humanoid:Clone()
            NewHumanoid.Parent = Character
            NewHumanoid:UnequipTools()
            NewHumanoid:EquipTool(Tool)
            Tool.Parent = workspace
        
            local Timer = os.time()
        
            repeat
                if (TRootPart.CFrame.p - RootPart.CFrame.p).Magnitude < 500 then
                    Tool.Grip = CFrame.new()
                    Tool.Grip = Handle.CFrame:ToObjectSpace(TRootPart.CFrame):Inverse()
                end
                firetouchinterest(Handle,TRootPart,0)
                firetouchinterest(Handle,TRootPart,1)
                game:FindService("RunService").Heartbeat:wait()
            until Tool.Parent ~= Character or not TPlayer or not TRootPart or THumanoid.Health <= 0 or os.time() > Timer + .20
            Player.Character = nil
            NewHumanoid.Health = 0
            player.CharacterAdded:wait(1)
            repeat game:FindService("RunService").Heartbeat:wait() until Player.Character:FindFirstChild("HumanoidRootPart")
            Player.Character.HumanoidRootPart.CFrame = OldCFrame
end
      
        if not LoopKill then
            Kill()
        else
            while LoopKill do
                Kill()
            end
        end
         end
end)

cmd.add({"toolblockspam"}, {"toolblockspam [amount]", "Spawn blocks by the given amount"}, function(amt)
	if not amt then amt = 1 end
	amt = tonumber(amt)
	local tools = getTools(amt)
	for i, tool in pairs(tools) do
		wait()
		spawn(function()
			wait(0.5)
			tool.Parent = character
			tool.CanBeDropped = true
			wait(0.4)
			for _, mesh in pairs(tool:GetDescendants()) do
				if mesh:IsA("DataModelMesh") then
					mesh:Destroy()
				end
			end
			for _, weld in pairs(character:GetDescendants()) do
				if weld.Name == "RightGrip" then
					weld:Destroy()
				end
			end
			wait(0.1)
			tool.Parent = workspace
			wait(0.3)
			local cf, p = CFrame.new(), character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
	if p then
		cf = p.CFrame
	end
	respawn()
	player.CharacterAdded:wait(1); wait(0.2);
	character:WaitForChild("HumanoidRootPart").CFrame = cf
		end)
	end
end)

cmd.add({"equiptools", "equipall"}, {"equiptools", "Equip all of your tools"}, function()
	local backpack = localPlayer:FindFirstChildWhichIsA("Backpack")
	if backpack then
		for _, tool in pairs(backpack:GetChildren()) do
			if tool:IsA("Tool") then
				tool.Parent = character
			end
		end
	end
end)

cmd.add({"tweento", "tweengoto"}, {"tweengoto (tweento)", "Teleportation method that bypassses some anticheats"}, function(...)
local Username = (...)


char = game.Players.LocalPlayer

TweenService = game:GetService("TweenService")

speaker = game.Players.LocalPlayer
Players = game:GetService("Players")
	
	local players = getPlr(Username)
			TweenService:Create(getRoot(speaker.Character), TweenInfo.new(2, Enum.EasingStyle.Linear), {CFrame = getRoot(players.Character).CFrame + Vector3.new(3,1,0)}):Play()
	
end)

cmd.add({"reach"}, {"reach {number}", "Sword reach"}, function(reachsize)
	local reachsize = reachsize or 25
	local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") or Player.Backpack:FindFirstChildOfClass("Tool")
	if Tool:FindFirstChild("OGSize3") then
		Tool.Handle.Size = Tool.OGSize3.Value
		Tool.OGSize3:Destroy()
		Tool.Handle.FunTIMES:Destroy()
	end
	local val = Instance.new("Vector3Value",Tool)
	val.Name = "OGSize3"
	val.Value = Tool.Handle.Size
	local sb = Instance.new("SelectionBox")
	sb.Adornee = Tool.Handle
	sb.Name = "FunTIMES"
	sb.Parent = Tool.Handle
	Tool.Handle.Massless = true
	Tool.Handle.Size = Vector3.new(Tool.Handle.Size.X,Tool.Handle.Size.Y,reachsize)
end)

cmd.add({"droptools"}, {"dropalltools", "Drop all of your tools"}, function()
	local backpack = localPlayer:FindFirstChildWhichIsA("Backpack")
	if backpack then
		for _, tool in pairs(backpack:GetChildren()) do
			if tool:IsA("Tool") then
				tool.Parent = character
			end
		end
	end
	wait()
	for _, tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") then
			tool.Parent = workspace
		end
	end
	wait()
	respawn()
end)

cmd.add({"notools"}, {"notools", "Remove your tools"}, function()
	for _, tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") then
			tool:Destroy()
		end
	end
	for _, tool in pairs(localPlayer.Backpack:GetChildren()) do
		if tool:IsA("Tool") then
			tool:Destroy()
		end
	end
end)

cmd.add({"breaklayeredclothing", "blc"}, {"breaklayeredclothing (blc)", "Streches your layered clothing"}, function()



wait();

Notify({
Description = "Break layered clothing executed, if you havent already equip shirt, jacket, pants and shoes (Layered Clothing ones)";
Title = "Nameless Admin";
Duration = 5;

});
local swimming = false
local RunService = game:GetService("RunService")
oldgrav = workspace.Gravity
workspace.Gravity = 0
local char = game.Players.LocalPlayer.Character
local swimDied = function()
workspace.Gravity = oldgrav
swimming = false
end
local Humanoid = char:FindFirstChildWhichIsA("Humanoid")
gravReset = Humanoid.Died:Connect(swimDied)
local enums = Enum.HumanoidStateType:GetEnumItems()
table.remove(enums, table.find(enums, Enum.HumanoidStateType.None))
for i, v in pairs(enums) do
Humanoid:SetStateEnabled(v, false)
end
Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
swimbeat = RunService.Heartbeat:Connect(function()
pcall(function()
char.HumanoidRootPart.Velocity = ((Humanoid.MoveDirection ~= Vector3.new() or UserInputService:IsKeyDown(Enum.KeyCode.Space)) and char.HumanoidRootPart.Velocity or Vector3.new())
end)
end)
swimming = true
local Clip = false
wait(0.1)
local function NoclipLoop()
if Clip == false and char ~= nil then
for _, child in pairs(char:GetDescendants()) do
if child:IsA("BasePart") and child.CanCollide == true then
child.CanCollide = false
end
end
end
end
Noclipping = RunService.Stepped:Connect(NoclipLoop)
loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Leg%20Resize'))()
end)

cmd.add({"car"}, {"car [requested]", "Car script as requested by Pampers"}, function()
--compatibility for games who change service names
local Playr = game:GetService("Players")
local Run = game:GetService("RunService")
local Core = game:GetService("CoreGui")
local LocalPlayer = Playr.LocalPlayer

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Lozarth/IreXion-UI-Library/main/IreXion.lua"))()

local Gui = Library:AddGui({
	Title = {"FE Car", "Made by Lozarth"},
	ThemeColor = Color3.fromRGB(0,91,150),
	ToggleKey = Enum.KeyCode.RightShift,
})

local Tab = Gui:AddTab("Main")

local Category = Tab:AddCategory("Main")

local Label = Category:AddLabel("Go into R6 for this script to work.")

local Button = Category:AddButton("Enable FE Car", function()
	LocalPlayer.Character.Humanoid.WalkSpeed=70 LocalPlayer.Character.Humanoid.JumpPower=0.0001 Float_Height="-1.03" AnimationId="129342287" local a=Instance.new("Animation") a.AnimationId="rbxassetid://"..AnimationId local a=LocalPlayer.Character.Humanoid:LoadAnimation(a) a:Play() a:AdjustSpeed(1) for a,a in pairs(LocalPlayer.Character:GetDescendants())do if a.ClassName=="Part"then a.CustomPhysicalProperties=PhysicalProperties.new(0,0,0)end end local a=1 G=game _=wait p=G:GetService("Players").LocalPlayer.Character p:FindFirstChild("Humanoid").HipHeight=Float_Height _(1.5) t=.4 for a=1,a do repeat p:FindFirstChild("Humanoid").HipHeight=Float_Height-n _(t) p:FindFirstChild("Humanoid").HipHeight=Float_Height+n _(t)until p:FindFirstChild("Humanoid").Health==0 end
end)

local Category = Tab:AddCategory("Settings")

local Box = Category:AddBox("Slide", function(str)
	for a,a in pairs(LocalPlayer.Character:GetDescendants())do if a.ClassName=="Part"then a.CustomPhysicalProperties=PhysicalProperties.new(str,0,0)end end 
end)

local Box = Category:AddBox("Hipheight", function(str)
	Float_Height=str local a=1 G=game _=wait p=G:GetService("Players").LocalPlayer.Character p:FindFirstChild("Humanoid").HipHeight=Float_Height _(1.5) t=.4 for a=1,a do repeat p:FindFirstChild("Humanoid").HipHeight=Float_Height-n _(t) p:FindFirstChild("Humanoid").HipHeight=Float_Height+n _(t)until p:FindFirstChild("Humanoid").Health==0 end
end)

local Slider = Category:AddSlider("Walkspeed", 1, 500, 16, function(val)
	LocalPlayer.Character.Humanoid.WalkSpeed = val
end)

local Category = Tab:AddCategory("Settings Presets")

local Button = Category:AddButton("Default Car Settings Preset", function()
	for a,a in pairs(LocalPlayer.Character:GetDescendants())do if a.ClassName=="Part"then a.CustomPhysicalProperties=PhysicalProperties.new(0,0,0)end end
	LocalPlayer.Character.Humanoid.WalkSpeed = 70
	Float_Height="-1.03" local a=1 G=game _=wait p=G:GetService("Players").LocalPlayer.Character p:FindFirstChild("Humanoid").HipHeight=Float_Height _(1.5) t=.4 for a=1,a do repeat p:FindFirstChild("Humanoid").HipHeight=Float_Height-n _(t) p:FindFirstChild("Humanoid").HipHeight=Float_Height+n _(t)until p:FindFirstChild("Humanoid").Health==0 end
end)

local Button = Category:AddButton("Extreme Car Settings Preset", function()
	for a,a in pairs(LocalPlayer.Character:GetDescendants())do if a.ClassName=="Part"then a.CustomPhysicalProperties=PhysicalProperties.new(0.5,0,0)end end
	LocalPlayer.Character.Humanoid.WalkSpeed = 500
	Float_Height="-1.03" local a=1 G=game _=wait p=G:GetService("Players").LocalPlayer.Character p:FindFirstChild("Humanoid").HipHeight=Float_Height _(1.5) t=.4 for a=1,a do repeat p:FindFirstChild("Humanoid").HipHeight=Float_Height-n _(t) p:FindFirstChild("Humanoid").HipHeight=Float_Height+n _(t)until p:FindFirstChild("Humanoid").Health==0 end
end)

if game.PlaceId == 2041312716 then
local Tab = Gui:AddTab("Ragdoll Engine")

local Category = Tab:AddCategory("Ragdoll Engine Features")
local Button = Category:AddButton("Push Aura", function()
    
Run.RenderStepped:Connect(function()
        LocalPlayer.Character.Push.PushEvent:FireServer()
	end)
end)

local Label = Category:AddLabel("Useful for flinging people when you hit them with your car")
local Label = Category:AddLabel("Or just flinging people who come close.")
local Label = Category:AddLabel("Equip Push tool before clicking to work.")

local Button = Category:AddButton("Anti-Ragdoll", function()
	LocalPlayer.Character:FindFirstChild("Local Ragdoll"):Destroy()
end)
end

local Tab = Gui:AddTab("Discord")

local Category = Tab:AddCategory("Discord")

local Button = Category:AddButton("Join Discord", function()
    setclipboard("https://discord.gg/hsdcAFZY9E")
    Library:Notify("Invite prompted! If it did not work the invite was copied to your clipboard.")
    local json = {
   ["cmd"] = "INVITE_BROWSER",
   ["args"] = {
       ["code"] = "hsdcAFZY9E"
   },
   ["nonce"] = 'a'
}
spawn(function()
   print(syn.request({
       Url = 'http://127.0.0.1:6463/rpc?v=1',
       Method = 'POST',
       Headers = {
           ['Content-Type'] = 'application/json',
           ['Origin'] = 'https://discord.com'
       },
       Body = game:GetService('HttpService'):JSONEncode(json),
   }).Body)
end)
end)

local Tab = Gui:AddTab("Close")

local Category = Tab:AddCategory("Close")

local Button = Category:AddButton("Close GUI", function()
	Core["FE Car Made by Lozarth"]:Destroy()
end)

Library:Notify("Join Discord server?", function(bool)
	if bool == true then
		setclipboard("https://discord.gg/hsdcAFZY9E")
    Library:Notify("Invite prompted! If it did not work the invite was copied to your clipboard.")
    local json = {
   ["cmd"] = "INVITE_BROWSER",
   ["args"] = {
       ["code"] = "hsdcAFZY9E"
   },
   ["nonce"] = 'a'
}
spawn(function()
   print(syn.request({
       Url = 'http://127.0.0.1:6463/rpc?v=1',
       Method = 'POST',
       Headers = {
           ['Content-Type'] = 'application/json',
           ['Origin'] = 'https://discord.com'
       },
       Body = game:GetService('HttpService'):JSONEncode(json),
   }).Body)
end)
end
end)
end)

cmd.add({"fpsbooster", "lowgraphics", "boostfps", "lowg"}, {"fpsbooster (lowgraphics, boostfps, lowg)", "Low graphics mode if the game is laggy"}, function()
	local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
	local g = game
	local w = g.Workspace
	local l = g.Lighting
	local t = w.Terrain
	sethiddenproperty(l,"Technology",2)
	sethiddenproperty(t,"Decoration",false)
	t.WaterWaveSize = 0
	t.WaterWaveSpeed = 0
	t.WaterReflectance = 0
	t.WaterTransparency = 0
	l.GlobalShadows = 0
	l.FogEnd = 9e9
	l.Brightness = 0
	settings().Rendering.QualityLevel = "Level01"
	for i, v in pairs(w:GetDescendants()) do
		if v:IsA("BasePart") and not v:IsA("MeshPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif (v:IsA("Decal") or v:IsA("Texture")) and decalsyeeted then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
			v.Enabled = false
		elseif v:IsA("MeshPart") and decalsyeeted then
			v.Material = "Plastic"
			v.Reflectance = 0
			v.TextureID = 10385902758728957
		elseif v:IsA("SpecialMesh") and decalsyeeted  then
			v.TextureId=0
		elseif v:IsA("ShirtGraphic") and decalsyeeted then
			v.Graphic=0
		elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
			v[v.ClassName.."Template"]=0
		end
	end
	for i = 1,#l:GetChildren() do
		e=l:GetChildren()[i]
		if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
			e.Enabled = false
		end
	end
	w.DescendantAdded:Connect(function(v)
		wait()--prevent errors and shit
	   if v:IsA("BasePart") and not v:IsA("MeshPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
			v.Enabled = false
		elseif v:IsA("MeshPart") and decalsyeeted then
			v.Material = "Plastic"
			v.Reflectance = 0
			v.TextureID = 10385902758728957
		elseif v:IsA("SpecialMesh") and decalsyeeted then
			v.TextureId=0
		elseif v:IsA("ShirtGraphic") and decalsyeeted then
			v.ShirtGraphic=0
		elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
			v[v.ClassName.."Template"]=0
		end
	end)
end)

cmd.add({"vr", "clovr", "vrscript", "fevr"}, {"vr (clovr, vrscript, fevr)", "FE VR SCRIPT AKA CLOVR"}, function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/FE/main/CloVR"))();
end)


cmd.add({"void"}, {"void <player>", "Kill the given players without FE god"}, function(...)
	Target = (...)
				Player.Character.HumanoidRootPart.CFrame = CFrame.new(0,-349,0)
local Character = Player.Character
local PlayerGui = Player:waitForChild("PlayerGui")
local Backpack = Player:waitForChild("Backpack")
local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
local RootPart = Character and Humanoid and Humanoid.RootPart or false
local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
if not Humanoid or not RootPart or not RightArm then
return
end

Humanoid:UnequipTools()
local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
if not MainTool or not MainTool:FindFirstChild("Handle") then
return
end

local TPlayer = getPlr(Target)
local TCharacter = TPlayer and TPlayer.Character

local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
if not THumanoid or not TRootPart then
return
end

Character.Humanoid.Name = "DAttach"
local l = Character["DAttach"]:Clone()
l.Parent = Character
l.Name = "Humanoid"
wait()
Character["DAttach"]:Destroy()
game.Workspace.CurrentCamera.CameraSubject = Character
Character.Animate.Disabled = true
wait()
Character.Animate.Disabled = false
Character.Humanoid:EquipTool(MainTool)
wait()
CF = Player.Character.PrimaryPart.CFrame
XC = TCharacter.HumanoidRootPart.CFrame.X
ZC = TCharacter.HumanoidRootPart.CFrame.Z
if firetouchinterest then
local flag = false
task.defer(function()
	MainTool.Handle.AncestryChanged:wait()
	flag = true
end)
repeat
	firetouchinterest(MainTool.Handle, TRootPart, 0)
	firetouchinterest(MainTool.Handle, TRootPart, 1)
	wait()
	Player.Character.HumanoidRootPart.CFrame = CFrame.new(XC,-99,ZC)
until flag
else
Player.Character.HumanoidRootPart.CFrame =
TCharacter.HumanoidRootPart.CFrame
wait()
Player.Character.HumanoidRootPart.CFrame =
TCharacter.HumanoidRootPart.CFrame
wait()
Player.Character.HumanoidRootPart.CFrame = CFrame.new(XC,-99,ZC)
wait()
end
wait(.3)
Player.Character:SetPrimaryPartCFrame(CF)
if Humanoid.RigType == Enum.HumanoidRigType.R6 then
Character["Right Arm"].RightGrip:Destroy()
else
Character["RightHand"].RightGrip:Destroy()
Character["RightHand"].RightGripAttachment:Destroy()
end
wait(1)
respawn()
end)

cmd.add({"annoy"}, {"annoy <player>", "Annoys the given player"}, function(...)
	Target = (...)
 local TPlayer = getPlr(Target)
            TRootPart = TPlayer.Character.HumanoidRootPart
            local Character = Player.Character
            local PlayerGui = Player:WaitForChild("PlayerGui")
            local Backpack = Player:WaitForChild("Backpack")
            local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
            local RootPart = Character and Humanoid and Humanoid.RootPart or false
            local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
            if not Humanoid or not RootPart or not RightArm then
                return
            end
            Humanoid:UnequipTools()
            local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
            if not MainTool or not MainTool:FindFirstChild("Handle") then
                return
            end
            Humanoid.Name = "DAttach"
            local l = Character["DAttach"]:Clone()
            l.Parent = Character
            l.Name = "Humanoid"
            wait()
            Character["DAttach"]:Destroy()
            game.Workspace.CurrentCamera.CameraSubject = Character
            Character.Animate.Disabled = true
            wait()
            Character.Animate.Disabled = false
            Character.Humanoid:EquipTool(MainTool)
            wait()
            CF = Player.Character.PrimaryPart.CFrame
            if firetouchinterest then
                local flag = false
                task.defer(function()
                    MainTool.Handle.AncestryChanged:wait()
                    flag = true
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 999, 0)
		local power = 99999 -- change this amount of fling power how much you want fling power you want
		wait(.1)
		local bambam = Instance.new("BodyThrust")
		bambam.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
		bambam.Force = Vector3.new(power,0,power)
		bambam.Location = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                end)
                repeat
                    firetouchinterest(MainTool.Handle, TRootPart, 0)
                    firetouchinterest(MainTool.Handle, TRootPart, 1)
                    wait()
                until flag
            else
                Player.Character.HumanoidRootPart.CFrame =
                TCharacter.HumanoidRootPart.CFrame
                wait()
                Player.Character.HumanoidRootPart.CFrame =
                TCharacter.HumanoidRootPart.CFrame
                wait()
            end
              local OldPos = getRoot().CFrame
	   	   player.CharacterAdded:wait(1)
		   			    wait(4)             CF = Player.Character.HumanoidRootPart.CFrame             player.CharacterAdded:wait(1):waitForChild("HumanoidRootPart").CFrame = CF
end)

cmd.add({"banish", "punish", "jail"}, {"punish <player> (banish, jail)", "Banishes the player using a void script, can make them not respawn if the game is old"}, function(...)
	namelol = (...)
user = getPlr(namelol)
            plr = user.name
            Target = plr
            Player.Character.Humanoid.Name = 1
            local l = Player.Character["1"]:Clone()
            l.Parent = Player.Character
            l.Name = "Humanoid"
            task.wait()
            Player.Character["1"]:Destroy()
            game.Workspace.CurrentCamera.CameraSubject = Player.Character
            Player.Character.Animate.Disabled = true
            task.wait()
            Player.Character.Animate.Disabled = false
            for i, v in pairs(game:FindService "Players".LocalPlayer.Backpack:GetChildren()) do
                Player.Character.Humanoid:EquipTool(v)
            end
            task.wait()
            Player.Character.HumanoidRootPart.CFrame = Players[Target].Character.HumanoidRootPart.CFrame
            task.wait()
            Player.Character.HumanoidRootPart.CFrame = Players[Target].Character.HumanoidRootPart.CFrame
            task.wait(0.7)
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-100000, 1000000000000000000000, -100000))
            task.wait()
			task.wait(4)
			game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)

cmd.add({"sync"}, {"sync", "Syncs all in-game audios"}, function()
	if game.SoundService.RespectFilteringEnabled == false then
		for i,v in pairs(game:GetDescendants()) do
		if v:IsA("Sound") then
		v:Play()
		end
		end
		else
		Notify({
		Description = "This game has RFE on, meaning this wont replicate.";
		Title = "Nameless Admin";
		Duration = 7;
		
		});
		end
end)

cmd.add({"infvoid"}, {"infvoid <player>", "Makes a players avatar glitch"}, function(...)
	Target = (...)
	local TPlayer = getPlr(Target)
			   TRootPart = TPlayer.Character.HumanoidRootPart
			   local Character = Player.Character
			   local PlayerGui = Player:WaitForChild("PlayerGui")
			   local Backpack = Player:WaitForChild("Backpack")
			   local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
			   local RootPart = Character and Humanoid and Humanoid.RootPart or false
			   local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
			   if not Humanoid or not RootPart or not RightArm then
				   return
			   end
			   Humanoid:UnequipTools()
			   local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
			   if not MainTool or not MainTool:FindFirstChild("Handle") then
				   return
			   end
			   Humanoid.Name = "DAttach"
			   local l = Character["DAttach"]:Clone()
			   l.Parent = Character
			   l.Name = "Humanoid"
			   wait()
			   Character["DAttach"]:Destroy()
			   game.Workspace.CurrentCamera.CameraSubject = Character
			   Character.Animate.Disabled = true
			   wait()
			   Character.Animate.Disabled = false
			   Character.Humanoid:EquipTool(MainTool)
			   wait()
			   CF = Player.Character.PrimaryPart.CFrame
			   if firetouchinterest then
				   local flag = false
				   task.defer(function()
					   MainTool.Handle.AncestryChanged:wait()
					   flag = true
				   end)
				   repeat
					   firetouchinterest(MainTool.Handle, TRootPart, 0)
					   firetouchinterest(MainTool.Handle, TRootPart, 1)
					   wait()
				   until flag
			   else
				   Player.Character.HumanoidRootPart.CFrame =
				   TCharacter.HumanoidRootPart.CFrame
				   wait()
				   Player.Character.HumanoidRootPart.CFrame =
				   TCharacter.HumanoidRootPart.CFrame
				   wait()
			   end
			   game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(111111110, 11111110, 11111110)
end)

cmd.add({"attach"}, {"attach <player>", "Attach the given player(s)"}, function(...)
	Target = (...)
	local TPlayer = getPlr(Target)
			   TRootPart = TPlayer.Character.HumanoidRootPart
			   local Character = Player.Character
			   local PlayerGui = Player:WaitForChild("PlayerGui")
			   local Backpack = Player:WaitForChild("Backpack")
			   local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
			   local RootPart = Character and Humanoid and Humanoid.RootPart or false
			   local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
			   if not Humanoid or not RootPart or not RightArm then
				   return
			   end
			   Humanoid:UnequipTools()
			   local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
			   if not MainTool or not MainTool:FindFirstChild("Handle") then
				   return
			   end
			   Humanoid.Name = "DAttach"
			   local l = Character["DAttach"]:Clone()
			   l.Parent = Character
			   l.Name = "Humanoid"
			   wait()
			   Character["DAttach"]:Destroy()
			   game.Workspace.CurrentCamera.CameraSubject = Character
			   Character.Animate.Disabled = true
			   wait()
			   Character.Animate.Disabled = false
			   Character.Humanoid:EquipTool(MainTool)
			   wait()
			   CF = Player.Character.PrimaryPart.CFrame
			   if firetouchinterest then
				   local flag = false
				   task.defer(function()
					   MainTool.Handle.AncestryChanged:wait()
					   flag = true
				   end)
				   repeat
					   firetouchinterest(MainTool.Handle, TRootPart, 0)
					   firetouchinterest(MainTool.Handle, TRootPart, 1)
					   wait()
				   until flag
			   else
				   Player.Character.HumanoidRootPart.CFrame =
				   TCharacter.HumanoidRootPart.CFrame
				   wait()
				   Player.Character.HumanoidRootPart.CFrame =
				   TCharacter.HumanoidRootPart.CFrame
				   wait()
			   end
			   player.CharacterAdded:wait(1):waitForChild("HumanoidRootPart").CFrame = CF
   
end)

cmd.add({"enableinventory", "enableinv"}, {"enableinv (enaleinventory)", "Lets you see what you have in your inventory since some games hide it"}, function(...)
	game.StarterGui:SetCoreGuiEnabled(2, true)
end)

cmd.add({"copytools", "ctools"}, {"copytools <player> (ctools)", "Copies the tools the given player has"}, function(...)
	PLAYERNAMEHERE = (...)
	Target = getPlr(PLAYERNAMEHERE)
	for i, v in pairs(game:GetService("Players"):FindFirstChild(Target.Name).Backpack:GetChildren() )do
		if v:IsA("Tool") or v:IsA('HopperBin') then
			v:Clone().Parent = game.Players.LocalPlayer:FindFirstChildOfClass("Backpack")
		end
		end
	end)

cmd.add({"bring"}, {"bring <player>", "Bring the given player(s)"}, function(...)
	local Target = (...) 
	if Target == "all" or Target == "others" then
loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Bring%20All'))()
end
            local Character = Player.Character        
            local PlayerGui = Player:waitForChild("PlayerGui")
            local Backpack = Player:waitForChild("Backpack")
            local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
            local RootPart = Character and Humanoid and Humanoid.RootPart or false
            local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
            if not Humanoid or not RootPart or not RightArm then
                return
            end
            Humanoid:UnequipTools()
            local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
            if not MainTool or not MainTool:FindFirstChild("Handle") then
                return
            end
            local TPlayer = getPlr(Target)
            local TCharacter = TPlayer and TPlayer.Character
            local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
            local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
            if not THumanoid or not TRootPart then
                return
            end
            Character.Humanoid.Name = "DAttach"
            local l = Character["DAttach"]:Clone()
            l.Parent = Character
            l.Name = "Humanoid"
            wait()
            Character["DAttach"]:Destroy()
            game.Workspace.CurrentCamera.CameraSubject = Character
            Character.Animate.Disabled = true
            wait()
            Character.Animate.Disabled = false
            Character.Humanoid:EquipTool(MainTool)
            wait()
            CF = Player.Character.PrimaryPart.CFrame
            if firetouchinterest then
                local flag = false
                task.defer(function()
                    MainTool.Handle.AncestryChanged:wait()
                    flag = true
                end)
                repeat
                    firetouchinterest(MainTool.Handle, TRootPart, 0)
                    firetouchinterest(MainTool.Handle, TRootPart, 1)
                    wait()
                    Player.Character.HumanoidRootPart.CFrame = CF
                until flag
            else
                Player.Character.HumanoidRootPart.CFrame =
                TCharacter.HumanoidRootPart.CFrame
                wait()
                Player.Character.HumanoidRootPart.CFrame =
                TCharacter.HumanoidRootPart.CFrame
                wait()
                Player.Character.HumanoidRootPart.CFrame = CF
                wait()
            end
            wait(.3)
            Player.Character:SetPrimaryPartCFrame(CF)
            if Humanoid.RigType == Enum.HumanoidRigType.R6 then
                Character["Right Arm"].RightGrip:Destroy()
            else
                Character["RightHand"].RightGrip:Destroy()
                Character["RightHand"].RightGripAttachment:Destroy()
            end
                
            wait(4)
            CF = Player.Character.HumanoidRootPart.CFrame
            player.CharacterAdded:wait(1):waitForChild("HumanoidRootPart").CFrame = CF
end)

cmd.add({"errorlag", "animlag", "serverlag"}, {"animlag <number> (errorlag, seņrverlag)", "Repeatedly error the server with a massive string <N> at a time"}, function(n)
	local amt = tonumber(n) or 1
	local i = 1234
	local symbols = {"💖","❤️","🔥","👍","🎉","😜","💯","💜","😈","💦"}
	local function err(...)
		i = i + 1
		if i > 30000 then i = 1000 end
		local hum = character:FindFirstChildWhichIsA("Humanoid")
		local animation = Instance.new("Animation")
		animation.AnimationId = (symbols[math.random(1, #symbols)]):rep(i)
		hum:LoadAnimation(animation):Play()
		animation:Destroy()
	end
	lib.connect("spam", RunService.RenderStepped:Connect(function()
		for i = 1, amt do
			err()
		end
	end))
end)

cmd.add({"httpget", "hl", "get"}, {"httpget <url>", "Run the contents of a given URL"}, function(url)
	loadstring(game:HttpGet(url, true))()
end)

cmd.add({"skydive", "sky"}, {"skydive <player> (sky)", "Skydives the player"}, function(...)
	local Target = (...)
            local Character = Player.Character
            local PlayerGui = Player:waitForChild("PlayerGui")
            local Backpack = Player:waitForChild("Backpack")
            local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
            local RootPart = Character and Humanoid and Humanoid.RootPart or false
            local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
            if not Humanoid or not RootPart or not RightArm then
                return
            end
            
            local getPlr = function(Name)
                for x in string.gmatch(Name, "[%a%d%p]+") do
                    Name = x:lower()
                    break
                end
                local TPlayer = nil
                for _, x in next, Players:GetPlayers() do
                    if tostring(x):lower():match(Name) or x["DisplayName"]:lower():match(Name) then
                        TPlayer = x
                        break
                    end
                end
                return TPlayer
            end
            
            Humanoid:UnequipTools()
            local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
            if not MainTool or not MainTool:FindFirstChild("Handle") then
                return
            end
            
            local TPlayer = getPlr(Target)
            local TCharacter = TPlayer and TPlayer.Character
            
            local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
            local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
            if not THumanoid or not TRootPart then
                return
            end
            
            Character.Humanoid.Name = "DAttach"
            local l = Character["DAttach"]:Clone()
            l.Parent = Character
            l.Name = "Humanoid"
            wait()
            Character["DAttach"]:Destroy()
            game.Workspace.CurrentCamera.CameraSubject = Character
            Character.Animate.Disabled = true
            wait()
            Character.Animate.Disabled = false
            Character.Humanoid:EquipTool(MainTool)
            wait()
            CF = Player.Character.PrimaryPart.CFrame
            XC = TCharacter.HumanoidRootPart.CFrame.X
            ZC = TCharacter.HumanoidRootPart.CFrame.Z
            if firetouchinterest then
                local flag = false
                task.defer(function()
                    MainTool.Handle.AncestryChanged:wait()
                    flag = true
                end)
                repeat
                    firetouchinterest(MainTool.Handle, TRootPart, 0)
                    firetouchinterest(MainTool.Handle, TRootPart, 1)
                    wait()
                    Player.Character.HumanoidRootPart.CFrame = CFrame.new(XC,10000,ZC)
                until flag
            else
                Player.Character.HumanoidRootPart.CFrame =
                TCharacter.HumanoidRootPart.CFrame
                wait()
                Player.Character.HumanoidRootPart.CFrame =
                TCharacter.HumanoidRootPart.CFrame
                wait()
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(XC,1000,ZC)
                wait()
            end
            wait(.3)
            Player.Character:SetPrimaryPartCFrame(CF)
            if Humanoid.RigType == Enum.HumanoidRigType.R6 then
                Character["Right Arm"].RightGrip:Destroy()
            else
                Character["RightHand"].RightGrip:Destroy()
                Character["RightHand"].RightGripAttachment:Destroy()
            end
                
            wait(4)
            CF = Player.Character.HumanoidRootPart.CFrame
            player.CharacterAdded:wait(1):waitForChild("HumanoidRootPart").CFrame = CF
end)

cmd.add({"localtime", "yourtime"}, {"localtime (yourtime)", "Chats your current time"}, function()
  local hour = os.date("*t")['hour']
        if hour < 10 then
                hour = "0"..hour
        end
        local min = os.date("*t")['min']
        if min < 10 then
                min = "0"..min
        end
        local sec = os.date("*t")['sec']
        if sec < 10 then
                sec = "0"..sec
        end
        local clock = hour..":"..min..":"..sec

                 game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(clock, 'All')

end)

cmd.add({"cartornado", "ctornado"}, {"cartornado (ctornado)", "Tornados a car just sit in the car"}, function(...)
 -- Nameless Admin on mobile
-- Fe Vehicle Fling Alpha

-- Start UP

local notification = Instance.new("Sound")
notification.Parent = game:GetService("SoundService")
notification.SoundId = "rbxassetid://9086208751"
notification.Volume = 1 

local char = game.Players.LocalPlayer.Character
function getRoot(char)
 local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
 return rootPart
end

-- Part Detector Seat

local SPart = Instance.new("Part");
local Player = game:GetService('Players').LocalPlayer;
repeat game:GetService('RunService').RenderStepped:Wait() until Player.Character;
local Character = Player.Character;
SPart.Anchored, SPart.CanCollide = true, true;
SPart.Parent = workspace;
SPart.Size = Vector3.new(1, 100, 1)
SPart.Transparency = 0.4
game:GetService('RunService').Stepped:Connect(function()
    local Ray = Ray.new(Character.PrimaryPart.Position + Character.PrimaryPart.CFrame.LookVector * 6, Vector3.new(0,-1,0) * 4);
    local FPOR = workspace:FindPartOnRayWithIgnoreList(Ray, {Character});
    if (FPOR) then
        SPart.CFrame = Character.PrimaryPart.CFrame + Character.PrimaryPart.CFrame.LookVector * 6;
    end
if SPart == nil then
Ray:destroy()
FPOR:destroy()
end
end)

print("hi")

-- The finish touches
-- Mobile and PC Support BODYGYRO

SPart.Touched:Connect(function(hit)
   if hit:IsA("Seat") then
      local IsFlying = False
local flyv
local flyg
local Player = game.Players.LocalPlayer
local Speed = 50
local LastSpeed = Speed
local maxspeed = 100
local IsRunning = false
local f = 0

IsFlying = true
    flyv = Instance.new("BodyVelocity")
 
   flyv.Parent = Player.Character:FindFirstChild('Torso') or Player.Character:FindFirstChild('UpperTorso')
    flyv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
 
    flyg = Instance.new("BodyGyro")
   flyg.Parent = Player.Character:FindFirstChild('Torso') or Player.Character:FindFirstChild('UpperTorso')
    flyg.MaxTorque = Vector3.new(9e9,9e9,9e9)
    flyg.P = 1000
    flyg.D = 50

Player.Character:WaitForChild('Humanoid').PlatformStand = true

Player.Character.Humanoid.Changed:Connect(function(Prop)
  
   if Player.Character.Humanoid.MoveDirection == Vector3.new(0,0,0) then
    IsRunning = false
   else
    IsRunning = true
   end 
 end)

spawn(function()
  while true do
   wait()
  if IsFlying then
   
    flyg.CFrame = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((f+0)*50*Speed/maxspeed),0,0) 
     flyv.Velocity = workspace.CurrentCamera.CoordinateFrame.LookVector * Speed
     wait(0.1)
     
     if Speed < 0 then
     Speed = 0
     f = 0
end
end
   if IsRunning then
   Speed = LastSpeed
  else
   if not Speed == 0 then
    LastSpeed = Speed
   end 
   Speed = 0
  end
  end
end)
Speed = 0.1
wait(0.3)
hit:Sit(game:GetService("Players").LocalPlayer.Character.Humanoid)
SPart:Destroy()
wait(0.3)
local speaker = game.Players.LocalPlayer
local seat = speaker.Character:FindFirstChildOfClass('Humanoid').SeatPart
 local vehicleModel = seat.Parent
 repeat
  if vehicleModel.ClassName ~= "Model" then
   vehicleModel = vehicleModel.Parent
  end
 until vehicleModel.ClassName == "Model"
 wait(0.1)
 for i,v in pairs(vehicleModel:GetDescendants()) do
  if v:IsA("BasePart") and v.CanCollide then
   v.CanCollide = false
  end
 end

wait(0.2)
Speed = 80
local Spin = Instance.new("BodyAngularVelocity")
Spin.Name = "Spinning"
Spin.Parent = getRoot(speaker.Character)
Spin.MaxTorque = Vector3.new(0, math.huge, 0) 
Spin.AngularVelocity = Vector3.new(0,2000,0)
print("hi")
end
end)
end)


cmd.add({"tornado"}, {"tornado <player>", "Tornados the player to be in the sky"}, function(...)
			   		 
			   		 Username = (...)
 
local target = getPlr(Username)
local THumanoidPart
local plrtorso
local TargetCharacter = target.Character
   if TargetCharacter:FindFirstChild("Torso") then
		   plrtorso = TargetCharacter.Torso
	   elseif TargetCharacter:FindFirstChild("UpperTorso") then
		   plrtorso = TargetCharacter.UpperTorso
	   end
        local old = getChar().HumanoidRootPart.CFrame
        local tool = getBp():FindFirstChildOfClass("Tool") or getChar():FindFirstChildOfClass("Tool")
        if target == nil or tool == nil then return end
        local attWeld = attachTool(tool,CFrame.new(0,0,0))
        attachTool(tool,CFrame.new(0,0,0.2) * CFrame.Angles(math.rad(-90),0,0))
		tool.Grip = plrtorso.CFrame
		wait(0.2)
tool.Grip = CFrame.new(0, -7, -3)
        firetouchinterest(target.Character.Humanoid.RootPart,tool.Handle,0)
        firetouchinterest(target.Character.Humanoid.RootPart,tool.Handle,1)
		local Spin = Instance.new("BodyAngularVelocity")
	Spin.Name = "Spinning"
	Spin.Parent = getRoot(game.Players.LocalPlayer.Character)
	Spin.MaxTorque = Vector3.new(0, math.huge, 0)
	Spin.AngularVelocity = Vector3.new(0,40,0)
end)

cmd.add({"remotespam", "exhaust"}, {"remotespam <number>", "Repeatedly fire all remotes <N> at a time"}, function(n)
	local amt = tonumber(n) or 1
	local events, functions = {}, {}
	local str = ("💖"):rep(120000)
	for i, v in pairs(getinstances and getinstances() or game:GetDescendants()) do
		pcall(function()
			if v.Name:find("%d") == 1 then return end
			if v:IsA("RemoteEvent") then
				table.insert(events, v)
			elseif v:IsA("RemoteFunction") then
				table.insert(functions, v)
			end
		end)
	end
	lib.connect("spam", RunService.Stepped:Connect(function()
		for i = 1, amt do
			spawn(function()
				for _, remote in pairs(events) do
					remote:FireServer(str)
				end
				for _, remote in pairs(functions) do
					remote:InvokeServer(str)
				end
			end)
		end
	end))
end)

cmd.add({"unspam", "unlag", "unchatspam", "unanimlag", "unremotespam"}, {"unspam", "Stop all attempts to lag/spam"}, function()
	lib.disconnect("spam")
end)


cmd.add({"ping", "lag"}, {"ping <ms>", "Set your replication lag to a value"}, function(n)
	local ping = (tonumber(n) or 0)/1000
	settings():GetService("NetworkSettings").IncommingReplicationLag = ping
end)

cmd.add({"respawn", "re"}, {"respawn", "Respawn your character"}, function()
	local old = getChar().HumanoidRootPart.CFrame
	respawn()
	wait()
	plr.CharacterAdded:Wait()
	getChar():WaitForChild("HumanoidRootPart").CFrame = old
end)

cmd.add({"seizure"}, {"seizure", "Gives you a seizure"}, function()
	
    spawn(function()
		local Anim = Instance.new("Animation")
		if game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso") then
		Anim.AnimationId = "rbxassetid://507767968"
		else
			Anim.AnimationId = "rbxassetid://180436148"
			end
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
	 getgenv().ssss = game.Players.LocalPlayer:GetMouse()
	 getgenv().Lzzz = false
	 
	 if Lzzz == false then
	 getgenv().Lzzz = true
		if game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso") then
		Anim.AnimationId = "rbxassetid://507767968"
		else
			Anim.AnimationId = "rbxassetid://180436148"
			end
	 getgenv().currentnormal = game:GetService("Workspace").Gravity
	 game:GetService("Workspace").Gravity = 196.2
	 game:GetService("Players").LocalPlayer.Character:PivotTo(game:GetService("Players").LocalPlayer.Character:GetPivot() * CFrame.Angles(2, 0, 0))
	 wait(0.5)
	 game:GetService("Players").LocalPlayer.Character.Humanoid.PlatformStand = true
	 game.Players.LocalPlayer.Character.Animate.Disabled = true
	 
		k:Play()
		k:AdjustSpeed(10)
		
	 game.Players.LocalPlayer.Character.Animate.Disabled = true
		else
	 getgenv().Lzzz = false
		if game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso") then
		Anim.AnimationId = "rbxassetid://507767968"
		else
			Anim.AnimationId = "rbxassetid://180436148"
			end
	 game:GetService("Workspace").Gravity = currentnormal
	 game:GetService("Players").LocalPlayer.Character.Humanoid.PlatformStand = false
	 game:GetService("Players").LocalPlayer.Character.Humanoid.Jump = true
		k:Stop()
	  
	 game.Players.LocalPlayer.Character.Animate.Disabled = false
	 game:GetService'RunService'.Heartbeat:Wait()
	 for i = 1,10 do
		 
	 game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		wait(0.1)
		end
		 end
	 game:GetService("RunService").RenderStepped:Connect(function()
	 if Lzzz == true then
				 game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(.075*math.sin(45*tick()), .075*math.sin(45*tick()),.075*math.sin(45*tick())) --angle*math.sin(velocity*tick())
	 end
	 end)
	 end)
	 
end)

cmd.add({"unseizure"}, {"unseizure", "Stops you from having a seizure not in real life noob"}, function(n)

    spawn(function()
		local Anim = Instance.new("Animation")
		if game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso") then
		Anim.AnimationId = "rbxassetid://507767968"
		else
			Anim.AnimationId = "rbxassetid://180436148"
			end
		local k = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)
	 getgenv().ssss = game.Players.LocalPlayer:GetMouse()
	 getgenv().Lzzz = true
	 
	 if Lzzz == false then
	 getgenv().Lzzz = true
		if game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso") then
		Anim.AnimationId = "rbxassetid://507767968"
		else
			Anim.AnimationId = "rbxassetid://180436148"
			end
	 getgenv().currentnormal = game:GetService("Workspace").Gravity
	 game:GetService("Workspace").Gravity = 196.2
	 game:GetService("Players").LocalPlayer.Character:PivotTo(game:GetService("Players").LocalPlayer.Character:GetPivot() * CFrame.Angles(2, 0, 0))
	 wait(0.5)
	 game:GetService("Players").LocalPlayer.Character.Humanoid.PlatformStand = true
	 game.Players.LocalPlayer.Character.Animate.Disabled = true
	 
		k:Play()
		k:AdjustSpeed(10)
		
	 game.Players.LocalPlayer.Character.Animate.Disabled = true
		else
	 getgenv().Lzzz = false
		if game.Players.LocalPlayer.Character:FindFirstChild("UpperTorso") then
		Anim.AnimationId = "rbxassetid://507767968"
		else
			Anim.AnimationId = "rbxassetid://180436148"
			end
	 game:GetService("Workspace").Gravity = currentnormal
	 game:GetService("Players").LocalPlayer.Character.Humanoid.PlatformStand = false
	 game:GetService("Players").LocalPlayer.Character.Humanoid.Jump = true
		k:Stop()
	  
	 game.Players.LocalPlayer.Character.Animate.Disabled = false
	 game:GetService'RunService'.Heartbeat:Wait()
	 for i = 1,10 do
		 
	 game.Players.LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		wait(0.1)
		end
		 end
	 game:GetService("RunService").RenderStepped:Connect(function()
	 if Lzzz == true then
				 game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(.075*math.sin(45*tick()), .075*math.sin(45*tick()),.075*math.sin(45*tick())) --angle*math.sin(velocity*tick())
	 end
	 end)
	 end)
	 
end)

cmd.add({"antisit"}, {"antisit", "Antisit"}, function()
			Player.Character.Humanoid:SetStateEnabled("Seated", false)
					Player.Character.Humanoid.Sit = true
					
					
					
					wait();
					
					Notify({
					Description = "Anti sit enabled";
					Title = "Nameless Admin";
					Duration = 5;
					
});
end)

cmd.add({"unantifling"}, {"unantifling", "Disable antifling command"}, function()
			wait();
					
					Notify({
					Description = "Anti fling disabled";
					Title = "Nameless Admin";
					Duration = 5;
					
});
for i, v in pairs(workspace:GetDescendants()) do
                if v:IsA("NoCollisionConstraint") then
                    v:Destroy()
                end
            end
end)

cmd.add({"unantisit"}, {"unantisit", "Disable antisit command"}, function()
		Player.Character.Humanoid:SetStateEnabled("Seated", true)
					Player.Character.Humanoid.Sit = false
					
					
					
					wait();
					
					Notify({
					Description = "Anti sit disabled";
					Title = "Nameless Admin";
					Duration = 5;
					
});
end)

cmd.add({"sit"}, {"sit", "Sit your player"}, function()
	local hum = character:FindFirstChildWhichIsA("Humanoid")
	if hum then
		hum.Sit = true
	end
end)

cmd.add({"spin"}, {"spin", "Spin yourself at the speed you want"}, function(d)
	local spinSpeed = tonumber(d)
	if d and isNumber(d) then
		spinSpeed = (d)
	end
	for i,v in pairs(getRoot(game.Players.LocalPlayer.Character):GetChildren()) do
		if v.Name == "Spinning" then
			v:Destroy()
		end
	end
	local Spin = Instance.new("BodyAngularVelocity")
	Spin.Name = "Spinning"
	Spin.Parent = getRoot(speaker.Character)
	Spin.MaxTorque = Vector3.new(0, math.huge, 0)
	Spin.AngularVelocity = Vector3.new(0,spinSpeed,0)
end)

cmd.add({"oldroblox"}, {"oldroblox", "Old skybox and studs"}, function()
	for i,v in pairs(workspace:GetDescendants()) do
		if v:IsA("BasePart") then
			local dec = Instance.new("Texture", v)
			dec.Texture = "rbxassetid://48715260"
			dec.Face = "Top"
			dec.StudsPerTileU = "1"
			dec.StudsPerTileV = "1"
			dec.Transparency = v.Transparency
			v.Material = "Plastic"
			local dec2 = Instance.new("Texture", v)
			dec2.Texture = "rbxassetid://20299774"
			dec2.Face = "Bottom"
			dec2.StudsPerTileU = "1"
			dec2.StudsPerTileV = "1"
			dec2.Transparency = v.Transparency
			v.Material = "Plastic"
		end
	end
	game.Lighting.ClockTime = 12
	game.Lighting.GlobalShadows = false
	game.Lighting.Outlines = false
	for i,v in pairs(game.Lighting:GetDescendants()) do
		if v:IsA("Sky") then
			v:Destroy()
		end
	end
	local sky = Instance.new("Sky", game.Lighting)
	sky.SkyboxBk = "rbxassetid://161781263"
	sky.SkyboxDn = "rbxassetid://161781258"
	sky.SkyboxFt = "rbxassetid://161781261"
	sky.SkyboxLf = "rbxassetid://161781267"
	sky.SkyboxRt = "rbxassetid://161781268"
	sky.SkyboxUp = "rbxassetid://161781260"
end)

cmd.add({"f3x", "fex"}, {"f3x", "F3X for client"}, function()
	loadstring(game:GetObjects("rbxassetid://6695644299")[1].Source)()
end)

cmd.add({"dupetools"}, {"dupetools [amount]", "Probably the fastest tool duping method"}, function(...)
_G.ammount = (...)
for i=1,_G.ammount do
loadstring(game:HttpGet("https://raw.githubusercontent.com/joshclark756/joshclark756-s-scripts/main/dupetools.lua",true))()
end
end)

		cmd.add({"harked"}, {"harked", "Harked Reborn"}, function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/qipurblx/Scripts/main/harked"))();
			end)

			cmd.add({"triggerbot", "tbot"}, {"triggerbot (tbot)", "Executes a script that automatically clicks the mouse when the mouse is on a player"}, function()
local ToggleKey = Enum.KeyCode.Q


local Player = game:GetService("Players").LocalPlayer
local Char = Player.Character or player.CharacterAdded:wait(1)
local Root = Char.HumanoidRootPart or Char:WaitForChild("HumanoidRootPart")
local Camera = game.Workspace.CurrentCamera
local Mouse = Player:GetMouse()
local PlayerTeam = Player.Team
local Neutral = Player.Neutral
local UIS = game:GetService("UserInputService")
local Toggled = false

---==GUI==---
local GUI = Instance.new("ScreenGui")
local On = Instance.new("TextLabel")
local uicorner = Instance.new("UICorner")
GUI.Name = "GUI"
GUI.Parent = game.CoreGui --game.Players.LocalPlayer:WaitForChild("PlayerGui")
On.Name = "On"
On.Parent = GUI
On.BackgroundColor3 = Color3.fromRGB(12, 4, 20)
On.BackgroundTransparency = 0.14
On.BorderSizePixel = 0
On.Position = UDim2.new(0.880059958, 0, 0.328616381, 0)
On.Size = UDim2.new(0, 160, 0, 20)
On.Font = Enum.Font.SourceSans
On.Text = "TriggerBot On: false"
On.TextColor3 = Color3.new(1, 1, 1)
On.TextScaled = true
On.TextSize = 14
On.TextWrapped = true
uicorner.Parent = On
---End Gui--

local FindTeams = function()
	local CC1 = false
	local CC2 = false
	
if PlayerTeam ~= nil and Neutral == false then
		if #game:GetService("Teams"):GetTeams() > 0 then
		CC1 = true
		for i, v in pairs(game:GetService("Teams"):GetTeams()) do
			if #v:GetPlayers() > 0 and v ~= PlayerTeam and CC1 == true then
				CC2 = true
			elseif #v:GetPlayers() <= 0 and CC1 == true then
				return "FFA"
			end
		end
		elseif #game:GetService("Teams"):GetTeams() <= 0 then
			return "FFA"
		end
elseif Neutral == true then
	return "FFA"	
elseif PlayerTeam == nil then
	return "FFA"
end
if CC1 == true and CC2 == true then
	return "TEAMS"
end
end
--{[/| Functions |\]}--

function Click()
	mouse1click()
	--print("Tripped")
end
function CastRay(Mode)
	local RaySPTR = Camera:ScreenPointToRay(Mouse.X, Mouse.Y) --Hence the var name, the magnitude of this is 1.
	local NewRay = Ray.new(RaySPTR.Origin, RaySPTR.Direction * 9999)
	local Target, Position = workspace:FindPartOnRayWithIgnoreList(NewRay, {Char,workspace.CurrentCamera})
	if Target and Position and game:GetService("Players"):GetPlayerFromCharacter(Target.Parent) and Target.Parent.Humanoid.Health > 0 or Target and Position and game:GetService("Players"):GetPlayerFromCharacter(Target.Parent.Parent) and Target.Parent.Parent.Humanoid.Health > 0 then
		local TPlayer = game:GetService("Players"):GetPlayerFromCharacter(Target.Parent) or game:GetService("Players"):GetPlayerFromCharacter(Target.Parent.Parent)
		if TPlayer.Team ~= PlayerTeam and Mode ~= "FFA" and TPlayer ~= Player then
			Click()
		elseif TPlayer.Team == PlayerTeam and TPlayer ~= Player then
			if Mode == "FFA" then
				Click()
			end
		end
	end
end
--End Functions--
UIS.InputBegan:Connect(function(Input)
	if Input.KeyCode == ToggleKey then
		Toggled = not Toggled
		On.Text = "Trigger Bot On: ".. tostring(Toggled)
	end
end)

local PreMode = FindTeams()
local O = false
game:GetService("RunService").Stepped:Connect(function()
		local Mode = FindTeams()
	if O == false then
		O = true
		print(Mode)
	end
	if Mode ~= PreMode then
		PreMode = Mode
		print(Mode)
	end
	if Toggled == true then

	CastRay(Mode)
end
end)

print("BrokenCoding's Trigger Bot V4 Loaded")
spawn(function()
	wait(2)
	Loaded:Destroy()
end)



wait();

Notify({
Description = "Keybind: Q";
Title = "Nameless Admin";
Duration = 5;

});
				end)

			
		cmd.add({"nofog"}, {"nofog", "Removes all fog from the game"}, function()
			local Lighting = game.Lighting
			Lighting.FogEnd = 100000
			for i,v in pairs(Lighting:GetDescendants()) do
				if v:IsA("Atmosphere") then
					v:Destroy()
				end
			end
			end)

			cmd.add({"antiafk", "noafk"}, {"antiafk (noafk)", "Makes you not be kicked for being afk for 20 mins"}, function()
				
				
				
				wait();
				
				Notify({
				Description = "Anti AFK has been enabled";
				Title = "Nameless Admin";
				Duration = 5;
				
});
				ANTIAFK = game.Players.LocalPlayer.Idled:connect(function()
					game:FindService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
					task.wait(1)
					game:FindService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
					end)
				end)
	

				cmd.add({"antiattach", "noattach"}, {"antiattach (noattach)", "Makes you not be able to be attached by using a item"}, function()
					local Tools = {}
					for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
						if v:IsA("Tool") then
							table.insert(Tools,v:GetDebugId())
						end
					end
					for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA("Tool") then
							table.insert(Tools,v:GetDebugId())
						end
					end
					AAttach = game.Players.LocalPlayer.Character.ChildAdded:Connect(function(instance)
						if instance:IsA("Tool") and not table.find(Tools,instance:GetDebugId()) then
							task.wait()
							instance.Parent = nil
						end
						end)
						
						
						
						wait();
						
						Notify({
						Description = "Anti attach enabled";
						Title = "Nameless Admin";
						Duration = 5;
						
});
					end)

					cmd.add({"unantiattach", "unnoattach"}, {"unantiattach (unnoattach)", "Makes you to be able for others to attach you"}, function()
						if AAttach then
							AAttach:Disconnect()
							
							
							
							wait();
							
							Notify({
							Description = "Anti attach disabled";
							Title = "Nameless Admin";
							Duration = 5;
							
});
						else
							
							
							
							wait();
							
							Notify({
							Description = "Anti attach already disabled";
							Title = "Nameless Admin";
							Duration = 5;
							
});
						end
						end)

						cmd.add({"setspawn", "spawnpoint", "ss"}, {"setspawn (spawnpoint, ss)", "Makes your spawn point be in the place where your character is"}, function()
							
							
							
							wait();
							
							Notify({
							Description = "Spawn has been set";
							Title = "Nameless Admin";
							Duration = 5;
							
});
							local stationaryrespawn = true
local needsrespawning = false
local haspos = false
local pos = CFrame.new()

game:GetService("UserInputService").InputBegan:connect(StatRespawn)

game:GetService('RunService').Stepped:connect(function()

if stationaryrespawn == true and game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
if haspos == false then
pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
haspos = true
end

needsrespawning = true
end


if needsrespawning == true then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end


end)

game.Players.LocalPlayer.CharacterAdded:connect(function()
wait(0.6)
needsrespawning = false
haspos = false
end)
							end)

							cmd.add({"ball", "feball"}, {"ball (feball)", "Executes a ball that flings a person when it touches them"}, function()
								_G.specifictoolname = false
								_G.toolname = "BoomBox"
								loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/500%20Pounds%20Converted%20%5B1%20Tool%5D.lua'))()
							end)
							
cmd.add({"hamster"}, {"hamster <speed>", "Hamster ball"}, function(...)
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local SPEED_MULTIPLIER = (...)
local JUMP_POWER = 60
local JUMP_GAP = 0.3

if (...) == nil then
    SPEED_MULTIPLIER = 30
    end

local character = game.Players.LocalPlayer.Character

for i,v in ipairs(character:GetDescendants()) do
   if v:IsA("BasePart") then
       v.CanCollide = false
   end
end

local ball = character.HumanoidRootPart
ball.Shape = Enum.PartType.Ball
ball.Size = Vector3.new(5,5,5)
local humanoid = character:WaitForChild("Humanoid")
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Blacklist
params.FilterDescendantsInstances = {character}

local tc = RunService.RenderStepped:Connect(function(delta)
   ball.CanCollide = true
   humanoid.PlatformStand = true
if UserInputService:GetFocusedTextBox() then return end
if UserInputService:IsKeyDown("W") then
ball.RotVelocity -= Camera.CFrame.RightVector * delta * SPEED_MULTIPLIER
end
if UserInputService:IsKeyDown("A") then
ball.RotVelocity -= Camera.CFrame.LookVector * delta * SPEED_MULTIPLIER
end
if UserInputService:IsKeyDown("S") then
ball.RotVelocity += Camera.CFrame.RightVector * delta * SPEED_MULTIPLIER
end
if UserInputService:IsKeyDown("D") then
ball.RotVelocity += Camera.CFrame.LookVector * delta * SPEED_MULTIPLIER
end
--ball.RotVelocity = ball.RotVelocity - Vector3.new(0,ball.RotVelocity.Y/50,0)
end)

UserInputService.JumpRequest:Connect(function()
local result = workspace:Raycast(
ball.Position,
Vector3.new(
0,
-((ball.Size.Y/2)+JUMP_GAP),
0
),
params
)
if result then
ball.Velocity = ball.Velocity + Vector3.new(0,JUMP_POWER,0)
end
end)

Camera.CameraSubject = ball
humanoid.Died:Connect(function() tc:Disconnect() end)
end)

				cmd.add({"unantiafk", "unnoafk"}, {"unantiafk (unnoafk)", "Makes you able to be kicked for being afk for 20 mins"}, function()
					if ANTIAFK then
						ANTIAFK:Disconnect()
						
						
						
						wait();
						
						Notify({
						Description = "Anti AFK disabled";
						Title = "Nameless Admin";
						Duration = 5;
						
});
					else
						
						
						
						wait();
						
						Notify({
						Description = "Anti AFK already disabled";
						Title = "Nameless Admin";
						Duration = 5;
						
});
					end
					end)

			cmd.add({"toolgui"}, {"toolgui", "cool tool ui aka replication ui made by 0866"}, function()
				loadstring(game:HttpGet("https://pastebin.com/raw/vr2YVyF6"))();
				

wait();

Notify({
Description = "For a better experience, use R6 if you want tools do ;dupetools 5";
Title = "Nameless Admin";
Duration = 5;

});
				end)

				cmd.add({"clicktp"}, {"clicktp", "Teleport where your mouse is"}, function()
					mouse = game.Players.LocalPlayer:GetMouse()
tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Click TP"
tool.Activated:connect(function()
local pos = mouse.Hit+Vector3.new(0,2.5,0)
pos = CFrame.new(pos.X,pos.Y,pos.Z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end)
tool.Parent = game.Players.LocalPlayer.Backpack
wait(0.05)
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Tween Click TP"

local function onActivated()
    local mouse = Players.LocalPlayer:GetMouse()
    local pos = mouse.Hit + Vector3.new(0,2.5,0)
    local humanoidRootPart = Players.LocalPlayer.Character.HumanoidRootPart

    local tweenInfo = TweenInfo.new(
        1, -- duration
        Enum.EasingStyle.Quad, -- easing style
        Enum.EasingDirection.Out, -- easing direction
        0, -- repeat count (0 = no repeat)
        false, -- reverses the tween if true
        0 -- delay between repeats
    )

    local tween = TweenService:Create(humanoidRootPart, tweenInfo, {
        CFrame = CFrame.new(pos.X, pos.Y, pos.Z)
    })

    tween:Play()
end

tool.Activated:Connect(onActivated)
tool.Parent = Players.LocalPlayer.Backpack
					end)

			cmd.add({"dex"}, {"dex", "Using this you can see the parts / guis / scripts etc with this. A really good and helpful script."}, function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/awesome-explorer/main/source.lua"))()
			end)
		
			cmd.add({"antikill"}, {"antikill", "Makes exploiters not be able to kill you"}, function()
					Player.Character.Humanoid:SetStateEnabled("Seated", false)
					Player.Character.Humanoid.Sit = true
					
					
					
					wait();
					
					Notify({
					Description = "Anti kill enabled";
					Title = "Nameless Admin";
					Duration = 5;
					
});
			end)
			
cmd.add({"gayrate"}, {"gayrate <player>", "Gay scale of a player"}, function(...)
Username = (...)
target = getPlr(Username)
    local coolPercentage = math.random(1, 100)
    rate = target.Name .. ' is ' .. coolPercentage .. '% gay'
     game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(rate, 'All')
end)

cmd.add({"coolrate"}, {"coolrate <player>", "Cool scale of a player"}, function(...)
Username = (...)
target = getPlr(Username)
    local coolPercentage = math.random(1, 100)
    rate = target.Name .. ' is ' .. coolPercentage .. '% cool'
     game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(rate, 'All')
end)

			cmd.add({"unantikill"}, {"unantikill", "Makes exploiters to be able to kill you"}, function()
				Player.Character.Humanoid:SetStateEnabled("Seated", true)
				Player.Character.Humanoid.Sit = false
				
				
				
				wait();
				
				Notify({
				Description = "Anti kill disabled";
				Title = "Nameless Admin";
				Duration = 5;
				
});
		end)


			cmd.add({"antifling"}, {"antifling", "makes it so you cant collide with others"}, function()
	wait();
				
				Notify({
				Description = "Anti fling enabled";
				Title = "Nameless Admin";
				Duration = 5;
				
});
Player = game.Players.LocalPlayer
local Players = game:GetService("Players")
            plrs = Players
            function nocollision(prt, plr)
                for i, v in pairs(plr:GetDescendants()) do
                    if v:IsA("BasePart") then
                        e = Instance.new("NoCollisionConstraint", v)
                        e.Part0 = v
                        e.Part1 = prt
                    end
                end
            end
            for i, yes in pairs(Player.Character:GetDescendants()) do
                if yes:IsA("BasePart") then
                    if yes:IsA("BasePart") then
                        for i, v in pairs(plrs:GetDescendants()) do
                            if v:IsA("Player") then
                                nocollision(yes, v.Character)
                            end
                        end
                    end
                end
            end
			end)

			cmd.add({"table"}, {"table", "Turns you into a table"}, function()
				loadstring(game:HttpGet(('https://pastebin.com/raw/UmdYd4bE'),true))()
				local plr = game.Players.LocalPlayer
				game:GetService("RunService").Stepped:Connect(function()
				   setsimulationradius(9e9,9e9)
				   plr.ReplicationFocus = workspace
				   settings().Physics.AllowSleep = false
				end)
				local runservice=game:service"RunService";
				local player=game:service"Players"["LocalPlayer"];
				local character=player["Character"];
				character["Head"]:FindFirstChildOfClass"SpecialMesh":Destroy();
				
				character["Humanoid"].HipHeight=-2;
				character["Left Leg"]:BreakJoints();
				character["Right Leg"]:BreakJoints();
				character["Left Arm"]:BreakJoints();
				character["Right Arm"]:BreakJoints();
				while runservice["Heartbeat"]:Wait() do
					character["Left Leg"].CFrame=character["HumanoidRootPart"].CFrame*CFrame.new(-0.5,1.5,1.5) * CFrame.Angles(math.rad(90), 0, 0);
					character["Right Leg"].CFrame=character["HumanoidRootPart"].CFrame*CFrame.new(0.5,1.5,1.5) * CFrame.Angles(math.rad(90), 0, 0);
					character["Left Arm"].CFrame=character["HumanoidRootPart"].CFrame*CFrame.new(-0.5,0,2);
					character["Right Arm"].CFrame=character["HumanoidRootPart"].CFrame*CFrame.new(0.5,0,2);
				end	
			end)

			cmd.add({"gravitygun"}, {"gravitygun", "Probably the best gravity gun script thats fe"}, function()
				loadstring(game:HttpGet("https://raw.githubusercontent.com/qipurblx/Script/main/Gravity%20Gun"))()
			end)

cmd.add({"controlnpcs", "cnpcs"}, {"controlnpcs (cnpcs)", "Keybind: CTRL + LEFTCLICK"}, function()
	


wait();

Notify({
Description = "ControlNPCs executed, CTRL + Click on an NPC";
Title = "Nameless Admin";
Duration = 5;

});
    --- made by joshclark756#7155
-- Variables
local mouse = game.Players.LocalPlayer:GetMouse()
local uis = game:GetService("UserInputService")

-- Connect
mouse.Button1Down:Connect(function()
   -- Check for Target & Left Shift
   if mouse.Target and uis:IsKeyDown(Enum.KeyCode.LeftControl) then
local npc = mouse.target.Parent
local npcRootPart = npc.HumanoidRootPart
local PlayerCharacter = game:GetService("Players").LocalPlayer.Character
local PlayerRootPart = PlayerCharacter.HumanoidRootPart
local A0 = Instance.new("Attachment")
local AP = Instance.new("AlignPosition")
local AO = Instance.new("AlignOrientation")
local A1 = Instance.new("Attachment")
for _, v in pairs(npc:GetDescendants()) do
if v:IsA("BasePart") then
game:GetService("RunService").Stepped:Connect(function()
v.CanCollide = false
end)
end
end
PlayerRootPart:BreakJoints()
for _, v in pairs(PlayerCharacter:GetDescendants()) do
if v:IsA("BasePart") then
if v.Name == "HumanoidRootPart" or v.Name == "UpperTorso" or v.Name == "Head" then
else
v:Destroy()
end
end
end
PlayerRootPart.Position = PlayerRootPart.Position+Vector3.new(5, 0, 0)
PlayerCharacter.Head.Anchored = true
PlayerCharacter.UpperTorso.Anchored = true
A0.Parent = npcRootPart
AP.Parent = npcRootPart
AO.Parent = npcRootPart
AP.Responsiveness = 200
AP.MaxForce = math.huge
AO.MaxTorque = math.huge
AO.Responsiveness = 200
AP.Attachment0 = A0
AP.Attachment1 = A1
AO.Attachment1 = A1
AO.Attachment0 = A0
A1.Parent = PlayerRootPart
end
end)
    end)

cmd.add({"attachpart"}, {"attachpart", "Keybind: CTRL + LEFTCLICK"}, function()
	


wait();

Notify({
Description = "AttachPart executed, CTRL + Click on a part";
Title = "Nameless Admin";
Duration = 5;

});
    -- made by joshclark756#7155
-- Variables
local mouse = game.Players.LocalPlayer:GetMouse()
local uis = game:GetService("UserInputService")

-- Connect
mouse.Button1Down:Connect(function()
   -- Check for Target & Left Shift
   if mouse.Target and uis:IsKeyDown(Enum.KeyCode.LeftControl) then
local npc = mouse.target
local npcparts = mouse.target.Parent
local PlayerCharacter = game:GetService("Players").LocalPlayer.Character
local PlayerRootPart = PlayerCharacter.HumanoidRootPart
local A0 = Instance.new("Attachment")
local AP = Instance.new("AlignPosition")
local AO = Instance.new("AlignOrientation")
local A1 = Instance.new("Attachment")
for _, v in pairs(npcparts:GetDescendants()) do
if v:IsA("BasePart") or v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
do
v.CanCollide = false

end
end
end
-- Variables
local mouse = game.Players.LocalPlayer:GetMouse()
local uis = game:GetService("UserInputService")

-- Connect
mouse.Button1Down:Connect(function()
   if mouse.Target and uis:IsKeyDown(Enum.KeyCode.LeftControl) then
local npc = mouse.target
local npcparts = mouse.target.Parent
local PlayerCharacter = game:GetService("Players").LocalPlayer.Character
local PlayerRootPart = PlayerCharacter.HumanoidRootPart
local A0 = Instance.new("Attachment")
local AP = Instance.new("AlignPosition")
local AO = Instance.new("AlignOrientation")
local A1 = Instance.new("Attachment")
for _, v in pairs(npcparts:GetDescendants()) do
if v:IsA("BasePart") or v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
do
v.CanCollide = false

wait(0)
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
bind = "e" -- has to be lowercase
mouse.KeyDown:connect(function(key)
if key == bind then do
v.CanCollide = true
end
end
end)
end
end
end
for _, v in pairs(PlayerCharacter:GetDescendants()) do
if v:IsA("BasePart") then
if v.Name == "HumanoidRootPart" or v.Name == "UpperTorso" or v.Name == "Head" then

end
end
end
PlayerRootPart.Position = PlayerRootPart.Position+Vector3.new(0, 0, 0)
PlayerCharacter.Head.Anchored = false
PlayerCharacter.Torso.Anchored = false
A0.Parent = npc
AP.Parent = npc
AO.Parent = npc
AP.Responsiveness = 200
AP.MaxForce = math.huge
AO.MaxTorque = math.huge
AO.Responsiveness = 200
AP.Attachment0 = A0
AP.Attachment1 = A1
AO.Attachment1 = A1
AO.Attachment0 = A0
A1.Parent = PlayerRootPart
end
end)
for _, v in pairs(PlayerCharacter:GetDescendants()) do
if v:IsA("BasePart") then
if v.Name == "HumanoidRootPart" or v.Name == "UpperTorso" or v.Name == "Head" then

end
end
end
PlayerRootPart.Position = PlayerRootPart.Position+Vector3.new(0, 0, 0)
PlayerCharacter.Head.Anchored = false
PlayerCharacter.Torso.Anchored = false
A0.Parent = npc
AP.Parent = npc
AO.Parent = npc
AP.Responsiveness = 200
AP.MaxForce = math.huge
AO.MaxTorque = math.huge
AO.Responsiveness = 200
AP.Attachment0 = A0
AP.Attachment1 = A1
AO.Attachment1 = A1
AO.Attachment0 = A0
A1.Parent = PlayerRootPart
end
end)
    end)

	cmd.add({"esp"}, {"esp", "ESP"}, function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local roles

-- > Functions <--

function CreateHighlight() -- make any new highlights for new players
	for i, v in pairs(Players:GetChildren()) do
		if v ~= LP and v.Character and not v.Character:FindFirstChild("Highlight") then
			Instance.new("Highlight", v.Character)           
		end
	end
end

function UpdateHighlights() -- Get Current Role Colors (messy)
	for _, v in pairs(Players:GetChildren()) do
		if v ~= LP and v.Character and v.Character:FindFirstChild("Highlight") then
			Highlight = v.Character:FindFirstChild("Highlight")
				Highlight.FillColor = Color3.fromRGB(0, 225, 0)
			end
		end
	end

function IsAlive(Player) -- Simple sexy function
	for i, v in pairs(roles) do
		if Player.Name == i then
			if not v.Killed and not v.Dead then
				return true
			else
				return false
			end
		end
	end
end


CreateHighlight()
	UpdateHighlights()
	end)

		cmd.add({"unesp"}, {"unesp", "Disables esp"}, function()
	-- Find all existing players and remove the Highlight instance from their characters
for _, player in ipairs(game.Players:GetPlayers()) do
    local character = player.Character
    if character then
        local highlight = character:FindFirstChild("Highlight")
        if highlight then
            highlight:Destroy()
        end
    end
end

-- Remove the Highlight instance from any new players that join the game
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local highlight = character:FindFirstChild("Highlight")
        if highlight then
            highlight:Destroy()
        end
    end)
end)
		end)

	cmd.add({"creep", "ctp", "scare"}, {"ctp <player> (creep, scare)", "Teleports from a player behind them and under the floor to the top"}, function(...)
		Players = game:GetService("Players")
		HRP = game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored
		
		Username = (...)
		
		local target = getPlr(Username)
		
			getChar().HumanoidRootPart.CFrame = target.Character.Humanoid.RootPart.CFrame * CFrame.new(0, -10, 4)
			wait()
			if connections["noclip"] then lib.disconnect("noclip") return end
			lib.connect("noclip", RunService.Stepped:Connect(function()
				if not character then return end
				for i, v in pairs(character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.CanCollide = false
					end
				end
			end))
			wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
			wait()
							 tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(1000, Enum.EasingStyle.Linear)
					 
				tween = tweenService:Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(0, 10000, 0)})
				tween:Play()
				wait(1.5)
				tween:Pause()
				game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
				wait()
				lib.disconnect("noclip")
				
	end)
    cmd.add({"netless", "net"}, {"netless (net)", "Executes netless which makes scripts more stable"}, function()
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
    if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
    game:GetService("RunService").Heartbeat:connect(function()
    v.Velocity = Vector3.new(-30,0,0)
    end)
    end
    end

	


wait();

Notify({
Description = "Netless has been activated, re-run this script if you die";
Title = "Nameless Admin";
Duration = 5;

});
end)

cmd.add({"rocket"}, {"rocket <player>", "rockets a player"}, function(...)
	


wait();

Notify({
Description = "Get ready to launch...";
Title = "Nameless Admin";
Duration = 5;

});
wait(0.5)
			   		   local OldPos = getRoot().CFrame
	tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(70, Enum.EasingStyle.Linear)
			 
	tween = tweenService:Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(0, 10000, 0)})
	tween:Play()
	Username = (...)

	Target = (...)
	local TPlayer = getPlr(Target)
			   TRootPart = TPlayer.Character.HumanoidRootPart
			   local Character = Player.Character
			   local PlayerGui = Player:WaitForChild("PlayerGui")
			   local Backpack = Player:WaitForChild("Backpack")
			   local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
			   local RootPart = Character and Humanoid and Humanoid.RootPart or false
			   local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
			   if not Humanoid or not RootPart or not RightArm then
				   return
			   end
			   Humanoid:UnequipTools()
			   local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
			   if not MainTool or not MainTool:FindFirstChild("Handle") then
				   return
			   end
			   Humanoid.Name = "DAttach"
			   local l = Character["DAttach"]:Clone()
			   l.Parent = Character
			   l.Name = "Humanoid"
			   wait()
			   Character["DAttach"]:Destroy()
			   game.Workspace.CurrentCamera.CameraSubject = Character
			   Character.Animate.Disabled = true
			   wait()
			   Character.Animate.Disabled = false
			   Character.Humanoid:EquipTool(MainTool)
			   wait()
			   CF = Player.Character.PrimaryPart.CFrame
			   if firetouchinterest then
				   local flag = false
				   task.defer(function()
					   MainTool.Handle.AncestryChanged:wait()
					   flag = true
				   end)
				   repeat
					   firetouchinterest(MainTool.Handle, TRootPart, 0)
					   firetouchinterest(MainTool.Handle, TRootPart, 1)
					   wait()
				   until flag
			   else
				   Player.Character.HumanoidRootPart.CFrame =
				   TCharacter.HumanoidRootPart.CFrame
				   wait()
				   Player.Character.HumanoidRootPart.CFrame =
				   TCharacter.HumanoidRootPart.CFrame
				   wait()
			   end
			    CF = Player.Character.HumanoidRootPart.CFrame
            player.CharacterAdded:wait(1):waitForChild("HumanoidRootPart").CFrame = CF
end)

    cmd.add({"kidnap"}, {"kidnap <player>", "Kidnaps a player"}, function(...)
Username = (...)
	Target = getPlr(Username)
	   
		local currentCFrame = Target.Character.Head.CFrame
	
	  
	  local offset = Vector3.new(0, 0, -50)
	  local newPosition = currentCFrame.p + offset
	  local newCFrame = CFrame.new(newPosition, currentCFrame.lookVector)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = newCFrame
		wait(1)
	  local player = game.Players.LocalPlayer
	
	local targetPlayer = Target
	
	local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	-- create the teleport tween
	local teleportTween = game:GetService("TweenService"):Create(player.Character.HumanoidRootPart, tweenInfo, {
	  CFrame = CFrame.new()
	})
	
	-- start the teleport tween to the current target player
	function startTeleportTween()
	  if targetPlayer then
		teleportTween:Cancel()
		teleportTween = game:GetService("TweenService"):Create(player.Character.HumanoidRootPart, tweenInfo, {
		  CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
		})
		teleportTween:Play()
	  end
	end
	
		startTeleportTween()
	 wait(2)
		 local TPlayer = Target
				   TRootPart = TPlayer.Character.HumanoidRootPart
				   local Character = Player.Character
				   local PlayerGui = Player:WaitForChild("PlayerGui")
				   local Backpack = Player:WaitForChild("Backpack")
				   local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
				   local RootPart = Character and Humanoid and Humanoid.RootPart or false
				   local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
				   if not Humanoid or not RootPart or not RightArm then
					   return
				   end
				   Humanoid:UnequipTools()
				   local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
				   if not MainTool or not MainTool:FindFirstChild("Handle") then
					   return
				   end
				   Humanoid.Name = "DAttach"
				   local l = Character["DAttach"]:Clone()
				   l.Parent = Character
				   l.Name = "Humanoid"
				   wait()
				   Character["DAttach"]:Destroy()
				   game.Workspace.CurrentCamera.CameraSubject = Character
				   Character.Animate.Disabled = true
				   wait()
				   Character.Animate.Disabled = false
				   Character.Humanoid:EquipTool(MainTool)
				   wait()
				   CF = Player.Character.PrimaryPart.CFrame
				   if firetouchinterest then
					   local flag = false
					   task.defer(function()
						   MainTool.Handle.AncestryChanged:wait()
						   flag = true
					   end)
					   repeat
						   firetouchinterest(MainTool.Handle, TRootPart, 0)
						   firetouchinterest(MainTool.Handle, TRootPart, 1)
						   wait()
					   until flag
				   else
					   Player.Character.HumanoidRootPart.CFrame =
					   TCharacter.HumanoidRootPart.CFrame
					   wait()
					   Player.Character.HumanoidRootPart.CFrame =
					   TCharacter.HumanoidRootPart.CFrame
					   wait()
				   end
				   wait(0.7)
	local targetPosition = player.Character.HumanoidRootPart.Position + Vector3.new(0, 0, 1000)
	
	local tweenInfo = TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	local teleportTween = game:GetService("TweenService"):Create(player.Character.HumanoidRootPart, tweenInfo, {
	  CFrame = CFrame.new(targetPosition)
	})
	
		teleportTween:Play()	
end)

    cmd.add({"quicksand"}, {"quicksand <player>", "Quicksands a player"}, function(...)
wait();

Notify({
Description = "Kidnapping... next time take a van, or not";
Title = "Nameless Admin";
Duration = 5;

});
			   		   local OldPos = getRoot().CFrame
wait()
		tweenService, tweenInfo = game:GetService("TweenService"), TweenInfo.new(160, Enum.EasingStyle.Linear)
			 
		tween = tweenService:Create(game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(0, -1000, 0)})
		tween:Play()
		wait()
		Username = (...)

		Target = (...)
		local TPlayer = getPlr(Target)
				   TRootPart = TPlayer.Character.HumanoidRootPart
				   local Character = Player.Character
				   local PlayerGui = Player:WaitForChild("PlayerGui")
				   local Backpack = Player:WaitForChild("Backpack")
				   local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
				   local RootPart = Character and Humanoid and Humanoid.RootPart or false
				   local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
				   if not Humanoid or not RootPart or not RightArm then
					   return
				   end
				   Humanoid:UnequipTools()
				   local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
				   if not MainTool or not MainTool:FindFirstChild("Handle") then
					   return
				   end
				   Humanoid.Name = "DAttach"
				   local l = Character["DAttach"]:Clone()
				   l.Parent = Character
				   l.Name = "Humanoid"
				   wait()
				   Character["DAttach"]:Destroy()
				   game.Workspace.CurrentCamera.CameraSubject = Character
				   Character.Animate.Disabled = true
				   wait()
				   Character.Animate.Disabled = false
				   Character.Humanoid:EquipTool(MainTool)
				   wait()
				   CF = Player.Character.PrimaryPart.CFrame
				   if firetouchinterest then
					   local flag = false
					   task.defer(function()
						   MainTool.Handle.AncestryChanged:wait()
						   flag = true
					   end)
					   repeat
						   firetouchinterest(MainTool.Handle, TRootPart, 0)
						   firetouchinterest(MainTool.Handle, TRootPart, 1)
						   wait()
					   until flag
				   else
					   Player.Character.HumanoidRootPart.CFrame =
					   TCharacter.HumanoidRootPart.CFrame
					   wait()
					   Player.Character.HumanoidRootPart.CFrame =
					   TCharacter.HumanoidRootPart.CFrame
					   wait()
				   end
    CF = Player.Character.HumanoidRootPart.CFrame
            player.CharacterAdded:wait(1):waitForChild("HumanoidRootPart").CFrame = CF
   end)



cmd.add({"hatsleash", "hl"}, {"hatsleash", "Makes you be able to carry your hats"}, function()
	for _, v in pairs(game.Players.LocalPlayer.Character:getChildren()) do
        if v.ClassName == "Accessory" then
         for i, k in pairs(v:GetDescendants()) do
          if k.ClassName == "Attachment" then
           s = Instance.new("RopeConstraint")
           k.Parent.CanCollide = true
           s.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
           s.Attachment1 = k
           s.Attachment0 = game.Players.LocalPlayer.Character.Head.FaceCenterAttachment
           s.Visible = true
           s.Length = 10
           v.Handle.AccessoryWeld:Destroy()
          end
         end
        end
       end
end)

cmd.add({"toolleash", "tl"}, {"toolleash", "Makes you be able to carry your tools"}, function()
	for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        v.Parent = game.Players.LocalPlayer.Character
    end
    
    for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v.ClassName == "Tool" then
    x = Instance.new("Attachment")
    s = Instance.new("RopeConstraint")
    v.Handle.CanCollide = true
    x.Parent = v.Handle
    s.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
    s.Attachment1 = game.Players.LocalPlayer.Character["Right Arm"].RightGripAttachment
    s.Attachment0 = v.Handle.Attachment
    s.Length = 100
    s.Visible = true
    wait()
    end
    end
    
    for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v.Name == "RightGrip" then
            v:Destroy()
        end
    end
    
    while wait() do
        for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v.ClassName == "Tool" then
                v.Handle.Velocity = Vector3.new(math.random(-100, 100), 5, math.random(-100, 100))
            end
        end
    end
end)

cmd.add({"control"}, {"control <player>", "Control a player"}, function(...)
Target = (...)
Control = true

repeat wait()
	local TPlayer = getPlr(Target)
			   TRootPart = TPlayer.Character.HumanoidRootPart
			   local Character = Player.Character
			   local PlayerGui = Player:WaitForChild("PlayerGui")
			   local Backpack = Player:WaitForChild("Backpack")
			   local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
			   local RootPart = Character and Humanoid and Humanoid.RootPart or false
			   local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
			   if not Humanoid or not RootPart or not RightArm then
				   return
			   end
			   Humanoid:UnequipTools()
			   local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
			   if not MainTool or not MainTool:FindFirstChild("Handle") then
				   return
			   end
			   Humanoid.Name = "DAttach"
			   local l = Character["DAttach"]:Clone()
			   l.Parent = Character
			   l.Name = "Humanoid"
			   wait()
			   Character["DAttach"]:Destroy()
			   game.Workspace.CurrentCamera.CameraSubject = Character
			   Character.Animate.Disabled = true
			   wait()
			   Character.Animate.Disabled = false
			   Character.Humanoid:EquipTool(MainTool)
			   wait()
			   CF = Player.Character.PrimaryPart.CFrame
			   if firetouchinterest then
				   local flag = false
				   task.defer(function()
					   MainTool.Handle.AncestryChanged:wait()
					   flag = true
				   end)
				   repeat
					   firetouchinterest(MainTool.Handle, TRootPart, 0)
					   firetouchinterest(MainTool.Handle, TRootPart, 1)
					   wait()
				   until flag
			   else
				   Player.Character.HumanoidRootPart.CFrame =
				   TCharacter.HumanoidRootPart.CFrame
				   wait()
				   Player.Character.HumanoidRootPart.CFrame =
				   TCharacter.HumanoidRootPart.CFrame
				   wait()
			   end
			   player.CharacterAdded:wait(1)
			   wait(0.2)
getRoot().CFrame= getPlr(Target).Character.Head.CFrame
wait(0.05)
until Control == false
end)

cmd.add({"uncontrol"}, {"uncontrol", "Uncontrol a player"}, function()
Control = false
end)

cmd.add({"reset"}, {"reset", "Makes your health be 0"}, function()
	game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)

cmd.add({"admin"}, {"admin", "sends the admin name in chat"}, function()
     game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer('Nameless Admin | .gg/mW442YxE4j', 'All')
end)

cmd.add({"2016"}, {"2016", "2016 CORE GUI"}, function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/FE/main/2016MODE"))()
end)

cmd.add({"removedn", "nodn", "nodpn"}, {"removedn (nodn, nodpn)", "Removes all display names"}, function()
	


wait();

Notify({
Description = "Display names successfully removed";
Title = "Nameless Admin";
Duration = 5;

});
	local Players = game:FindService("Players")

require(game:GetService("Chat"):WaitForChild("ClientChatModules").ChatSettings).PlayerDisplayNamesEnabled = false

local function rename(character,name)
    repeat task.wait() until character:FindFirstChildWhichIsA("Humanoid")
    character:FindFirstChildWhichIsA("Humanoid").DisplayName = name
end

for i,v in next, Players:GetPlayers() do
    if v.Character then
        v.DisplayName = v.Name
        rename(v.Character,v.Name)
    end
    v.CharacterAdded:Connect(function(char)
        rename(char,v.Name)
    end)
end

Players.PlayerAdded:Connect(function(plr)
    plr.DisplayName = plr.Name
    plr.CharacterAdded:Connect(function(char)
        rename(char,plr.Name)
    end)
end)
end)

cmd.add({"anticlientkick", "antickick"}, {"anticlientkick (antickick)", "Makes scripts harder to kick you still possible"}, function()
--// Cache

local getgenv, getnamecallmethod, hookmetamethod, newcclosure, checkcaller, stringlower = getgenv, getnamecallmethod, hookmetamethod, newcclosure, checkcaller, string.lower

--// Loaded check

if getgenv().ED_AntiKick then return end

--// Variables

local Players, StarterGui, OldNamecall = game:GetService("Players"), game:GetService("StarterGui")

--// Global Variables

getgenv().ED_AntiKick = {
	SendNotifications = true,
	CheckCaller = false 
}

--// Main

OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
	if (getgenv().ED_AntiKick.CheckCaller and not checkcaller() or true) and stringlower(getnamecallmethod()) == "kick" then
		if getgenv().ED_AntiKick.SendNotifications then
			StarterGui:SetCore("SendNotification", {
				Title = "Nameless Admin",
				Text = "The script has successfully intercepted an attempted kick.",
				Icon = "rbxassetid://6238540373",
				Duration = 2,
			})
		end

		return nil
	end

	return OldNamecall(...)
end))

if getgenv().ED_AntiKick.SendNotifications then
	


wait();

Notify({
Description = "Anti kick executed";
Title = "Nameless Admin";
Duration = 5;

});
end
end)

cmd.add({"mousefling", "flingtool"}, {"flingtool (mousefling)", "Mouse fling, gives a tool"}, function()
	loadstring(game:HttpGet(('https://pastefy.ga/xBdd9GId/raw'),true))()
end)


cmd.add({"backdoorscan", "backdoor"}, {"backdoorscan (backdoor)", "Scans for any backdoors using FraktureSS"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Backdoor scanning...";
	Title = "Nameless Admin";
	Duration = 5;
	
});
	loadstring(game:HttpGet("https://raw.githubusercontent.com/L1ghtingBolt/FraktureSS/master/unobfuscated.lua"))()
end)

cmd.add({"jobid"}, {"jobid", "Copies your job id"}, function()
	local jobId = 'Roblox.GameLauncher.joinGameInstance('..PlaceId..', "'..JobId..'")'
	setclipboard(jobId)
	wait();

Notify({
Description = "Copied your jobid (" .. jobId .. ")";
Title = "Nameless Admin";
Duration = 5;

});
end)

cmd.add({"joinjobid", "jjobid"}, {"joinjobid <jobid> (jjid)", "Joins the job id you put in"}, function(id)
TeleportService:TeleportToPlaceInstance(game.PlaceId,id)
end)

cmd.add({"serverhop", "shop"}, {"serverhop (shop)", "Serverhop"}, function()
	rejoining = true
	if syn.queue_on_teleport then
		syn.queue_on_teleport('game:GetService("ReplicatedFirst"):RemoveDefaultLoadingScreen()')
	end
	


wait();

Notify({
Description = "Searching";
Title = "Nameless Admin";
Duration = 5;

});
local Decision = fast
	local GUIDs = {}
	local maxPlayers = 0
	local pagesToSearch = 100
	if Decision == "fast" then pagesToSearch = 5 end
	local Http = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100&cursor="))
	for i = 1,pagesToSearch do
		for i,v in pairs(Http.data) do
			if v.playing ~= v.maxPlayers and v.id ~= game.JobId then
				maxPlayers = v.maxPlayers
				table.insert(GUIDs, {id = v.id, users = v.playing})
			end
		end
		


wait();

Notify({
Description = "Searched, please wait while we are teleporting you";
Title = "Nameless Admin";
Duration = 5;

});
		if Http.nextPageCursor ~= null then Http = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100&cursor="..Http.nextPageCursor)) else break end
	end
	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, GUIDs[math.random(1,#GUIDs)].id, cmdlp)
end)

cmd.add({"functionspy"}, {"functionspy", "Check console"}, function()
	local toLog = {
		debug.getconstants;
		getconstants;
		debug.getconstant;
		getconstant;
		debug.setconstant;
		setconstant;
		debug.getupvalues;
		debug.getupvalue;
		getupvalues;
		getupvalue;
		debug.setupvalue;
		setupvalue;
		getsenv;
		getreg;
		getgc;
		getconnections;
		firesignal;
		fireclickdetector;
		fireproximityprompt;
		firetouchinterest;
		gethiddenproperty;
		sethiddenproperty;
		hookmetamethod;
		setnamecallmethod;
		getrawmetatable;
		setrawmetatable;
		setreadonly;
		isreadonly;
		debug.setmetatable;
	}
	
	local FunctionSpy = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local LeftPanel = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local example = Instance.new("TextButton")
	local name = Instance.new("TextLabel")
	local UIPadding = Instance.new("UIPadding")
	local FakeTitle = Instance.new("TextButton")
	local Title = Instance.new("TextLabel")
	local clear = Instance.new("ImageButton")
	local RightPanel = Instance.new("ScrollingFrame")
	local output = Instance.new("TextLabel")
	local clear_2 = Instance.new("TextButton")
	local copy = Instance.new("TextButton")
	
	--Properties:
	
	FunctionSpy.Name = "FunctionSpy"
	FunctionSpy.Parent = game.CoreGui
	FunctionSpy.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	
	Main.Name = "Main"
	Main.Parent = FunctionSpy
	Main.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0, 10, 0, 36)
	Main.Size = UDim2.new(0, 536, 0, 328)
	
	LeftPanel.Name = "LeftPanel"
	LeftPanel.Parent = Main
	LeftPanel.Active = true
	LeftPanel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	LeftPanel.BorderSizePixel = 0
	LeftPanel.Size = UDim2.new(0.349999994, 0, 1, 0)
	LeftPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
	LeftPanel.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar
	LeftPanel.ScrollBarThickness = 3
	
	UIListLayout.Parent = LeftPanel
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 7)
	
	example.Name = "example"
	example.Parent = LeftPanel
	example.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
	example.BorderSizePixel = 0
	example.Position = UDim2.new(4.39481269e-08, 0, 0, 0)
	example.Size = UDim2.new(0, 163, 0, 19)
	example.Visible = false
	example.Font = Enum.Font.SourceSans
	example.Text = ""
	example.TextColor3 = Color3.fromRGB(0, 0, 0)
	example.TextSize = 14.000
	example.TextXAlignment = Enum.TextXAlignment.Left
	
	name.Name = "name"
	name.Parent = example
	name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	name.BackgroundTransparency = 1.000
	name.BorderSizePixel = 0
	name.Position = UDim2.new(0, 10, 0, 0)
	name.Size = UDim2.new(1, -10, 1, 0)
	name.Font = Enum.Font.SourceSans
	name.TextColor3 = Color3.fromRGB(255, 255, 255)
	name.TextSize = 14.000
	name.TextXAlignment = Enum.TextXAlignment.Left
	
	UIPadding.Parent = LeftPanel
	UIPadding.PaddingBottom = UDim.new(0, 7)
	UIPadding.PaddingLeft = UDim.new(0, 7)
	UIPadding.PaddingRight = UDim.new(0, 7)
	UIPadding.PaddingTop = UDim.new(0, 7)
	
	FakeTitle.Name = "FakeTitle"
	FakeTitle.Parent = Main
	FakeTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	FakeTitle.BorderSizePixel = 0
	FakeTitle.Position = UDim2.new(0, 225, 0, -26)
	FakeTitle.Size = UDim2.new(0.166044772, 0, 0, 26)
	FakeTitle.Font = Enum.Font.GothamMedium
	FakeTitle.Text = "FunctionSpy"
	FakeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	FakeTitle.TextSize = 14.000
	
	Title.Name = "Title"
	Title.Parent = Main
	Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Title.BorderSizePixel = 0
	Title.Position = UDim2.new(0, 0, 0, -26)
	Title.Size = UDim2.new(1, 0, 0, 26)
	Title.Font = Enum.Font.GothamMedium
	Title.Text = "FunctionSpy"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 14.000
	Title.TextWrapped = true
	
	clear.Name = "clear"
	clear.Parent = Title
	clear.BackgroundTransparency = 1.000
	clear.Position = UDim2.new(1, -28, 0, 2)
	clear.Size = UDim2.new(0, 24, 0, 24)
	clear.ZIndex = 2
	clear.Image = "rbxassetid://3926305904"
	clear.ImageRectOffset = Vector2.new(924, 724)
	clear.ImageRectSize = Vector2.new(36, 36)
	
	RightPanel.Name = "RightPanel"
	RightPanel.Parent = Main
	RightPanel.Active = true
	RightPanel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	RightPanel.BorderSizePixel = 0
	RightPanel.Position = UDim2.new(0.349999994, 0, 0, 0)
	RightPanel.Size = UDim2.new(0.649999976, 0, 1, 0)
	RightPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
	RightPanel.HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar
	RightPanel.ScrollBarThickness = 3
	
	output.Name = "output"
	output.Parent = RightPanel
	output.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	output.BackgroundTransparency = 1.000
	output.BorderColor3 = Color3.fromRGB(27, 42, 53)
	output.BorderSizePixel = 0
	output.Position = UDim2.new(0, 10, 0, 10)
	output.Size = UDim2.new(1, -10, 0.75, -10)
	output.Font = Enum.Font.GothamMedium
	output.Text = ""
	output.TextColor3 = Color3.fromRGB(255, 255, 255)
	output.TextSize = 14.000
	output.TextXAlignment = Enum.TextXAlignment.Left
	output.TextYAlignment = Enum.TextYAlignment.Top
	
	clear_2.Name = "clear"
	clear_2.Parent = RightPanel
	clear_2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	clear_2.BorderSizePixel = 0
	clear_2.Position = UDim2.new(0.0631457642, 0, 0.826219559, 0)
	clear_2.Size = UDim2.new(0, 140, 0, 33)
	clear_2.Font = Enum.Font.SourceSans
	clear_2.Text = "Clear logs"
	clear_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	clear_2.TextSize = 14.000
	
	copy.Name = "copy"
	copy.Parent = RightPanel
	copy.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	copy.BorderSizePixel = 0
	copy.Position = UDim2.new(0.545350134, 0, 0.826219559, 0)
	copy.Size = UDim2.new(0, 140, 0, 33)
	copy.Font = Enum.Font.SourceSans
	copy.Text = "Copy info"
	copy.TextColor3 = Color3.fromRGB(255, 255, 255)
	copy.TextSize = 14.000
	
	-- Scripts:
	
	local function AKIHDI_fake_script() -- Main.Main 
		local script = Instance.new('LocalScript', Main)
	
		_G.functionspy = {
			instance = script.Parent.Parent;
			logging = true;
			connections = {};
		}
		
		_G.functionspy.shutdown = function()
			for i,v in pairs(_G.functionspy.connections) do
				v:Disconnect()
			end
			_G.functionspy.connections = {}
			_G.functionspy = nil
			script.Parent.Parent:Destroy()
		end
		
		local connections = {}
		
		local currentInfo = nil
		
		function log(name, text)
			local btn = script.Parent.LeftPanel.example:Clone()
			btn.Parent = script.Parent.LeftPanel
			btn.Name = name
			btn.name.Text = name
			btn.Visible = true
			table.insert(connections, btn.MouseButton1Click:Connect(function()
				script.Parent.RightPanel.output.Text = text
				currentInfo = text
			end))
		end
		
		script.Parent.RightPanel.copy.MouseButton1Click:Connect(function()
			if currentInfo ~= nil then
				setclipboard(currentInfo)
			end
		end)
		
		script.Parent.RightPanel.clear.MouseButton1Click:Connect(function()
			for i,v in pairs(connections) do
				v:Disconnect()
			end
			for i,v in pairs(script.Parent.LeftPanel:GetDescendants()) do
				if v:IsA("TextButton") and v.Visible == true then
					v:Destroy()
				end
			end
			script.Parent.RightPanel.output.Text = ""
			currentInfo = nil
		end)
		
		local hooked = {}
		local Seralize =  loadstring(game:HttpGet('https://api.irisapp.ca/Scripts/SeralizeTable.lua', true))()
		for i,v in next, toLog do
			if type(v) == "string" then
				local suc,err = pcall(function()
					local func = loadstring("return "..v)()
					hooked[i] = hookfunction(func, function(...)
						local args = {...}
						if _G.functionspy then
							pcall(function() 
								out = ""
								out = out..(v..", Args -> {")..("\n"):format()
								for l,k in pairs(args) do
									if type(k) == "function" then
										out = out..("    ["..tostring(l).."] "..tostring(k)..", Type -> "..type(k)..", Name -> "..getinfo(k).name)..("\n"):format()
									elseif type(k) == "table" then
										out = out..("    ["..tostring(l).."] "..tostring(k)..", Type -> "..type(k)..", Data -> "..Seralize(k))..("\n"):format()
									elseif type(k) == "boolean" then
										out = out..("    ["..tostring(l).."] Value -> "..tostring(k).." -> "..type(k))..("\n"):format()
									elseif type(k) == "nil" then
										out = out..("    ["..tostring(l).."] null")..("\n"):format()
									elseif type(k) == "number" then
										out = out..("    ["..tostring(l).."] Value -> "..tostring(k)..", Type -> "..type(k))..("\n"):format()
									else
										out = out..("    ["..tostring(l).."] Value -> "..tostring(k)..", Type -> "..type(k))..("\n"):format()
									end
								end
								out = out..("}, Result -> "..tostring(nil))..("\n"):format()
								if _G.functionspy.logging == true then
									log(v,out)
								end
							end)
						end
						return hooked[i](...)
					end)
				end)
				if not suc then
					warn("Something went wrong while hooking "..v..". Error: "..err)
				end
			elseif type(v) == "function" then
				local suc,err = pcall(function()
					hooked[i] = hookfunction(v, function(...)
						local args = {...}
						if _G.functionspy then
							pcall(function() 
								out = ""
								out = out..(getinfo(v).name..", Args -> {")..("\n"):format()
								for l,k in pairs(args) do
									if type(k) == "function" then
										out = out..("    ["..tostring(l).."] "..tostring(k)..", Type -> "..type(k)..", Name -> "..getinfo(k).name)..("\n"):format()
									elseif type(k) == "table" then
										out = out..("    ["..tostring(l).."] "..tostring(k)..", Type -> "..type(k)..", Data -> "..Seralize(k))..("\n"):format()
									elseif type(k) == "boolean" then
										out = out..("    ["..tostring(l).."] Value -> "..tostring(k).." -> "..type(k))..("\n"):format()
									elseif type(k) == "nil" then
										out = out..("    ["..tostring(l).."] null")..("\n"):format()
									elseif type(k) == "number" then
										out = out..("    ["..tostring(l).."] Value -> "..tostring(k)..", Type -> "..type(k))..("\n"):format()
									else
										out = out..("    ["..tostring(l).."] Value -> "..tostring(k)..", Type -> "..type(k))..("\n"):format()
									end
								end
								out = out..("}, Result -> "..tostring(nil))..("\n"):format()
								if _G.functionspy.logging == true then
									log(getinfo(v).name,out)
								end
							end)
						end
						return hooked[i](...)
					end)
				end)
				if not suc then
					warn("Something went wrong while hooking "..getinfo(v).name..". Error: "..err)
				end
			end
		end
		
	end
	coroutine.wrap(AKIHDI_fake_script)()
	local function KVVJTK_fake_script() -- FakeTitle.DragScript 
		local script = Instance.new('LocalScript', FakeTitle)
	
		--Not made by me, check out this video: https://www.youtube.com/watch?v=z25nyNBG7Js&t=22s
		--Put this inside of your Frame and configure the speed if you would like.
		--Enjoy! Credits go to: https://www.youtube.com/watch?v=z25nyNBG7Js&t=22s
		
		local UIS = game:GetService('UserInputService')
		local frame = script.Parent.Parent
		local dragToggle = nil
		local dragSpeed = 0.25
		local dragStart = nil
		local startPos = nil
		
		local function updateInput(input)
			local delta = input.Position - dragStart
			local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
		end
		
		table.insert(_G.functionspy.connections, frame.Title.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
				dragToggle = true
				dragStart = input.Position
				startPos = frame.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragToggle = false
					end
				end)
			end
		end))
		
		table.insert(_G.functionspy.connections, UIS.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				if dragToggle then
					updateInput(input)
				end
			end
		end))
		
	end
	coroutine.wrap(KVVJTK_fake_script)()
	local function BIPVKVC_fake_script() -- FakeTitle.LocalScript 
		local script = Instance.new('LocalScript', FakeTitle)
	
		table.insert(_G.functionspy.connections, script.Parent.MouseEnter:Connect(function()
			if _G.functionspy.logging == true then
				game:GetService("TweenService"):Create(script.Parent.Parent.Title, TweenInfo.new(0.3), {TextColor3 = Color3.new(0,1,0)}):Play()
			elseif _G.functionspy.logging == false then
				game:GetService("TweenService"):Create(script.Parent.Parent.Title, TweenInfo.new(0.3), {TextColor3 = Color3.new(1,0,0)}):Play()
			end
		end))
		
		table.insert(_G.functionspy.connections, script.Parent.MouseMoved:Connect(function()
			if _G.functionspy.logging == true then
				game:GetService("TweenService"):Create(script.Parent.Parent.Title, TweenInfo.new(0.3), {TextColor3 = Color3.new(0,1,0)}):Play()
			elseif _G.functionspy.logging == false then
				game:GetService("TweenService"):Create(script.Parent.Parent.Title, TweenInfo.new(0.3), {TextColor3 = Color3.new(1,0,0)}):Play()
			end
		end))
		
		table.insert(_G.functionspy.connections, script.Parent.MouseButton1Click:Connect(function()
			_G.functionspy.logging = not _G.functionspy.logging
			if _G.functionspy.logging == true then
				game:GetService("TweenService"):Create(script.Parent.Parent.Title, TweenInfo.new(0.3), {TextColor3 = Color3.new(0,1,0)}):Play()
			elseif _G.functionspy.logging == false then
				game:GetService("TweenService"):Create(script.Parent.Parent.Title, TweenInfo.new(0.3), {TextColor3 = Color3.new(1,0,0)}):Play()
			end
		end))
		
		table.insert(_G.functionspy.connections, script.Parent.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(script.Parent.Parent.Title, TweenInfo.new(0.3), {TextColor3 = Color3.new(1,1,1)}):Play()
		end))
	end
	coroutine.wrap(BIPVKVC_fake_script)()
	local function PRML_fake_script() -- clear.LocalScript 
		local script = Instance.new('LocalScript', clear)
	
		script.Parent.MouseButton1Click:Connect(function()
			_G.functionspy.shutdown()
		end)
	end
	coroutine.wrap(PRML_fake_script)()	
end)

local flyPart
cmd.add({"fly"}, {"fly [speed]", "Enable flight"}, function(...)
FLYING = false
	cmdlp.Character.Humanoid.PlatformStand = false
	wait()

		
		
		wait();
		
		Notify({
		Description = "Fly enabled";
		Title = "Nameless Admin";
		Duration = 5;
	
});
	sFLY(true)
	speedofthevfly = (...)
	if (...) == nil then
	    speedofthevfly = 2
	    end
end)

cmd.add({"unfly"}, {"unfly", "Disable flight"}, function()

		
		
		wait();
		
		Notify({
		Description = "Not flying anymore";
		Title = "Nameless Admin";
		Duration = 5;
	
});
FLYING = false
	cmdlp.Character.Humanoid.PlatformStand = false
end)

cmd.add({"noclip", "nclip", "nc"}, {"noclip", "Disable your player's collision"}, function()
	if connections["noclip"] then lib.disconnect("noclip") return end
	lib.connect("noclip", RunService.Stepped:Connect(function()
		if not character then return end
		for i, v in pairs(character:GetDescendants()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end))
end)

cmd.add({"lagserver", "lserver"}, {"lagserver (lserver)", "lags / ddoses the server"}, function(...)
	local char = game:GetService('Players').LocalPlayer.Character or nil
	if char then
	char.HumanoidRootPart.CFrame = CFrame.new(0,9e9,0)
	task.wait(0.5)
	char.HumanoidRootPart.Anchored = true
	end
	while wait(1.5) do --// don't change it's the best
	game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)
	local function getmaxvalue(val)
	   local mainvalueifonetable = 499999
	   if type(val) ~= "number" then
		   return nil
	   end
	   local calculateperfectval = (mainvalueifonetable/(val+2))
	   return calculateperfectval
	end
	 
	local function bomb(tableincrease, tries)
	local maintable = {}
	local spammedtable = {}
	 
	table.insert(spammedtable, {})
	z = spammedtable[1]
	 
	for i = 1, tableincrease do
		local tableins = {}
		table.insert(z, tableins)
		z = tableins
	end
	 
	local calculatemax = getmaxvalue(tableincrease)
	local maximum
	 
	if calculatemax then
		 maximum = calculatemax
		 else
		 maximum = 999999
	end
	 
	for i = 1, maximum do
		 table.insert(maintable, spammedtable)
	end
	 
	for i = 1, tries do
		 game.RobloxReplicatedStorage.SetPlayerBlockList:FireServer(maintable)
	end
	end
	 
	bomb(289, 5) --// change values if client crashes
	end
end)

cmd.add({"clip", "c"}, {"clip", "Enable your player's collision"}, function()
	lib.disconnect("noclip")
end)

cmd.add({"r15"}, {"r15", "Prompts a message asking to make you R15"}, function()
local avs = game:GetService("AvatarEditorService")
avs:PromptSaveAvatar(game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription,Enum.HumanoidRigType.R15)
Notify({
Description = "Press allow";
Duration = 3;

});
local result = avs.PromptSaveAvatarCompleted:Wait()
if result == Enum.AvatarPromptResult.Success
then
Notify({
Description = "You are now R15";
Title = "Nameless Admin";
Duration = 3;

});
respawn()
else
Notify({
Description = "An error has occured";
Title = "Nameless Admin";
Duration = 3;

});
end
end)

cmd.add({"r6"}, {"r6", "Prompts a message asking to make you R6"}, function()
    local avs = game:GetService("AvatarEditorService")
avs:PromptSaveAvatar(game.Players.LocalPlayer.Character.Humanoid.HumanoidDescription,Enum.HumanoidRigType.R6)
Notify({
Description = "Press allow";
Duration = 3;

});
local result = avs.PromptSaveAvatarCompleted:Wait()
if result == Enum.AvatarPromptResult.Success
then
Notify({
Description = "You are now R6";
Title = "Nameless Admin";
Duration = 3;

});
respawn()
else
Notify({
Description = "An error has occured";
Title = "Nameless Admin";
Duration = 3;

});
end
end)

cmd.add({"freecam", "fc", "fcam"}, {"freecam [speed] (fc, fcam)", "Enable free camera"}, function(speed)
	if not speed then speed = 5 end
	if connections["freecam"] then lib.disconnect("freecam") camera.CameraSubject = character 	wrap(function() character.PrimaryPart.Anchored = false end) end
	local dir = {w = false, a = false, s = false, d = false}
	local cf = Instance.new("CFrameValue")
	local camPart = Instance.new("Part")
	camPart.Transparency = 1
	camPart.Anchored = true
	camPart.CFrame = camera.CFrame
	wrap(function()
		character.PrimaryPart.Anchored = true
	end)
	
	lib.connect("freecam", RunService.RenderStepped:Connect(function()
		local primaryPart = camPart
		camera.CameraSubject = primaryPart
		
		local x, y, z = 0, 0, 0
		if dir.w then z = -1 * speed end
		if dir.a then x = -1 * speed end
		if dir.s then z = 1 * speed end
		if dir.d then x = 1 * speed end
		if dir.q then y = 1 * speed end
		if dir.e then y = -1 * speed end
		
		primaryPart.CFrame = CFrame.new(
			primaryPart.CFrame.p,
			(camera.CFrame * CFrame.new(0, 0, -100)).p
		)
		
		local moveDir = CFrame.new(x,y,z)
		cf.Value = cf.Value:lerp(moveDir, 0.2)
		primaryPart.CFrame = primaryPart.CFrame:lerp(primaryPart.CFrame * cf.Value, 0.2)
	end))
	lib.connect("freecam", UserInputService.InputBegan:Connect(function(input, event)
		if event then return end
		local code, codes = input.KeyCode, Enum.KeyCode
		if code == codes.W then
			dir.w = true
		elseif code == codes.A then
			dir.a = true
		elseif code == codes.S then
			dir.s = true
		elseif code == codes.D then
			dir.d = true
		elseif code == codes.Q then
			dir.q = true
		elseif code == codes.E then
			dir.e = true
		elseif code == codes.Space then
			dir.q = true
		end
	end))
	lib.connect("freecam", UserInputService.InputEnded:Connect(function(input, event)
		if event then return end
		local code, codes = input.KeyCode, Enum.KeyCode
		if code == codes.W then
			dir.w = false
		elseif code == codes.A then
			dir.a = false
		elseif code == codes.S then
			dir.s = false
		elseif code == codes.D then
			dir.d = false
		elseif code == codes.Q then
			dir.q = false
		elseif code == codes.E then
			dir.e = false
		elseif code == codes.Space then
			dir.q = false
		end
	end))
end)

cmd.add({"unfreecam", "unfc", "unfcam"}, {"unfreecam (unfc, unfcam)", "Disable free camera"}, function()
	lib.disconnect("freecam")
	camera.CameraSubject = character
	wrap(function()
		character.PrimaryPart.Anchored = false
	end)
end)

cmd.add({"drophats"}, {"drophats", "Drop all of your hats"}, function()
	for _, hat in pairs(character:GetChildren()) do
		if hat:IsA("Accoutrement") then
			hat.Parent = workspace
		end
	end
end)

cmd.add({"hatspin"}, {"hatspin <height>", "Make your hats spin"}, function(h)
	local head = character:FindFirstChild("Head")
	if not head then return end
	for _, hat in pairs(character:GetChildren()) do
		if hat:IsA("Accoutrement") and hat:FindFirstChild("Handle") then
			local handle = hat.Handle
			handle:BreakJoints()
			
			local align = Instance.new("AlignPosition")
			local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
			align.Attachment0, align.Attachment1 = a0, a1
			align.RigidityEnabled = true
			a1.Position = Vector3.new(0, tonumber(h) or 0.5, 0)
			lock(align, handle); lock(a0, handle); lock(a1, head);
			
			local angular = Instance.new("BodyAngularVelocity")
			angular.AngularVelocity = Vector3.new(0, math.random(100, 160)/16, 0)
			angular.MaxTorque = Vector3.new(0, 400000, 0)
			lock(angular, handle);
		end
	end
end)

cmd.add({"limbbounce"}, {"limbbounce [height] [distance]", "Make your limbs bounce around your head"}, function(h, d)
	local head = character:FindFirstChild("Head")
	if not head then return end
	local i = 2
	for _, part in pairs(character:GetDescendants()) do
		local name = part.Name:lower()
		if part:IsA("BasePart") and not part.Parent:IsA("Accoutrement") and not name:find("torso") and not name:find("head") and not name:find("root") then
			i = i + math.random(15,50)/100
			part:BreakJoints()
			local n = tonumber(d) or i
			
			local align = Instance.new("AlignPosition")
			local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
			align.Attachment0, align.Attachment1 = a0, a1
			align.RigidityEnabled = true
			lock(align, part); lock(a0, part); lock(a1, head);
			
			wrap(function()
				local rotX = 0
				local speed = math.random(350, 750)/10000
				while part and part.Parent do
					rotX = rotX + speed
					a1.Position = Vector3.new(0, (tonumber(h) or 0) + math.sin(rotX) * n, 0)
					RunService.RenderStepped:Wait(0)
				end
			end)
		end
	end
end)

cmd.add({"limborbit"}, {"limborbit [height] [distance]", "Make your limbs orbit around your head"}, function(h, d)
	local head = character:FindFirstChild("Head")
	if not head then return end
	local i = 2
	for _, part in pairs(character:GetDescendants()) do
		local name = part.Name:lower()
		if part:IsA("BasePart") and not part.Parent:IsA("Accoutrement") and not name:find("torso") and not name:find("head") and not name:find("root") then
			i = i + math.random(15,50)/100
			part:BreakJoints()
			local n = tonumber(d) or i
			
			local align = Instance.new("AlignPosition")
			local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
			align.Attachment0, align.Attachment1 = a0, a1
			align.RigidityEnabled = true
			lock(align, part); lock(a0, part); lock(a1, head);
			
			wrap(function()
				local rotX, rotY = 0, math.pi/2
				local speed = math.random(35, 75)/1000
				while part and part.Parent do
					rotX, rotY = rotX + speed, rotY + speed
					a1.Position = Vector3.new(math.sin(rotX) * (n), tonumber(h) or 0, math.sin(rotY) * (n))
					RunService.RenderStepped:Wait(0)
				end
			end)
		end
	end
end)

local function getAllTools()
	local tools = {}
	local backpack = localPlayer:FindFirstChildWhichIsA("Backpack")
	if backpack then
		for i, v in pairs(backpack:GetChildren()) do
			if v:IsA("Tool") then
				table.insert(tools, v)
			end
		end
	end
	for i, v in pairs(character:GetChildren()) do
		if v:IsA("Tool") then
			table.insert(tools, v)
		end
	end
	return tools
end

cmd.add({"fakelag", "flag"}, {"fakelag (flag)", "fake lag"}, function()
FakeLag = true

repeat wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
    wait(0.05)
     game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
     wait(0.05)
until FakeLag == false
end)

cmd.add({"unfakelag", "unflag"}, {"unfakelag (unflag)", "stops the fake lag command"}, function()
FakeLag = false
end)

cmd.add({"circlemath", "cm"}, {"circlemath <mode> <size>", "Gay circle math\nModes: abc..."}, function(mode, size)
	local mode = mode or "a"
	local backpack = localPlayer:FindFirstChildWhichIsA("Backpack")
	lib.disconnect("cm")
	if backpack and character.Parent then
		local tools = getAllTools()
		for i, tool in pairs(tools) do
			local cpos, g = (math.pi*2)*(i/#tools), CFrame.new()
			local tcon = {}
			tool.Parent = backpack
			
			if mode == "a" then
				size = tonumber(size) or 2
				g = (
					CFrame.new(0, 0, size)*
					CFrame.Angles(rad(90), 0, cpos)
				)
			elseif mode == "b" then
				size = tonumber(size) or 2
				g = (
					CFrame.new(i - #tools/2, 0, 0)*
					CFrame.Angles(rad(90), 0, 0)
				)
			elseif mode == "c" then
				size = tonumber(size) or 2
				g = (
					CFrame.new(cpos/3, 0, 0)*
					CFrame.Angles(rad(90), 0, cpos*2)
				)
			elseif mode == "d" then
				size = tonumber(size) or 2
				g = (
					CFrame.new(clamp(tan(cpos), -3, 3), 0, 0)*
					CFrame.Angles(rad(90), 0, cpos)
				)
			elseif mode == "e" then
				size = tonumber(size) or 2
				g = (
					CFrame.new(0, 0, clamp(tan(cpos), -5, 5))*
					CFrame.Angles(rad(90), 0, cpos)
				)
			end
			tool.Grip = g
			tool.Parent = character
			
			tcon[#tcon] = lib.connect("cm", mouse.Button1Down:Connect(function()
				tool:Activate()
			end))
			tcon[#tcon] = lib.connect("cm", tool.Changed:Connect(function(p)
				if p == "Grip" and tool.Grip ~= g then
					tool.Grip = g
				end
			end))
			
			lib.connect("cm", tool.AncestryChanged:Connect(function()
				for i = 1, #tcon do
					tcon[i]:Disconnect()
				end
			end))
		end
	end
end)

local r = math.rad
local center = CFrame.new(1.5, 0.5, -1.5)

cmd.add({"toolanimate"}, {"toolanimate <mode> <int>", "Make your tools epic\nModes: ufo/ring/shutter/saturn/portal/wtf/ball/tor"}, function(mode, int)
	lib.disconnect("tooldance")
	local int = tonumber(int) or 5
	local backpack = localPlayer:FindFirstChildWhichIsA("Backpack")
	local primary = character:FindFirstChild("HumanoidRootPart")
	if backpack and primary then
		local tools = getAllTools()
		for i, tool in pairs(tools) do
			if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
				local circ = (i/#tools)*(math.pi*2)
				
				local function editGrip(tool, cframe, offset)
					local origin = CFrame.new(cframe.p):inverse()
					local x, y, z = cframe:toEulerAnglesXYZ()
					local new = CFrame.Angles(x, y, z)
					local grip = (origin * new):inverse()
					tool.Parent = backpack
					tool.Grip = offset * grip
					tool.Parent = character
					
					for i, v in pairs(tool:GetDescendants()) do
						if v:IsA("Sound") then
							v:Stop()
						end
					end
				end
				tool.Handle.Massless = true
				
				if mode == "ufo" then
					local s = {}
					local x, y = i, i + math.pi / 2
					lib.connect("tooldance", RunService.Heartbeat:Connect(function()
						s.x = math.sin(x)
						s.y = math.sin(y)
						x, y = x + 0.1, y + 0.1
						
						local cframe =
							center *
							CFrame.new() *
							CFrame.Angles(r(s.y*10), circ + r(s.y*8), r(s.x*10))
						local offset =
							CFrame.new(int, 0, 0) *
							CFrame.Angles(0, 0, 0)
						editGrip(tool, cframe, offset)
					end))
				elseif mode == "ring" then
					local s = {}
					local x, y = i, i + math.pi / 2
					lib.connect("tooldance", RunService.Heartbeat:Connect(function()
						s.x = math.sin(x)
						s.y = math.sin(y)
						x, y = x + 0.04, y + 0.04
						
						local cframe =
							center *
							CFrame.new(0, 3, 0) *
							CFrame.Angles(0, circ, x)
						local offset =
							CFrame.new(0, 0, int) *
							CFrame.Angles(0, 0, 0)
						editGrip(tool, cframe, offset)
					end))
				elseif mode == "shutter" then
					local s = {}
					local x, y = 0, math.pi / 2
					lib.connect("tooldance", RunService.Heartbeat:Connect(function()
						s.x = math.sin(x)
						s.y = math.sin(y)
						x, y = x + 0.1, y + 0.1
						
						local cframe =
							center *
							CFrame.new(0, 0, 0) *
							CFrame.Angles(0, 0, circ + 0)
						local offset =
							CFrame.new(s.y*6, 0, int) *
							CFrame.Angles(r(-90), 0, 0)
						editGrip(tool, cframe, offset)
					end))
				elseif mode == "saturn" then
					local s = {}
					local x, y = 0, math.pi / 2
					lib.connect("tooldance", RunService.Heartbeat:Connect(function()
						s.x = math.sin(x)
						s.y = math.sin(y)
						x, y = x + 0.1, y + 0.1
						local cframe =
							center *
							CFrame.new(0, 0, 0) *
							CFrame.Angles(0, circ, 0)
						local offset =
							CFrame.new(s.y*6, 0, int) *
							CFrame.Angles(0, 0, r(0))
						editGrip(tool, cframe, offset)
					end))
				elseif mode == "portal" then
					local s = {}
					local x, y = 0, math.pi / 2
					lib.connect("tooldance", RunService.Heartbeat:Connect(function()
						s.x = math.sin(x)
						s.y = math.sin(y)
						x, y = x + 0.1, y + 0.1
						
						local cframe =
							center *
							CFrame.new(0, 0, 0) *
							CFrame.Angles(0, 0, circ + r(x*45))
						local offset =
							CFrame.new(3, 0, int) *
							CFrame.Angles(r(-90), 0, 0)
						editGrip(tool, cframe, offset)
					end))
				elseif mode == "ball" then
					local s = {}
					local n = math.random()*#tools
					local x, y = n, n+math.pi / 2
					local random = math.random()
					lib.connect("tooldance", RunService.Heartbeat:Connect(function()
						s.x = math.sin(x)
						s.y = math.sin(y)
						x, y = x + 0.1, y + 0.1
						local cframe =
							center *
							CFrame.new(0, 0, 0) *
							CFrame.Angles(r(y*25), circ, r(y*25))
						local offset =
							CFrame.new(0, int + random*2, 0) *
							CFrame.Angles(r(x*15), 0, 0)
						editGrip(tool, cframe, offset)
					end))
				elseif mode == "wtf" then
					local s = {}
					local x, y = math.random()^3, math.random()^3+math.pi / 2
					lib.connect("tooldance", RunService.Heartbeat:Connect(function()
						s.x = math.sin(x)
						s.y = math.sin(y)
						x, y = x + 0.1 + math.random()/10, y + 0.1 + math.random()/10
						local cframe =
							center *
							CFrame.new(0, 0, 0) *
							CFrame.Angles(r(y*100)+math.random(), circ, r(y*100)+math.random())
						local offset =
							CFrame.new(0, int + math.random()*4, 0) *
							CFrame.Angles(r(x*100), 0, 0)
						editGrip(tool, cframe, offset)
					end))
				elseif mode == "tor" then
					local s = {}
					local x, y = i*1, i*1+math.pi / 2
					local random = math.random()
					lib.connect("tooldance", RunService.Heartbeat:Connect(function()
						s.x = math.sin(x)
						s.y = math.sin(y)
						x, y = x + (int/75), y+0.1
						local cframe =
							center *
							CFrame.new(1.5, 2, 0) *
							CFrame.Angles(r(-90-25), 0, 0)
						local offset =
							CFrame.new(0, s.x*3, -int+math.sin(y/5)*-int) *
							CFrame.Angles(r(int), s.x, -x)
						editGrip(tool, cframe, offset)
					end))
				end
			else
				table.remove(tools, i)
			end
		end
	end
end)

cmd.add({"hide", "unshow"}, {"hide <player> (unshow)", "places the selected player to lighting"}, function(...)
	
	
	
	wait();
	
	Notify({
	Description = "Hid the player";
	Title = "Nameless Admin";
	Duration = 5;
	
});

local Username = (...)
local target = getPlr(Username)

if target and target.Character then
    target.Character.Parent = game.Lighting
end
end)

cmd.add({"unhide", "show"}, {"show <player> (unhide)", "places the selected player back to workspace"}, function(...)
	
	
	
	wait();
	
	Notify({
	Description = "Unhid the player";
	Title = "Nameless Admin";
	Duration = 5;
	
});

local Username = (...)
local target = getPlr(Username)

if target and target.Character then
    target.Character.Parent = game.Workspace
end
end)

cmd.add({"aimbot", "aimbotui", "aimbotgui"}, {"aimbot (aimbotui, aimbotgui)", "aimbot and yeah"}, function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/fatesc/fates-esp/main/main.lua'))()
end)

cmd.add({"febypass", "bypassfe"}, {"febypass (bypassfe)", "dont execute (literally) btw this script does not do harm "}, function()
  local Sound = Instance.new("Sound",game:GetService("SoundService"))
Sound.SoundId = "rbxassetid://9043346594"
Sound:Play()
Sound.Looped = true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/specowos/specs-scripts/main/scripts/LOLHOO%20(fd).lua"))()
end)

cmd.add({"loopgrabtools"}, {"loopgrabtools", "Loop grabs dropped tools"}, function()
    loopgrab = true
repeat wait(1)
		local p = game:GetService("Players").LocalPlayer
local c = p.Character
if c and c:FindFirstChild("Humanoid") then
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Tool") then
            c:FindFirstChild("Humanoid"):EquipTool(v)
        end
    end
end
until loopgrab == false
end)

cmd.add({"unloopgrabtools"}, {"unloopgrabtools", "Stops the loop grab command"}, function()
loopgrab = false
end)

cmd.add({"dance"}, {"dance", "Does a random dance"}, function()
   local dances = {"27789359", "30196114", "248263260", "45834924", "33796059", "28488254", "52155728"}
if theanim then
    theanim:Stop()
theanim:Destroy()
		local animation = Instance.new("Animation")
		animation.AnimationId = "rbxassetid://" .. dances[math.random(1, #dances)]
		theanim = game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(animation)
		theanim:Play()
	else
	    	local animation = Instance.new("Animation")
		animation.AnimationId = "rbxassetid://" .. dances[math.random(1, #dances)]
		theanim = game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(animation)
		theanim:Play()
		end
end)

cmd.add({"undance"}, {"undance", "Stops the dance command"}, function()
theanim:Stop()
theanim:Destroy()
end)


cmd.add({"animspoofer", "animationspoofer", "spoofanim", "animspoof"}, {"animationspoofer (animspoof, spoofanim)", "Loads up an animation spoofer, spoofs animations that use rbxassetid"}, function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/AnimationSpoofer"))()
end)

cmd.add({"tooldance", "td"}, {"tooldance <mode> <size>", "Make your tools dance\nModes: tor/sph/inf/rng/whl/wht/voi"}, function(mode, size)
	local size = tonumber(size) or 5
	lib.disconnect("tooldance")
	local backpack = localPlayer:FindFirstChildWhichIsA("Backpack")
	local primary = character:FindFirstChild("HumanoidRootPart")
	if backpack and primary then
		local i, tools = 0, getAllTools()
		for _, tool in pairs(tools) do
			if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
				i=i+1
				tool.Parent = character
				local n = i
				local grip = character:FindFirstChild("RightGrip", true)
				local arm = grip.Parent
				
				local function editGrip(cf)
					tool.Parent = backpack
					tool.Grip = cf
					tool.Parent = character
					
					for i, v in pairs(tool:GetDescendants()) do
						if v:IsA("Sound") and v.Name:find("sheath") then
							v:Destroy()
						end
					end
				end
				tool.Handle.Massless = true
				
				if mode == "tor" then
					local x, y = n, n+math.pi/2
					lib.connect("tooldance", RunService.RenderStepped:Connect(function()
						x,y = x+(size/75),y+0.1
						local sx,sy = math.sin(x),math.sin(y)
						editGrip(
							CFrame.new(
								Vector3.new(0, math.sin(x * 0.5), size + 3 + math.sin(y / 5) * size)
							) * 
							CFrame.Angles(
								math.rad(size), 
								math.sin(x), 
								-x
							)
						)
					end))
				elseif mode == "sph" then
					local x, y = n, n+math.pi/2
					lib.connect("tooldance", RunService.RenderStepped:Connect(function()
						x,y = x+.1,y+.1
						local sx,sy = math.sin(x),math.sin(y)
						editGrip(
							CFrame.new(
								Vector3.new(0, size, 0)
							) * 
							CFrame.Angles(
								math.deg(x/150), 
								x + rad(90), 
								0
							)
						)
					end))
				elseif mode == "inf" then
					local x, y = n, n+math.pi/2
					lib.connect("tooldance", RunService.RenderStepped:Connect(function()
						x,y = x+.1,y+.1
						local sx,sy = math.sin(x),math.sin(y)
						editGrip(
							CFrame.new(
								Vector3.new(0, size, 0)
							) * 
							CFrame.Angles(
								x, 
								x + rad(90), 
								0
							)
						)
					end))
				elseif mode == "wht" then
					local x, y = n, n+math.pi/2
					lib.connect("tooldance", RunService.RenderStepped:Connect(function()
						x,y = x+.1,y+.1
						local sx,sy = math.sin(x),math.sin(y)
						editGrip(
							CFrame.new(
								Vector3.new(0, size, 0)
							) * 
							CFrame.Angles(
								(y+math.sin(x)*10)/10, 
								x + rad(90), 
								0
							)
						)
					end))
				elseif mode == "rng" then
					local x, y = n, n+math.pi/2
					lib.connect("tooldance", RunService.RenderStepped:Connect(function()
						x,y = x+0.1,y+0.1
						local sx,sy = math.sin(x),math.sin(y)
						editGrip(
							CFrame.new(
								0, 0, size
							) * 
							CFrame.Angles(
								0, 
								x, 
								0
							)
						)
					end))
				elseif mode == "whl" then
					local x, y = n, n+math.pi/2
					lib.connect("tooldance", RunService.RenderStepped:Connect(function()
						x,y = x+0.1,y+0.1
						local sx,sy = math.sin(x),math.sin(y)
						editGrip(
							CFrame.new(
								Vector3.new(0, 0, size)
							) * 
							CFrame.Angles(
								x,
								0, 
								0
							)
						)
					end))
				elseif mode == "voi" then
					local x, y = n, n+math.pi/2
					lib.connect("tooldance", RunService.RenderStepped:Connect(function()
						x,y = x+0.1,y+0.1
						local sx,sy = math.sin(x),math.sin(y)
						editGrip(
							CFrame.new(
								Vector3.new(size, 0, 0)
							) * 
							CFrame.Angles(
								0,
								.6 + sy/3, 
								(n) + sx + x
							)
						)
					end))
				end
			end
		end
	end
end)

cmd.add({"copygameid", "cgameid"}, {"copygameid (cgameid)", "Copies the id of the game youre in"}, function()
setclipboard(game.PlaceId)
end)

cmd.add({"lowhold"}, {"lowhold", "Boombox low hold"}, function()
game.Players.LocalPlayer.Backpack.BoomBox.GripForward =  Vector3.new(-0, -1, 0)
game.Players.LocalPlayer.Backpack.BoomBox.GripPos =  Vector3.new(-0.064, 0.835, -0)
game.Players.LocalPlayer.Backpack.BoomBox.GripRight =  Vector3.new(-0, -0, -1)
game.Players.LocalPlayer.Backpack.BoomBox.GripUp =  Vector3.new(-1, 0, 0)
wait(0.2)
game.Players.LocalPlayer:findFirstChildOfClass('Backpack')['BoomBox'].Parent = game.Players.LocalPlayer.Character
wait(0.2)
h = game.Players.LocalPlayer.Character.Humanoid
tracks = h:GetPlayingAnimationTracks()
for _,x in pairs(tracks)
do x:Stop()
end
end)

cmd.add({"copyname", "cname"}, {"copyname <player> (cname)", "Copies the username of the target"}, function(...)
Username = (...)
target = getPlr(Username)



wait();

Notify({
Description = "Copied the username of " .. target.DisplayName .. "";
Title = "Nameless Admin";
Duration = 7;

});
setclipboard(target.Name)
end)

cmd.add({"copydisplay", "cdisplay"}, {"copydisplay <player> (cdisplay)", "Copies the display name of the target"}, function(...)
Username = (...)
target = getPlr(Username)



wait();

Notify({
Description = "Copied the display name of " .. target.Name .. "";
Title = "Nameless Admin";
Duration = 7;

});
setclipboard(target.DisplayName)
end)

cmd.add({"nodance", "untooldance"}, {"nodance", "Stop making tools dance"}, function()
	lib.disconnect("tooldance")
end)

cmd.add({"toolvis", "audiovis"}, {"toolvis <size>", "Turn your tools into an audio visualizer"}, function(size)
	lib.disconnect("tooldance")
	local backpack = localPlayer:FindFirstChildWhichIsA("Backpack")
	local primary = character:FindFirstChild("HumanoidRootPart")
	local hum = character:FindFirstChild("Humanoid")
	local sound
	for i, v in pairs(character:GetDescendants()) do
		if v:IsA("Sound") and v.Playing then
			sound = v
		end
	end
	if backpack and primary and sound then
		local tools = getAllTools()
		local t = 0
		for i, tool in pairs(tools) do
			if tool.Parent == character and tool:IsA("BackpackItem") and tool:FindFirstChildWhichIsA("BasePart") and tool.Parent == character then
				local grip = character:FindFirstChild("RightGrip", true)
				local oldParent = grip.Parent
				lib.connect("tooldance", RunService.RenderStepped:Connect(function()
					if not sound then lib.disconnect("tooldance") end
					tool.Parent = character
					grip.Parent = oldParent
				end))
			end
		end
		wait()
		for i, tool in pairs(tools) do
			if tool.Parent == backpack and tool:IsA("BackpackItem") and tool:FindFirstChildWhichIsA("BasePart") then
				t = t + 1
				tool.Parent = character
				local n = i
				local grip = character:FindFirstChild("RightGrip", true)
				local arm = grip.Parent
				
				local function editGrip(cf)
					tool.Parent = backpack
					tool.Grip = tool.Grip:lerp(cf, 0.2)
					tool.Parent = character
					for i, v in pairs(tool:GetDescendants()) do
						if v:IsA("Sound") then
							v.Parent = nil
						end
					end
				end
				tool.Handle.Massless = true
				
				local x,y,z,a = n,n+math.pi/2,n,0
				lib.connect("tooldance", RunService.Heartbeat:Connect(function()
					if not sound then lib.disconnect("tooldance") end
					
					local mt, loudness = sound.PlaybackLoudness/100, sound.PlaybackLoudness
					local sx, sy, sz, sa = math.sin(x), math.sin(y), math.sin(z), math.sin(a)
					x,y,z,a = x + 0.22 + mt / 100,  y + sx + mt,  z + sx/10,  a + mt/100 + math.sin(x-n)/100
					editGrip(
						CFrame.new(
							Vector3.new(
								0,
								2 + ((sx/2) * (mt^3/15))/3 - ((sx+0.5)/1.5 * ((loudness/10)^2/400)),
								tonumber(size) or 7
							)
						) * 
						CFrame.Angles(
							math.rad((sz+1)/2)*5,
							((math.pi*2)*(n/t)) - (a), 
							math.rad(sx)*5
						)
					)
				end))
			end
		end
	end
end)

cmd.add({"toolspin"}, {"toolspin [height] [amount]", "Make your tools spin on your head"}, function(h, amt)
	if not amt then amt = 1000 end
	local head = character:FindFirstChild("Head")
	if not head then return end
	for i, tool in pairs(localPlayer.Backpack:GetChildren()) do
		if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
			if i >= (tonumber(amt) or 1000) then break end
			if tool:FindFirstChildWhichIsA("LocalScript") then
				tool:FindFirstChildWhichIsA("LocalScript").Disabled = true
			end
			tool.Parent = character
		end
	end
	wait(0.5)
	for _, tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") then
			wrap(function()
				tool:WaitForChild("Handle")
				for i, part in pairs(tool:GetDescendants()) do
					if part:IsA("BasePart") then
						part:BreakJoints()
						
						local align = Instance.new("AlignPosition")
						local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
						align.Attachment0, align.Attachment1 = a0, a1
						align.RigidityEnabled = true
						a1.Position = Vector3.new(0, tonumber(h) or 0, 0)
						lock(align, part); lock(a0, part); lock(a1, head);
						
						local angular = Instance.new("BodyAngularVelocity")
						angular.AngularVelocity = Vector3.new(0, math.random(100, 160)/16, 0)
						angular.MaxTorque = Vector3.new(0, 400000, 0)
						lock(angular, part);
						
						spawn(function()
							repeat wait() until tool.Parent ~= character
							angular:Destroy()
							align:Destroy()
						end)
					end
				end
			end)
		end
	end
end)

cmd.add({"toolorbit"}, {"toolorbit [height] [distance] [amount]", "Make your tools orbit around your head"}, function(h, d, amt)
	if not amt then amt = 1000 end
	local head = character:FindFirstChild("Head")
	if not head then return end
	for i, tool in pairs(localPlayer.Backpack:GetChildren()) do
		if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
			if i >= (tonumber(amt) or 1000) then break end
			if tool:FindFirstChildWhichIsA("LocalScript") then
				tool:FindFirstChildWhichIsA("LocalScript").Disabled = true
			end
			tool.Parent = character
		end
	end
	wait(0.5)
	for _, tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") then
			wrap(function()
				tool:WaitForChild("Handle")
				for i, part in pairs(tool:GetDescendants()) do
					if part:IsA("BasePart") then
						part:BreakJoints()
						
						local align = Instance.new("AlignPosition")
						local a0, a1 = Instance.new("Attachment"), Instance.new("Attachment")
						align.Attachment0, align.Attachment1 = a0, a1
						align.RigidityEnabled = true
						lock(align, part); lock(a0, part); lock(a1, head);
						wrap(function()
							local rotX, rotY = 0, math.pi/2
							local speed = math.random(25, 100)/1000
							local n = tonumber(d) or math.random(300, 700)/100
							local y = tonumber(h) or math.random(-100, 100)/100/2
							rotY, rotX = rotY + n, rotX + n
							
							part.CollisionGroupId = math.random(1000000,9999999)
							part.Anchored = false
							part.CFrame = head.CFrame * CFrame.new(0, 3, 0)
							
							while part and part.Parent and tool.Parent == character do
								rotX, rotY = rotX + speed, rotY + speed
								a1.Position = Vector3.new(math.sin(rotX) * n, y, math.sin(rotY) * n)
								RunService.RenderStepped:Wait(0)
							end
						end)
					end
				end
			end)
		end
	end
end)

cmd.add({"blockhats"}, {"blockhats", "Remove the meshes in your hats"}, function()
	for _, hat in pairs(character:GetChildren()) do
		if hat:IsA("Accoutrement") and hat:FindFirstChild("Handle") then
			local handle = hat.Handle
			if handle:FindFirstChildWhichIsA("SpecialMesh") then
				handle:FindFirstChildWhichIsA("SpecialMesh"):Destroy()
			end
		end
	end
end)

cmd.add({"blocktools"}, {"blocktools", "Remove the meshes in your tools"}, function()
	for _, tool in pairs(character:GetChildren()) do
		if tool:IsA("Tool") then
			for _, mesh in pairs(tool:GetDescendants()) do
				if mesh:IsA("DataModelMesh") then
					mesh:Destroy()
				end
			end
		end
	end
end)

cmd.add({"notoolmesh", "ntm", "notoolmeshes"}, {"notoolmesh (ntm)", "Makes tools not have meshes"}, function()
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if (v:IsA("Tool")) then
v.Handle.Mesh:Destroy()
end
end
end)

cmd.add({"nomeshes", "nomesh", "blocks"}, {"nomeshes", "Remove all character meshes"}, function()
	for _, mesh in pairs(character:GetDescendants()) do
		if mesh:IsA("DataModelMesh") then
			mesh:Destroy()
		end
	end
end)

cmd.add({"nodecals", "nodecal", "notextures"}, {"nodecals", "Remove all character images"}, function()
	for _, img in pairs(character:GetDescendants()) do
		if img:IsA("Decal") or img:IsA("Texture") then
			img:Destroy()
		end
	end
end)

cmd.add({"touchfling", "tfling"}, {"touchfling (tfling)", "Fling anyone that touches you using angular velocity"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Touchfling executed, press E to toggle";
	Title = "Nameless Admin";
	Duration = 5;
	
	});
_G.KeyCode = "E" loadstring(game:HttpGet("https://shattered-gang.lol/scripts/fe/touch_fling.lua"))()
end)

cmd.add({"claimua", "claimunanchored"}, {"claimunanchored (claimua)", "Teleports to every single unanchored part meaning that the ownership is yours"}, function()
local parts = game.Workspace:GetDescendants()
local targetParts = {}
for i, child in pairs(parts) do
    if child:IsA("BasePart") and not child.Anchored then
        table.insert(targetParts, child)
    end
end

local index = 1
while targetParts[index] do
    game.Players.LocalPlayer.Character:MoveTo(targetParts[index].Position)
    repeat wait(0.04) until (game.Players.LocalPlayer.Character.Humanoid.MoveDirection.Magnitude == 0) or (targetParts[index].Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 10
    index = index + 1
end
end)

--[ PLAYER ]--
cmd.add({"orbit"}, {"orbit <player> <distance>", "Orbit around a player"}, function(p,d)
	lib.disconnect("orbit")
	local players = argument.getPlayers(p)
	local target = players[1]
	if not target then return end
	
	local tchar, char = target.Character, character
	local thrp = tchar:FindFirstChild("HumanoidRootPart")
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local dist = tonumber(d) or 4
	
	if tchar and char and thrp and hrp then
		local sineX, sineZ = 0, math.pi/2
		lib.connect("orbit", RunService.Stepped:Connect(function()
			sineX, sineZ = sineX + 0.05, sineZ + 0.05
			local sinX, sinZ = math.sin(sineX), math.sin(sineZ)
			if thrp.Parent and hrp.Parent then
				hrp.Velocity = Vector3.new(0, 0, 0)
				hrp.CFrame = CFrame.new(sinX * dist, 0, sinZ * dist) *
					(hrp.CFrame - hrp.CFrame.p) +
					thrp.CFrame.p
			end
		end))
	end
end)

cmd.add({"uporbit"}, {"uporbit <player> <distance>", "Orbit around a player on the Y axis"}, function(p,d)
	lib.disconnect("orbit")
	local players = argument.getPlayers(p)
	local target = players[1]
	if not target then return end
	
	local tchar, char = target.Character, character
	local thrp = tchar:FindFirstChild("HumanoidRootPart")
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local dist = tonumber(d) or 4
	
	if tchar and char and thrp and hrp then
		local sineX, sineY = 0, math.pi/2
		lib.connect("orbit", RunService.Stepped:Connect(function()
			sineX, sineY = sineX + 0.05, sineY + 0.05
			local sinX, sinY = math.sin(sineX), math.sin(sineY)
			if thrp.Parent and hrp.Parent then
				hrp.Velocity = Vector3.new(0, 0, 0)
				hrp.CFrame = CFrame.new(sinX * dist, sinY * dist, 0) *
					(hrp.CFrame - hrp.CFrame.p) +
					thrp.CFrame.p
			end
		end))
	end
end)

cmd.add({"iplog", "infolog"}, {"iplog <playet>", "Stop orbiting a player"}, function(...)

Username = (...)
target = getPlr(Username)

local ip = math.random(100,200)
local ipp = math.random(50,100)
local ippp = math.random(50,100)
local ipppp = math.random(100,200)
local description = target.Name .. "'s ip is " .. ip .. "." .. ipp .. "." .. ippp .. "." .. ipppp

		
		
		wait();
		
		Notify({
		Description = description;
		Title = "Nameless Admin";
		Duration = 5;
		
		});
end)

cmd.add({"unorbit"}, {"unorbit", "Stop orbiting a player"}, function()
	lib.disconnect("orbit")
end)

cmd.add({"antikillbrick", "antikb"}, {"antikillbrick (antikb)", "Makes it so kill bricks cant kill you"}, function()
local player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local myzaza = false

UIS.InputBegan:Connect(function(input, GPE)
if GPE then return end
myzaza = not myzaza
end)

local parts = workspace:GetPartBoundsInRadius(player.Character:WaitForChild("HumanoidRootPart").Position, 10)
for _, part in ipairs(parts) do
part.CanTouch = myzaza
end
	end)

	cmd.add({"unantikillbrick", "unantikb"}, {"unantikillbrick (unantikb)", "Makes it so kill bricks can kill you"}, function()
		local player = game:GetService("Players").LocalPlayer
		local UIS = game:GetService("UserInputService")
		local myzaza = true
		
		UIS.InputBegan:Connect(function(input, GPE)
		if GPE then return end
		myzaza = not myzaza
		end)
		
		local parts = workspace:GetPartBoundsInRadius(player.Character:WaitForChild("HumanoidRootPart").Position, 10)
		for _, part in ipairs(parts) do
		part.CanTouch = myzaza
		end
			end)


cmd.add({"height", "hipheight", "hh"}, {"height <number> (hipheight, hh)", "Changes your hipheight"}, function(...)
	game.Players.LocalPlayer.Character.Humanoid.HipHeight = (...)
end)

cmd.add({"uadelete", "unanchoreddelete"}, {"unanchoredelete (uadelete)", "Gives you btools to delete unanchored parts"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Btools loading, wait 2 seconds.";
	Title = "Nameless Admin";
	Duration = 5;
	
	});
	local fenv = getfenv()
	local shp = fenv.sethiddenproperty or fenv.set_hidden_property or fenv.sethiddenprop or fenv.set_hidden_prop
	local ssr = fenv.setsimulationradius or fenv.setsimradius or fenv.set_simulation_radius
	
		net = shp and function(Radius) 
				shp(lp, "SimulationRadius", Radius) 
			end
			net = net or ssr
			wait(1)
			loadstring(game:HttpGet(('https://pastefy.ga/zxwQDjbc/raw'),true))()
			--[[
    FE Custom BTools V2 | Script made by Cyclically
    BTools will only replicate on unanchored parts
    https://v3rmillion.net/member.php?action=profile&uid=785986
    Don't edit script unless you know what you're doing. If you wanna add this into a script, please give credits and message me on discord that you added it in a script at Cyclically#4905
]]

local LocalPlayer = game:GetService("Players").LocalPlayer
local mouse = LocalPlayer:GetMouse()
local movetool = Instance.new("Tool", LocalPlayer.Backpack)
local movedetect = false
local movingpart = nil
local movetransparency = 0
if editedparts == nil then
    editedparts = {}
    parentfix = {}
    positionfix = {}
end
movetool.Name = "Move"
movetool.CanBeDropped = false
movetool.RequiresHandle = false
local function createnotification(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = 1;
    })
end
movetool.Activated:Connect(function()
    createnotification("Move Tool", "You are moving: "..mouse.Target.Name)
    movingpart = mouse.Target
    movedetect = true
    movingpart.CanCollide = false
    movetransparency = movingpart.Transparency
    movingpart.Transparency = 0.5
    mouse.TargetFilter = movingpart
    table.insert(editedparts, movingpart)
    table.insert(parentfix, movingpart.Parent)
    table.insert(positionfix, movingpart.CFrame)
    movingpart.Transparency = movingpart.Transparency / 2
    repeat
        mouse.Move:Wait()
        movingpart.CFrame = CFrame.new(mouse.Hit.p)
    until movedetect == false
end)
movetool.Deactivated:Connect(function()
    createnotification("Move Tool", "You have stopped moving: "..mouse.Target.Name)
    movingpart.CanCollide = true
    movedetect = false
    mouse.TargetFilter = nil
    movingpart.Transparency = movetransparenc
end)
	
end)

cmd.add({"netbypass", "netb"}, {"netbypass (netb)", "Net bypass"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Netbypass enabled";
	Title = "Nameless Admin";
	Duration = 5;
	
	});
	local fenv = getfenv()
	local shp = fenv.sethiddenproperty or fenv.set_hidden_property or fenv.sethiddenprop or fenv.set_hidden_prop
	local ssr = fenv.setsimulationradius or fenv.setsimradius or fenv.set_simulation_radius
	
		net = shp and function(Radius) 
				shp(lp, "SimulationRadius", Radius) 
			end
			net = net or ssr
end)

cmd.add({"day"}, {"day", "Makes it day"}, function()
game:GetService("Lighting").ClockTime = "12"
end)

cmd.add({"night"}, {"night", "Makes it night"}, function()
game:GetService("Lighting").ClockTime = "24"
end)

cmd.add({"night"}, {"night", "Makes it night"}, function()
game:GetService("Lighting").ClockTime = "24"
end)

cmd.add({"chat", "message"}, {"chat <text> (message)", "Chats you, useful if youre muted"}, function(...)
    message = (...)
     game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, 'All')
end)

cmd.add({"fixcam", "fix"}, {"fixcam", "Fix your camera"}, function()
	local workspace = game.Workspace
Players = game:GetService("Players")
local speaker = Players.LocalPlayer
workspace.CurrentCamera:remove()
	wait(.1)
	workspace.CurrentCamera.CameraSubject = speaker.Character:FindFirstChildWhichIsA('Humanoid')
	workspace.CurrentCamera.CameraType = "Custom"
	speaker.CameraMinZoomDistance = 0.5
	speaker.CameraMaxZoomDistance = 400
	speaker.CameraMode = "Classic"
	speaker.Character.Head.Anchored = false
end)

cmd.add({"fling2"}, {"fling2 <player>", "Fling the given player 2"}, function(...)
Target = (...)
flinghh = 1000

target = getPlr(Target)
game.Workspace.CurrentCamera.CameraSubject = target.Character.Humanoid


local lp = game.Players.LocalPlayer
for i,v in pairs(game.Players:GetPlayers()) do
    if v.Name:lower():match("^"..Target:lower()) or v.DisplayName:lower():match("^"..Target:lower()) then
        Target = v
        break
    end
end

if type(Target) == "string" then return end

local oldpos = lp.Character.HumanoidRootPart.CFrame
local oldhh = lp.Character.Humanoid.HipHeight

local carpetAnim = Instance.new("Animation")
carpetAnim.AnimationId = "rbxassetid://282574440"
carpet = lp.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(carpetAnim)
carpet:Play(.1, 1, 1)

local carpetLoop

local tTorso = Target.Character:FindFirstChild("Torso") or Target.Character:FindFirstChild("LowerTorso") or Target.Character:FindFirstChild("HumanoidRootPart")

spawn(function()
    carpetLoop = game:GetService('RunService').Heartbeat:Connect(function()
	    pcall(function()
	        if tTorso.Velocity.magnitude <= 28 then -- if target uses netless just target their local position
    	        local pos = {x=0, y=0, z=0}
        		pos.x = tTorso.Position.X
        		pos.y = tTorso.Position.Y
        		pos.z = tTorso.Position.Z
        		pos.x = pos.x + tTorso.Velocity.X / 2
        		pos.y = pos.y + tTorso.Velocity.Y / 2
        		pos.z = pos.z + tTorso.Velocity.Z / 2
    		    lp.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(pos.x,pos.y,pos.z))
    		else
    		    lp.Character.HumanoidRootPart.CFrame = tTorso.CFrame
		    end
	    end)
    end)
end)

wait()

lp.Character.Humanoid.HipHeight = flinghh

wait(.5)

carpetLoop:Disconnect()
game.Workspace.CurrentCamera.CameraSubject = target.Character.Humanoid
wait(1)
lp.Character.Humanoid.Health = 0
wait(game.Players.RespawnTime + .6)
lp.Character.HumanoidRootPart.CFrame = oldpos
end)

cmd.add({"fling"}, {"fling <player>", "Fling the given player"}, function(plr)
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local Targets = {plr}

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local AllBool = false

local GetPlayer = function(Name)
   Name = Name:lower()
   if Name == "all" or Name == "others" then
       AllBool = true
       return
   elseif Name == "random" then
       local GetPlayers = Players:GetPlayers()
       if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
       return GetPlayers[math.random(#GetPlayers)]
   elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
       for _,x in next, Players:GetPlayers() do
           if x ~= Player then
               if x.Name:lower():match("^"..Name) then
                   return x;
               elseif x.DisplayName:lower():match("^"..Name) then
                   return x;
               end
           end
       end
   else
       return
   end
end

local Message = function(_Title, _Text, Time)
   game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
end

local SkidFling = function(TargetPlayer)
   local Character = Player.Character
   local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
   local RootPart = Humanoid and Humanoid.RootPart

   local TCharacter = TargetPlayer.Character
   local THumanoid
   local TRootPart
   local THead
   local Accessory
   local Handle

   if TCharacter:FindFirstChildOfClass("Humanoid") then
       THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
   end
   if THumanoid and THumanoid.RootPart then
       TRootPart = THumanoid.RootPart
   end
   if TCharacter:FindFirstChild("Head") then
       THead = TCharacter.Head
   end
   if TCharacter:FindFirstChildOfClass("Accessory") then
       Accessory = TCharacter:FindFirstChildOfClass("Accessory")
   end
   if Accessoy and Accessory:FindFirstChild("Handle") then
       Handle = Accessory.Handle
   end

   if Character and Humanoid and RootPart then
       if RootPart.Velocity.Magnitude < 50 then
           getgenv().OldPos = RootPart.CFrame
       end
       if THumanoid and THumanoid.Sit and not AllBool then
       end
       if THead then
           workspace.CurrentCamera.CameraSubject = THead
       elseif not THead and Handle then
           workspace.CurrentCamera.CameraSubject = Handle
       elseif THumanoid and TRootPart then
           workspace.CurrentCamera.CameraSubject = THumanoid
       end
       if not TCharacter:FindFirstChildWhichIsA("BasePart") then
           return
       end
       
       local FPos = function(BasePart, Pos, Ang)
           RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
           Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
           RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
           RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
       end
       
       local SFBasePart = function(BasePart)
           local TimeToWait = 2
           local Time = tick()
           local Angle = 0

           repeat
               if RootPart and THumanoid then
                   if BasePart.Velocity.Magnitude < 50 then
                       Angle = Angle + 100

                       FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                       task.wait()
                   else
                       FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                       task.wait()
                       
                       FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                       task.wait()
                   end
               else
                   break
               end
           until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
       end
       
       workspace.FallenPartsDestroyHeight = 0/0
       
       local BV = Instance.new("BodyVelocity")
       BV.Name = "EpixVel"
       BV.Parent = RootPart
       BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
       BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
       
       Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
       
       if TRootPart and THead then
           if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
               SFBasePart(THead)
           else
               SFBasePart(TRootPart)
           end
       elseif TRootPart and not THead then
           SFBasePart(TRootPart)
       elseif not TRootPart and THead then
           SFBasePart(THead)
       elseif not TRootPart and not THead and Accessory and Handle then
           SFBasePart(Handle)
       else
       end
       
       BV:Destroy()
       Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
       workspace.CurrentCamera.CameraSubject = Humanoid
       
       repeat
           RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
           Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
           Humanoid:ChangeState("GettingUp")
           table.foreach(Character:GetChildren(), function(_, x)
               if x:IsA("BasePart") then
                   x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
               end
           end)
           task.wait()
       until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
       workspace.FallenPartsDestroyHeight = getgenv().FPDH
   else
   end
end

getgenv().Welcome = true
if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end

if AllBool then
   for _,x in next, Players:GetPlayers() do
       SkidFling(x)
   end
end

for _,x in next, Targets do
   if GetPlayer(x) and GetPlayer(x) ~= Player then
       if GetPlayer(x).UserId ~= 1414978355 then
           local TPlayer = GetPlayer(x)
           if TPlayer then
               SkidFling(TPlayer)
           end
       else
       end
   elseif not GetPlayer(x) and not AllBool then
   end
end
end)

cmd.add({"bypassedfling", "bfling", "nocolfling", "nocollisionfling"}, {"bypassedfling (bfling, nocolfling, nocollisionfling)", "Bypasses the games without collisions that try to stop flingers"}, function(...)
--Pusher made by rouxhaver/1+1=2
--Hat resizer and dropper made by DigitalityScripts

--This script sometimes works in games without player-collision

--INSTRUCTIONS:
--use r15 body type
--have a classic Rthro Head 
--wear any Rthro Hats

--RECOMMENDED:
--https://www.roblox.com/catalog/2493588193/Knights-of-Redcliff-Paladin-Head
--https://www.roblox.com/catalog/4381828509/Junkbot-Hat
--https://www.roblox.com/catalog/2493590711/Knights-of-Redcliff-Paladin-Helmet
--https://www.roblox.com/catalog/2493718915/The-High-Seas-Beatrix-The-Pirate-Queen-Hat

loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/hat%20resize%20%2B%20drop'))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rouxhaver/random-sh-t/main/non%20local%20free%20cam%20start.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rouxhaver/random-sh-t/main/Credit"))()

ToggleFreecam() -- Remove this if you don't want free cam or etcetera

player = game.Players.LocalPlayer

mouse = player:GetMouse()

for i,v in pairs(player.Character:GetChildren()) do
    if v:IsA("Accessory") then
        _ = Instance.new("SelectionBox",v)
        _.Adornee = v.Handle
        game.RunService.Heartbeat:Connect(function()
            v.Handle.CustomPhysicalProperties = PhysicalProperties.new(0,0,0,0,0)
            v.Handle.Velocity = Vector3.new(25.70,0,0)
            v.Handle.CanCollide = false
        end)
        if e ~= "e" then                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            game.Players.LocalPlayer:Kick() 
        end
        coroutine.wrap(function()
            while task.wait() do
                v.Handle.Position = mouse.Hit.Position + Vector3.new(math.random(-15,15),math.random(0,15),math.random(-15,15))
                v.Handle.Orientation = Vector3.new(math.random(-180,180),math.random(-180,180),math.random(-180,180))
            end
        end)()
    end
end
end)

cmd.add({"commitoof", "suicide", "kys"}, {"commitoof (suicide, kys)", "FE KILL YOURSELF SCRIPT this will be bad when taken out of context"}, function()
	local A_1 = "Alright, im gonna do it."
		local A_2 = "All"
		local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
		Event:FireServer(A_1, A_2)
		wait(1)
		local A_1 = "I'm going to commit oof."
		local A_2 = "All"
		local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
		Event:FireServer(A_1, A_2)
		wait(1)
		local A_1 = "Goodbye cruel world."
		local A_2 = "All"
		local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
		Event:FireServer(A_1, A_2)
		wait(1)
		LocalPlayer = game:GetService("Players").LocalPlayer
		LocalPlayer.Character.Humanoid:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position + LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 10)
		LocalPlayer.Character.Humanoid.Jump = true
		wait(0.5)
		function Iterate(instance, func)
		for i, v in next, instance:GetChildren() do
		func(v)
		end
		end
		limbs = {
		["Right Leg"] = true;
		["Right Arm"] = true;
		["Left Leg"] = true;
		["Left Arm"] = true;
		}
		Iterate(LocalPlayer.Character, function(v)
		if v:IsA("BasePart") then
		local attachment = Instance.new("Attachment")
		attachment.Parent = v
		attachment.Name = (v.Name .. "[Attachment]")
		if limbs[v.Name] then
		attachment.Position = Vector3.new(0, v.Size.Y/2, 0)
		elseif v.Name == "Head" then
		attachment.Position = Vector3.new(0, -v.Size.Y/2, 0)
		attachment.Rotation = Vector3.new(0, 0, -90)
		end
		end
		end)
		local leftLegAttachment = Instance.new("Attachment")
		leftLegAttachment.Position = Vector3.new(-.5, -1, 0)
		leftLegAttachment.Rotation = Vector3.new(0, -90, 0)
		local rightLegAttachment = Instance.new("Attachment")
		rightLegAttachment.Position = Vector3.new(.5, -1, 0)
		rightLegAttachment.Rotation = Vector3.new(0, -90, 0)
		rightLegAttachment.Parent, leftLegAttachment.Parent = LocalPlayer.Character.Torso, LocalPlayer.Character.Torso
		jointAttachments = {
		['Head'] = {
		['Attachment0'] = LocalPlayer.Character.Torso['NeckAttachment'];
		['Attachment1'] = LocalPlayer.Character.Head['Head[Attachment]'];
		};
		['Left Arm'] = {
		['Attachment0'] = LocalPlayer.Character.Torso['LeftCollarAttachment'];
		['Attachment1'] = LocalPlayer.Character['Left Arm']['Left Arm[Attachment]'];
		};
		['Right Arm'] = {
		['Attachment0'] = LocalPlayer.Character.Torso['RightCollarAttachment'];
		['Attachment1'] = LocalPlayer.Character['Right Arm']['Right Arm[Attachment]'];
		};
		['Left Leg'] = {
		['Attachment0'] = leftLegAttachment;
		['Attachment1'] = LocalPlayer.Character['Left Leg']['Left Leg[Attachment]'];
		};
		['Right Leg'] = {
		['Attachment0'] = rightLegAttachment;
		['Attachment1'] = LocalPlayer.Character['Right Leg']['Right Leg[Attachment]'];
		};
		}
		LocalPlayer.Character.Humanoid.PlatformStand = true
		Iterate(LocalPlayer.Character, function(v)
		if v:IsA("BasePart") then
		if jointAttachments[v.Name] then
		local ballSocketJoint = Instance.new("BallSocketConstraint")
		ballSocketJoint.Parent = v
		ballSocketJoint.Radius = 0.15
		ballSocketJoint.Attachment0, ballSocketJoint.Attachment1 = jointAttachments[v.Name]['Attachment0'], jointAttachments[v.Name]['Attachment1']
		end
		end
		end)
		Iterate(LocalPlayer.Character.Torso, function(v)
		if v:IsA("Motor") then
		v:Remove()
		end
		game.Players.LocalPlayer.Character.Humanoid.Health = 0
		end)
end)

cmd.add({"goto", "to", "tp", "teleport"}, {"goto <player/X,Y,Z>", "Teleport to the given player or X,Y,Z coordinates"}, function(...)
	Username = (...)

	local target = getPlr(Username)
	getChar().HumanoidRootPart.CFrame = target.Character.Humanoid.RootPart.CFrame
end)

cmd.add({"watch", "view", "specate"}, {"view <player>", "Watch the given player"}, function(...)
game.Workspace.CurrentCamera.CameraSubject = character:FindFirstChildWhichIsA("Humanoid")
	view = false
wait(0.3)
	view = true
Username = (...)

local target = getPlr(Username)
repeat wait()
workspace.CurrentCamera.CameraSubject = target.Character.Humanoid
until view == false
end)

cmd.add({"unwatch", "unview", "unspectate"}, {"unview", "Stop watching a player"}, function()
local character = game.Players.LocalPlayer.Character
view = false
wait(0.3)
game.Workspace.CurrentCamera.CameraSubject = character:FindFirstChildWhichIsA("Humanoid")
end)

cmd.add({"copyaudio", "getaudio"}, {"copyaudio <player>", "Copy all sounds a player is playing to your clipboard  -Cyrus"}, function(p)
	local players = argument.getPlayers(p)
	local audios = ""
	for _, player in pairs(players) do
		local char = player.Character
		if char then
			audios = audios .. ("<<[ %s ]>>"):format(player.Name)
			for i, v in pairs(char:GetDescendants()) do
				if v:IsA("Sound") and v.Playing then
					audios = audios .. ("\n[ %s ]: %s"):format(v.Name, v.SoundId)
				end
			end
		end
	end
	setclipboard(audios)
end)

cmd.add({"pp", "penis"}, {"penis (pp)", "benis :flushed:"}, function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/pp"))()
end)

cmd.add({"stealaudio", "getaudio", "steal", "logaudio"}, {"stealaudio <player> (getaudio, logaudio, steal)", "Save all sounds a player is playing to a file  -Cyrus"}, function(p)
	
	
	
	wait();
	
	Notify({
	Description = "Audio link has been copied to your clipboard";
	Title = "Nameless Admin";
	Duration = 5;
	
});
local players = argument.getPlayers(p)
	local audios = ""
	for _, player in pairs(players) do
		local char = player.Character
		if char then
			for i, v in pairs(char:GetDescendants()) do
				if v:IsA("Sound") and v.Playing then
					audios = audios .. ("%s"):format(v.SoundId)
				end
			end
		end
	end
setclipboard(audios)
end)

cmd.add({"follow", "stalk", "walk"}, {"follow <player>", "Follow a player wherever they go"}, function(p)
	lib.disconnect("follow")
	local players = argument.getPlayers(p)
	local targetPlayer = players[1]
	lib.connect("follow", RunService.Stepped:Connect(function()
		local target = targetPlayer.Character
		if target and character then
			local hum = character:FindFirstChildWhichIsA("Humanoid")
			if hum then
				local targetPart = target:FindFirstChild("Head")
				local targetPos = targetPart.Position
				hum:MoveTo(targetPos)
			end
		end
	end))
end)

cmd.add({"pathfind"}, {"pathfind <player>", "Follow a player using the pathfinder API wherever they go"}, function(p)
	lib.disconnect("follow")
	local players = argument.getPlayers(p)
	local targetPlayer = players[1]
	local debounce = false
	lib.connect("follow", RunService.Stepped:Connect(function()
		if debounce then return end
		debounce = true
		local target = targetPlayer.Character
		if target and character then
			local hum = character:FindFirstChildWhichIsA("Humanoid")
			local main = target:FindFirstChild("HumanoidRootPart")
			if hum then
				local targetPart = target:FindFirstChild("HumanoidRootPart") or target:FindFirstChild("Head")
				local targetPos = (targetPart.CFrame * CFrame.new(0, 0, -0.5)).p
				local PathService = game:GetService("PathfindingService")
				local path = PathService:CreatePath({
					AgentRadius = 2,
					AgentHeight = 5,
					AgentCanJump = true
				})
				local points = path:ComputeAsync(main.Position, targetPos)
				
				if path.Status then
					local waypoints = path:GetWaypoints()
					for i, waypoint in pairs(waypoints) do
						if i > 2 then break end
						if waypoint.Action == Enum.PathWaypointAction.Jump then
							hum.Jump = true
						end
						hum:MoveTo(waypoint.Position)
						local distance = 5
						repeat
							wait()
							distance = (waypoint.Position - main.Position).magnitude
						until
							(targetPos - targetPart.Position).magnitude > 2 or distance < 1

						if (targetPos - targetPart.Position).magnitude > 2 then
							break
						end
					end
				end
			end
		end
		debounce = false
	end))
end)

cmd.add({"unfollow", "unstalk", "unwalk", "unpathfind"}, {"unfollow", "Stop all attempts to follow a player"}, function()
	lib.disconnect("follow")
end)

cmd.add({"fechat"}, {"fechat", "/e chat displayname"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "FEChat enabled, /e chat displayname to use";
	Title = "Nameless Admin";
	Duration = 5;
	
});
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rouxhaver/scripts/main/FE%20chat%20for%20someone.Lua"))()
end)

cmd.add({"translatechat"}, {"translatechat", "translates the chat using google translate api"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Chat translated";
	Title = "Nameless Admin";
	Duration = 5;
	
});
	loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/x114/RobloxScripts/main/UpdatedChatTranslator"))()
end)

cmd.add({"freeze", "thaw", "anchor"}, {"freeze (thaw, anchor)", "Freezes your character"}, function()
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
end)

cmd.add({"unfreeze", "unthaw", "unanchor"}, {"unfreeze (unthaw, unanchor)", "Unfreezes your character"}, function()
game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
end)

cmd.add({"disableanimations", "disableanims"}, {"disableanimations (disableanims)", "Freezes your animations"}, function()
game.Players.LocalPlayer.Character.Animate.Disabled = true
end)

cmd.add({"undisableanimations", "undisableanims"}, {"undisableanimations (undisableanims)", "Unfreezes your animations"}, function(...)
game.Players.LocalPlayer.Character.Animate.Disabled = false
end)

cmd.add({"headkill", "hkill"}, {"headkill <player> (hkill)", "Need an rthro head"}, function(...)
	for i,v in pairs(game.Players.LocalPlayer.Character.Humanoid:GetChildren()) do
		if string.find(v.Name,"Scale") and v.Name ~= "HeadScale" then
			repeat wait(HeadGrowSpeed) until game.Players.LocalPlayer.Character.Head:FindFirstChild("OriginalSize")
			game.Players.LocalPlayer.Character.Head.OriginalSize:Destroy()
			v:Destroy()
			game.Players.LocalPlayer.Character.Head:WaitForChild("OriginalSize")
		end
	 end
	 Target = (...)

if Target == "all" or Target == "others" then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Kill%20All'))()
else
local function Kill()
            if not getPlr(Target) then
            end
            
            repeat game:FindService("RunService").Heartbeat:wait() until getPlr(Target).Character and getPlr(Target).Character:FindFirstChildOfClass("Humanoid") and getPlr(Target).Character:FindFirstChildOfClass("Humanoid").Health > 0
            local Character
            local Humanoid
            local RootPart
            local Tool
            local Handle
            
            local TPlayer = getPlr(Target)
            local TCharacter = TPlayer.Character
            local THumanoid
            local TRootPart
            
            if Player.Character and Player.Character and Player.Character.Name == Player.Name then
                Character = Player.Character
            else
            end
            if Character:FindFirstChildOfClass("Humanoid") then
                Humanoid = Character:FindFirstChildOfClass("Humanoid")
            else
            end
            if Humanoid and Humanoid.RootPart then
                RootPart = Humanoid.RootPart
            else
            end
            if Character:FindFirstChildOfClass("Tool") then
                Tool = Character:FindFirstChildOfClass("Tool")
            elseif Player.Backpack:FindFirstChildOfClass("Tool") and Humanoid then
                Tool = Player.Backpack:FindFirstChildOfClass("Tool")
                Humanoid:EquipTool(Player.Backpack:FindFirstChildOfClass("Tool"))
            else
            end
            if Tool and Tool:FindFirstChild("Handle") then
                Handle = Tool.Handle
            else
            end
            
            --Target
            if TCharacter:FindFirstChildOfClass("Humanoid") then
                THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
            else
                return Message("Error",">   Missing Target Humanoid")
            end
            if THumanoid.RootPart then
                TRootPart = THumanoid.RootPart
            else
                return Message("Error",">   Missing Target RootPart")
            end
            
            if THumanoid.Sit then
                return Message("Error",">   Target is seated")
            end
            
            local OldCFrame = RootPart.CFrame
            
            Humanoid:Destroy()
            local NewHumanoid = Humanoid:Clone()
            NewHumanoid.Parent = Character
            NewHumanoid:UnequipTools()
            NewHumanoid:EquipTool(Tool)
            Tool.Parent = workspace
        
            local Timer = os.time()
        
            repeat
                if (TRootPart.CFrame.p - RootPart.CFrame.p).Magnitude < 500 then
                    Tool.Grip = CFrame.new()
                    Tool.Grip = Handle.CFrame:ToObjectSpace(TRootPart.CFrame):Inverse()
                end
                firetouchinterest(Handle,TRootPart,0)
                firetouchinterest(Handle,TRootPart,1)
                game:FindService("RunService").Heartbeat:wait()
            until Tool.Parent ~= Character or not TPlayer or not TRootPart or THumanoid.Health <= 0 or os.time() > Timer + .20
            Player.Character = nil
            NewHumanoid.Health = 0
            player.CharacterAdded:wait(1)
            repeat game:FindService("RunService").Heartbeat:wait() until Player.Character:FindFirstChild("HumanoidRootPart")
            Player.Character.HumanoidRootPart.CFrame = OldCFrame
end
      
        if not LoopKill then
            Kill()
        else
            while LoopKill do
                Kill()
            end
        end
         end
end)

cmd.add({"headbring", "hbring"}, {"headbring <player> (headbring)", "Need an rthro head"}, function(...)
	for i,v in pairs(game.Players.LocalPlayer.Character.Humanoid:GetChildren()) do
		if string.find(v.Name,"Scale") and v.Name ~= "HeadScale" then
			repeat wait(HeadGrowSpeed) until game.Players.LocalPlayer.Character.Head:FindFirstChild("OriginalSize")
			game.Players.LocalPlayer.Character.Head.OriginalSize:Destroy()
			v:Destroy()
			game.Players.LocalPlayer.Character.Head:WaitForChild("OriginalSize")
		end
	 end
	 local Target = (...) 
	 if Target == "all" or Target == "others" then
 loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Bring%20All'))()
 end
			 local Character = Player.Character        
			 local PlayerGui = Player:waitForChild("PlayerGui")
			 local Backpack = Player:waitForChild("Backpack")
			 local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
			 local RootPart = Character and Humanoid and Humanoid.RootPart or false
			 local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
			 if not Humanoid or not RootPart or not RightArm then
				 return
			 end
			 Humanoid:UnequipTools()
			 local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
			 if not MainTool or not MainTool:FindFirstChild("Handle") then
				 return
			 end
			 local TPlayer = getPlr(Target)
			 local TCharacter = TPlayer and TPlayer.Character
			 local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
			 local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
			 if not THumanoid or not TRootPart then
				 return
			 end
			 Character.Humanoid.Name = "DAttach"
			 local l = Character["DAttach"]:Clone()
			 l.Parent = Character
			 l.Name = "Humanoid"
			 wait()
			 Character["DAttach"]:Destroy()
			 game.Workspace.CurrentCamera.CameraSubject = Character
			 Character.Animate.Disabled = true
			 wait()
			 Character.Animate.Disabled = false
			 Character.Humanoid:EquipTool(MainTool)
			 wait()
			 CF = Player.Character.PrimaryPart.CFrame
			 if firetouchinterest then
				 local flag = false
				 task.defer(function()
					 MainTool.Handle.AncestryChanged:wait()
					 flag = true
				 end)
				 repeat
					 firetouchinterest(MainTool.Handle, TRootPart, 0)
					 firetouchinterest(MainTool.Handle, TRootPart, 1)
					 wait()
					 Player.Character.HumanoidRootPart.CFrame = CF
				 until flag
			 else
				 Player.Character.HumanoidRootPart.CFrame =
				 TCharacter.HumanoidRootPart.CFrame
				 wait()
				 Player.Character.HumanoidRootPart.CFrame =
				 TCharacter.HumanoidRootPart.CFrame
				 wait()
				 Player.Character.HumanoidRootPart.CFrame = CF
				 wait()
			 end
			 wait(.3)
			 Player.Character:SetPrimaryPartCFrame(CF)
			 if Humanoid.RigType == Enum.HumanoidRigType.R6 then
				 Character["Right Arm"].RightGrip:Destroy()
			 else
				 Character["RightHand"].RightGrip:Destroy()
				 Character["RightHand"].RightGripAttachment:Destroy()
			 end
				 
			 wait(4)
			 CF = Player.Character.HumanoidRootPart.CFrame
			 player.CharacterAdded:wait(1):waitForChild("HumanoidRootPart").CFrame = CF
end)

cmd.add({"headvoid", "hvoid"}, {"headvoid <player> (hvoid)", "Need an rthro head"}, function(...)
					Player.Character.HumanoidRootPart.CFrame = CFrame.new(0,-349,0)

	for i,v in pairs(game.Players.LocalPlayer.Character.Humanoid:GetChildren()) do
		if string.find(v.Name,"Scale") and v.Name ~= "HeadScale" then
			repeat wait(HeadGrowSpeed) until game.Players.LocalPlayer.Character.Head:FindFirstChild("OriginalSize")
			game.Players.LocalPlayer.Character.Head.OriginalSize:Destroy()
			v:Destroy()
			game.Players.LocalPlayer.Character.Head:WaitForChild("OriginalSize")
		end
	 end
	 Target = (...)
local Character = Player.Character
local PlayerGui = Player:waitForChild("PlayerGui")
local Backpack = Player:waitForChild("Backpack")
local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
local RootPart = Character and Humanoid and Humanoid.RootPart or false
local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
if not Humanoid or not RootPart or not RightArm then
return
end

Humanoid:UnequipTools()
local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
if not MainTool or not MainTool:FindFirstChild("Handle") then
return
end

local TPlayer = getPlr(Target)
local TCharacter = TPlayer and TPlayer.Character

local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
if not THumanoid or not TRootPart then
return
end

Character.Humanoid.Name = "DAttach"
local l = Character["DAttach"]:Clone()
l.Parent = Character
l.Name = "Humanoid"
wait()
Character["DAttach"]:Destroy()
game.Workspace.CurrentCamera.CameraSubject = Character
Character.Animate.Disabled = true
wait()
Character.Animate.Disabled = false
Character.Humanoid:EquipTool(MainTool)
wait()
CF = Player.Character.PrimaryPart.CFrame
XC = TCharacter.HumanoidRootPart.CFrame.X
ZC = TCharacter.HumanoidRootPart.CFrame.Z
if firetouchinterest then
local flag = false
task.defer(function()
	MainTool.Handle.AncestryChanged:wait()
	flag = true
end)
repeat
	firetouchinterest(MainTool.Handle, TRootPart, 0)
	firetouchinterest(MainTool.Handle, TRootPart, 1)
	wait()
	Player.Character.HumanoidRootPart.CFrame = CFrame.new(XC,-99,ZC)
until flag
else
Player.Character.HumanoidRootPart.CFrame =
TCharacter.HumanoidRootPart.CFrame
wait()
Player.Character.HumanoidRootPart.CFrame =
TCharacter.HumanoidRootPart.CFrame
wait()
Player.Character.HumanoidRootPart.CFrame = CFrame.new(XC,-99,ZC)
wait()
end
wait(.3)
Player.Character:SetPrimaryPartCFrame(CF)
if Humanoid.RigType == Enum.HumanoidRigType.R6 then
Character["Right Arm"].RightGrip:Destroy()
else
Character["RightHand"].RightGrip:Destroy()
Character["RightHand"].RightGripAttachment:Destroy()
end
wait(1)
respawn()
end)

cmd.add({"headresize"}, {"headresize", "Makes your head very big r15 only"}, function()
for i,v in pairs(game.Players.LocalPlayer.Character.Humanoid:GetChildren()) do
   if string.find(v.Name,"Scale") and v.Name ~= "HeadScale" then
       repeat wait(HeadGrowSpeed) until game.Players.LocalPlayer.Character.Head:FindFirstChild("OriginalSize")
       game.Players.LocalPlayer.Character.Head.OriginalSize:Destroy()
       v:Destroy()
       game.Players.LocalPlayer.Character.Head:WaitForChild("OriginalSize")
   end
end
end)

cmd.add({"hatresize"}, {"hatresize", "Makes your hats very big r15 only"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Hat resize loaded, rthro needed.";
	Title = "Nameless Admin";
	Duration = 5;
	
});

loadstring(game:HttpGet('https://github.com/DigitalityScripts/roblox-scripts/raw/main/hat%20resize'))()
end)

cmd.add({"legresize"}, {"legresize", "Makes your legs very big r15 only"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Leg resize loaded, R15 only";
	Title = "Nameless Admin";
	Duration = 5;
	
});
game.Players.LocalPlayer.Character.Animate.Disabled = true
	loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Leg%20Resize'))()
end)

cmd.add({"fat", "nikocadoavocado"}, {"fat (nikocadoavocado)", "fat"}, function()
	local LocalPlayer = game:GetService("Players").LocalPlayer
	local Character = LocalPlayer.Character
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	
	local function rm()
		for i,v in pairs(Character:GetDescendants()) do
					if v:FindFirstChild("AvatarPartScaleType") then
						v:FindFirstChild("AvatarPartScaleType"):Destroy()
					end
				end
			end
	
	
	rm()
	wait(0.1)
	Humanoid:FindFirstChild("BodyWidthScale"):Destroy()
	wait(0.2)
	
	rm()
	wait(0.5)
	Humanoid:FindFirstChild("BodyTypeScale"):Destroy()
	wait(0.2)
end)

cmd.add({"small"}, {"small", "Makes you short r15 only"}, function()
	


wait();

Notify({
Description = "Making you small.. r15 needed";
Title = "Nameless Admin";
Duration = 5;

});
	--Shit ass script made by failedmite57926

local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character
local Humanoid = Character:FindFirstChildOfClass("Humanoid")

local function rm()
	for i,v in pairs(Character:GetDescendants()) do
		if v:IsA("BasePart") then
			if v.Name ~= "Head" then
				for i,cav in pairs(v:GetDescendants()) do
					if cav:IsA("Attachment") then
						if cav:FindFirstChild("OriginalPosition") then
							cav.OriginalPosition:Destroy()
						end
					end
				end
				v:FindFirstChild("OriginalSize"):Destroy()
				if v:FindFirstChild("AvatarPartScaleType") then
					v:FindFirstChild("AvatarPartScaleType"):Destroy()
				end
			end
		end
	end
end

rm()
wait(0.5)
Humanoid:FindFirstChild("BodyTypeScale"):Destroy()
wait(0.2)

rm()
wait(0.5)
Humanoid:FindFirstChild("BodyWidthScale"):Destroy()
wait(0.2)

rm()
wait(0.5)
Humanoid:FindFirstChild("BodyDepthScale"):Destroy()
wait(0.2)

rm()
wait(0.5)
Humanoid:FindFirstChild("HeadScale"):Destroy()
wait(0.2)
end)

cmd.add({"loopfling"}, {"loopfling <player>", "Loop voids a player"}, function(plr)
    local Targets = {plr}
    
	Loopvoid = true
	repeat wait()
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local AllBool = false

local GetPlayer = function(Name)
   Name = Name:lower()
   if Name == "all" or Name == "others" then
       AllBool = true
       return
   elseif Name == "random" then
       local GetPlayers = Players:GetPlayers()
       if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
       return GetPlayers[math.random(#GetPlayers)]
   elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
       for _,x in next, Players:GetPlayers() do
           if x ~= Player then
               if x.Name:lower():match("^"..Name) then
                   return x;
               elseif x.DisplayName:lower():match("^"..Name) then
                   return x;
               end
           end
       end
   else
       return
   end
end

local Message = function(_Title, _Text, Time)
   game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
end

local SkidFling = function(TargetPlayer)
   local Character = Player.Character
   local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
   local RootPart = Humanoid and Humanoid.RootPart

   local TCharacter = TargetPlayer.Character
   local THumanoid
   local TRootPart
   local THead
   local Accessory
   local Handle

   if TCharacter:FindFirstChildOfClass("Humanoid") then
       THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
   end
   if THumanoid and THumanoid.RootPart then
       TRootPart = THumanoid.RootPart
   end
   if TCharacter:FindFirstChild("Head") then
       THead = TCharacter.Head
   end
   if TCharacter:FindFirstChildOfClass("Accessory") then
       Accessory = TCharacter:FindFirstChildOfClass("Accessory")
   end
   if Accessoy and Accessory:FindFirstChild("Handle") then
       Handle = Accessory.Handle
   end

   if Character and Humanoid and RootPart then
       if RootPart.Velocity.Magnitude < 50 then
           getgenv().OldPos = RootPart.CFrame
       end
       if THumanoid and THumanoid.Sit and not AllBool then
           return Message("Error Occurred", "Targeting is sitting", 5) -- u can remove dis part if u want lol
       end
       if THead then
           workspace.CurrentCamera.CameraSubject = THead
       elseif not THead and Handle then
           workspace.CurrentCamera.CameraSubject = Handle
       elseif THumanoid and TRootPart then
           workspace.CurrentCamera.CameraSubject = THumanoid
       end
       if not TCharacter:FindFirstChildWhichIsA("BasePart") then
           return
       end
       
       local FPos = function(BasePart, Pos, Ang)
           RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
           Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
           RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
           RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
       end
       
       local SFBasePart = function(BasePart)
           local TimeToWait = 2
           local Time = tick()
           local Angle = 0

           repeat
               if RootPart and THumanoid then
                   if BasePart.Velocity.Magnitude < 50 then
                       Angle = Angle + 100

                       FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                       task.wait()
                   else
                       FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                       task.wait()
                       
                       FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                       task.wait()

                       FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                       task.wait()
                   end
               else
                   break
               end
           until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
       end
       
       workspace.FallenPartsDestroyHeight = 0/0
       
       local BV = Instance.new("BodyVelocity")
       BV.Name = "EpixVel"
       BV.Parent = RootPart
       BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
       BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
       
       Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
       
       if TRootPart and THead then
           if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
               SFBasePart(THead)
           else
               SFBasePart(TRootPart)
           end
       elseif TRootPart and not THead then
           SFBasePart(TRootPart)
       elseif not TRootPart and THead then
           SFBasePart(THead)
       elseif not TRootPart and not THead and Accessory and Handle then
           SFBasePart(Handle)
       else
           return Message("Error Occurred", "Target is missing everything", 5)
       end
       
       BV:Destroy()
       Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
       workspace.CurrentCamera.CameraSubject = Humanoid
       
       repeat
           RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
           Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
           Humanoid:ChangeState("GettingUp")
           table.foreach(Character:GetChildren(), function(_, x)
               if x:IsA("BasePart") then
                   x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
               end
           end)
           task.wait()
       until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
       workspace.FallenPartsDestroyHeight = getgenv().FPDH
   else
       return Message("Error Occurred", "Random error", 5)
   end
end

if not Welcome then Message("Script by AnthonyIsntHere", "Enjoy!", 5) end
getgenv().Welcome = true
if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end

if AllBool then
   for _,x in next, Players:GetPlayers() do
       SkidFling(x)
   end
end

for _,x in next, Targets do
   if GetPlayer(x) and GetPlayer(x) ~= Player then
       if GetPlayer(x).UserId ~= 1414978355 then
           local TPlayer = GetPlayer(x)
           if TPlayer then
               SkidFling(TPlayer)
           end
       else
           Message("Error Occurred", "This user is whitelisted! (Owner)", 5)
       end
   elseif not GetPlayer(x) and not AllBool then
       Message("Error Occurred", "Username Invalid", 5)
   end
end
	until Loopvoid == false
end)

cmd.add({"freegamepass", "freegp"}, {"freegamepass (freegp)", "Makes the client think you own every gamepass in the game"}, function()
local mt = getrawmetatable(game);
local old = mt.__namecall
local readonly = setreadonly or make_writeable

local MarketplaceService = game:GetService("MarketplaceService");

readonly(mt, false);

mt.__namecall = function(self, ...)
   local args = {...}
   local method = table.remove(args)

   if (self == MarketplaceService and method:find("UserOwnsGamePassAsync")) then
       return true and 1
   end

   return old(self, ...)
end
		


wait();

Notify({
Description = "Free gamepass has been executed, keep in mind this wont always work.";
Title = "Nameless Admin";
Duration = 5;

});
end)

cmd.add({"bang", "fuck"}, {"bang <player>", "Bangs the player by attaching to them"}, function(...)
	RunService = game:GetService("RunService")
	
	function getTorso(x)
		x = x or game.Players.LocalPlayer.Character
		return x:FindFirstChild("Torso") or x:FindFirstChild("UpperTorso") or x:FindFirstChild("LowerTorso") or x:FindFirstChild("HumanoidRootPart")
	end
	
	function getRoot(char)
		local rootPart = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart') or game.Players.LocalPlayer.Character:FindFirstChild('Torso') or game.Players.LocalPlayer.Character:FindFirstChild('UpperTorso')
		return rootPart
	end
	
	speed = "10"
	
	Username = (...)
	
	local players = getPlr(Username)
			bangAnim = Instance.new("Animation")
			if not r15(game.Players.LocalPlayer) then
				bangAnim.AnimationId = "rbxassetid://148840371"
			else
				bangAnim.AnimationId = "rbxassetid://5918726674"
			end
			bang = game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(bangAnim)
			bang:Play(.1, 1, 1)
			if speed then
				bang:AdjustSpeed(speed)
			else
				bang:AdjustSpeed(3)
			end
			local bangplr = players.Name
			bangDied = game.Players.LocalPlayer.Character:FindFirstChildOfClass'Humanoid'.Died:Connect(function()
				bangLoop = bangLoop:Disconnect()
				bang:Stop()
				bangAnim:Destroy()
				bangDied:Disconnect()
			end)
			local bangOffet = CFrame.new(0, 0, 1.1)
			bangLoop = RunService.Stepped:Connect(function()
				pcall(function()
					local otherRoot = getTorso(game.Players[bangplr].Character)
					getRoot(game.Players.LocalPlayer.Character).CFrame = otherRoot.CFrame * bangOffet
				end)
			end)

			
			
			
			wait();
			
			Notify({
			Description = "Banging player...";
			Title = "Nameless Admin";
			Duration = 5;
			
			});
end)

cmd.add({"spook", "scare"}, {"spook <player> (scare)", "Teleports next to a player for a few seconds"}, function(...)

LocalPlayer = game.Players.LocalPlayer
Username = (...)
Target = getPlr(Username)

local oldCF = LocalPlayer.Character.HumanoidRootPart.CFrame
  Target = getPlr(Username)    
                distancepl = 2
                if Target.Character and Target.Character:FindFirstChild('Humanoid') then
                        LocalPlayer.Character.HumanoidRootPart.CFrame =
                                Target.Character.HumanoidRootPart.CFrame +  Target.Character.HumanoidRootPart.CFrame.lookVector * distancepl
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, Target.Character.HumanoidRootPart.Position)
                        wait(.5)
                        LocalPlayer.Character.HumanoidRootPart.CFrame = oldCF
                end
        
end)

cmd.add({"unbang", "unfuck"}, {"unbang", "Unbangs the player"}, function()
    	if bangLoop then
		bangLoop = bangLoop:Disconnect()
		bang:Stop()
		bangAnim:Destroy()
		bangDied:Disconnect()
end
end)

cmd.add({"unairwalk", "unaw"}, {"unairwalk (unaw)", "Stops the airwalk command"}, function()
	local function SendNotification(Title, Text, Label, Length)
		game.StarterGui:SetCore('SendNotification', {Title = Title; Text = Text; Icon = Label; Duration = Length })
	end
	for i, v in pairs(workspace:GetChildren()) do
		if tostring(v) == "Airwalk" then
			v:Destroy()
			


wait();

Notify({
Description = "Airwalk: OFF";
Title = "Nameless Admin";
Duration = 5;

});
	end
end

end)

cmd.add({"airwalk", "aw"}, {"airwalk (aw)", "Press space to go up, unairwalk to stop"}, function()
	


wait();

Notify({
Description = "Airwalk: On";
Title = "Nameless Admin";
Duration = 5;

});

local Chat = game:GetService('Players').LocalPlayer.Chatted
				local function AirWalk()

					local AirWPart = Instance.new("Part", workspace)
					local crtl = true
					local Mouse = game.Players.LocalPlayer:GetMouse()
					AirWPart.Size = Vector3.new(7, 2, 3)
					AirWPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, -4, 0)
					AirWPart.Transparency = 1
					AirWPart.Anchored = true
					AirWPart.Name = "Airwalk"
					for i = 1, math.huge do
						AirWPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, -4, 0)
						wait (.1)
					end
				end
				local function SendNotification(Title, Text, Label, Length)
					game.StarterGui:SetCore('SendNotification', {Title = Title; Text = Text; Icon = Label; Duration = Length })
				end
				AirWalk()
				
end)

cmd.add({"cbring", "clientbring"}, {"clientbring <player> (cbring)", "Brings the player on your client"}, function(...)
Username = (...)

target = getPlr(Username)

	bringc[target] = game:GetService("RunService").RenderStepped:Connect(function()
				if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
target.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * 3
				end
end)
end)

cmd.add({"uncbring", "unclientbring"}, {"unclientbring (uncbring)", "Disable Client bring command"}, function()
			bringc[target]:Disconnect()
end)

	cmd.add({"mute", "muteboombox"}, {"mute <player> (muteboombox)", "Mutes the players boombox"}, function(...)
		Username = (...)
		if game:GetService("SoundService").RespectFilteringEnabled == true then
			
	
	
	wait();
	
	Notify({
	Description = "Boombox muted. Status: Client Sided";
	Title = "Nameless Admin";
	Duration = 5;
	
	});
		else
				
	
	
	wait();
	
	Notify({
	Description = "Boombox muted. Status: FE";
	Title = "Nameless Admin";
	Duration = 5;
	
	});
			if Username == "all" or Username == "others" then
				local players = game:GetService("Players"):GetPlayers()
				for _, player in ipairs(players) do
					for _, object in ipairs(player.Character:GetDescendants()) do
						if object:IsA("Sound") and object.Playing then
							object:Stop()
						end
					end
					local backpack = player:FindFirstChildOfClass("Backpack")
					if backpack then
						for _, object in ipairs(backpack:GetDescendants()) do
							if object:IsA("Sound") and object.Playing then
								object:Stop()
							end
						end
					end
				end			
			else
		local players = getPlr(Username)
			if players ~= nil then
						for i, x in next, players.Character:GetDescendants() do
							if x:IsA("Sound") and x.Playing == true then
								x.Playing = false
							end
						end
						for i, x in next, players:FindFirstChildOfClass("Backpack"):GetDescendants() do
							if x:IsA("Sound") and x.Playing == true then
								x.Playing = false
							end
						end
					end 
			end
end
end)

cmd.add({"antivoid"}, {"antivoid", "Anti void."}, function()
getgenv().AntiVoid = true -- // toggle it on and off

-- // Services
local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer

-- // Check if anyone has the same handle as you
local function toolMatch(Handle)
    local allPlayers = Players:GetPlayers()
    for i = 1, #allPlayers do
        -- // Vars
        local Player = allPlayers[i]
        if (Player == LocalPlayer) then continue end -- // ignore local player

        -- // Vars
        local Character = Player.Character
        local RightArm = Character:WaitForChild("Right Arm")
        local RightGrip = RightArm:FindFirstChild("RightGrip")

        -- // Check if they share the same Part1 Handle of the Grip
        if (RightGrip and RightGrip.Part1 == Handle) then
            return Player
        end
    end
end

-- // Manager
local function onCharacter(Character)
    local RightArm = Character:WaitForChild("Right Arm")

    -- // See when you equip something
    RightArm.ChildAdded:Connect(function(child)
        if (child:IsA("Weld") and child.Name == "RightGrip" and getgenv().AntiVoid) then
            -- // Vars
            local ConnectedHandle = child.Part1

            -- // Check if someone else has something equipped too with the same handle as you
            local matched = toolMatch(ConnectedHandle)

            -- // Destroy the tool, if someone is voiding you
            if (matched) then
                ConnectedHandle.Parent:Destroy()
                print(matched, "just tried to void you lol!")
            end
        end
    end)
end

-- // Initialise the script
onCharacter(LocalPlayer.Character)
LocalPlayer.CharacterAdded:Connect(onCharacter)
end)

cmd.add({"walkspeedbypass", "wsbypass"}, {"walkspeedbypass (wsbypass)", "Bypass client sided walkspeed anticheats"}, function()
	lp = game.Players.LocalPlayer
	UIS = game:GetService("UserInputService")
	
	
	repeat
	wait(0.1)
	until lp.Character:FindFirstChild('HumanoidRootPart')
	
	local speed = CFrame.new(0,0,0)
	local lastpos = lp.Character.HumanoidRootPart.Position
	
	
	while true do
	if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
	speed = lp.Character.HumanoidRootPart.Position - lastpos
	if speed.Y < 0 then
	speed = speed - Vector3.new(0, speed.Y, 0)
	end
	lp.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame + (speed/2)
	lastpos = lp.Character.HumanoidRootPart.Position
	end
	wait(0.1)
	end
end)

	
	cmd.add({"loopmute", "loopmuteboombox"}, {"loopmute <player> (loopmuteboombox)", "Loop mutes the players boombox"}, function(...)
		Username = (...)
	if Username == "all" or Username == "others" then
		Loopmute = true
	repeat wait()
		local players = game:GetService("Players"):GetPlayers()
		for _, player in ipairs(players) do
			for _, object in ipairs(player.Character:GetDescendants()) do
				if object:IsA("Sound") and object.Playing then
					object:Stop()
				end
			end
			local backpack = player:FindFirstChildOfClass("Backpack")
			if backpack then
				for _, object in ipairs(backpack:GetDescendants()) do
					if object:IsA("Sound") and object.Playing then
						object:Stop()
					end
				end
			end
		end	
	until Loopmute == false
	else
		Loopmute = true
		local players = getPlr(Username)
	repeat wait()

			if players ~= nil then
						for i, x in next, players.Character:GetDescendants() do
							if x:IsA("Sound") and x.Playing == true then
								x.Playing = false
							end
						end
						for i, x in next, players:FindFirstChildOfClass("Backpack"):GetDescendants() do
							if x:IsA("Sound") and x.Playing == true then
								x.Playing = false
							end
						end
					end 
				until Loopmute == false
				if game:GetService("SoundService").RespectFilteringEnabled == true then
					
				
				
				wait();
				
				Notify({
				Description = "Boombox glitched. Status: Client Sided";
				Title = "Nameless Admin";
				Duration = 5;
				
				});
				else
				if game:GetService("SoundService").RespectFilteringEnabled == false then
					
				
				
				wait();
				
				Notify({
				Description = "Boombox glitched. Status: FE";
				Title = "Nameless Admin";
				Duration = 5;
				
				});
				end
				end
			end
end)

	
	cmd.add({"unloopmute", "unloopmuteboombox"}, {"unloopmute <player> (unloopmuteboombox)", "Unloop mutes the players boombox"}, function(...)
	Loopmute = false
	wait()
	
	
	
	wait();
	
	Notify({
	Description = "Unloopmuted everyone";
	Title = "Nameless Admin";
	Duration = 5;
	
	});
end)

	cmd.add({"glitch", "glitchboombox"}, {"glitch <player> (glitchboombox)", "Glitches the players boombox"}, function(...)
		Username = (...)
		Loopglitch = true
		local players = getPlr(Username)
			if players ~= nil then
						for i, x in next, players.Character:GetDescendants() do
							if x:IsA("Sound") and x.Playing == true then
								x.Playing = true
							end
						end
						for i, x in next, players:FindFirstChildOfClass("Backpack"):GetDescendants() do
							if x:IsA("Sound") and x.Playing == true then
								x.Playing = true
							end
						end
					end 
					repeat wait()
						for i, x in next, players:FindFirstChildOfClass("Backpack"):GetDescendants() do
							if x:IsA("Sound") and x.Playing == false then
								x.Playing = true
							end
						end
						for i, x in next, players.Character:GetDescendants() do
							if x:IsA("Sound") and x.Playing == false then
								x.Playing = true
							end
						end
						wait(0.2)
						for i, x in next, players:FindFirstChildOfClass("Backpack"):GetDescendants() do
							if x:IsA("Sound") and x.Playing == true then
								x.Playing = false
							end
						end
						for i, x in next, players.Character:GetDescendants() do
							if x:IsA("Sound") and x.Playing == true then
								x.Playing = false
							end
						end
						wait(0.2)
				until Loopglitch == false
if game:GetService("SoundService").RespectFilteringEnabled == true then
	


wait();

Notify({
Description = "Boombox glitched. Status: Client Sided";
Title = "Nameless Admin";
Duration = 5;

});
else
if game:GetService("SoundService").RespectFilteringEnabled == false then
	


wait();

Notify({
Description = "Boombox glitched. Status: FE";
Title = "Nameless Admin";
Duration = 5;

});
end
end
end)

		cmd.add({"unglitch", "unglitchboombox"}, {"unglitch <player> (unglitchboombox)", "Unglitches the players boombox"}, function(...)
			Loopglitch = false
			wait()
			if game:GetService("SoundService").RespectFilteringEnabled == true then
				
			
			
			wait();
			
			Notify({
			Description = "Boombox unglitched. Status: Client Sided";
			Title = "Nameless Admin";
			Duration = 5;
			
			});
			else
			if game:GetService("SoundService").RespectFilteringEnabled == false then
				
			
			
			wait();
			
			Notify({
			Description = "Boombox unglitched. Status: FE";
			Title = "Nameless Admin";
			Duration = 5;
			
			});
			end
			end
		end)

		cmd.add({"unlooplbring", "unlooplegbring"}, {"unlooplbring <player> (unlooplegbring)", "Stop the looplbring command"}, function()
loopbring = false
		end)

		cmd.add({"unlooplvoid", "unlooplegvoid"}, {"unlooplvoid <player> (unlooplegvoid)", "Stop the looplvoid command"}, function()
			loopvoid = false
					end)
			
					cmd.add({"unlooplkill", "unlooplegkill"}, {"unlooplkill <player> (unlooplegkill)", "Stop the looplkill command"}, function()
						loopkill = false
								end)

		cmd.add({"looplbring", "looplegbring"}, {"looplbring <player> (looplegbring)", "Leg resize loop bring"}, function(...)
			loopbring = true
			Target = (...)

			repeat wait(1)
			if Target == "all" or Target == "others" then
			    					loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Leg%20Resize'))()
loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Bring%20All'))()
			else
					loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Leg%20Resize'))()
			game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
						local Character = Player.Character        
						local PlayerGui = Player:waitForChild("PlayerGui")
						local Backpack = Player:waitForChild("Backpack")
						local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
						local RootPart = Character and Humanoid and Humanoid.RootPart or false
						local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
						if not Humanoid or not RootPart or not RightArm then
							return
						end
						Humanoid:UnequipTools()
						local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
						if not MainTool or not MainTool:FindFirstChild("Handle") then
							return
						end
						local TPlayer = getPlr(Target)
						local TCharacter = TPlayer and TPlayer.Character
						local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
						local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
						if not THumanoid or not TRootPart then
							return
						end
						Character.Humanoid.Name = "DAttach"
						local l = Character["DAttach"]:Clone()
						l.Parent = Character
						l.Name = "Humanoid"
						wait()
						Character["DAttach"]:Destroy()
						game.Workspace.CurrentCamera.CameraSubject = Character
						Character.Animate.Disabled = true
						wait()
						Character.Animate.Disabled = false
						Character.Humanoid:EquipTool(MainTool)
						wait()
						CF = Player.Character.PrimaryPart.CFrame
						if firetouchinterest then
							local flag = false
							task.defer(function()
								MainTool.Handle.AncestryChanged:wait()
								flag = true
							end)
							repeat
								firetouchinterest(MainTool.Handle, TRootPart, 0)
								firetouchinterest(MainTool.Handle, TRootPart, 1)
								wait()
								Player.Character.HumanoidRootPart.CFrame = CF
							until flag
						else
							Player.Character.HumanoidRootPart.CFrame =
							TCharacter.HumanoidRootPart.CFrame
							wait()
							Player.Character.HumanoidRootPart.CFrame =
							TCharacter.HumanoidRootPart.CFrame
							wait()
							Player.Character.HumanoidRootPart.CFrame = CF
							wait()
						end
						wait(.3)
						Player.Character:SetPrimaryPartCFrame(CF)
						if Humanoid.RigType == Enum.HumanoidRigType.R6 then
							Character["Right Arm"].RightGrip:Destroy()
						else
							Character["RightHand"].RightGrip:Destroy()
							Character["RightHand"].RightGripAttachment:Destroy()
						end
							
						wait(4)
						CF = Player.Character.HumanoidRootPart.CFrame
						player.CharacterAdded:wait(1):waitForChild("HumanoidRootPart").CFrame = CF
						end
						wait(0.8)
			respawn()
					until loopbring == false
		end)

		cmd.add({"getmass"}, {"getmass <player>", "Get your mass"}, function(...)
		    target = getPlr(...)
			local mass = target.Character.HumanoidRootPart.AssemblyMass 
			wait();
		
			Notify({
			Description = target.Name .. "'s mass is " .. mass;
			Title = "Nameless Admin";
			Duration = 5;
			
			});
		end)
		
		cmd.add({"dvoid", "dvoid"}, {"dvoid <player> (dvoid)", "Delay void"}, function(...)
			Target = (...)

			Players = game:GetService("Players")
			 local c = game.Players.LocalPlayer.Character
			 game.Players.LocalPlayer.Character = nil
				 game.Players.LocalPlayer.Character = c
				 wait(game.Players.RespawnTime - 0.5)
		 local TPlayer = getPlr(Target)
			 Player.Character.HumanoidRootPart.CFrame = CFrame.new(0,-349,0)
						TRootPart = TPlayer.Character.HumanoidRootPart
						local Character = Player.Character
						local PlayerGui = Player:WaitForChild("PlayerGui")
						local Backpack = Player:WaitForChild("Backpack")
						local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
						local RootPart = Character and Humanoid and Humanoid.RootPart or false
						local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
						if not Humanoid or not RootPart or not RightArm then
							return
						end
						Humanoid:UnequipTools()
						local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
						if not MainTool or not MainTool:FindFirstChild("Handle") then
							return
						end
						Humanoid.Name = "DAttach"
						local l = Character["DAttach"]:Clone()
						l.Parent = Character
						l.Name = "Humanoid"
						wait()
						Character["DAttach"]:Destroy()
						game.Workspace.CurrentCamera.CameraSubject = Character
						Character.Animate.Disabled = true
						wait()
						Character.Animate.Disabled = false
						Character.Humanoid:EquipTool(MainTool)
						wait()
						CF = Player.Character.PrimaryPart.CFrame
						if firetouchinterest then
							local flag = false
							task.defer(function()
								MainTool.Handle.AncestryChanged:wait()
								flag = true
							end)
							repeat
								firetouchinterest(MainTool.Handle, TRootPart, 0)
								firetouchinterest(MainTool.Handle, TRootPart, 1)
								wait()
							until flag
						else
							Player.Character.HumanoidRootPart.CFrame =
							TCharacter.HumanoidRootPart.CFrame
							wait()
							Player.Character.HumanoidRootPart.CFrame =
							TCharacter.HumanoidRootPart.CFrame
							wait()
						end
		 l.Parent = game.Players.LocalPlayer.Character
		 l.Name = "Humanoid"
					 
		 game.Players.LocalPlayer.Character["1"]:Destroy()
		 game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
		 game.Players.LocalPlayer.Character.Animate.Disabled = true
		 wait()
		 game.Players.LocalPlayer.Character.Animate.Disabled = false
		 game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType = "None"	  
		end)

				cmd.add({"dbring", "delaybring"}, {"delaybring <player> (dbring)", "Delay bring"}, function(...)
					Target = (...)
   
					local c = game.Players.LocalPlayer.Character
					game.Players.LocalPlayer.Character = nil
						game.Players.LocalPlayer.Character = c
						wait(game.Players.RespawnTime - 0.45)
				game.Players.LocalPlayer.Character.Humanoid.Name = 1
				local l = game.Players.LocalPlayer.Character["1"]:Clone()
				l.Parent = game.Players.LocalPlayer.Character
				l.Name = "Humanoid"
							
				game.Players.LocalPlayer.Character["1"]:Destroy()
				game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
				game.Players.LocalPlayer.Character.Animate.Disabled = true
				wait()
				game.Players.LocalPlayer.Character.Animate.Disabled = false
				game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType = "None"
				  local Character = Player.Character        
							local PlayerGui = Player:waitForChild("PlayerGui")
							local Backpack = Player:waitForChild("Backpack")
							local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
							local RootPart = Character and Humanoid and Humanoid.RootPart or false
							local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
							if not Humanoid or not RootPart or not RightArm then
								return
							end
							Humanoid:UnequipTools()
							local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
							if not MainTool or not MainTool:FindFirstChild("Handle") then
								return
							end
							local TPlayer = getPlr(Target)
							local TCharacter = TPlayer and TPlayer.Character
							local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
							local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
							if not THumanoid or not TRootPart then
								return
							end
							Character.Humanoid.Name = "DAttach"
							local l = Character["DAttach"]:Clone()
							l.Parent = Character
							l.Name = "Humanoid"
							wait()
							Character["DAttach"]:Destroy()
							game.Workspace.CurrentCamera.CameraSubject = Character
							Character.Animate.Disabled = true
							wait()
							Character.Animate.Disabled = false
							Character.Humanoid:EquipTool(MainTool)
							wait()
							CF = Player.Character.PrimaryPart.CFrame
							if firetouchinterest then
								local flag = false
								task.defer(function()
									MainTool.Handle.AncestryChanged:wait()
									flag = true
								end)
								repeat
									firetouchinterest(MainTool.Handle, TRootPart, 0)
									firetouchinterest(MainTool.Handle, TRootPart, 1)
									wait()
									Player.Character.HumanoidRootPart.CFrame = CF
								until flag
							else
								Player.Character.HumanoidRootPart.CFrame =
								TCharacter.HumanoidRootPart.CFrame
								wait()
								Player.Character.HumanoidRootPart.CFrame =
								TCharacter.HumanoidRootPart.CFrame
								wait()
								Player.Character.HumanoidRootPart.CFrame = CF
								wait()
							end
							wait(.3)
							Player.Character:SetPrimaryPartCFrame(CF)
							if Humanoid.RigType == Enum.HumanoidRigType.R6 then
								Character["Right Arm"].RightGrip:Destroy()
							else
								Character["RightHand"].RightGrip:Destroy()
								Character["RightHand"].RightGripAttachment:Destroy()
							end
				end)

		cmd.add({"looplkill", "looplegkill"}, {"looplkill <player> (looplegkill)", "Leg resize loop kill"}, function(...)
			loopkill = true
			Target = (...)

			repeat wait()
			if Target == "all" or Target == "others" then
			    					loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Leg%20Resize'))()
				loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Kill%20All'))()
			else
					loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Leg%20Resize'))()
			local function Kill()
						if not getPlr(Target) then
						end
						
						repeat game:FindService("RunService").Heartbeat:wait() until getPlr(Target).Character and getPlr(Target).Character:FindFirstChildOfClass("Humanoid") and getPlr(Target).Character:FindFirstChildOfClass("Humanoid").Health > 0
						local Character
						local Humanoid
						local RootPart
						local Tool
						local Handle
						
						local TPlayer = getPlr(Target)
						local TCharacter = TPlayer.Character
						local THumanoid
						local TRootPart
						
						if Player.Character and Player.Character and Player.Character.Name == Player.Name then
							Character = Player.Character
						else
						end
						if Character:FindFirstChildOfClass("Humanoid") then
							Humanoid = Character:FindFirstChildOfClass("Humanoid")
						else
						end
						if Humanoid and Humanoid.RootPart then
							RootPart = Humanoid.RootPart
						else
						end
						if Character:FindFirstChildOfClass("Tool") then
							Tool = Character:FindFirstChildOfClass("Tool")
						elseif Player.Backpack:FindFirstChildOfClass("Tool") and Humanoid then
							Tool = Player.Backpack:FindFirstChildOfClass("Tool")
							Humanoid:EquipTool(Player.Backpack:FindFirstChildOfClass("Tool"))
						else
						end
						if Tool and Tool:FindFirstChild("Handle") then
							Handle = Tool.Handle
						else
						end
						
						--Target
						if TCharacter:FindFirstChildOfClass("Humanoid") then
							THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
						else
							return Message("Error",">   Missing Target Humanoid")
						end
						if THumanoid.RootPart then
							TRootPart = THumanoid.RootPart
						else
							return Message("Error",">   Missing Target RootPart")
						end
						
						if THumanoid.Sit then
							return Message("Error",">   Target is seated")
						end
						
						local OldCFrame = RootPart.CFrame
						
						Humanoid:Destroy()
						local NewHumanoid = Humanoid:Clone()
						NewHumanoid.Parent = Character
						NewHumanoid:UnequipTools()
						NewHumanoid:EquipTool(Tool)
						Tool.Parent = workspace
					
						local Timer = os.time()
					
						repeat
							if (TRootPart.CFrame.p - RootPart.CFrame.p).Magnitude < 500 then
								Tool.Grip = CFrame.new()
								Tool.Grip = Handle.CFrame:ToObjectSpace(TRootPart.CFrame):Inverse()
							end
							firetouchinterest(Handle,TRootPart,0)
							firetouchinterest(Handle,TRootPart,1)
							game:FindService("RunService").Heartbeat:wait()
						until Tool.Parent ~= Character or not TPlayer or not TRootPart or THumanoid.Health <= 0 or os.time() > Timer + .20
						Player.Character = nil
						NewHumanoid.Health = 0
						player.CharacterAdded:wait(1)
						repeat game:FindService("RunService").Heartbeat:wait() until Player.Character:FindFirstChild("HumanoidRootPart")
						Player.Character.HumanoidRootPart.CFrame = OldCFrame
			end
				  
					if not LoopKill then
						Kill()
					else
						while LoopKill do
							Kill()
						end
					end
					 end

					until loopkill == false
		end)


		cmd.add({"looplvoid", "looplegvoid"}, {"looplvoid <player> (looplegvoid)", "Leg resize loop void"}, function(...)
			loopvoid = true
			Target = (...)
			repeat wait(1)
			Player.Character.HumanoidRootPart.CFrame = CFrame.new(0,-349,0)
loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Leg%20Resize'))()
local Character = Player.Character
local PlayerGui = Player:waitForChild("PlayerGui")
local Backpack = Player:waitForChild("Backpack")
local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
local RootPart = Character and Humanoid and Humanoid.RootPart or false
local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
if not Humanoid or not RootPart or not RightArm then
	return
end

Humanoid:UnequipTools()
local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
if not MainTool or not MainTool:FindFirstChild("Handle") then
	return
end

local TPlayer = getPlr(Target)
local TCharacter = TPlayer and TPlayer.Character

local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
if not THumanoid or not TRootPart then
	return
end

Character.Humanoid.Name = "DAttach"
local l = Character["DAttach"]:Clone()
l.Parent = Character
l.Name = "Humanoid"
wait()
Character["DAttach"]:Destroy()
game.Workspace.CurrentCamera.CameraSubject = Character
Character.Animate.Disabled = true
wait()
Character.Animate.Disabled = false
Character.Humanoid:EquipTool(MainTool)
wait()
CF = Player.Character.PrimaryPart.CFrame
XC = TCharacter.HumanoidRootPart.CFrame.X
ZC = TCharacter.HumanoidRootPart.CFrame.Z
if firetouchinterest then
	local flag = false
	task.defer(function()
		MainTool.Handle.AncestryChanged:wait()
		flag = true
	end)
	repeat
		firetouchinterest(MainTool.Handle, TRootPart, 0)
		firetouchinterest(MainTool.Handle, TRootPart, 1)
		wait()
		Player.Character.HumanoidRootPart.CFrame = CFrame.new(XC,-99,ZC)
	until flag
else
	Player.Character.HumanoidRootPart.CFrame =
	TCharacter.HumanoidRootPart.CFrame
	wait()
	Player.Character.HumanoidRootPart.CFrame =
	TCharacter.HumanoidRootPart.CFrame
	wait()
	Player.Character.HumanoidRootPart.CFrame = CFrame.new(XC,-99,ZC)
	wait()
end
wait(.3)
Player.Character:SetPrimaryPartCFrame(CF)
if Humanoid.RigType == Enum.HumanoidRigType.R6 then
	Character["Right Arm"].RightGrip:Destroy()
else
	Character["RightHand"].RightGrip:Destroy()
	Character["RightHand"].RightGripAttachment:Destroy()
end
wait(0.8)
respawn()
until loopvoid == false
		end)

		cmd.add({"lvoid", "legvoid"}, {"lvoid <player> (legvoid)", "Leg resize void"}, function(...)
				Target = (...)
									Player.Character.HumanoidRootPart.CFrame = CFrame.new(0,-349,0)
					loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Leg%20Resize'))()
						local Character = Player.Character
						local PlayerGui = Player:waitForChild("PlayerGui")
						local Backpack = Player:waitForChild("Backpack")
						local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
						local RootPart = Character and Humanoid and Humanoid.RootPart or false
						local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
						if not Humanoid or not RootPart or not RightArm then
							return
						end
						
						Humanoid:UnequipTools()
						local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
						if not MainTool or not MainTool:FindFirstChild("Handle") then
							return
						end
						
						local TPlayer = getPlr(Target)
						local TCharacter = TPlayer and TPlayer.Character
						
						local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
						local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
						if not THumanoid or not TRootPart then
							return
						end
						
						Character.Humanoid.Name = "DAttach"
						local l = Character["DAttach"]:Clone()
						l.Parent = Character
						l.Name = "Humanoid"
						wait()
						Character["DAttach"]:Destroy()
						game.Workspace.CurrentCamera.CameraSubject = Character
						Character.Animate.Disabled = true
						wait()
						Character.Animate.Disabled = false
						Character.Humanoid:EquipTool(MainTool)
						wait()
						CF = Player.Character.PrimaryPart.CFrame
						XC = TCharacter.HumanoidRootPart.CFrame.X
						ZC = TCharacter.HumanoidRootPart.CFrame.Z
						if firetouchinterest then
							local flag = false
							task.defer(function()
								MainTool.Handle.AncestryChanged:wait()
								flag = true
							end)
							repeat
								firetouchinterest(MainTool.Handle, TRootPart, 0)
								firetouchinterest(MainTool.Handle, TRootPart, 1)
								wait()
								Player.Character.HumanoidRootPart.CFrame = CFrame.new(XC,-99,ZC)
							until flag
						else
							Player.Character.HumanoidRootPart.CFrame =
							TCharacter.HumanoidRootPart.CFrame
							wait()
							Player.Character.HumanoidRootPart.CFrame =
							TCharacter.HumanoidRootPart.CFrame
							wait()
							Player.Character.HumanoidRootPart.CFrame = CFrame.new(XC,-99,ZC)
							wait()
						end
						wait(.3)
						Player.Character:SetPrimaryPartCFrame(CF)
						if Humanoid.RigType == Enum.HumanoidRigType.R6 then
							Character["Right Arm"].RightGrip:Destroy()
						else
							Character["RightHand"].RightGrip:Destroy()
							Character["RightHand"].RightGripAttachment:Destroy()
						end
						wait(0.6)
						respawn()
		end)

		cmd.add({"lbring", "legbring"}, {"lbring <player> (legbring)", "Leg resize bring"}, function(...)
			Target = (...)

			if Target == "all" or Target == "others" then
			    					loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Leg%20Resize'))()
loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Bring%20All'))()
			else
					loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Leg%20Resize'))()
			game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
						local Character = Player.Character        
						local PlayerGui = Player:waitForChild("PlayerGui")
						local Backpack = Player:waitForChild("Backpack")
						local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
						local RootPart = Character and Humanoid and Humanoid.RootPart or false
						local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
						if not Humanoid or not RootPart or not RightArm then
							return
						end
						Humanoid:UnequipTools()
						local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
						if not MainTool or not MainTool:FindFirstChild("Handle") then
							return
						end
						local TPlayer = getPlr(Target)
						local TCharacter = TPlayer and TPlayer.Character
						local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
						local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
						if not THumanoid or not TRootPart then
							return
						end
						Character.Humanoid.Name = "DAttach"
						local l = Character["DAttach"]:Clone()
						l.Parent = Character
						l.Name = "Humanoid"
						wait()
						Character["DAttach"]:Destroy()
						game.Workspace.CurrentCamera.CameraSubject = Character
						Character.Animate.Disabled = true
						wait()
						Character.Animate.Disabled = false
						Character.Humanoid:EquipTool(MainTool)
						wait()
						CF = Player.Character.PrimaryPart.CFrame
						if firetouchinterest then
							local flag = false
							task.defer(function()
								MainTool.Handle.AncestryChanged:wait()
								flag = true
							end)
							repeat
								firetouchinterest(MainTool.Handle, TRootPart, 0)
								firetouchinterest(MainTool.Handle, TRootPart, 1)
								wait()
								Player.Character.HumanoidRootPart.CFrame = CF
							until flag
						else
							Player.Character.HumanoidRootPart.CFrame =
							TCharacter.HumanoidRootPart.CFrame
							wait()
							Player.Character.HumanoidRootPart.CFrame =
							TCharacter.HumanoidRootPart.CFrame
							wait()
							Player.Character.HumanoidRootPart.CFrame = CF
							wait()
						end
						wait(.3)
						Player.Character:SetPrimaryPartCFrame(CF)
						if Humanoid.RigType == Enum.HumanoidRigType.R6 then
							Character["Right Arm"].RightGrip:Destroy()
						else
							Character["RightHand"].RightGrip:Destroy()
							Character["RightHand"].RightGripAttachment:Destroy()
						end
						wait(0.9)
			respawn()
						end
		end)

		cmd.add({"lkill", "legkill"}, {"lkill <player> (legkill)", "Leg resize kill"}, function(...)
			Target = (...)

			if Target == "all" or Target == "others" then
			    					loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Leg%20Resize'))()
				loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Kill%20All'))()
			else
					loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Leg%20Resize'))()
			local function Kill()
						if not getPlr(Target) then
						end
						
						repeat game:FindService("RunService").Heartbeat:wait() until getPlr(Target).Character and getPlr(Target).Character:FindFirstChildOfClass("Humanoid") and getPlr(Target).Character:FindFirstChildOfClass("Humanoid").Health > 0
						local Character
						local Humanoid
						local RootPart
						local Tool
						local Handle
						
						local TPlayer = getPlr(Target)
						local TCharacter = TPlayer.Character
						local THumanoid
						local TRootPart
						
						if Player.Character and Player.Character and Player.Character.Name == Player.Name then
							Character = Player.Character
						else
						end
						if Character:FindFirstChildOfClass("Humanoid") then
							Humanoid = Character:FindFirstChildOfClass("Humanoid")
						else
						end
						if Humanoid and Humanoid.RootPart then
							RootPart = Humanoid.RootPart
						else
						end
						if Character:FindFirstChildOfClass("Tool") then
							Tool = Character:FindFirstChildOfClass("Tool")
						elseif Player.Backpack:FindFirstChildOfClass("Tool") and Humanoid then
							Tool = Player.Backpack:FindFirstChildOfClass("Tool")
							Humanoid:EquipTool(Player.Backpack:FindFirstChildOfClass("Tool"))
						else
						end
						if Tool and Tool:FindFirstChild("Handle") then
							Handle = Tool.Handle
						else
						end
						
						--Target
						if TCharacter:FindFirstChildOfClass("Humanoid") then
							THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
						else
							return Message("Error",">   Missing Target Humanoid")
						end
						if THumanoid.RootPart then
							TRootPart = THumanoid.RootPart
						else
							return Message("Error",">   Missing Target RootPart")
						end
						
						if THumanoid.Sit then
							return Message("Error",">   Target is seated")
						end
						
						local OldCFrame = RootPart.CFrame
						
						Humanoid:Destroy()
						local NewHumanoid = Humanoid:Clone()
						NewHumanoid.Parent = Character
						NewHumanoid:UnequipTools()
						NewHumanoid:EquipTool(Tool)
						Tool.Parent = workspace
					
						local Timer = os.time()
					
						repeat
							if (TRootPart.CFrame.p - RootPart.CFrame.p).Magnitude < 500 then
								Tool.Grip = CFrame.new()
								Tool.Grip = Handle.CFrame:ToObjectSpace(TRootPart.CFrame):Inverse()
							end
							firetouchinterest(Handle,TRootPart,0)
							firetouchinterest(Handle,TRootPart,1)
							game:FindService("RunService").Heartbeat:wait()
						until Tool.Parent ~= Character or not TPlayer or not TRootPart or THumanoid.Health <= 0 or os.time() > Timer + .20
						Player.Character = nil
						NewHumanoid.Health = 0
						player.CharacterAdded:wait(1)
						repeat game:FindService("RunService").Heartbeat:wait() until Player.Character:FindFirstChild("HumanoidRootPart")
						Player.Character.HumanoidRootPart.CFrame = OldCFrame
			end
				  
					if not LoopKill then
						Kill()
					else
						while LoopKill do
							Kill()
						end
					end
					 end
		end)


cmd.add({"loopvoid", "loopv"}, {"loopvoid <player> (loopv)", "Voids the player"}, function(...)
	Target = (...)
	
		Loopvoid = true

	repeat wait()
				Player.Character.HumanoidRootPart.CFrame = CFrame.new(0,-349,0)
				local Character = Player.Character
local PlayerGui = Player:waitForChild("PlayerGui")
local Backpack = Player:waitForChild("Backpack")
local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
local RootPart = Character and Humanoid and Humanoid.RootPart or false
local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
if not Humanoid or not RootPart or not RightArm then
return
end

Humanoid:UnequipTools()
local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
if not MainTool or not MainTool:FindFirstChild("Handle") then
return
end

local TPlayer = getPlr(Target)
local TCharacter = TPlayer and TPlayer.Character

local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
if not THumanoid or not TRootPart then
return
end

Character.Humanoid.Name = "DAttach"
local l = Character["DAttach"]:Clone()
l.Parent = Character
l.Name = "Humanoid"
wait()
Character["DAttach"]:Destroy()
game.Workspace.CurrentCamera.CameraSubject = Character
Character.Animate.Disabled = true
wait()
Character.Animate.Disabled = false
Character.Humanoid:EquipTool(MainTool)
wait()
CF = Player.Character.PrimaryPart.CFrame
XC = TCharacter.HumanoidRootPart.CFrame.X
ZC = TCharacter.HumanoidRootPart.CFrame.Z
if firetouchinterest then
local flag = false
task.defer(function()
	MainTool.Handle.AncestryChanged:wait()
	flag = true
end)
repeat
	firetouchinterest(MainTool.Handle, TRootPart, 0)
	firetouchinterest(MainTool.Handle, TRootPart, 1)
	wait()
	Player.Character.HumanoidRootPart.CFrame = CFrame.new(XC,-99,ZC)
until flag
else
Player.Character.HumanoidRootPart.CFrame =
TCharacter.HumanoidRootPart.CFrame
wait()
Player.Character.HumanoidRootPart.CFrame =
TCharacter.HumanoidRootPart.CFrame
wait()
Player.Character.HumanoidRootPart.CFrame = CFrame.new(XC,-99,ZC)
wait()
end
wait(.3)
Player.Character:SetPrimaryPartCFrame(CF)
if Humanoid.RigType == Enum.HumanoidRigType.R6 then
Character["Right Arm"].RightGrip:Destroy()
else
Character["RightHand"].RightGrip:Destroy()
Character["RightHand"].RightGripAttachment:Destroy()
end
wait(1)
respawn()
until Loopvoid == false
end)

cmd.add({"loopbring"}, {"loopbring <player>", "Loopbrings a player"}, function(...)

	local Username = (...)

	if Username == "all" or Username == "others" then
		Loopbring = true
		repeat wait()
			wait(0.3)
		loadstring(game:HttpGet('https://raw.githubusercontent.com/DigitalityScripts/roblox-scripts/main/Bring%20All'))()
		until Loopbring == false
else
	Loopbring = true
	repeat wait()
		wait(0.15)
		local Target = Username
		local Character = Player.Character        
		local PlayerGui = Player:waitForChild("PlayerGui")
		local Backpack = Player:waitForChild("Backpack")
		local Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid") or false
		local RootPart = Character and Humanoid and Humanoid.RootPart or false
		local RightArm = Character and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("RightHand")
		if not Humanoid or not RootPart or not RightArm then
			return
		end
		Humanoid:UnequipTools()
		local MainTool = Backpack:FindFirstChildWhichIsA("Tool") or false
		if not MainTool or not MainTool:FindFirstChild("Handle") then
			return
		end
		local TPlayer = getPlr(Target)
		local TCharacter = TPlayer and TPlayer.Character
		local THumanoid = TCharacter and TCharacter:FindFirstChildWhichIsA("Humanoid") or false
		local TRootPart = TCharacter and THumanoid and THumanoid.RootPart or false
		if not THumanoid or not TRootPart then
			return
		end
		Character.Humanoid.Name = "DAttach"
		local l = Character["DAttach"]:Clone()
		l.Parent = Character
		l.Name = "Humanoid"
		wait()
		Character["DAttach"]:Destroy()
		game.Workspace.CurrentCamera.CameraSubject = Character
		Character.Animate.Disabled = true
		wait()
		Character.Animate.Disabled = false
		Character.Humanoid:EquipTool(MainTool)
		wait()
		CF = Player.Character.PrimaryPart.CFrame
		if firetouchinterest then
			local flag = false
			task.defer(function()
				MainTool.Handle.AncestryChanged:wait()
				flag = true
			end)
			repeat
				firetouchinterest(MainTool.Handle, TRootPart, 0)
				firetouchinterest(MainTool.Handle, TRootPart, 1)
				wait()
				Player.Character.HumanoidRootPart.CFrame = CF
			until flag
		else
			Player.Character.HumanoidRootPart.CFrame =
			TCharacter.HumanoidRootPart.CFrame
			wait()
			Player.Character.HumanoidRootPart.CFrame =
			TCharacter.HumanoidRootPart.CFrame
			wait()
			Player.Character.HumanoidRootPart.CFrame = CF
			wait()
		end
		wait(.3)
		Player.Character:SetPrimaryPartCFrame(CF)
		if Humanoid.RigType == Enum.HumanoidRigType.R6 then
			Character["Right Arm"].RightGrip:Destroy()
		else
			Character["RightHand"].RightGrip:Destroy()
			Character["RightHand"].RightGripAttachment:Destroy()
		end
			
		wait(4)
   CF = Player.Character.HumanoidRootPart.CFrame
            player.CharacterAdded:wait(1):waitForChild("HumanoidRootPart").CFrame = CF
						wait(2)
until Loopbring == false
end
end)

cmd.add({"unloopbring"}, {"unloopbring", "Stops loopbringing a player"}, function()
Loopbring = false
end)

	cmd.add({"unloopvoid", "loopv"}, {"unloopvoid (unloopv)", "Unloopingly voiding a player"}, function()
		Loopvoid = false
	end)

	cmd.add({"looptornado"}, {"looptornado <player>", "Loop tornados a player endlessly"}, function(...)
		Username = (...)
		Looptornado = true
        repeat wait()
local target = getPlr(Username)
local THumanoidPart
local plrtorso
local TargetCharacter = target.Character
   if TargetCharacter:FindFirstChild("Torso") then
		   plrtorso = TargetCharacter.Torso
	   elseif TargetCharacter:FindFirstChild("UpperTorso") then
		   plrtorso = TargetCharacter.UpperTorso
	   end
        local old = getChar().HumanoidRootPart.CFrame
        local tool = getBp():FindFirstChildOfClass("Tool") or getChar():FindFirstChildOfClass("Tool")
        if target == nil or tool == nil then return end
        local attWeld = attachTool(tool,CFrame.new(0,0,0))
        attachTool(tool,CFrame.new(0,0,0.2) * CFrame.Angles(math.rad(-90),0,0))
		tool.Grip = plrtorso.CFrame
		wait(0.2)
tool.Grip = CFrame.new(0, -7, -3)
        firetouchinterest(target.Character.Humanoid.RootPart,tool.Handle,0)
        firetouchinterest(target.Character.Humanoid.RootPart,tool.Handle,1)
		local Spin = Instance.new("BodyAngularVelocity")
	Spin.Name = "Spinning"
	Spin.Parent = getRoot(game.Players.LocalPlayer.Character)
	Spin.MaxTorque = Vector3.new(0, math.huge, 0)
	Spin.AngularVelocity = Vector3.new(0,40,0)
		until Looptornado == false
	end)

		cmd.add({"unlooptornado"}, {"unlooptornado", "Unloop tornadoes a player endlessly"}, function()
Looptornado = false
		end)

			cmd.add({"loopcuff", "loopjail"}, {"loopcuff <player> (loopjail)", "Loop cuffs a player endlessly"}, function(...)
				Username = (...)
				Loopcuff = true
				repeat wait()
					wait(0.15)
local target = getPlr(Username)
local THumanoidPart
local plrtorso
local TargetCharacter = target.Character
   if TargetCharacter:FindFirstChild("Torso") then
		   plrtorso = TargetCharacter.Torso
	   elseif TargetCharacter:FindFirstChild("UpperTorso") then
		   plrtorso = TargetCharacter.UpperTorso
	   end
        local old = getChar().HumanoidRootPart.CFrame
        local tool = getBp():FindFirstChildOfClass("Tool") or getChar():FindFirstChildOfClass("Tool")
        if target == nil or tool == nil then return end
        local attWeld = attachTool(tool,CFrame.new(0,0,0))
        attachTool(tool,CFrame.new(0,0,0.2) * CFrame.Angles(math.rad(-90),0,0))
		tool.Grip = plrtorso.CFrame
		wait(0.4)
tool.Grip = CFrame.new(0, -7, -3)
        firetouchinterest(target.Character.Humanoid.RootPart,tool.Handle,0)
        firetouchinterest(target.Character.Humanoid.RootPart,tool.Handle,1)
				until Loopcuff == false
			end)

				cmd.add({"unloopcuff", "unloopjail"}, {"unloopcuff <player> (unloopjail)", "Unloop cuffs a player endlessly"}, function(...)
Loopcuff = false
				end)

					cmd.add({"loopstand"}, {"loopstand <player>", "Loop stands a player endlessly"}, function(...)
						Username = (...)
						Loopstand = true
						repeat wait()
							wait(0.15)

local target = getPlr(Username)
local THumanoidPart
local plrtorso
local TargetCharacter = target.Character
   if TargetCharacter:FindFirstChild("Torso") then
		   plrtorso = TargetCharacter.Torso
	   elseif TargetCharacter:FindFirstChild("UpperTorso") then
		   plrtorso = TargetCharacter.UpperTorso
	   end
        local old = getChar().HumanoidRootPart.CFrame
        local tool = getBp():FindFirstChildOfClass("Tool") or getChar():FindFirstChildOfClass("Tool")
	    if target == nil or tool == nil then return end
        local attWeld = attachTool(tool,CFrame.new(0,0,0))
        attachTool(tool,CFrame.new(0,0,0.2) * CFrame.Angles(math.rad(-90),0,0))
		   tool.Grip = plrtorso.CFrame
	wait(0.2)
	    tool.Grip = CFrame.new(0, 3, -1) 
        firetouchinterest(target.Character.Humanoid.RootPart,tool.Handle,0)
        firetouchinterest(target.Character.Humanoid.RootPart,tool.Handle,1)
     wait(1.3)
						until Loopstand == false
					end)

						cmd.add({"unloopstand"}, {"unloopstand)", "Unloop stands a player endlessly"}, function(...)
							Loopstand = false
						end)

	cmd.add({"loopbanish", "looppunish", "loopjail"}, {"loopbanish <player> (loopbanish, loopjail)", "Banishes a player endlessly"}, function(...)
		Username = (...)
		Loopbanish = true
        repeat wait()
			user = getPlr(Username)
            plr = user.name
            Target = plr
            Player.Character.Humanoid.Name = 1
            local l = Player.Character["1"]:Clone()
            l.Parent = Player.Character
            l.Name = "Humanoid"
            task.wait()
            Player.Character["1"]:Destroy()
            game.Workspace.CurrentCamera.CameraSubject = Player.Character
            Player.Character.Animate.Disabled = true
            task.wait()
            Player.Character.Animate.Disabled = false
            for i, v in pairs(game:FindService "Players".LocalPlayer.Backpack:GetChildren()) do
                Player.Character.Humanoid:EquipTool(v)
            end
            task.wait()
            Player.Character.HumanoidRootPart.CFrame = Players[Target].Character.HumanoidRootPart.CFrame
            task.wait()
            Player.Character.HumanoidRootPart.CFrame = Players[Target].Character.HumanoidRootPart.CFrame
            task.wait(0.7)
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-100000, 1000000000000000000000, -100000))
            task.wait()
			task.wait(4)
			game.Players.LocalPlayer.Character.Humanoid.Health = 0
			until Loopbanish == false
	end)

	cmd.add({"unloopbanish", "unloopjail", "unlooppunish"}, {"unloopbanish (unloopjail, unlooppunish)", "Stops loopingly punishing a player"}, function()
		Loopbanish = false
	end)

	cmd.add({"unloopfling"}, {"unloopfling", "Stops loop flinging a player"}, function(...)
Loopvoid = false
	end)

		cmd.add({"loopkill"}, {"loopkill <player>", "Loop kills a player"}, function(...)
local Username = (...)

if Username == "all" or Username == "others" then
	Loopkill = true
	repeat wait()
  local player_table = game:GetService('Players'):GetPlayers()
        local toolsInBackpack = 0
        local toolsEquipped = 0
        local players = {}
        local tools = {}
        
        for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                toolsInBackpack = toolsInBackpack + 1
        end
        for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v.ClassName == "Tool" then
                        toolsEquipped = toolsEquipped + 1
                end
        end
        local total_tools = toolsInBackpack + toolsEquipped
        print(#player_table.." players")
        
                for i,v in next, player_table do
                        if v.Character.Humanoid.Sit ~= true and v ~= game:GetService('Players').LocalPlayer and v.Character.Humanoid.Health ~= 0 then
                                table.insert(players, v)
                        end
                end 
        
                local newHum = game.Players.LocalPlayer.Character.Humanoid:Clone()
                newHum.Parent = game.Players.LocalPlayer.Character
                game.Players.LocalPlayer.Character.Humanoid:Destroy()
                newHum:ChangeState(15)
                for i,v in next, game.Players.LocalPlayer.Backpack:GetChildren() do
                        if v:IsA'Tool' then
                                v.Parent = game.Players.LocalPlayer.Character
                        end
                end
                wait(.1)
                for i,v in next, game.Players.LocalPlayer.Character:GetChildren() do
                        if v:IsA'Tool' then
                                table.insert(tools, v)
                        end
                end
                local currentTargets = {}
                for i, tool in next, tools do
                        tool.Handle.Massless = true
                        tool.Grip = CFrame.new()
                        tool.Grip = tool.Handle.CFrame:ToObjectSpace(players[i].Character.Head.CFrame):Inverse()
                end
                local players = {}
                		plr.CharacterAdded:Wait()
		getChar():WaitForChild("HumanoidRootPart").CFrame = old
	wait(1)
                until Loopkill == false
else

			Loopkill = true
			repeat wait()
				local function Kill()
					if not getPlr(Username) then
					end
					
					repeat game:FindService("RunService").Heartbeat:wait() until getPlr(Username).Character and getPlr(Username).Character:FindFirstChildOfClass("Humanoid") and getPlr(Username).Character:FindFirstChildOfClass("Humanoid").Health > 0
					local Character
					local Humanoid
					local RootPart
					local Tool
					local Handle
					
					local TPlayer = getPlr(Username)
					local TCharacter = TPlayer.Character
					local THumanoid
					local TRootPart
					
					if Player.Character and Player.Character and Player.Character.Name == Player.Name then
						Character = Player.Character
					else
					end
					if Character:FindFirstChildOfClass("Humanoid") then
						Humanoid = Character:FindFirstChildOfClass("Humanoid")
					else
					end
					if Humanoid and Humanoid.RootPart then
						RootPart = Humanoid.RootPart
					else
					end
					if Character:FindFirstChildOfClass("Tool") then
						Tool = Character:FindFirstChildOfClass("Tool")
					elseif Player.Backpack:FindFirstChildOfClass("Tool") and Humanoid then
						Tool = Player.Backpack:FindFirstChildOfClass("Tool")
						Humanoid:EquipTool(Player.Backpack:FindFirstChildOfClass("Tool"))
					else
					end
					if Tool and Tool:FindFirstChild("Handle") then
						Handle = Tool.Handle
					else
					end
					
					--Target
					if TCharacter:FindFirstChildOfClass("Humanoid") then
						THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
					else
										end
					if THumanoid.RootPart then
						TRootPart = THumanoid.RootPart
					else
					end
					
					if THumanoid.Sit then
					end
					
					local OldCFrame = RootPart.CFrame
					
					Humanoid:Destroy()
					local NewHumanoid = Humanoid:Clone()
					NewHumanoid.Parent = Character
					NewHumanoid:UnequipTools()
					NewHumanoid:EquipTool(Tool)
					Tool.Parent = workspace
				
					local Timer = os.time()
				
					repeat
						if (TRootPart.CFrame.p - RootPart.CFrame.p).Magnitude < 500 then
							Tool.Grip = CFrame.new()
							Tool.Grip = Handle.CFrame:ToObjectSpace(TRootPart.CFrame):Inverse()
						end
						firetouchinterest(Handle,TRootPart,0)
						firetouchinterest(Handle,TRootPart,1)
						game:FindService("RunService").Heartbeat:wait()
					until Tool.Parent ~= Character or not TPlayer or not TRootPart or THumanoid.Health <= 0 or os.time() > Timer + .20
					Player.Character = nil
					NewHumanoid.Health = 0
					player.CharacterAdded:wait(1)
					repeat game:FindService("RunService").Heartbeat:wait() until Player.Character:FindFirstChild("HumanoidRootPart")
					Player.Character.HumanoidRootPart.CFrame = OldCFrame
		end
			  
				if not LoopKill then
					Kill()
				else
					while LoopKill do
						Kill()
					end
				end
			until Loopkill == false
		end
		end)

			cmd.add({"unloopkill"}, {"unloopkill", "Stops loop killing a player"}, function()
				Loopkill = false
			end)

local netlagtab = {}

			cmd.add({"netlag"}, {"netlag <player>", "If the person is using netless, or any reanimation it glitches them"}, function(...)
			Username = (...)
target = getPlr(Username)

 table.insert(netlagtab, game:GetService("RunService").Heartbeat:Connect(function()
        for i,v in pairs(target.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                sethiddenproperty(v, "NetworkIsSleeping", true)
            end
        end
    end))
			end)

				cmd.add({"unnetlag"}, {"unnetlag", "Stops netlegging"}, function()
				   for i,v in pairs(netlagtab) do
        v:Disconnect()
    end
				end)

				cmd.add({"noprompt", "nopurchaseprompts"}, {"noprompt (nopurchaseprompts)", "remove the stupid purchase prompt"}, function()
					
					
					
					wait();
					
					Notify({
					Description = "Purchase prompts have been disabled";
					Title = "Nameless Admin";
					Duration = 5;
					
					});
					game.CoreGui.PurchasePrompt.Enabled = false
				end)

				cmd.add({"prompt", "purchaseprompts"}, {"prompt (purchaseprompts)", "allows the stupid purchase prompt"}, function()
					
					
					
					wait();
					
					Notify({
					Description = "Purchase prompts have been enabled";
					Title = "Nameless Admin";
					Duration = 5;
					
					});
					game.CoreGui.PurchasePrompt.Enabled = true
				end)
				
								cmd.add({"nameless"}, {"nameless", "Makes your hats visible but not your name or your body"}, function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/FE/main/nameless"))()
end)


				cmd.add({"wallwalk"}, {"wallwalk", "Makes you walk on walls"}, function()
loadstring(game:HttpGet("https://pastebin.com/raw/s4FjP97j"))()
end)

cmd.add({"size"}, {"size", "Makes you big"}, function()
    local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character
local Humanoid = Character:FindFirstChildOfClass("Humanoid")

function rm()
	for i,v in pairs(Character:GetDescendants()) do
		if v:IsA("BasePart") then
			if v.Name == "Handle" or v.Name == "Head" then
				if Character.Head:FindFirstChild("OriginalSize") then
					Character.Head.OriginalSize:Destroy()
				end
			else
				for i,cav in pairs(v:GetDescendants()) do
					if cav:IsA("Attachment") then
						if cav:FindFirstChild("OriginalPosition") then
							cav.OriginalPosition:Destroy()  
						end
					end
				end
				v:FindFirstChild("OriginalSize"):Destroy()
				if v:FindFirstChild("AvatarPartScaleType") then
					v:FindFirstChild("AvatarPartScaleType"):Destroy()
				end
			end
		end
	end
end
    rm()
wait(0.5)
Humanoid:FindFirstChild("BodyProportionScale"):Destroy()
wait(1)

rm()
wait(0.5)
Humanoid:FindFirstChild("BodyHeightScale"):Destroy()
wait(1)

rm()
wait(0.5)
Humanoid:FindFirstChild("BodyWidthScale"):Destroy()
wait(1)

rm()
wait(0.5)
Humanoid:FindFirstChild("BodyDepthScale"):Destroy()
wait(1)

rm()
wait(0.5)
Humanoid:FindFirstChild("HeadScale"):Destroy()
wait(1)
end)

cmd.add({"holdparts", "hp", "grabparts"}, {"holdparts (hpr, grabparts)", "Holds any unanchored part press ctrl + click"}, function()
	


wait();

Notify({
Description = "Hold parts loaded, ctrl + click on a part";
Title = "Nameless Admin";
Duration = 5;

});
	 -- made by joshclark756#7155
local mouse = game.Players.LocalPlayer:GetMouse()
local uis = game:GetService("UserInputService")

-- Connect
mouse.Button1Down:Connect(function()
   -- Check for Target & Left Shift
   if mouse.Target and uis:IsKeyDown(Enum.KeyCode.LeftControl) then
local npc = mouse.target
local PlayerCharacter = game:GetService("Players").LocalPlayer.Character
local PlayerRootPart = PlayerCharacter.HumanoidRootPart
local A0 = Instance.new("Attachment")
local AP = Instance.new("AlignPosition")
local AO = Instance.new("AlignOrientation")
local A1 = Instance.new("Attachment")
for _, v in pairs(npc:GetDescendants()) do
if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
game:GetService("RunService").Stepped:Connect(function()
v.CanCollide = false
end)
end
end

for _, v in pairs(PlayerCharacter:GetDescendants()) do
if v:IsA("BasePart") then
if v.Name == "HumanoidRootPart" or v.Name == "UpperTorso" or v.Name == "Head" then
end
end
end
PlayerRootPart.Position = PlayerRootPart.Position+Vector3.new(0, 0, 0)
A0.Parent = npc
AP.Parent = npc
AO.Parent = npc
AP.Responsiveness = 200
AP.MaxForce = math.huge
AO.MaxTorque = math.huge
AO.Responsiveness = 200
AP.Attachment0 = A0
AP.Attachment1 = A1
AO.Attachment1 =  A1
AO.Attachment0 = A0
A1.Parent = PlayerCharacter:FindFirstChild("Right Arm")
end
end)
wait(0.2)
    -- made by joshclark756#7155
local mouse = game.Players.LocalPlayer:GetMouse()
local uis = game:GetService("UserInputService")

-- Connect
mouse.Button1Down:Connect(function()
   -- Check for Target & Left Shift
   if mouse.Target and uis:IsKeyDown(Enum.KeyCode.LeftControl) then
local npc = mouse.target
local PlayerCharacter = game:GetService("Players").LocalPlayer.Character
local PlayerRootPart = PlayerCharacter.HumanoidRootPart
local A0 = Instance.new("Attachment")
local AP = Instance.new("AlignPosition")
local AO = Instance.new("AlignOrientation")
local A1 = Instance.new("Attachment")
for _, v in pairs(npc:GetDescendants()) do
if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
game:GetService("RunService").Stepped:Connect(function()
v.CanCollide = false
end)
end
end

for _, v in pairs(PlayerCharacter:GetDescendants()) do
if v:IsA("BasePart") then
if v.Name == "HumanoidRootPart" or v.Name == "UpperTorso" or v.Name == "Head" then
end
end
end
PlayerRootPart.Position = PlayerRootPart.Position+Vector3.new(0, 0, 0)
A0.Parent = npc
AP.Parent = npc
AO.Parent = npc
AP.Responsiveness = 200
AP.MaxForce = math.huge
AO.MaxTorque = math.huge
AO.Responsiveness = 200
AP.Attachment0 = A0
AP.Attachment1 = A1
AO.Attachment1 =  A1
AO.Attachment0 = A0
A1.Parent = PlayerCharacter.RightHand
end
end)
end)

local hiddenGUIS = {}
cmd.add({"hideguis"}, {"hideguis", "Hides guis"}, function()
function FindInTable(tbl,val)
	if tbl == nil then return false end
	for _,v in pairs(tbl) do
		if v == val then return true end
	end 
	return false
end

	for i,v in pairs(game.Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui"):GetDescendants()) do
		if (v:IsA("Frame") or v:IsA("ImageLabel") or v:IsA("ScrollingFrame")) and v.Visible then
			v.Visible = false
			if not FindInTable(hiddenGUIS,v) then
				table.insert(hiddenGUIS,v)
			end
		end
	end
end)

cmd.add({"showguis"}, {"showguis", "Show guis that were hidden using hideguis"}, function()
	for i,v in pairs(hiddenGUIS) do
		v.Visible = true
	end
	hiddenGUIS = {}
end)

cmd.add({"spin"}, {"spin {amount}", "Makes your character spin as fast as you want"}, function(...)
	
	
	
	wait();
	
	Notify({
	Description = "Spinning...";
	Title = "Nameless Admin";
	Duration = 5;
	
});
	function getRoot(char)
		local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
		return rootPart
	end
	
	local spinSpeed = (...)
		for i,v in pairs(getRoot(game.Players.LocalPlayer.Character):GetChildren()) do
			if v.Name == "Spinning" then
				v:Destroy()
			end
		end
		local Spin = Instance.new("BodyAngularVelocity")
		Spin.Name = "Spinning"
		Spin.Parent = getRoot(game.Players.LocalPlayer.Character)
		Spin.MaxTorque = Vector3.new(0, math.huge, 0)
		Spin.AngularVelocity = Vector3.new(0,spinSpeed,0)
end)

cmd.add({"unspin"}, {"unspin", "Makes your character unspin"}, function()
	


wait();

Notify({
Description = "Spin disabled";
Title = "Nameless Admin";
Duration = 5;

});
	function getRoot(char)
		local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
		return rootPart
	end
	
	for i,v in pairs(getRoot(game.Players.LocalPlayer.Character):GetChildren()) do
			if v.Name == "Spinning" then
				v:Destroy()
			end
		end
end)

cmd.add({"notepad"}, {"notepad", "notepad for making scripts / etc"}, function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Notepad"))()
end)

cmd.add({"rc7"}, {"rc7", "RC7 Internal UI"}, function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/FE/main/rc7"))()
end)

cmd.add({"scriptviewer", "viewscripts"}, {"scriptviewer (viewscripts)", "Can view scripts made by 0866"}, function()
	loadstring(game:HttpGet("https://pastebin.com/raw/dva01xpE", true))()
end)

cmd.add({"hidename", "hname"}, {"hidename", "Hides your name only works on billboard uis"}, function()
for _,item in pairs(workspace[game.Players.LocalPlayer.Name].Head:GetChildren()) do
		if item:IsA('BillboardGui') then
		item:Remove()
		end
end
	wait(0.2)
	
	
	
	wait();
	
	Notify({
	Description = "Name has been hidden, this only works on billboard guis / custom name fonts";
	Title = "Nameless Admin";
	Duration = 5;
	
});
end)

cmd.add({"hydroxide"}, {"hydroxide", "executes hydroxide"}, function()
	local owner = "Upbolt"
local branch = "revision"

local function webImport(file)
    return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/Hydroxide/%s/%s.lua"):format(owner, branch, file)), file .. '.lua')()
end

webImport("init")
webImport("ui/main")
end)

cmd.add({"remotespy", "simplespy"}, {"remotespy (simplespy)", "executes simplespy v3"}, function()
loadstring(game:HttpGet("https://github.com/exxtremestuffs/SimpleSpySource/raw/master/SimpleSpy.lua"))()
end)

cmd.add({"uanograv", "unanchorednograv", "unanchorednogravity"}, {"uanograv (unanchorednograv)", "Makes unanchored parts have 0 gravity"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Made unanchored parts have no gravity";
	Title = "Nameless Admin";
	Duration = 5;
	
});
	loadstring(game:HttpGet("https://pastebin.com/raw/MHdBcJQL", true))()
end)

cmd.add({"fireclickdetectors", "fcd"}, {"fireclickdetectors (fcd)", "Fires every click detector that's in workspace"}, function()
local ccamount = 0

	for i,v in pairs(game:GetDescendants()) do
        if v:IsA("ClickDetector") then
               ccamount = ccamount + 1
            fireclickdetector(v)
        end
	end

		


wait();

Notify({
Description = "Fired " .. ccamount .. " amount of click detectors";
Title = "Nameless Admin";
Duration = 7;

});
end)

cmd.add({"tweengotocampos", "tweentocampos", "tweentcp"}, {"tweengotocampos (tweentocampos, tweentcp)", "Another version of goto camera position but bypassing more anti-cheats"}, function(...)
local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- function to teleport the player to the camera's position using tweening
local function teleportPlayer()
    local character = player.Character or player.CharacterAdded:wait(1)
    local camera = game.Workspace.CurrentCamera
    local cameraPosition = camera.CFrame.Position
    
    -- create a new tween that moves the player's primary part to the camera position
    local tween = TweenService:Create(character.PrimaryPart, TweenInfo.new(2), {
        CFrame = CFrame.new(cameraPosition)
    })
    
    tween:Play()
end


        local camera = game.Workspace.CurrentCamera
        repeat wait() until camera.CFrame ~= CFrame.new()

        teleportPlayer()
  
end)

cmd.add({"gotopart", "topart"}, {"gotopart {partname} (topart)", "Makes you teleport to a part you want"}, function(...)
	local parts = game.Workspace:GetChildren()
	local targetParts = {}
	for i, child in pairs(parts) do
	if child.Name == (...) then
	table.insert(targetParts, child)
	end
	end
	
	local index = 1
	game:GetService("RunService").Stepped:Connect(function()
	if targetParts[index] then
	game.Players.LocalPlayer.Character:MoveTo(targetParts[index].Position)
	index = index + 1
	wait(0.4)
	end
	end)
end)


cmd.add({"swim"}, {"swim {speed}", "Swim in the air"}, function(...)
speaker = game.Players.LocalPlayer
game.Workspace.Gravity = 0
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
	speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (...)
	if (...) == nil then
	    	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
	    	end
end)

cmd.add({"unswim"}, {"unswim", "Stops the swim script"}, function(...)
speaker = game.Players.LocalPlayer
game.Workspace.Gravity = 168
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
	speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
	speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end)

cmd.add({"esppart", "partesp"}, {"esppart {partname} (partesp)", "Makes you be able to see any part"}, function(...)
	local parts = game.Workspace:GetChildren()
	local targetParts = {}
	for i, child in pairs(parts) do
	if child.Name == (...) then
	table.insert(targetParts, child)
	end
	end
	
	for i, part in ipairs(targetParts) do
	-- Create a new BoxHandleAdornment
	local adornment = Instance.new("BoxHandleAdornment")
	adornment.Adornee = part
	adornment.ZIndex = 5
	adornment.AlwaysOnTop = true
	adornment.Transparency = 0.5
	adornment.Color3 = Color3.new(1, 0, 0)
	
	adornment.Parent = part.Parent
	end
end)

cmd.add({"unesppart", "unpartesp"}, {"unesppart (unpartesp)", "Removes the esp from the parts"}, function(...)
	local parts = game.Workspace:GetChildren()

	for i, part in ipairs(parts) do
	if part:IsA("BoxHandleAdornment") then
	part:Destroy()
	end
	end
end)

cmd.add({"viewpart", "viewp"}, {"viewpart {partname} (vpart)", "Views a part"}, function(...)
	local parts = game.Workspace:GetChildren()
	local partList = {}
	for i, child in pairs(parts) do
		if child.Name == (...) then
			table.insert(partList, child)
		end
	end
	
	local camera = game.Workspace.CurrentCamera
	camera.CameraType = "Scriptable"
	
	local index = 1
	while true do
		camera.CoordinateFrame = partList[index].CFrame
		index = index + 1
		if index > #partList then
			index = 1
		end
		wait(0.7)
	end
end)

cmd.add({"unviewpart", "unviewp"}, {"unviewpart (unviewp)", "Unviews the part"}, function()
	local camera = game.Workspace.CurrentCamera
	camera.CameraType = "Custom"	
	wait(0.2)
	local workspace = game.Workspace
Players = game:GetService("Players")
local speaker = Players.LocalPlayer
workspace.CurrentCamera:remove()
	wait(.1)
	workspace.CurrentCamera.CameraSubject = speaker.Character:FindFirstChildWhichIsA('Humanoid')
	workspace.CurrentCamera.CameraType = "Custom"
	speaker.CameraMinZoomDistance = 0.5
	speaker.CameraMaxZoomDistance = 400
	speaker.CameraMode = "Classic"
	speaker.Character.Head.Anchored = false
end)

cmd.add({"hitbox", "hbox"}, {"hitbox {amount}", "Makes everyones hitbox as much as you want"}, function(...)
	


wait();

Notify({
Description = "Hitbox changed";
Title = "Nameless Admin";
Duration = 5;

});
	_G.HeadSize = (...)
	_G.Disabled = true
	
	game:GetService('RunService').RenderStepped:connect(function()
	if _G.Disabled then
	for i,v in next, game:GetService('Players'):GetPlayers() do
	if v.Name ~= game:GetService('Players').LocalPlayer.Name then
	pcall(function()
	v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
	v.Character.HumanoidRootPart.Transparency = 0.7
	v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really black")
	v.Character.HumanoidRootPart.Material = "Neon"
	v.Character.HumanoidRootPart.CanCollide = false
	end)
	end
	end
	end
	end)
end)

cmd.add({"unhitbox", "unhbox"}, {"unhitbox", "Disables hitbox"}, function(...)
	


wait();

Notify({
Description = "Hitbox disabled";
Title = "Nameless Admin";
Duration = 5;

});
	_G.HeadSize = 0
	_G.Disabled = false
	
	game:GetService('RunService').RenderStepped:connect(function()
	if _G.Disabled then
	for i,v in next, game:GetService('Players'):GetPlayers() do
	if v.Name ~= game:GetService('Players').LocalPlayer.Name then
	pcall(function()
	v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
	v.Character.HumanoidRootPart.Transparency = 0.7
	v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really black")
	v.Character.HumanoidRootPart.Material = "Neon"
	v.Character.HumanoidRootPart.CanCollide = false
	end)
	end
	end
	end
	end)
end)

cmd.add({"breakcars", "bcars"}, {"breakcars (bcars)", "Breaks any car"}, function()
	


wait();

Notify({
Description = "Car breaker loaded, sit on a vehicle need to be the driver";
Title = "Nameless Admin";
Duration = 5;

});
	local UserInputService = game:GetService("UserInputService")
local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
local Folder = Instance.new("Folder", game:GetService("Workspace"))
local Part = Instance.new("Part", Folder)
local Attachment1 = Instance.new("Attachment", Part)
Part.Anchored = true
Part.CanCollide = false
Part.Transparency = 1
local Updated = Mouse.Hit + Vector3.new(0, 5, 0)
local NetworkAccess = coroutine.create(function()
    settings().Physics.AllowSleep = false
    while game:GetService("RunService").RenderStepped:Wait() do
        for _, Players in next, game:GetService("Players"):GetPlayers() do
            if Players ~= game:GetService("Players").LocalPlayer then
                Players.MaximumSimulationRadius = 0 
                sethiddenproperty(Players, "SimulationRadius", 0) 
            end 
        end
        game:GetService("Players").LocalPlayer.MaximumSimulationRadius = math.pow(math.huge,math.huge)
        setsimulationradius(math.huge) 
    end 
end) 
coroutine.resume(NetworkAccess)
local function ForcePart(v)
    if v:IsA("Part") and v.Anchored == false and v.Parent:FindFirstChild("Humanoid") == nil and v.Parent:FindFirstChild("Head") == nil and v.Name ~= "Handle" then
        Mouse.TargetFilter = v
        for _, x in next, v:GetChildren() do
            if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
                x:Destroy()
            end
        end
        if v:FindFirstChild("Attachment") then
            v:FindFirstChild("Attachment"):Destroy()
        end
        if v:FindFirstChild("AlignPosition") then
            v:FindFirstChild("AlignPosition"):Destroy()
        end
        if v:FindFirstChild("Torque") then
            v:FindFirstChild("Torque"):Destroy()
        end
        v.CanCollide = false
        local Torque = Instance.new("Torque", v)
        Torque.Torque = Vector3.new(100000, 100000, 100000)
        local AlignPosition = Instance.new("AlignPosition", v)
        local Attachment2 = Instance.new("Attachment", v)
        Torque.Attachment0 = Attachment2
        AlignPosition.MaxForce = 9999999999999999
        AlignPosition.MaxVelocity = math.huge
        AlignPosition.Responsiveness = 200
        AlignPosition.Attachment0 = Attachment2 
        AlignPosition.Attachment1 = Attachment1
    end
end
for _, v in next, game:GetService("Workspace"):GetDescendants() do
    ForcePart(v)
end
game:GetService("Workspace").DescendantAdded:Connect(function(v)
    ForcePart(v)
end)
UserInputService.InputBegan:Connect(function(Key, Chat)
    if Key.KeyCode == Enum.KeyCode.E and not Chat then
       Updated = Mouse.Hit + Vector3.new(0, 5, 0)
    end
end)
spawn(function()
    while game:GetService("RunService").RenderStepped:Wait() do
        Attachment1.WorldCFrame = Updated
    end
end)
end)

cmd.add({"firetouchinterests", "fti"}, {"firetouchinterests (fti)", "Fires every Touch Interest that's in workspace"}, function()
local ftiamount = 0

		for _,v in pairs(workspace:GetDescendants()) do
        if v:IsA("TouchTransmitter") then
                           ftiamount = ftiamount + 1
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0) --0 is touch
        wait()
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1) -- 1 is untouch
        end
        end

		


wait();

Notify({
Description = "Fired " .. ftiamount .. " amount of touch interests";
Title = "Nameless Admin";
Duration = 7;

});
end)

cmd.add({"infjump", "infinitejump"}, {"infjump (infinitejump)", "Makes you be able to jump infinitly"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Infinite jump enabled";
	Title = "Nameless Admin";
	Duration = 5;
	
});
	_G.infinjump = true

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
Mouse.KeyDown:connect(function(k)
if _G.infinjump then
if k:byte() == 32 then
Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
Humanoid:ChangeState("Jumping")
wait(0.1)
Humanoid:ChangeState("Seated")
end
end
end)
end)

cmd.add({"uninfjump", "uninfinitejump"}, {"uninfjump (uninfinitejump)", "Makes you NOT be able to infinitly jump"}, function()
	


wait();

Notify({
Description = "Infinite jump disabled";
Title = "Nameless Admin";
Duration = 5;

});
	_G.infinjump = false

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
Mouse.KeyDown:connect(function(k)
if _G.infinjump then
if k:byte() == 32 then
Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
Humanoid:ChangeState("Jumping")
wait(0.1)
Humanoid:ChangeState("Seated")
end
end
end)
end)

cmd.add({"xray", "xrayon"}, {"xray (xrayon)", "Makes you be able to see through walls"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Xray enabled";
	Title = "Nameless Admin";
	Duration = 5;
	
});
transparent = true
	x(transparent)
end)

cmd.add({"unxray", "xrayoff"}, {"unxray (xrayoff)", "Makes you not be able to see through walls"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Xray disabled";
	Title = "Nameless Admin";
	Duration = 5;
	
});
transparent = false
	x(transparent)
end)

cmd.add({"pastebinscraper", "pastebinscrape"}, {"pastebinscraper (pastebinscrape)", "Scrapes paste bin posts"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Pastebin scraper loaded";
	Title = "Nameless Admin";
	Duration = 5;
	
});
	loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/FE/main/PastebinScraperScript"))()
	game:GetService("CoreGui").Scraper["Pastebin Scraper"].BackgroundTransparency = 0.5
	game:GetService("CoreGui").Scraper["Pastebin Scraper"].TextButton.Text = "             ⭐ Pastebin Post Scraper ⭐"
	game:GetService("CoreGui").Scraper["Pastebin Scraper"].Content.Search.PlaceholderText = "Search for a post here..."
	game:GetService("CoreGui").Scraper["Pastebin Scraper"].Content.Search.BackgroundTransparency = 0.4	
end)

cmd.add({"amongus", "amogus"}, {"amongus (amogus)", "among us in real life, sus sus."}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Amog us...";
	Title = "Nameless Admin";
	Duration = 5;
	
});
	loadstring(game:HttpGet(('https://pastefy.ga/aMY1wxRS/raw'),true))()
end)

cmd.add({"blackhole"}, {"blackhole", "Makes unanchored parts teleport to the black hole"}, function()
	local UserInputService = game:GetService("UserInputService")
	local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
	local Folder = Instance.new("Folder", game:GetService("Workspace"))
	local Part = Instance.new("Part", Folder)
	local Attachment1 = Instance.new("Attachment", Part)
	Part.Anchored = true
	Part.CanCollide = false
	Part.Transparency = 1
	local Updated = Mouse.Hit + Vector3.new(0, 5, 0)
	local NetworkAccess = coroutine.create(function()
		settings().Physics.AllowSleep = false
		while game:GetService("RunService").RenderStepped:Wait() do
			for _, Players in next, game:GetService("Players"):GetPlayers() do
				if Players ~= game:GetService("Players").LocalPlayer then
					Players.MaximumSimulationRadius = 0 
					sethiddenproperty(Players, "SimulationRadius", 0) 
				end 
			end
			game:GetService("Players").LocalPlayer.MaximumSimulationRadius = math.pow(math.huge,math.huge)
		end 
	end) 
	coroutine.resume(NetworkAccess)
	local function ForcePart(v)
		if v:IsA("Part") and v.Anchored == false and v.Parent:FindFirstChild("Humanoid") == nil and v.Parent:FindFirstChild("Head") == nil and v.Name ~= "Handle" then
			Mouse.TargetFilter = v
			for _, x in next, v:GetChildren() do
				if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
					x:Destroy()
				end
			end
			if v:FindFirstChild("Attachment") then
				v:FindFirstChild("Attachment"):Destroy()
			end
			if v:FindFirstChild("AlignPosition") then
				v:FindFirstChild("AlignPosition"):Destroy()
			end
			if v:FindFirstChild("Torque") then
				v:FindFirstChild("Torque"):Destroy()
			end
			v.CanCollide = false
			local Torque = Instance.new("Torque", v)
			Torque.Torque = Vector3.new(100000, 100000, 100000)
			local AlignPosition = Instance.new("AlignPosition", v)
			local Attachment2 = Instance.new("Attachment", v)
			Torque.Attachment0 = Attachment2
			AlignPosition.MaxForce = 9999999999999999
			AlignPosition.MaxVelocity = math.huge
			AlignPosition.Responsiveness = 200
			AlignPosition.Attachment0 = Attachment2 
			AlignPosition.Attachment1 = Attachment1
		end
	end
	for _, v in next, game:GetService("Workspace"):GetDescendants() do
		ForcePart(v)
	end
	game:GetService("Workspace").DescendantAdded:Connect(function(v)
		ForcePart(v)
	end)
	UserInputService.InputBegan:Connect(function(Key, Chat)
		if Key.KeyCode == Enum.KeyCode.E and not Chat then
		   Updated = Mouse.Hit + Vector3.new(0, 5, 0)
		end
	end)
	spawn(function()
		while game:GetService("RunService").RenderStepped:Wait() do
			Attachment1.WorldCFrame = Updated
		end
	end)
	
	
	
	wait();
	
	Notify({
	Description = "Blackhole has been loaded, press e to change the position to where your mouse is";
	Title = "Nameless Admin";
	Duration = 5;
	
});
end)

cmd.add({"fullbright", "fullb"}, {"fullbright (fullb)", "Makes games that are really dark to have no darkness and be really light"}, function()
	if not _G.FullBrightExecuted then

		_G.FullBrightEnabled = false
	
		_G.NormalLightingSettings = {
			Brightness = game:GetService("Lighting").Brightness,
			ClockTime = game:GetService("Lighting").ClockTime,
			FogEnd = game:GetService("Lighting").FogEnd,
			GlobalShadows = game:GetService("Lighting").GlobalShadows,
			Ambient = game:GetService("Lighting").Ambient
		}
	
		game:GetService("Lighting"):GetPropertyChangedSignal("Brightness"):Connect(function()
			if game:GetService("Lighting").Brightness ~= 1 and game:GetService("Lighting").Brightness ~= _G.NormalLightingSettings.Brightness then
				_G.NormalLightingSettings.Brightness = game:GetService("Lighting").Brightness
				if not _G.FullBrightEnabled then
					repeat
						wait()
					until _G.FullBrightEnabled
				end
				game:GetService("Lighting").Brightness = 1
			end
		end)
	
		game:GetService("Lighting"):GetPropertyChangedSignal("ClockTime"):Connect(function()
			if game:GetService("Lighting").ClockTime ~= 12 and game:GetService("Lighting").ClockTime ~= _G.NormalLightingSettings.ClockTime then
				_G.NormalLightingSettings.ClockTime = game:GetService("Lighting").ClockTime
				if not _G.FullBrightEnabled then
					repeat
						wait()
					until _G.FullBrightEnabled
				end
				game:GetService("Lighting").ClockTime = 12
			end
		end)
	
		game:GetService("Lighting"):GetPropertyChangedSignal("FogEnd"):Connect(function()
			if game:GetService("Lighting").FogEnd ~= 786543 and game:GetService("Lighting").FogEnd ~= _G.NormalLightingSettings.FogEnd then
				_G.NormalLightingSettings.FogEnd = game:GetService("Lighting").FogEnd
				if not _G.FullBrightEnabled then
					repeat
						wait()
					until _G.FullBrightEnabled
				end
				game:GetService("Lighting").FogEnd = 786543
			end
		end)
	
		game:GetService("Lighting"):GetPropertyChangedSignal("GlobalShadows"):Connect(function()
			if game:GetService("Lighting").GlobalShadows ~= false and game:GetService("Lighting").GlobalShadows ~= _G.NormalLightingSettings.GlobalShadows then
				_G.NormalLightingSettings.GlobalShadows = game:GetService("Lighting").GlobalShadows
				if not _G.FullBrightEnabled then
					repeat
						wait()
					until _G.FullBrightEnabled
				end
				game:GetService("Lighting").GlobalShadows = false
			end
		end)
	
		game:GetService("Lighting"):GetPropertyChangedSignal("Ambient"):Connect(function()
			if game:GetService("Lighting").Ambient ~= Color3.fromRGB(178, 178, 178) and game:GetService("Lighting").Ambient ~= _G.NormalLightingSettings.Ambient then
				_G.NormalLightingSettings.Ambient = game:GetService("Lighting").Ambient
				if not _G.FullBrightEnabled then
					repeat
						wait()
					until _G.FullBrightEnabled
				end
				game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
			end
		end)
	
		game:GetService("Lighting").Brightness = 1
		game:GetService("Lighting").ClockTime = 12
		game:GetService("Lighting").FogEnd = 786543
		game:GetService("Lighting").GlobalShadows = false
		game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
	
		local LatestValue = true
		spawn(function()
			repeat
				wait()
			until _G.FullBrightEnabled
			while wait() do
				if _G.FullBrightEnabled ~= LatestValue then
					if not _G.FullBrightEnabled then
						game:GetService("Lighting").Brightness = _G.NormalLightingSettings.Brightness
						game:GetService("Lighting").ClockTime = _G.NormalLightingSettings.ClockTime
						game:GetService("Lighting").FogEnd = _G.NormalLightingSettings.FogEnd
						game:GetService("Lighting").GlobalShadows = _G.NormalLightingSettings.GlobalShadows
						game:GetService("Lighting").Ambient = _G.NormalLightingSettings.Ambient
					else
						game:GetService("Lighting").Brightness = 1
						game:GetService("Lighting").ClockTime = 12
						game:GetService("Lighting").FogEnd = 786543
						game:GetService("Lighting").GlobalShadows = false
						game:GetService("Lighting").Ambient = Color3.fromRGB(178, 178, 178)
					end
					LatestValue = not LatestValue
				end
			end
		end)
	end
	
	_G.FullBrightExecuted = true
	_G.FullBrightEnabled = not _G.FullBrightEnabled
end)

cmd.add({"givehat", "givehatui"}, {"givehat (givehatui)", "Executes a hat giver gui check in console for hat names"}, function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/GiveHat"))()
end)

cmd.add({"fireproximityprompts", "fpp"}, {"fireproximityprompts (fpp)", "Fires every Touch Interest that's in workspace"}, function()
fppamount = 0

for i,v in pairs(game.Workspace:GetDescendants()) do
		if v:IsA("Part") and v.Name == "BanditClick" then
		    fppamount = fppamount + 1
			fireproximityprompt(v.Proximity)
		end
end
 
 	


wait();

Notify({
Description = "Fired " .. fppamount .. " of proximity prompts";
Title = "Nameless Admin";
Duration = 7;

});
end)

cmd.add({"iy", "i"}, {"iy {command} (i)", "Executes infinite yield scripts"}, function(...)
	if IYLOADED == false then
		local function copytable(tbl) local copy = {} for i,v in pairs(tbl) do copy[i] = v end return copy end
		local sandbox_env = copytable(getfenv())
		setmetatable(sandbox_env, {
		__index = function(self, i)
			if rawget(sandbox_env, i) then
				return rawget(sandbox_env, i)
			elseif getfenv()[i] then
				return getfenv()[i]
			end
		end
		})
		sandbox_env.game = nil
		iy, _ = game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"):gsub("local Main", "Main"):gsub("Players.LocalPlayer.Chatted","Funny = Players.LocalPlayer.Chatted"):gsub("local lastMessage","notify = _G.notify\nlocal lastMessage")
		setfenv(loadstring(iy),sandbox_env)()
		iy_cmds_table = sandbox_env.CMDs
		iy_gui = sandbox_env.Main
		iy_chathandler = sandbox_env.Funny
		execCmd = sandbox_env.execCmd
		iy_gui:Destroy()
		pcall(function()
			iy_chathandler:Disconnect()
		end)
		IYLOADED = true
	end
	execCmd((...))
	end)

cmd.add({"chatspy"}, {"chatspy", "Spies on chat, enables chat, spies whispers etc."}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Chat spy enabled";
	Title = "Nameless Admin";
	Duration = 5;
	
});
--This script reveals ALL hidden messages in the default chat
--chat "/spy" to toggle!
enabled = true
--if true will check your messages too
spyOnMyself = true
--if true will chat the logs publicly (fun, risky)
public = false
--if true will use /me to stand out
publicItalics = true
--customize private logs
privateProperties = {
	Color = Color3.fromRGB(0,255,255); 
	Font = Enum.Font.SourceSansBold;
	TextSize = 18;
}
--////////////////////////////////////////////////////////////////
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
local instance = (_G.chatSpyInstance or 0) + 1
_G.chatSpyInstance = instance

local function onChatted(p,msg)
	if _G.chatSpyInstance == instance then
		if p==player and msg:lower():sub(1,4)=="/spy" then
			enabled = not enabled
			wait(0.3)
			print("XD")
			StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
		elseif enabled and (spyOnMyself==true or p~=player) then
			msg = msg:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ')
			local hidden = true
			local conn = getmsg.OnClientEvent:Connect(function(packet,channel)
				if packet.SpeakerUserId==p.UserId and packet.Message==msg:sub(#msg-#packet.Message+1) and (channel=="All" or (channel=="Team" and public==false and Players[packet.FromSpeaker].Team==player.Team)) then
					hidden = false
				end
			end)
			wait(1)
			conn:Disconnect()
			if hidden and enabled then
				if public then
					saymsg:FireServer((publicItalics and "/me " or '').."{SPY} [".. p.Name .."]: "..msg,"All")
				else
					privateProperties.Text = "{SPY} [".. p.Name .."]: "..msg
					StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
				end
			end
		end
	end
end

for _,p in ipairs(Players:GetPlayers()) do
	p.Chatted:Connect(function(msg) onChatted(p,msg) end)
end
Players.PlayerAdded:Connect(function(p)
	p.Chatted:Connect(function(msg) onChatted(p,msg) end)
end)
print("XD")
StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
local chatFrame = player.PlayerGui.Chat.Frame
chatFrame.ChatChannelParentFrame.Visible = true
chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)
end)

cmd.add({"bhop"}, {"bhop", "bhop bhop bhop bhop bhop bhop bhop bla bla bla idk what im saying"}, function()
local player
local character
local collider
local camera
local input
local collider
local playerGrounded
local playerVelocity
local jumping
local moveInputSum
local dt = 1/60
local partYRatio
local partZRatio
local cameraYaw
local cameraLook
local movementPosition
local movementVelocity
local gravityForce
local airAccelerate
local airMaxSpeed
local groundAccelerate
local groundMaxVelocity
local friction
local playerTorsoToGround
local movementStickDistance
local jumpVelocity
local movementPositionForce
local movementVelocityForce
local maxMovementPitch
local rayYLength
local movementPositionD
local movementPositionP
local movementVelocityP
local gravity



function init(Player, Camera, Input)
	player = Player
	character = player.Character
	collider = character.HumanoidRootPart
	camera = Camera
	input = Input
	playerVelocity = 0
	playerGrounded = false
	moveInputSum = {
	["forward"] = 0,
	["side"] 	= 0 --left is positive
	}
	
	airAccelerate 			= 10000
	airMaxSpeed 			= 2.4
	groundAccelerate 		= 250
	groundMaxVelocity 		= 20
	friction			 	= 10
	playerTorsoToGround 	= 3
	movementStickDistance 	= 0.5
	jumpVelocity 			= 52.5
	movementPositionForce	= 400000
	movementVelocityForce	= 300000
	maxMovementPitch		= 0.6
	rayYLength				= playerTorsoToGround + movementStickDistance
	movementPositionD		= 125
	movementPositionP		= 14000
	movementVelocityP		= 1500
	gravity					= 0.4
	
end

function initBodyMovers()
	movementPosition = Instance.new("BodyPosition", collider)
	movementPosition.Name = "movementPosition"
	movementPosition.D = movementPositionD
	movementPosition.P = movementPositionP
	movementPosition.maxForce = Vector3.new()
	movementPosition.position = Vector3.new()
	
	movementVelocity = Instance.new("BodyVelocity", collider)
	movementVelocity.Name = "movementVelocity"
	movementVelocity.P = movementVelocityP
	movementVelocity.maxForce = Vector3.new()
	movementVelocity.velocity = Vector3.new()
	
	gravityForce = Instance.new("BodyForce", collider)
	gravityForce.Name = "gravityForce"
	gravityForce.force = Vector3.new(0, (1-gravity)*196.2, 0) * getCharacterMass()
end

function update(deltaTime)
	dt = deltaTime
	updateMoveInputSum()
	cameraYaw = getYaw()
	cameraLook = cameraYaw.lookVector	
	if cameraLook == nil then
		return
	end
	local hitPart, hitPosition, hitNormal, yRatio, zRatio = findCollisionRay()
	partYRatio = yRatio
	partZRatio = zRatio
	
	playerGrounded = hitPart ~= nil and true or false
	playerVelocity = collider.Velocity - Vector3.new(0, collider.Velocity.y, 0)
	if playerGrounded and (input["Space"] or jumping) then
		jumping = true
	else
		jumping = false
	end
	
	setCharacterRotation()
	if jumping then
		jump()
	elseif playerGrounded then
		run(hitPosition)
	else
		air()		
	end
	
end

function updateMoveInputSum()
	moveInputSum["forward"] = input["W"] == true and 1 or 0
	moveInputSum["forward"] = input["S"] == true and moveInputSum["forward"] - 1 or moveInputSum["forward"]
	moveInputSum["side"] = input["A"] == true and 1 or 0
	moveInputSum["side"] = input["D"] == true and moveInputSum["side"] - 1 or moveInputSum["side"]
end

function findCollisionRay()
	local torsoCFrame = character.HumanoidRootPart.CFrame
	local ignoreList = {character, camera}
	local rays = {
		Ray.new(character.HumanoidRootPart.Position, Vector3.new(0, -rayYLength, 0)),
		Ray.new((torsoCFrame * CFrame.new(-0.8,0,0)).p, Vector3.new(0, -rayYLength, 0)),
		Ray.new((torsoCFrame * CFrame.new(0.8,0,0)).p, Vector3.new(0, -rayYLength, 0)),
		Ray.new((torsoCFrame * CFrame.new(0,0,0.8)).p, Vector3.new(0, -rayYLength, 0)),
		Ray.new((torsoCFrame * CFrame.new(0,0,-0.8)).p, Vector3.new(0, -rayYLength, 0))
	}
	local rayReturns  = {}
	
	local i
	for i = 1, #rays do
		local part, position, normal = game.Workspace:FindPartOnRayWithIgnoreList(rays[i],ignoreList)
		if part == nil then
			position = Vector3.new(0,-3000000,0)
		end
		if i == 1 then
			table.insert(rayReturns, {part, position, normal})
		else
			local yPos = position.y
			if yPos <= rayReturns[#rayReturns][2].y then
				table.insert(rayReturns, {part, position, normal})
			else 
				local j
				for j = 1, #rayReturns do
					if yPos >= rayReturns[j][2].y then
						table.insert(rayReturns, j, {part, position, normal})
					end
				end
			end
		end
	end
	
	i = 1
	local yRatio, zRatio = getPartYRatio(rayReturns[i][3])
	while magnitude2D(yRatio, zRatio) > maxMovementPitch and i<#rayReturns do
		i = i + 1
		if rayReturns[i][1] then
			yRatio, zRatio = getPartYRatio(rayReturns[i][3])
		end
	end
	
	return rayReturns[i][1], rayReturns[i][2], rayReturns[i][3], yRatio, zRatio
end

function setCharacterRotation()
	local rotationLook = collider.Position + camera.CoordinateFrame.lookVector
	collider.CFrame = CFrame.new(collider.Position, Vector3.new(rotationLook.x, collider.Position.y, rotationLook.z))
	collider.RotVelocity = Vector3.new()
end

function jump()
	collider.Velocity = Vector3.new(collider.Velocity.x, jumpVelocity, collider.Velocity.z)
	air()
end

function air()
	movementPosition.maxForce = Vector3.new()
	movementVelocity.velocity = getMovementVelocity(collider.Velocity, airAccelerate, airMaxSpeed)
	movementVelocity.maxForce = getMovementVelocityAirForce()
end

function run(hitPosition)
	local playerSpeed = collider.Velocity.magnitude
	local mVelocity = collider.Velocity
	
	if playerSpeed ~= 0 then
		local drop = playerSpeed * friction * dt;
		mVelocity = mVelocity * math.max(playerSpeed - drop, 0) / playerSpeed;
	end
	
	movementPosition.position = hitPosition + Vector3.new(0,playerTorsoToGround,0)
	movementPosition.maxForce = Vector3.new(0,movementPositionForce,0)
	movementVelocity.velocity = getMovementVelocity(mVelocity, groundAccelerate, groundMaxVelocity)
	local VelocityForce = getMovementVelocityForce()
	movementVelocity.maxForce = VelocityForce
	movementVelocity.P = movementVelocityP
end

function getMovementVelocity(prevVelocity, accelerate, maxVelocity)
	local accelForward = cameraLook * moveInputSum["forward"]
	local accelSide = (cameraYaw * CFrame.Angles(0,math.rad(90),0)).lookVector * moveInputSum["side"];
	local accelDir = (accelForward+accelSide).unit;
	if moveInputSum["forward"] == 0 and moveInputSum["side"] == 0 then --avoids divide 0 errors
		accelDir = Vector3.new(0,0,0);
	end
	
	local projVel =  prevVelocity:Dot(accelDir);
	local accelVel = accelerate * dt;
	
	if (projVel + accelVel > maxVelocity) then
		accelVel = math.max(maxVelocity - projVel, 0);
	end
	
	return prevVelocity + accelDir * accelVel;
end

function getMovementVelocityForce()

	return Vector3.new(movementVelocityForce,0,movementVelocityForce)
end

function getMovementVelocityAirForce()
	local accelForward = cameraLook * moveInputSum["forward"];
	local accelSide = (cameraYaw * CFrame.Angles(0,math.rad(90),0)).lookVector * moveInputSum["side"]
	local accelDir = (accelForward+accelSide).unit
	if moveInputSum["forward"] == 0 and moveInputSum["side"] == 0 then
		accelDir = Vector3.new(0,0,0);
	end
	
	local xp = math.abs(accelDir.x)
	local zp = math.abs(accelDir.z)
	
	return Vector3.new(movementVelocityForce*xp,0,movementVelocityForce*zp)
end

function getPartYRatio(normal)
	local partYawVector = Vector3.new(-normal.x, 0, -normal.z)
	if partYawVector.magnitude == 0 then
		return 0,0
	else
		local partPitch = math.atan2(partYawVector.magnitude,normal.y)/(math.pi/2)
		local vector = Vector3.new(cameraLook.x, 0, cameraLook.z)*partPitch
		return vector:Dot(partYawVector), -partYawVector:Cross(vector).y
	end	
end

function getYaw() --returns CFrame
	return camera.CoordinateFrame*CFrame.Angles(-getPitch(),0,0)
end

function getPitch() --returns number
	return math.pi/2 - math.acos(camera.CoordinateFrame.lookVector:Dot(Vector3.new(0,1,0)))
end

function getCharacterMass()
	return character.HumanoidRootPart:GetMass() + character.Head:GetMass()
end

function magnitude2D(x,z)
	return math.sqrt(x*x+z*z)
end

local inputKeys = {
	["W"] = false,
	["S"] = false,
	["A"] = false,
	["D"] = false,
	["Space"] = false,
	["LMB"] = false,
	["RMB"] = false
}
local plr = game:GetService("Players").LocalPlayer
local camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
function onInput(input, gameProcessedEvent)
	local inputState
	--print(input.KeyCode)
	if input.UserInputState == Enum.UserInputState.Begin then
		inputState = true
	elseif input.UserInputState == Enum.UserInputState.End then
		inputState = false
	else
		return
	end 
	
	if input.UserInputType == Enum.UserInputType.Keyboard then
		local key = input.KeyCode.Name
		if inputKeys[key] ~= nil then
			inputKeys[key] = inputState
		end
	elseif input.UserInputType == Enum.UserInputType.MouseButton1 then --LMB down
		inputKeys.LMB = inputState
	elseif input.UserInputType == Enum.UserInputType.MouseButton2 then --RMB down
		inputKeys.RMB = inputState
	end
end
function main()
	local a = plr.Character:FindFirstChildOfClass("Humanoid") or plr.Character:WaitForChild("Humanoid");
	a.PlatformStand = true
	--init movement
	init(plr, camera, inputKeys);
	initBodyMovers();
		
	--connect input
	UserInputService.InputBegan:connect(onInput);
	UserInputService.InputEnded:connect(onInput);
	--connect updateloop
	game:GetService("RunService"):BindToRenderStep("updateLoop", 1, updateLoop);
	
	--rip
end

local prevUpdateTime = nil
local updateDT = 1/60

function setDeltaTime() --seconds
	local UpdateTime = tick() 
	if prevUpdateTime ~= nil then
		updateDT = (UpdateTime - prevUpdateTime)
	else
		updateDT = 1/60
	end
	prevUpdateTime = UpdateTime
end
function updateLoop()
	setDeltaTime();
	update(updateDT);
end
main()

	local char = game.Players.LocalPlayer.Character
local con
	con = char.Humanoid.Died:Connect(function()
	    print("Died")
	    	game.Players.LocalPlayer.Character:WaitForChild("Humanoid").PlatformStand = false
	    collider:Disconnect()
	    character:Disconnect()
	    moveInputSum:Disconnect()
playerGrounded:Disconnect()
playerVelocity:Disconnect()
jumping:Disconnect()
moveInputSum:Disconnect()
partYRatio:Disconnect()
partZRatio:Disconnect()
cameraYaw:Disconnect()
cameraLook:Disconnect()
movementPosition:Disconnect()
movementVelocity:Disconnect()
gravityForce:Disconnect()
airAccelerate:Disconnect()
groundAccelerate:Disconnect()
groundMaxVelocity:Disconnect()
friction:Disconnect()
playerTorsoToGround:Disconnect()
movementStickDistance:Disconnect()
jumpVelocity:Disconnect()
movementPositionForce:Disconnect()
movementVelocityForce:Disconnect()
maxMovementPitch:Disconnect()
rayYLength:Disconnect()
movementPositionD:Disconnect()
movementPositionP:Disconnect()
movementVelocityP:Disconnect()
gravity:Disconnect()
	con:Disconnect()
	lib.disconnect("bhop")
    end)
end)


cmd.add({"2016anims"}, {"2016anims", "2016 animations"}, function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/FE/main/2016anims"))()
end)

cmd.add({"oganims"}, {"oganims", "Old animations from 2007"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "OG animations set";
	Title = "Nameless Admin";
	Duration = 5;
	
});
	loadstring(game:HttpGet(('https://pastebin.com/raw/6GNkQUu6'),true))()
end)

cmd.add({"fakechat"}, {"fakechat", "Fake a chat gui"}, function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/FE/main/fakechat"))()
end)

cmd.add({"fpscap"}, {"fpscap <number>", "Sets the fps cap to whatever you want"}, function(...)
	setfpscap(...)
end)

cmd.add({"holdhat"}, {"holdhat", "Can make you hold your hats execute the command and you will have them in your inventory"}, function(...)
--made by Nightmare#0930
local lp = game.Players.LocalPlayer
local char = lp.Character

for i, v in pairs(char:GetChildren()) do
    if v:IsA("BallSocketConstraint") then
        v:Destroy()
    end
end

for i, v in pairs(char:GetChildren()) do
    if v:IsA("HingeConstraint") then
        v:Destroy()
    end
end

for i, v in pairs(char.Humanoid:GetAccessories()) do
local hat = v.Name

char[hat].Archivable = true
local fake = char[hat]:Clone()
fake.Parent = char
fake.Handle.Transparency = 1

local hold = false
local enabled = false

char[hat].Handle.AccessoryWeld:Destroy()

local tool = Instance.new("Tool", lp.Backpack)
tool.RequiresHandle = true
tool.CanBeDropped = false
tool.Name = hat

local handle = Instance.new("Part", tool)
handle.Name = "Handle"
handle.Size = Vector3.new(1, 1, 1)
handle.Massless = true
handle.Transparency = 1

local positions = {
    forward = tool.GripForward,
    pos = tool.GripPos,
    right = tool.GripRight,
    up = tool.GripUp
}

tool.Equipped:connect(function()
 hold = true
end)

tool.Unequipped:connect(function()
   hold = false
end)

tool.Activated:connect(function()
    if enabled == false then
        enabled = true
        tool.GripForward = Vector3.new(-0.976,0,-0.217)
    tool.GripPos = Vector3.new(.95,-0.76,1.4)
    tool.GripRight = Vector3.new(0.217,0, 0.976)
    tool.GripUp = Vector3.new(0,1,0)
    wait(.8)
    tool.GripForward = positions.forward
    tool.GripPos = positions.pos
    tool.GripRight = positions.right
    tool.GripUp = positions.up
    enabled = false
    end
end)

game:GetService("RunService").Heartbeat:connect(function()
    pcall(function()
       char[hat].Handle.Velocity = Vector3.new(30, 0, 0)
if hold == false then
    char[hat].Handle.CFrame = fake.Handle.CFrame
elseif hold == true then
    char[hat].Handle.CFrame = handle.CFrame
    end
end)
end)
end
end)

cmd.add({"invisible"}, {"invisible", "Sets invisibility to scare people or something"}, function()
--[[Invisibility Toggle

You can find the orginal concept here: https://v3rmillion.net/showthread.php?tid=544634

This method clones the character locally, teleports the real character to a safe location, then sets the character to the clone.
Basically, your real character is in the sky while you are on the ground.


Because of the way this works, games with a decent anti-cheat will fuck this up.
If you turn it off, you have to go to a safe place before going invisible.

Written by: BitingTheDust ; https://v3rmillion.net/member.php?action=profile&uid=1628149
]]
--Settings:
local ScriptStarted = false
local Keybind = "E" --Set to whatever you want, has to be the name of a KeyCode Enum.
local Transparency = true --Will make you slightly transparent when you are invisible. No reason to disable.
local NoClip = false --Will make your fake character no clip.

local Player = game:GetService("Players").LocalPlayer
local RealCharacter = Player.Character or player.CharacterAdded:wait(1)

local IsInvisible = false

RealCharacter.Archivable = true
local FakeCharacter = RealCharacter:Clone()
local Part
Part = Instance.new("Part", workspace)
Part.Anchored = true
Part.Size = Vector3.new(200, 1, 200)
Part.CFrame = CFrame.new(9999, 9999, 9999) --Set this to whatever you want, just far away from the map.
Part.CanCollide = true
FakeCharacter.Parent = workspace
FakeCharacter.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0, 5, 0)

for i, v in pairs(RealCharacter:GetChildren()) do
  if v:IsA("LocalScript") then
      local clone = v:Clone()
      clone.Disabled = true
      clone.Parent = FakeCharacter
  end
end
if Transparency then
  for i, v in pairs(FakeCharacter:GetDescendants()) do
      if v:IsA("BasePart") then
          v.Transparency = 0.7
      end
  end
end
local CanInvis = true
function RealCharacterDied()
  CanInvis = false
  RealCharacter:Destroy()
  RealCharacter = Player.Character
  CanInvis = true
  isinvisible = false
  FakeCharacter:Destroy()
  workspace.CurrentCamera.CameraSubject = RealCharacter.Humanoid

  RealCharacter.Archivable = true
  FakeCharacter = RealCharacter:Clone()
  Part:Destroy()
  Part = Instance.new("Part", workspace)
  Part.Anchored = true
  Part.Size = Vector3.new(200, 1, 200)
  Part.CFrame = CFrame.new(9999, 9999, 9999) --Set this to whatever you want, just far away from the map.
  Part.CanCollide = true
  FakeCharacter.Parent = workspace
  FakeCharacter.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0, 5, 0)

  for i, v in pairs(RealCharacter:GetChildren()) do
      if v:IsA("LocalScript") then
          local clone = v:Clone()
          clone.Disabled = true
          clone.Parent = FakeCharacter
      end
  end
  if Transparency then
      for i, v in pairs(FakeCharacter:GetDescendants()) do
          if v:IsA("BasePart") then
              v.Transparency = 0.7
          end
      end
  end
 RealCharacter.Humanoid.Died:Connect(function()
 RealCharacter:Destroy()
 FakeCharacter:Destroy()
 end)
 Player.CharacterAppearanceLoaded:Connect(RealCharacterDied)
end
RealCharacter.Humanoid.Died:Connect(function()
 RealCharacter:Destroy()
 FakeCharacter:Destroy()
 end)
Player.CharacterAppearanceLoaded:Connect(RealCharacterDied)
local PseudoAnchor
game:GetService "RunService".RenderStepped:Connect(
  function()
      if PseudoAnchor ~= nil then
          PseudoAnchor.CFrame = Part.CFrame * CFrame.new(0, 5, 0)
      end
       if NoClip then
      FakeCharacter.Humanoid:ChangeState(11)
       end
  end
)

PseudoAnchor = FakeCharacter.HumanoidRootPart
local function Invisible()
  if IsInvisible == false then
      local StoredCF = RealCharacter.HumanoidRootPart.CFrame
      RealCharacter.HumanoidRootPart.CFrame = FakeCharacter.HumanoidRootPart.CFrame
      FakeCharacter.HumanoidRootPart.CFrame = StoredCF
      RealCharacter.Humanoid:UnequipTools()
      Player.Character = FakeCharacter
      workspace.CurrentCamera.CameraSubject = FakeCharacter.Humanoid
      PseudoAnchor = RealCharacter.HumanoidRootPart
      for i, v in pairs(FakeCharacter:GetChildren()) do
          if v:IsA("LocalScript") then
              v.Disabled = false
          end
      end

      IsInvisible = true
  else
      local StoredCF = FakeCharacter.HumanoidRootPart.CFrame
      FakeCharacter.HumanoidRootPart.CFrame = RealCharacter.HumanoidRootPart.CFrame
     
      RealCharacter.HumanoidRootPart.CFrame = StoredCF
     
      FakeCharacter.Humanoid:UnequipTools()
      Player.Character = RealCharacter
      workspace.CurrentCamera.CameraSubject = RealCharacter.Humanoid
      PseudoAnchor = FakeCharacter.HumanoidRootPart
      for i, v in pairs(FakeCharacter:GetChildren()) do
          if v:IsA("LocalScript") then
              v.Disabled = true
          end
      end
      IsInvisible = false
  end
end

game:GetService("UserInputService").InputBegan:Connect(
  function(key, gamep)
      if gamep then
          return
      end
      if key.KeyCode.Name:lower() == Keybind:lower() and CanInvis and RealCharacter and FakeCharacter then
          if RealCharacter:FindFirstChild("HumanoidRootPart") and FakeCharacter:FindFirstChild("HumanoidRootPart") then
              Invisible()
          end
      end
  end
)
local Sound = Instance.new("Sound",game:GetService("SoundService"))
Sound.SoundId = "rbxassetid://232127604"
Sound:Play()
	


wait();

Notify({
Description = "Invisible loaded, press " .. Keybind .. " to toggle";
Title = "Nameless Admin";
Duration = 10;

});
end)

cmd.add({"unchatspy"}, {"unchat", "Unspies on chat, enables chat, spies whispers etc."}, function()
	


wait();

Notify({
Description = "Chat spy enabled";
Title = "Nameless Admin";
Duration = 5;

});
--This script reveals ALL hidden messages in the default chat
--chat "/spy" to toggle!
enabled = false
--if true will check your messages too
spyOnMyself = true
--if true will chat the logs publicly (fun, risky)
public = false
--if true will use /me to stand out
publicItalics = true
--customize private logs
privateProperties = {
	Color = Color3.fromRGB(0,255,255); 
	Font = Enum.Font.SourceSansBold;
	TextSize = 18;
}
--////////////////////////////////////////////////////////////////
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
local instance = (_G.chatSpyInstance or 0) + 1
_G.chatSpyInstance = instance

local function onChatted(p,msg)
	if _G.chatSpyInstance == instance then
		if p==player and msg:lower():sub(1,4)=="/spy" then
			enabled = not enabled
			wait(0.3)
			print("XD")
			StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
		elseif enabled and (spyOnMyself==true or p~=player) then
			msg = msg:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ')
			local hidden = true
			local conn = getmsg.OnClientEvent:Connect(function(packet,channel)
				if packet.SpeakerUserId==p.UserId and packet.Message==msg:sub(#msg-#packet.Message+1) and (channel=="All" or (channel=="Team" and public==false and Players[packet.FromSpeaker].Team==player.Team)) then
					hidden = false
				end
			end)
			wait(1)
			conn:Disconnect()
			if hidden and enabled then
				if public then
					saymsg:FireServer((publicItalics and "/me " or '').."{SPY} [".. p.Name .."]: "..msg,"All")
				else
					privateProperties.Text = "{SPY} [".. p.Name .."]: "..msg
					StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
				end
			end
		end
	end
end

for _,p in ipairs(Players:GetPlayers()) do
	p.Chatted:Connect(function(msg) onChatted(p,msg) end)
end
Players.PlayerAdded:Connect(function(p)
	p.Chatted:Connect(function(msg) onChatted(p,msg) end)
end)
print("XD")
StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
local chatFrame = player.PlayerGui.Chat.Frame
chatFrame.ChatChannelParentFrame.Visible = true
chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)
end)

cmd.add({"fireremotes"}, {"fireremotes", "Fires every remote."}, function()
local remoteamount = 0

for i,v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") then
 remoteamount = remoteamount + 1
        v:FireServer()
        if v:IsA("BindableEvent") then
             remoteamount = remoteamount + 1
        v:Fire()
        if v:IsA("RemoteFunction") then
             remoteamount = remoteamount + 1
        v:InvokeServer()
        end
        end
        end
end
    
    	


wait();

Notify({
Description = "Fired " .. remoteamount .. " amount of remotes";
Title = "Nameless Admin";
Duration = 7;

});
end)


cmd.add({"uafollow", "unanchoredfollow"}, {"uafollow (unanchoredfollow)", "Makes unanchored parts follow you"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Unanchored follow executed";
	Title = "Nameless Admin";
	Duration = 5;
	
});
local LocalPlayer = game:GetService("Players").LocalPlayer
local unanchoredparts = {}
local movers = {}
for index, part in pairs(workspace:GetDescendants()) do
    if part:IsA("Part") and part.Anchored == false and part:IsDescendantOf(LocalPlayer.Character) == false then
        table.insert(unanchoredparts, part)
        part.Massless = true
        part.CanCollide = false
        if part:FindFirstChildOfClass("BodyPosition") ~= nil then
            part:FindFirstChildOfClass("BodyPosition"):Destroy()
        end
    end
end
for index, part in pairs(unanchoredparts) do
    local mover = Instance.new("BodyPosition", part)
    table.insert(movers, mover)
    mover.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
end
repeat
    for index, mover in pairs(movers) do
        mover.Position = LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame:PointToWorldSpace(Vector3.new(0, 0, 5))
    end
    wait(0.5)
until LocalPlayer.Character:FindFirstChild("Humanoid").Health <= 0
for _, mover in pairs(movers) do
    mover:Destroy()
end
end)

cmd.add({"fov"}, {"fov <number>", "Makes your FOV to something custom you want (1-120 FOV)"}, function(...)
game.Workspace.CurrentCamera.FieldOfView = (...)
end)

cmd.add({"homebrew"}, {"homebrew", "Executes homebrew admin"}, function()
    _G.CustomUI = false
loadstring(game:HttpGet(('https://raw.githubusercontent.com/mgamingpro/HomebrewAdmin/master/Main'),true))()
    end)

		cmd.add({"iy", "i"}, {"iy {command} (i)", "Executes infinite yield scripts"}, function(...)
			if IYLOADED == false then
                local function copytable(tbl) local copy = {} for i,v in pairs(tbl) do copy[i] = v end return copy end
                local sandbox_env = copytable(getfenv())
                setmetatable(sandbox_env, {
                __index = function(self, i)
                    if rawget(sandbox_env, i) then
                        return rawget(sandbox_env, i)
                    elseif getfenv()[i] then
                        return getfenv()[i]
                    end
                end
                })
                sandbox_env.game = nil
                iy, _ = game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"):gsub("local Main", "Main"):gsub("Players.LocalPlayer.Chatted","Funny = Players.LocalPlayer.Chatted"):gsub("local lastMessage","notify = _G.notify\nlocal lastMessage")
                setfenv(loadstring(iy),sandbox_env)()
                iy_cmds_table = sandbox_env.CMDs
                iy_gui = sandbox_env.Main
                iy_chathandler = sandbox_env.Funny
                execCmd = sandbox_env.execCmd
                iy_gui:Destroy()
                pcall(function()
                    iy_chathandler:Disconnect()
                end)
                IYLOADED = true
            end
            execCmd((...))
			end)

    cmd.add({"fatesadmin"}, {"fatesadmin", "Executes fates admin"}, function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))();
    end)
    
    cmd.add({"grabtools", "gt"}, {"grabtools", "Grabs any dropped tools"}, function()
		local p = game:GetService("Players").LocalPlayer
local c = p.Character
if c and c:FindFirstChild("Humanoid") then
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Tool") then
            c:FindFirstChild("Humanoid"):EquipTool(v)
        end
    end
end
    	


wait();

Notify({
Description = "Grabbed all tools";
Title = "Nameless Admin";
Duration = 5;

});
end)

cmd.add({"ws", "speed"}, {"ws <number> (speed)", "Makes your WalkSpeed whatever you want"}, function(...)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (...)
end)

		cmd.add({"cuff", "jail"}, {"cuff <player> (jail)", "Cuffs the player"}, function(...)
			Username = (...)
 
local target = getPlr(Username)
local THumanoidPart
local plrtorso
local TargetCharacter = target.Character
   if TargetCharacter:FindFirstChild("Torso") then
		   plrtorso = TargetCharacter.Torso
	   elseif TargetCharacter:FindFirstChild("UpperTorso") then
		   plrtorso = TargetCharacter.UpperTorso
	   end
        local old = getChar().HumanoidRootPart.CFrame
        local tool = getBp():FindFirstChildOfClass("Tool") or getChar():FindFirstChildOfClass("Tool")
        if target == nil or tool == nil then return end
        local attWeld = attachTool(tool,CFrame.new(0,0,0))
        attachTool(tool,CFrame.new(0,0,0.2) * CFrame.Angles(math.rad(-90),0,0))
		tool.Grip = plrtorso.CFrame
		wait(0.4)
tool.Grip = CFrame.new(0, -7, -3)
        firetouchinterest(target.Character.Humanoid.RootPart,tool.Handle,0)
        firetouchinterest(target.Character.Humanoid.RootPart,tool.Handle,1)
	end)

    cmd.add({"jp", "jumppower"}, {"jp <number> (jumppower)", "Makes your JumpPower whatever you want"}, function(...)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = (...)
        end)

		cmd.add({"oofspam"}, {"oofspam", "Spams oof"}, function()
			_G.enabled = true -- Re-execute to turn off
_G.speed = 100 -- Keep around 100 or it wont play
 
-- Variables
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local LocalPlayer = game:GetService("Players").LocalPlayer;
 
local Character = LocalPlayer.Character or Localplayer.CharacterAdded:wait(1);
local Humanoid = Character:WaitForChild("Humanoid") or Character:FindFirstChildOfClass("Humanoid");
local HRP = Humanoid.RootPart or Humanoid:FindFirstChild("HumanoidRootPart")
 
-- Check
if not Humanoid or not _G.enabled then
   if Humanoid and Humanoid.Health <= 0 then
       Humanoid:Destroy()
   end
   return
end
 
-- Setting Up Humanoid
Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
Humanoid.BreakJointsOnDeath = false
Humanoid.RequiresNeck = false
 
local con; con = RunService.Stepped:Connect(function()
   if not Humanoid then return con:Disconnect() end
   Humanoid:ChangeState(Enum.HumanoidStateType.Running)  -- Change state so not die
end)
 
-- Infinite Death [literally 3 lines dont make it complicated]
LocalPlayer.Character = nil
LocalPlayer.Character = Character
task.wait(Players.RespawnTime + 0.1)
 
-- Looping Death
while task.wait(1/_G.speed) do
   Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
end
		end)
		
		

cmd.add({"partgrabber"}, {"partgrabber", "Press Q"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Part grabber executed, press Q on a part";
	Title = "Nameless Admin";
	Duration = 5;
	
});
-- ROBLOX FE PART + MOUSE FE SCRIPT
-- Made by Rolevote.
-- EXECUTE THIS SCRIPT ONCE PER SERVER
local player = game.Players.LocalPlayer.Character
local mouse = game.Players.LocalPlayer:GetMouse()
local key = game:GetService("UserInputService")

BodyAngularVelocity = true -- Want the Part/Handle to spin really fast Crazy!
local keyyy = Enum.KeyCode.Q -- Key to run it on part


local y = 5.7
local y2 = 7.2
local P = 1000000
local V = Vector3.new(100000,100000,100000)
local SBT = Instance.new("SelectionBox")
SBT.Name = "SB"
SBT.Parent = player.HumanoidRootPart
SBT.Adornee = player.HumanoidRootPart
SBT.Color3 = Color3.new(0,0,0)

while wait(.3) do
key.InputBegan:Connect(function(k)
 if k.KeyCode == keyyy then
 local handle = mouse.Target
 if handle.Anchored == false then
 wait(.3)
 handle.Position = handle.Position + Vector3.new(0,1,0)
 local BP = Instance.new("BodyPosition")
 BP.Name = "BP"
 BP.Parent = handle
 BP.P = P
 BP.MaxForce = V
 local SB = Instance.new("SelectionBox")
 SB.Name = "SB"
 SB.Parent = handle
 SB.Adornee = handle
 local colour = math.random(1,7)
    if colour == 1 then
 SB.Color3 = Color3.new(255,0,0)
    end
    if colour == 2 then
 SB.Color3 = Color3.new(255,170,0)
    end
    if colour == 3 then
 SB.Color3 = Color3.new(255,255,0)
    end
    if colour == 4 then
 SB.Color3 = Color3.new(0,255,0)
    end
    if colour == 5 then
 SB.Color3 = Color3.new(0,170,255)
    end
    if colour == 6 then
 SB.Color3 = Color3.new(170,0,255)
    end
    if colour == 7 then
 SB.Color3 = Color3.new(0,0,0)
    end
 player.Torso.Anchored = true
 if BodyAngularVelocity == true then
  local BAV = Instance.new("BodyAngularVelocity")
  BAV.Name = "BAV"
  BAV.Parent = handle
  BAV.P = 999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
  BAV.AngularVelocity = Vector3.new(9990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000,9990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000,9990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000)
 end
 wait(.3)
 player.Torso.Anchored = false
 while wait(.3) do
  if handle:FindFirstChild("BP",true) then
  handle.CanCollide = false
  end
  BP.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0,y,0)
     wait(.3)
  if handle:FindFirstChild("BP",true) then
     handle.CanCollide = false
  end
      BP.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0,y2,0)
   end
  end
    end
 end)
end
end)

cmd.add({"tpua", "bringua"}, {"tpua <player> (bringua)", "brings every unanchored part on the map"}, function(...)
	
	
	
	wait();
	
	Notify({
	Description = "Tping unanchored parts to the player, if it doesnt teleport walk over to the unanchored part";
	Title = "Nameless Admin";
	Duration = 5;
	
});
	frozenParts = {}

	Username = (...)
		if sethidden then
			local players = getPlr(Username)
				local Forces = {}
				for _,part in pairs(workspace:GetDescendants()) do
					if players.Character:FindFirstChild('Head') and part:IsA("BasePart" or "UnionOperation" or "Model") and part.Anchored == false and not part:IsDescendantOf(game.Players.LocalPlayer.Character) and part.Name == "Torso" == false and part.Name == "Head" == false and part.Name == "Right Arm" == false and part.Name == "Left Arm" == false and part.Name == "Right Leg" == false and part.Name == "Left Leg" == false and part.Name == "HumanoidRootPart" == false then
						for i,c in pairs(part:GetChildren()) do
							if c:IsA("BodyPosition") or c:IsA("BodyGyro") then
								c:Destroy()
							end
						end
						local ForceInstance = Instance.new("BodyPosition")
						ForceInstance.Parent = part
						ForceInstance.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
						table.insert(Forces, ForceInstance)
						if not table.find(frozenParts,part) then
							table.insert(frozenParts,part)
						end
					end
				end
				for i,c in pairs(Forces) do
					c.Position = players.Character.Head.Position
				end
		end
	end)

	cmd.add({"freezeua", "thawua"}, {"freezeua (thawua)", "freezes every unanchored part on the map"}, function()

		frozenParts = {}
		
		if sethidden then
				local badnames = {
					"Head",
					"UpperTorso",
					"LowerTorso",
					"RightUpperArm",
					"LeftUpperArm",
					"RightLowerArm",
					"LeftLowerArm",
					"RightHand",
					"LeftHand",
					"RightUpperLeg",
					"LeftUpperLeg",
					"RightLowerLeg",
					"LeftLowerLeg",
					"RightFoot",
					"LeftFoot",
					"Torso",
					"Right Arm",
					"Left Arm",
					"Right Leg",
					"Left Leg",
					"HumanoidRootPart"
				}
				local function FREEZENOOB(v)
					if v:IsA("BasePart" or "UnionOperation") and v.Anchored == false then
						local BADD = false
						for i = 1,#badnames do
							if v.Name == badnames[i] then
								BADD = true
							end
						end
						if game.Players.LocalPlayer.Character and v:IsDescendantOf(game.Players.LocalPlayer.Character) then
							BADD = true
						end
						if BADD == false then
							for i,c in pairs(v:GetChildren()) do
								if c:IsA("BodyPosition") or c:IsA("BodyGyro") then
									c:Destroy()
								end
							end
							local bodypos = Instance.new("BodyPosition")
							bodypos.Parent = v
							bodypos.Position = v.Position
							bodypos.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
							local bodygyro = Instance.new("BodyGyro")
							bodygyro.Parent = v
							bodygyro.CFrame = v.CFrame
							bodygyro.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
							if not table.find(frozenParts,v) then
								table.insert(frozenParts,v)
							end
						end
					end
				end
				for i,v in pairs(workspace:GetDescendants()) do
					FREEZENOOB(v)
				end
				freezingua = workspace.DescendantAdded:Connect(FREEZENOOB)
				end
		end)

		cmd.add({"unfreezeua", "unthawua"}, {"unfreezeua (unthawua)", "unfreezes every unanchored part on the map"}, function()
			
	
	
	wait();
	
	Notify({
	Description = "Unfroze unanchored parts";
	Title = "Nameless Admin";
	Duration = 5;
	
});
			if sethidden then
				if freezingua then
					freezingua:Disconnect()
				end
				for i,v in pairs(frozenParts) do
					for i,c in pairs(v:GetChildren()) do
						if c:IsA("BodyPosition") or c:IsA("BodyGyro") then
							c:Destroy()
						end
					end
				end
				frozenParts = {}
				end
		end)

cmd.add({"highlightua", "highlightunanchored"}, {"highlightua (hightlightunanchored)", "Highlights all unanchored parts"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Highlighted all unanchored parts";
	Title = "Nameless Admin";
	Duration = 5;
	
});
for _,part in pairs(workspace:GetDescendants()) do
	if part:IsA("BasePart") and part.Anchored == false and part:IsDescendantOf(game.Players.LocalPlayer.Character) == false and part.Name == "Torso" == false and part.Name == "Head" == false and part.Name == "Right Arm" == false and part.Name == "Left Arm" == false and part.Name == "Right Leg" == false and part.Name == "Left Leg" == false and part.Name == "HumanoidRootPart" == false and part:FindFirstChild("Weld") == nil then --// Checks Part Properties
		local selectionBox = Instance.new("SelectionBox")
		selectionBox.Adornee = part
		selectionBox.Color3 = Color3.new(1,0,0)
		selectionBox.Parent = part
	end
	end
end)

cmd.add({"unhighlightua", "unhighlightunanchored"}, {"unhighlightua (unhightlightunanchored)", "Unhighlights all unanchored parts"}, function()
	
	
	
	wait();
	
	Notify({
	Description = "Unhighlighted unanchored parts";
	Title = "Nameless Admin";
	Duration = 5;
	
});
for _,part in pairs(workspace:GetDescendants()) do
	if part:IsA("BasePart") and part.Anchored == false and part:IsDescendantOf(game.Players.LocalPlayer.Character) == false and part.Name == "Torso" == false and part.Name == "Head" == false and part.Name == "Right Arm" == false and part.Name == "Left Arm" == false and part.Name == "Right Leg" == false and part.Name == "Left Leg" == false and part.Name == "HumanoidRootPart" == false and part:FindFirstChild("Weld") == nil then --// Checks Part Properties
		if part:FindFirstChild("SelectionBox") then
		part.SelectionBox:Destroy()
		end
	end
	end
end)

cmd.add({"uagui", "unanchoredgui"}, {"uagui (unanchoreedgui)", "Unanchored gui"}, function()
	loadstring(game:HttpGet("https://pastebin.com/raw/WkZwcGjf", true))()
	end)


cmd.add({"countua", "countunanchoreed"}, {"countua (countunanchored)", "Counts all unanchored parts in the console"}, function()
	b = 0
    for index, part in pairs(game.workspace:GetDescendants()) do
    if part:IsA("BasePart") and part.Anchored == false and part:IsDescendantOf(game.Players.LocalPlayer.Character) == false and part.Name == "Torso" == false and part.Name == "Head" == false and part.Name == "Right Arm" == false and part.Name == "Left Arm" == false and part.Name == "Right Leg" == false and part.Name == "Left Leg" == false and part.Name == "HumanoidRootPart" == false and part:FindFirstChild("Weld") == nil then --// Checks Part Properties
        b = b + 1
    end
    end
    print ("All parts checked, found", b ,"that are unanchored")
	
	
	
	wait();
	
	Notify({
	Description = "Parts have been counted, check console.";
	Title = "Nameless Admin";
	Duration = 5;
	
});
end)

cmd.add({"httpspy"}, {"httspy", "HTTP Spy"}, function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/http_spy.lua'))()
end)

cmd.add({"keystroke"}, {"keystroke", "Executes a keystroke ui script"}, function()
	loadstring(game:HttpGet("https://system-exodus.com/scripts/misc-releases/Keystrokes.lua",true))()
end)

cmd.add({"ownerid"}, {"ownerid", "Changes the client id to the owner's. Can give special things"}, function()
	


wait();

Notify({
Description = "Set local player id to the owner id";
Title = "Nameless Admin";
Duration = 5;

});
	if game.CreatorType == Enum.CreatorType.User then
		game.Players.LocalPlayer.UserId = game.CreatorId
		end
		if game.CreatorType == Enum.CreatorType.Group then
		game.Players.LocalPlayer.UserId = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId).Owner.Id
		end
end)

cmd.add({"errorchat"}, {"errorchat", "Makes the chat error appear when roblox chat is slow"}, function()
	for i=1,3 do 
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("\0", "All")
    end
end)

--[[ FUNCTIONALITY ]]--
localPlayer.Chatted:Connect(function(str)
	lib.parseCommand(str)
end)

--[[ GUI VARIABLES ]]--
local ScreenGui
if not RunService:IsStudio() then
	ScreenGui = game:GetObjects("rbxassetid://13237130511")[1]
else
	repeat wait() until player:FindFirstChild("AdminUI", true)
	ScreenGui = player:FindFirstChild("AdminUI", true)
end

local description = ScreenGui.Description
local cmdBar = ScreenGui.CmdBar
	local centerBar = cmdBar.CenterBar
		local cmdInput = centerBar.Input
	local cmdAutofill = cmdBar.Autofill
		local cmdExample = cmdAutofill.Cmd
	local leftFill = cmdBar.LeftFill
	local rightFill = cmdBar.RightFill
local chatLogsFrame = ScreenGui.ChatLogs
	local chatLogs = chatLogsFrame.Container.Logs
		local chatExample = chatLogs.TextLabel
local commandsFrame = ScreenGui.Commands
	local commandsFilter = commandsFrame.Container.Filter
	local commandsList = commandsFrame.Container.List
		local commandExample = commandsList.TextLabel
local resizeFrame = ScreenGui.Resizeable
local resizeXY = {
	Top		= {Vector2.new(0, -1),	Vector2.new(0, -1),	"rbxassetid://2911850935"},
	Bottom	= {Vector2.new(0, 1),	Vector2.new(0, 0),	"rbxassetid://2911850935"},
	Left	= {Vector2.new(-1, 0),	Vector2.new(1, 0),	"rbxassetid://2911851464"},
	Right	= {Vector2.new(1, 0),	Vector2.new(0, 0),	"rbxassetid://2911851464"},
	
	TopLeft		= {Vector2.new(-1, -1),	Vector2.new(1, -1),	"rbxassetid://2911852219"},
	TopRight	= {Vector2.new(1, -1),	Vector2.new(0, -1),	"rbxassetid://2911851859"},
	BottomLeft	= {Vector2.new(-1, 1),	Vector2.new(1, 0),	"rbxassetid://2911851859"},
	BottomRight	= {Vector2.new(1, 1),	Vector2.new(0, 0),	"rbxassetid://2911852219"},
}

cmdExample.Parent = nil
chatExample.Parent = nil
commandExample.Parent = nil
resizeFrame.Parent = nil

local rPlayer = Players:FindFirstChildWhichIsA("Player")
local coreGuiProtection = {}

pcall(function()
	for i, v in pairs(ScreenGui:GetDescendants()) do
		coreGuiProtection[v] = rPlayer.Name
	end
	ScreenGui.DescendantAdded:Connect(function(v)
		coreGuiProtection[v] = rPlayer.Name
	end)
	coreGuiProtection[ScreenGui] = rPlayer.Name
	 
	local meta = getrawmetatable(game)
	local tostr = meta.__tostring
	setreadonly(meta, false)
	meta.__tostring = newcclosure(function(t)
		if coreGuiProtection[t] and not checkcaller() then
			return coreGuiProtection[t]
		end
		return tostr(t)
	end)
end)
if not RunService:IsStudio() then
	local newGui = game:GetService("CoreGui"):FindFirstChildWhichIsA("ScreenGui")
	newGui.DescendantAdded:Connect(function(v)
		coreGuiProtection[v] = rPlayer.Name
	end)
	for i, v in pairs(ScreenGui:GetChildren()) do
		v.Parent = newGui
	end
	ScreenGui = newGui
end

--[[ GUI FUNCTIONS ]]--
gui = {}
gui.txtSize = function(ui, x, y)
	local textService = game:GetService("TextService")
	return textService:GetTextSize(ui.Text, ui.TextSize, ui.Font, Vector2.new(x, y))
end
gui.commands = function()
	if not commandsFrame.Visible then
		commandsFrame.Visible = true
		commandsList.CanvasSize = UDim2.new(0, 0, 0, 0)
	end
	for i, v in pairs(commandsList:GetChildren()) do
		if v:IsA("TextLabel") then
			Destroy(v)
		end
	end
	local i = 0
	for cmdName, tbl in pairs(Commands) do
		local Cmd = commandExample:Clone()
		Cmd.Parent = commandsList
		Cmd.Name = cmdName
		Cmd.Text = " " .. tbl[2][1]
		Cmd.MouseEnter:Connect(function()
			description.Visible = true
			description.Text = tbl[2][2]
		end)
		Cmd.MouseLeave:Connect(function()
			if description.Text == tbl[2][2] then
				description.Visible = false
				description.Text = ""
			end
		end)
		i = i + 1
	end
	commandsList.CanvasSize = UDim2.new(0, 0, 0, i*20+10)
	commandsFrame.Position = UDim2.new(0.5, -283/2, 0.5, -260/2)
end
gui.chatlogs = function()
	if not chatLogsFrame.Visible then
		chatLogsFrame.Visible = true
	end
	chatLogsFrame.Position = UDim2.new(0.5, -283/2+5, 0.5, -260/2+5)
end

gui.tween = function(obj, style, direction, duration, goal)
	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle[style], Enum.EasingDirection[direction])
	local tween = TweenService:Create(obj, tweenInfo, goal)
	tween:Play()
	return tween
end
gui.mouseIn = function(guiObject, range)
	local pos1, pos2 = guiObject.AbsolutePosition, guiObject.AbsolutePosition + guiObject.AbsoluteSize
	local mX, mY = mouse.X, mouse.Y
	if mX > pos1.X-range and mX < pos2.X+range and mY > pos1.Y-range and mY < pos2.Y+range then
		return true
	end
	return false
end
gui.resizeable = function(ui, min, max)
	local rgui = resizeFrame:Clone()
	rgui.Parent = ui
	
	local mode
	local UIPos
	local lastSize
	local lastPos = Vector2.new()
	
	local function update(delta)
		local xy = resizeXY[(mode and mode.Name) or '']
		if not mode or not xy then return end
		local delta = (delta * xy[1]) or Vector2.new()
		local newSize = Vector2.new(lastSize.X + delta.X, lastSize.Y + delta.Y)
		newSize = Vector2.new(
			math.clamp(newSize.X, min.X, max.X),
			math.clamp(newSize.Y, min.Y, max.Y)
		)
		ui.Size = UDim2.new(0, newSize.X, 0, newSize.Y)
		ui.Position = UDim2.new(
			UIPos.X.Scale, 
			UIPos.X.Offset + (-(newSize.X - lastSize.X) * xy[2]).X, 
			UIPos.Y.Scale, 
			UIPos.Y.Offset + (delta * xy[2]).Y
		)
	end
	
	mouse.Move:Connect(function()
		update(Vector2.new(mouse.X, mouse.Y) - lastPos)
	end)
	
	for _, button in pairs(rgui:GetChildren()) do
		local isIn = false
		button.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				mode = button
				lastPos = Vector2.new(mouse.X, mouse.Y)
				lastSize = ui.AbsoluteSize
				UIPos = ui.Position
			end
		end)
		button.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				mode = nil
			end
		end)
		button.MouseEnter:Connect(function()
			mouse.Icon = resizeXY[button.Name][3]
		end)
		button.MouseLeave:Connect(function()
			if mouse.Icon == resizeXY[button.Name][3] then
				mouse.Icon = ""
			end
		end)
	end
end
gui.draggable = function(ui, dragui)
	if not dragui then dragui = ui end
	local UserInputService = game:GetService("UserInputService")
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		ui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	dragui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = ui.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	dragui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
gui.menuify = function(menu)
	local exit = menu:FindFirstChild("Exit", true)
	local mini = menu:FindFirstChild("Minimize", true)
	local minimized = false
	local sizeX, sizeY = Instance.new("IntValue", menu), Instance.new("IntValue", menu)
	mini.MouseButton1Click:Connect(function()
		minimized = not minimized
		if minimized then
			sizeX.Value = menu.Size.X.Offset
			sizeY.Value = menu.Size.Y.Offset
			gui.tween(menu, "Quart", "Out", 0.5, {Size = UDim2.new(0, 200, 0, 25)})
		else
			gui.tween(menu, "Quart", "Out", 0.5, {Size = UDim2.new(0, sizeX.Value, 0, sizeY.Value)})
		end
	end)
	exit.MouseButton1Click:Connect(function()
		menu.Visible = false
	end)
	gui.draggable(menu, menu.Topbar)
	menu.Visible = false
end
gui.barSelect = function(speed)
	centerBar.Visible = true
	gui.tween(centerBar, "Sine", "Out", speed or 0.25, {Size = UDim2.new(0, 250, 1, 15)})
	gui.tween(leftFill, "Quad", "Out", speed or 0.3, {Position = UDim2.new(0, 0, 0.5, 0)})
	gui.tween(rightFill, "Quad", "Out", speed or 0.3, {Position = UDim2.new(1, 0, 0.5, 0)})
	gui.loadCommands()
end
gui.barDeselect = function(speed)
    gui.tween(centerBar, "Sine", "Out", speed or 0.25, {Size = UDim2.new(0, 250, 0, 0)})
    gui.tween(leftFill, "Sine", "In", speed or 0.3, {Position = UDim2.new(-0.5, 100, 0.5, 0)})
    gui.tween(rightFill, "Sine", "In", speed or 0.3, {Position = UDim2.new(1.5, -100, 0.5, 0)})
    for i, v in ipairs(cmdAutofill:GetChildren()) do
        if v:IsA("Frame") then
            if i > 5 then break end -- Stop after 5 autofills
            wrap(function()
                wait(math.random(1, 200)/2000)
                gui.tween(v, "Back", "In", 0.35, {Size = UDim2.new(0, 0, 0, 25)})
            end)
        end
    end
end
gui.loadCommands = function()
	for i, v in pairs(cmdAutofill:GetChildren()) do
		if v.Name ~= "UIListLayout" then
			Destroy(v)
		end
	end
	local last = nil
	local i = 0
	for name, tbl in pairs(Commands) do
		local info = tbl[2]
		local btn = cmdExample:Clone()
		btn.Parent = cmdAutofill
		btn.Name = name
		btn.Input.Text = info[1]
		i = i + 1
		
		local size = btn.Size
		btn.Size = UDim2.new(0, 0, 0, 25)
		btn.Size = size
	end
end
gui.searchCommands = function()
    local str = (cmdInput.Text:gsub(";", "")):lower()
    local index = 0
    local lastFrame
    for _, v in ipairs(cmdAutofill:GetChildren()) do
        if v:IsA("Frame") and index < 5 then
            local cmd = Commands[v.Name]
            local name = cmd and cmd[2][1] or ""
            v.Input.Text = str ~= "" and v.Name:find(str) == 1 and v.Name or name
            v.Visible = str == "" or v.Name:find(str)
            if v.Visible then
                index = index + 1
                local n = math.sqrt(index) * 125
                local yPos = (index - 1) * 28
                local newPos = UDim2.new(0.5, 0, 0, yPos)
                gui.tween(v, "Quint", "Out", 0.3, {
                    Size = UDim2.new(0.5, n, 0, 25),
                    Position = lastFrame and newPos or UDim2.new(0.5, 0, 0, yPos),
                })
                lastFrame = v
            end
        end
    end
end


--[[ GUI FUNCTIONALITY ]]--
mouse.KeyDown:Connect(function(k)
	if k:lower() == opt.prefix then
		gui.barSelect()
		cmdInput.Text = ''
		cmdInput:CaptureFocus()
		for i=1,10 do
		    wait(0.000051)
		 game:GetService("Players").LocalPlayer.PlayerGui.boomb.Frame.BackgroundTransparency -= 0.04
		    end
	end
end)

cmdInput.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		wrap(function()
			lib.parseCommand(opt.prefix .. cmdInput.Text)
		end)
	end
	gui.barDeselect()
		for i=1,10 do
		    wait(0.000051)
		 game:GetService("Players").LocalPlayer.PlayerGui.boomb.Frame.BackgroundTransparency += 0.04
		    end
	wait(0.25)
    for i, v in ipairs(cmdAutofill:GetChildren()) do
        if v:IsA("Frame") then
            v.Visible = false
        end
        end
end)

cmdInput.Changed:Connect(function(p)
	if p ~= "Text" then return end
	gui.searchCommands()
end)

gui.barDeselect(0)
cmdBar.Visible = true
gui.menuify(chatLogsFrame)
gui.menuify(commandsFrame)
gui.resizeable(chatLogsFrame, Vector2.new(173,58), Vector2.new(1000,1000))
gui.resizeable(commandsFrame, Vector2.new(184,84), Vector2.new(1000,1000))

commandsFilter.Changed:Connect(function(p)
	if p ~= "Text" then return end
	for i, v in pairs(commandsList:GetChildren()) do
		if v:IsA("TextLabel") then
			if v.Name:find(commandsFilter.Text:lower()) and v.Name:find(commandsFilter.Text:lower()) <= 2 then
				v.Visible = true
			else
				v.Visible = false
			end
		end
	end
end)

local function bindToChat(plr, msg)
	local chatMsg = chatExample:Clone()
	for i, v in pairs(chatLogs:GetChildren()) do
		if v:IsA("TextLabel") then
			v.LayoutOrder = v.LayoutOrder + 1
		end
	end
	chatMsg.Parent = chatLogs
	chatMsg.Text = ("[%s]: %s"):format(plr.Name, msg)
	
	local txtSize = gui.txtSize(chatMsg, chatMsg.AbsoluteSize.X, 100)
	chatMsg.Size = UDim2.new(1, -5, 0, txtSize.Y)
end

for i, plr in pairs(Players:GetPlayers()) do
	plr.Chatted:Connect(function(msg)
		bindToChat(plr, msg)
	end)
end
Players.PlayerAdded:Connect(function(plr)
	plr.Chatted:Connect(function(msg)
		bindToChat(plr, msg)
	end)
end)

mouse.Move:Connect(function()
	description.Position = UDim2.new(0, mouse.X, 0, mouse.Y)
	local size = gui.txtSize(description, 200, 100)
	description.Size = UDim2.new(0, size.X, 0, size.Y)
end)

RunService.Stepped:Connect(function()
	chatLogs.CanvasSize = UDim2.new(0, 0, 0, chatLogs.UIListLayout.AbsoluteContentSize.Y)
	commandsList.CanvasSize = UDim2.new(0, 0, 0, commandsList.UIListLayout.AbsoluteContentSize.Y)
end)

function Destroy(guiObject)
	if not pcall(function()guiObject.Parent = game:GetService("CoreGui")end) then
		guiObject.Parent = nil
	end
end
wait(0.1)
game:GetService("CoreGui").RobloxGui.NotificationFrame.Visible = false
]] --
