local FLEE_THE_FACILITY_REVAMPED_GUI = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local title = Instance.new("TextLabel")
local status = Instance.new("TextLabel")
local tptauc = Instance.new("TextButton")
local tpaftb = Instance.new("TextButton")
local tptae = Instance.new("TextButton")
local tptlp = Instance.new("TextButton")
local playernamebox = Instance.new("TextBox")
local exit = Instance.new("TextButton")

FLEE_THE_FACILITY_REVAMPED_GUI.Name = "FLEE_THE_FACILITY_REVAMPED_GUI"
FLEE_THE_FACILITY_REVAMPED_GUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
FLEE_THE_FACILITY_REVAMPED_GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
FLEE_THE_FACILITY_REVAMPED_GUI.DisplayOrder = 9999
FLEE_THE_FACILITY_REVAMPED_GUI.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = FLEE_THE_FACILITY_REVAMPED_GUI
MainFrame.BackgroundColor3 = Color3.fromRGB(85, 170, 127)
MainFrame.BorderColor3 = Color3.fromRGB(85, 170, 0)
MainFrame.BorderSizePixel = 7
MainFrame.Position = UDim2.new(0.0263719559, 0, 0.475089371, 0)
MainFrame.Size = UDim2.new(0, 201, 0, 400)
MainFrame.ZIndex = 9999
MainFrame.Active = true
MainFrame.Selectable = true
MainFrame.Draggable = true

title.Name = "title"
title.Parent = MainFrame
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1.000
title.Size = UDim2.new(0, 160, 0, 50)
title.Font = Enum.Font.GothamBold
title.Text = "Revamped \"Flee the Facility\" Gui"
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextSize = 20.000
title.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
title.TextStrokeTransparency = 0.750
title.TextWrapped = true

status.Name = "status"
status.Parent = MainFrame
status.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
status.BorderSizePixel = 0
status.Position = UDim2.new(0, 0, 0.125, 0)
status.Size = UDim2.new(0, 200, 0, 80)
status.Font = Enum.Font.SciFi
status.Text = " Awaiting map..."
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.TextSize = 20.000
status.TextStrokeColor3 = Color3.fromRGB(0, 255, 0)
status.TextStrokeTransparency = 0.750
status.TextWrapped = true
status.TextXAlignment = Enum.TextXAlignment.Left
status.TextYAlignment = Enum.TextYAlignment.Top

tptauc.Name = "tptauc"
tptauc.Parent = MainFrame
tptauc.BackgroundColor3 = Color3.fromRGB(255, 255, 127)
tptauc.BorderSizePixel = 0
tptauc.Position = UDim2.new(0, 0, 0.349999994, 0)
tptauc.Size = UDim2.new(0, 200, 0, 50)
tptauc.Font = Enum.Font.GothamBold
tptauc.Text = "Teleport to an unhacked computer"
tptauc.TextColor3 = Color3.fromRGB(0, 0, 0)
tptauc.TextSize = 20.000
tptauc.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
tptauc.TextStrokeTransparency = 0.000
tptauc.TextWrapped = true

tpaftb.Name = "tpaftb"
tpaftb.Parent = MainFrame
tpaftb.BackgroundColor3 = Color3.fromRGB(255, 255, 127)
tpaftb.BorderSizePixel = 0
tpaftb.Position = UDim2.new(0, 0, 0.5, 0)
tpaftb.Size = UDim2.new(0, 200, 0, 50)
tpaftb.Font = Enum.Font.GothamBold
tpaftb.Text = "Teleport away from the Beast"
tpaftb.TextColor3 = Color3.fromRGB(0, 0, 0)
tpaftb.TextSize = 20.000
tpaftb.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
tpaftb.TextStrokeTransparency = 0.000
tpaftb.TextWrapped = true

tptae.Name = "tptae"
tptae.Parent = MainFrame
tptae.BackgroundColor3 = Color3.fromRGB(255, 255, 127)
tptae.BorderSizePixel = 0
tptae.Position = UDim2.new(0, 0, 0.649999976, 0)
tptae.Size = UDim2.new(0, 200, 0, 50)
tptae.Font = Enum.Font.GothamBold
tptae.Text = "Teleport to an exit"
tptae.TextColor3 = Color3.fromRGB(0, 0, 0)
tptae.TextSize = 20.000
tptae.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
tptae.TextStrokeTransparency = 0.000

tptlp.Name = "tptlp"
tptlp.Parent = MainFrame
tptlp.BackgroundColor3 = Color3.fromRGB(255, 255, 127)
tptlp.BorderSizePixel = 0
tptlp.Position = UDim2.new(0, 0, 0.875, 0)
tptlp.Size = UDim2.new(0, 200, 0, 50)
tptlp.Font = Enum.Font.GothamBold
tptlp.Text = "Teleport to listed player"
tptlp.TextColor3 = Color3.fromRGB(0, 0, 0)
tptlp.TextSize = 20.000
tptlp.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
tptlp.TextStrokeTransparency = 0.000
tptlp.TextWrapped = true

playernamebox.Name = "playernamebox"
playernamebox.Parent = MainFrame
playernamebox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
playernamebox.BorderSizePixel = 0
playernamebox.Position = UDim2.new(0, 0, 0.82249999, 0)
playernamebox.Size = UDim2.new(0, 200, 0, 21)
playernamebox.ClearTextOnFocus = false
playernamebox.Font = Enum.Font.Code
playernamebox.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
playernamebox.PlaceholderText = "PlayerName"
playernamebox.Text = ""
playernamebox.TextColor3 = Color3.fromRGB(85, 255, 255)
playernamebox.TextSize = 14.000
playernamebox.TextStrokeColor3 = Color3.fromRGB(85, 255, 0)
playernamebox.TextStrokeTransparency = 0.750

exit.Name = "exit"
exit.Parent = MainFrame
exit.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
exit.BorderSizePixel = 0
exit.Position = UDim2.new(0.796000004, 0, 0.0125000002, 0)
exit.Size = UDim2.new(0, 40, 0, 40)
exit.Font = Enum.Font.GothamBold
exit.Text = "X"
exit.TextColor3 = Color3.fromRGB(0, 0, 0)
exit.TextSize = 30.000
exit.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
exit.TextStrokeTransparency = 0.000
exit.TextWrapped = true

local mapNames = {"Facility_0 by MrWindy","Abandoned Facility by iiGalaxyKoala, Vexhins, and cyrda","Abandoned Prison by AtomixKing and Duck_Ify","Homestead by MrWindy","Airport by deadlybones28"}
local currMap = nil
spawn(function()
	while wait() do
		for _,v in pairs(workspace:GetChildren()) do
			for i = 1, #mapNames do
				if v.Name == mapNames[i] then
					currMap = mapNames[i]
					break
				end
			end
		end
		if currMap then
			if workspace:FindFirstChild(currMap) then
				MainFrame.status.Text = " Map: " .. currMap
			else
				MainFrame.status.Text = " Awaiting map..."
			end
		else
			MainFrame.status.Text = " Awaiting map..."
		end
	end
end)
MainFrame.tptauc.MouseButton1Click:Connect(function()
	if workspace:FindFirstChild(currMap) then
		local pc
		for _,v in pairs(workspace:FindFirstChild(currMap):GetChildren()) do
			if v.Name == "ComputerTable" then
				if v.Screen.BrickColor ~= BrickColor.new("Dark green") then
					pc = v
					break
				end
			end
		end
		if pc:FindFirstChild("ClearWall") then
			pc.ClearWall.CanCollide = false
		end
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pc.BasePart.Position.X, pc.BasePart.Position.Y + 6, pc.BasePart.Position.Z)
	end
end)
MainFrame.tpaftb.MouseButton1Click:Connect(function()
	if workspace:FindFirstChild(currMap) then
		workspace:FindFirstChild(currMap):FindFirstChild("FreezePod"):GetChildren().CanCollide = false
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(workspace:FindFirstChild(currMap):FindFirstChild("FreezePod").BasePart.Position.X, workspace:FindFirstChild(currMap):FindFirstChild("FreezePod").BasePart.Position.Y + 3, workspace:FindFirstChild(currMap):FindFirstChild("FreezePod").BasePart.Position.Z)
	end
end)
MainFrame.tptae.MouseButton1Click:Connect(function()
	if workspace:FindFirstChild(currMap) then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(workspace:FindFirstChild(currMap):FindFirstChild("ExitDoor").Light.Position.X, workspace:FindFirstChild(currMap):FindFirstChild("ExitDoor").Light.Position.Y - 4.5, workspace:FindFirstChild(currMap):FindFirstChild("ExitDoor").Light.Position.Z)
	end
end)
MainFrame.tptlp.MouseButton1Click:Connect(function()
	if workspace:FindFirstChild(MainFrame.playernamebox.Text) then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(workspace:FindFirstChild(MainFrame.playernamebox.Text).HumanoidRootPart.Position)
	end
end)
MainFrame.exit.MouseButton1Click:Connect(function()
	MainFrame.Parent:Destroy()
end)
