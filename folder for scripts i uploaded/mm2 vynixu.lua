--	 /$$    /$$                     /$$                    
--	| $$   | $$                    |__/                    
--	| $$   | $$ /$$   /$$ /$$$$$$$  /$$ /$$   /$$ /$$   /$$
--	|  $$ / $$/| $$  | $$| $$__  $$| $$|  $$ /$$/| $$  | $$
--	 \  $$ $$/ | $$  | $$| $$  \ $$| $$ \  $$$$/ | $$  | $$
--	  \  $$$/  | $$  | $$| $$  | $$| $$  >$$  $$ | $$  | $$
--	   \  $/   |  $$$$$$$| $$  | $$| $$ /$$/\  $$|  $$$$$$/
--	    \_/     \____  $$|__/  |__/|__/|__/  \__/ \______/ 
--	            /$$  | $$                                  
--	           |  $$$$$$/                                  
-- 		        \______/   
                                
local VynixuMM2Script = Instance.new("ScreenGui")
local Holder = Instance.new("Frame")
local Top = Instance.new("Frame")
local OpenClose = Instance.new("TextButton")
local Title = Instance.new("TextLabel")
local ErrorLabel = Instance.new("TextLabel")
local PlayerList = Instance.new("Frame")
local Top_2 = Instance.new("Frame")
local OpenClose_2 = Instance.new("TextButton")
local Players = Instance.new("Frame")
local Player1 = Instance.new("TextButton")
local Player2 = Instance.new("TextButton")
local Player3 = Instance.new("TextButton")
local Player4 = Instance.new("TextButton")
local Player6 = Instance.new("TextButton")
local Player5 = Instance.new("TextButton")
local Player8 = Instance.new("TextButton")
local Player7 = Instance.new("TextButton")
local Player10 = Instance.new("TextButton")
local Player11 = Instance.new("TextButton")
local Player12 = Instance.new("TextButton")
local Player9 = Instance.new("TextButton")
local Roles = Instance.new("Frame")
local Murderer = Instance.new("ImageLabel")
local Sherrif = Instance.new("ImageLabel")
local MurdererLabel = Instance.new("TextLabel")
local SherrifLabel = Instance.new("TextLabel")
local Main = Instance.new("Frame")
local CoinFarm = Instance.new("TextButton")
local Underline = Instance.new("TextLabel")
local Fly = Instance.new("TextButton")
local Underline_2 = Instance.new("TextLabel")
local GunDropGrabber = Instance.new("TextButton")
local Underline_3 = Instance.new("TextLabel")
local KillAll = Instance.new("TextButton")
local Underline_4 = Instance.new("TextLabel")
local MurdererESP = Instance.new("TextButton")
local Underline_5 = Instance.new("TextLabel")
local Noclip = Instance.new("TextButton")
local Underline_6 = Instance.new("TextLabel")
local PlayerName = Instance.new("TextBox")
local Underline_7 = Instance.new("TextLabel")
local SherrifESP = Instance.new("TextButton")
local Underline_8 = Instance.new("TextLabel")
local ShowNames = Instance.new("TextButton")
local Underline_9 = Instance.new("TextLabel")
local TPtoLobby = Instance.new("TextButton")
local Underline_10 = Instance.new("TextLabel")
local TPtoMap = Instance.new("TextButton")
local Underline_11 = Instance.new("TextLabel")
local TPtoMuderer = Instance.new("TextButton")
local Underline_12 = Instance.new("TextLabel")
local TPtoPlayer = Instance.new("TextButton")
local Underline_13 = Instance.new("TextLabel")
local TPtoSherrif = Instance.new("TextButton")
local Underline_14 = Instance.new("TextLabel")
local Walkspeed = Instance.new("TextButton")
local Underline_15 = Instance.new("TextLabel")
local JumpPower = Instance.new("TextButton")
local Underline_16 = Instance.new("TextLabel")
local WSInput = Instance.new("TextBox")
local Underline_17 = Instance.new("TextLabel")
local JPInput = Instance.new("TextBox")
local Underline_18 = Instance.new("TextLabel")
local WSReset = Instance.new("TextButton")
local Underline_19 = Instance.new("TextLabel")
local JPReset = Instance.new("TextButton")
local Underline_20 = Instance.new("TextLabel")
--Properties:
VynixuMM2Script.Name = "VynixuMM2Script"
VynixuMM2Script.Parent = game.CoreGui
VynixuMM2Script.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
VynixuMM2Script.ResetOnSpawn = false

Holder.Name = "Holder"
Holder.Parent = VynixuMM2Script
Holder.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
Holder.BorderSizePixel = 0
Holder.Position = UDim2.new(1, -350, 1, -405)
Holder.Size = UDim2.new(0, 340, 0, 395)

Top.Name = "Top"
Top.Parent = Holder
Top.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Top.BorderSizePixel = 0
Top.Position = UDim2.new(0, 0, 0, -25)
Top.Size = UDim2.new(1, 0, 0, 25)

OpenClose.Name = "OpenClose"
OpenClose.Parent = Top
OpenClose.BackgroundColor3 = Color3.new(0.392157, 0, 1)
OpenClose.BorderSizePixel = 0
OpenClose.Rotation = -90
OpenClose.Size = UDim2.new(0, 25, 0, 25)
OpenClose.Font = Enum.Font.SourceSans
OpenClose.Text = ">"
OpenClose.TextColor3 = Color3.new(1, 1, 1)
OpenClose.TextSize = 32
OpenClose.TextStrokeTransparency = 0
OpenClose.TextWrapped = true

Title.Name = "Title"
Title.Parent = Top
Title.BackgroundColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Font = Enum.Font.SourceSans
Title.Text = "Vynixu's MM2 Script"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 20
Title.TextStrokeTransparency = 0

ErrorLabel.Name = "ErrorLabel"
ErrorLabel.Parent = Holder
ErrorLabel.BackgroundColor3 = Color3.new(1, 1, 1)
ErrorLabel.BackgroundTransparency = 1
ErrorLabel.BorderSizePixel = 0
ErrorLabel.Position = UDim2.new(0, 0, 0, -50)
ErrorLabel.Size = UDim2.new(1, 0, 0, 25)
ErrorLabel.Font = Enum.Font.Fantasy
ErrorLabel.Text = ""
ErrorLabel.TextColor3 = Color3.new(1, 0, 0.0980392)
ErrorLabel.TextSize = 14
ErrorLabel.TextStrokeTransparency = 0

PlayerList.Name = "PlayerList"
PlayerList.Parent = Holder
PlayerList.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
PlayerList.BorderSizePixel = 0
PlayerList.Position = UDim2.new(0, -25, 0, 0)
PlayerList.Size = UDim2.new(0, 175, 0, 395)

Top_2.Name = "Top"
Top_2.Parent = PlayerList
Top_2.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Top_2.BorderSizePixel = 0
Top_2.Size = UDim2.new(0, 25, 1, 0)

OpenClose_2.Name = "OpenClose"
OpenClose_2.Parent = Top_2
OpenClose_2.BackgroundColor3 = Color3.new(0.392157, 0, 1)
OpenClose_2.BorderSizePixel = 0
OpenClose_2.Position = UDim2.new(0, 0, 1, -25)
OpenClose_2.Rotation = 180
OpenClose_2.Size = UDim2.new(0, 25, 0, 25)
OpenClose_2.Font = Enum.Font.SourceSans
OpenClose_2.Text = ">"
OpenClose_2.TextColor3 = Color3.new(1, 1, 1)
OpenClose_2.TextSize = 32
OpenClose_2.TextStrokeTransparency = 0
OpenClose_2.TextWrapped = true

Players.Name = "Players"
Players.Parent = PlayerList
Players.BackgroundColor3 = Color3.new(1, 1, 1)
Players.BackgroundTransparency = 1
Players.BorderSizePixel = 0
Players.Size = UDim2.new(1, 0, 1, 0)

Player1.Name = "Player1"
Player1.Parent = Players
Player1.BackgroundColor3 = Color3.new(1, 1, 1)
Player1.BackgroundTransparency = 1
Player1.BorderSizePixel = 0
Player1.Position = UDim2.new(0, 25, 0, 7)
Player1.Size = UDim2.new(1, -25, 0, 25)
Player1.Font = Enum.Font.Fantasy
Player1.Text = "Player"
Player1.TextColor3 = Color3.new(1, 1, 1)
Player1.TextSize = 14
Player1.TextStrokeTransparency = 0

Player2.Name = "Player2"
Player2.Parent = Players
Player2.BackgroundColor3 = Color3.new(1, 1, 1)
Player2.BackgroundTransparency = 1
Player2.BorderSizePixel = 0
Player2.Position = UDim2.new(0, 25, 0, 32)
Player2.Size = UDim2.new(1, -25, 0, 25)
Player2.Font = Enum.Font.Fantasy
Player2.Text = "Player"
Player2.TextColor3 = Color3.new(1, 1, 1)
Player2.TextSize = 14
Player2.TextStrokeTransparency = 0

Player3.Name = "Player3"
Player3.Parent = Players
Player3.BackgroundColor3 = Color3.new(1, 1, 1)
Player3.BackgroundTransparency = 1
Player3.BorderSizePixel = 0
Player3.Position = UDim2.new(0, 25, 0, 57)
Player3.Size = UDim2.new(1, -25, 0, 25)
Player3.Font = Enum.Font.Fantasy
Player3.Text = "Player"
Player3.TextColor3 = Color3.new(1, 1, 1)
Player3.TextSize = 14
Player3.TextStrokeTransparency = 0

Player4.Name = "Player4"
Player4.Parent = Players
Player4.BackgroundColor3 = Color3.new(1, 1, 1)
Player4.BackgroundTransparency = 1
Player4.BorderSizePixel = 0
Player4.Position = UDim2.new(0, 25, 0, 82)
Player4.Size = UDim2.new(1, -25, 0, 25)
Player4.Font = Enum.Font.Fantasy
Player4.Text = "Player"
Player4.TextColor3 = Color3.new(1, 1, 1)
Player4.TextSize = 14
Player4.TextStrokeTransparency = 0

Player6.Name = "Player6"
Player6.Parent = Players
Player6.BackgroundColor3 = Color3.new(1, 1, 1)
Player6.BackgroundTransparency = 1
Player6.BorderSizePixel = 0
Player6.Position = UDim2.new(0, 25, 0, 132)
Player6.Size = UDim2.new(1, -25, 0, 25)
Player6.Font = Enum.Font.Fantasy
Player6.Text = "Player"
Player6.TextColor3 = Color3.new(1, 1, 1)
Player6.TextSize = 14
Player6.TextStrokeTransparency = 0

Player5.Name = "Player5"
Player5.Parent = Players
Player5.BackgroundColor3 = Color3.new(1, 1, 1)
Player5.BackgroundTransparency = 1
Player5.BorderSizePixel = 0
Player5.Position = UDim2.new(0, 25, 0, 107)
Player5.Size = UDim2.new(1, -25, 0, 25)
Player5.Font = Enum.Font.Fantasy
Player5.Text = "Player"
Player5.TextColor3 = Color3.new(1, 1, 1)
Player5.TextSize = 14
Player5.TextStrokeTransparency = 0

Player8.Name = "Player8"
Player8.Parent = Players
Player8.BackgroundColor3 = Color3.new(1, 1, 1)
Player8.BackgroundTransparency = 1
Player8.BorderSizePixel = 0
Player8.Position = UDim2.new(0, 25, 0, 182)
Player8.Size = UDim2.new(1, -25, 0, 25)
Player8.Font = Enum.Font.Fantasy
Player8.Text = "Player"
Player8.TextColor3 = Color3.new(1, 1, 1)
Player8.TextSize = 14
Player8.TextStrokeTransparency = 0

Player7.Name = "Player7"
Player7.Parent = Players
Player7.BackgroundColor3 = Color3.new(1, 1, 1)
Player7.BackgroundTransparency = 1
Player7.BorderSizePixel = 0
Player7.Position = UDim2.new(0, 25, 0, 157)
Player7.Size = UDim2.new(1, -25, 0, 25)
Player7.Font = Enum.Font.Fantasy
Player7.Text = "Player"
Player7.TextColor3 = Color3.new(1, 1, 1)
Player7.TextSize = 14
Player7.TextStrokeTransparency = 0

Player10.Name = "Player10"
Player10.Parent = Players
Player10.BackgroundColor3 = Color3.new(1, 1, 1)
Player10.BackgroundTransparency = 1
Player10.BorderSizePixel = 0
Player10.Position = UDim2.new(0, 25, 0, 232)
Player10.Size = UDim2.new(1, -25, 0, 25)
Player10.Font = Enum.Font.Fantasy
Player10.Text = "Player"
Player10.TextColor3 = Color3.new(1, 1, 1)
Player10.TextSize = 14
Player10.TextStrokeTransparency = 0

Player11.Name = "Player11"
Player11.Parent = Players
Player11.BackgroundColor3 = Color3.new(1, 1, 1)
Player11.BackgroundTransparency = 1
Player11.BorderSizePixel = 0
Player11.Position = UDim2.new(0, 25, 0, 257)
Player11.Size = UDim2.new(1, -25, 0, 25)
Player11.Font = Enum.Font.Fantasy
Player11.Text = "Player"
Player11.TextColor3 = Color3.new(1, 1, 1)
Player11.TextSize = 14
Player11.TextStrokeTransparency = 0

Player12.Name = "Player12"
Player12.Parent = Players
Player12.BackgroundColor3 = Color3.new(1, 1, 1)
Player12.BackgroundTransparency = 1
Player12.BorderSizePixel = 0
Player12.Position = UDim2.new(0, 25, 0, 282)
Player12.Size = UDim2.new(1, -25, 0, 25)
Player12.Font = Enum.Font.Fantasy
Player12.Text = "Player"
Player12.TextColor3 = Color3.new(1, 1, 1)
Player12.TextSize = 14
Player12.TextStrokeTransparency = 0

Player9.Name = "Player9"
Player9.Parent = Players
Player9.BackgroundColor3 = Color3.new(1, 1, 1)
Player9.BackgroundTransparency = 1
Player9.BorderSizePixel = 0
Player9.Position = UDim2.new(0, 25, 0, 207)
Player9.Size = UDim2.new(1, -25, 0, 25)
Player9.Font = Enum.Font.Fantasy
Player9.Text = "Player"
Player9.TextColor3 = Color3.new(1, 1, 1)
Player9.TextSize = 14
Player9.TextStrokeTransparency = 0

Roles.Name = "Roles"
Roles.Parent = PlayerList
Roles.BackgroundColor3 = Color3.new(1, 1, 1)
Roles.BackgroundTransparency = 1
Roles.BorderSizePixel = 0
Roles.Position = UDim2.new(0, -210, 1, -100)
Roles.Size = UDim2.new(0, 205, 0, 100)

Murderer.Name = "Murderer"
Murderer.Parent = Roles
Murderer.BackgroundColor3 = Color3.new(1, 1, 1)
Murderer.BackgroundTransparency = 1
Murderer.BorderSizePixel = 0
Murderer.Size = UDim2.new(0, 100, 0, 100)

Sherrif.Name = "Sherrif"
Sherrif.Parent = Roles
Sherrif.BackgroundColor3 = Color3.new(1, 1, 1)
Sherrif.BackgroundTransparency = 1
Sherrif.BorderSizePixel = 0
Sherrif.Position = UDim2.new(1, -100, 0, 0)
Sherrif.Size = UDim2.new(0, 100, 0, 100)

MurdererLabel.Name = "MurdererLabel"
MurdererLabel.Parent = Roles
MurdererLabel.BackgroundColor3 = Color3.new(1, 1, 1)
MurdererLabel.BackgroundTransparency = 1
MurdererLabel.BorderSizePixel = 0
MurdererLabel.Position = UDim2.new(0, 0, 1, -25)
MurdererLabel.Size = UDim2.new(0, 100, 0, 25)
MurdererLabel.Font = Enum.Font.Fantasy
MurdererLabel.Text = "Murderer"
MurdererLabel.TextColor3 = Color3.new(1, 0, 0.0980392)
MurdererLabel.TextSize = 24
MurdererLabel.TextStrokeTransparency = 0
MurdererLabel.TextWrapped = true

SherrifLabel.Name = "SherrifLabel"
SherrifLabel.Parent = Roles
SherrifLabel.BackgroundColor3 = Color3.new(1, 1, 1)
SherrifLabel.BackgroundTransparency = 1
SherrifLabel.BorderSizePixel = 0
SherrifLabel.Position = UDim2.new(1, -100, 1, -25)
SherrifLabel.Size = UDim2.new(0, 100, 0, 25)
SherrifLabel.Font = Enum.Font.Fantasy
SherrifLabel.Text = "Sherrif"
SherrifLabel.TextColor3 = Color3.new(0, 0.196078, 1)
SherrifLabel.TextSize = 24
SherrifLabel.TextStrokeTransparency = 0
SherrifLabel.TextWrapped = true

Main.Name = "Main"
Main.Parent = Holder
Main.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
Main.BorderSizePixel = 0
Main.Size = UDim2.new(1, 0, 1, 0)

CoinFarm.Name = "CoinFarm"
CoinFarm.Parent = Main
CoinFarm.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
CoinFarm.BorderColor3 = Color3.new(0, 0, 0)
CoinFarm.BorderSizePixel = 0
CoinFarm.Position = UDim2.new(0, 10, 0, 50)
CoinFarm.Size = UDim2.new(0, 155, 0, 25)
CoinFarm.Font = Enum.Font.Fantasy
CoinFarm.Text = "Coin Farm (x40)"
CoinFarm.TextColor3 = Color3.new(1, 1, 1)
CoinFarm.TextSize = 18
CoinFarm.TextStrokeTransparency = 0

Underline.Name = "Underline"
Underline.Parent = CoinFarm
Underline.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline.BorderSizePixel = 0
Underline.Position = UDim2.new(0, 0, 1, 0)
Underline.Size = UDim2.new(1, 0, 0, 5)
Underline.Font = Enum.Font.SourceSans
Underline.Text = ""
Underline.TextColor3 = Color3.new(0, 0, 0)
Underline.TextSize = 14

Fly.Name = "Fly"
Fly.Parent = Main
Fly.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
Fly.BorderColor3 = Color3.new(0, 0, 0)
Fly.BorderSizePixel = 0
Fly.Position = UDim2.new(0, 175, 0, 90)
Fly.Size = UDim2.new(0, 155, 0, 25)
Fly.Font = Enum.Font.Fantasy
Fly.Text = "Fly [L]"
Fly.TextColor3 = Color3.new(1, 1, 1)
Fly.TextSize = 18
Fly.TextStrokeTransparency = 0

Underline_2.Name = "Underline"
Underline_2.Parent = Fly
Underline_2.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_2.BorderSizePixel = 0
Underline_2.Position = UDim2.new(0, 0, 1, 0)
Underline_2.Size = UDim2.new(1, 0, 0, 5)
Underline_2.Font = Enum.Font.SourceSans
Underline_2.Text = ""
Underline_2.TextColor3 = Color3.new(0, 0, 0)
Underline_2.TextSize = 14

GunDropGrabber.Name = "GunDropGrabber"
GunDropGrabber.Parent = Main
GunDropGrabber.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
GunDropGrabber.BorderColor3 = Color3.new(0, 0, 0)
GunDropGrabber.BorderSizePixel = 0
GunDropGrabber.Position = UDim2.new(0, 10, 0, 90)
GunDropGrabber.Size = UDim2.new(0, 155, 0, 25)
GunDropGrabber.Font = Enum.Font.Fantasy
GunDropGrabber.Text = "Gun Grabber"
GunDropGrabber.TextColor3 = Color3.new(1, 1, 1)
GunDropGrabber.TextSize = 18
GunDropGrabber.TextStrokeTransparency = 0

Underline_3.Name = "Underline"
Underline_3.Parent = GunDropGrabber
Underline_3.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_3.BorderSizePixel = 0
Underline_3.Position = UDim2.new(0, 0, 1, 0)
Underline_3.Size = UDim2.new(1, 0, 0, 5)
Underline_3.Font = Enum.Font.SourceSans
Underline_3.Text = ""
Underline_3.TextColor3 = Color3.new(0, 0, 0)
Underline_3.TextSize = 14

KillAll.Name = "KillAll"
KillAll.Parent = Main
KillAll.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
KillAll.BorderColor3 = Color3.new(0, 0, 0)
KillAll.BorderSizePixel = 0
KillAll.Position = UDim2.new(0, 175, 0, 130)
KillAll.Size = UDim2.new(0, 155, 0, 25)
KillAll.Font = Enum.Font.Fantasy
KillAll.Text = "Kill All"
KillAll.TextColor3 = Color3.new(1, 1, 1)
KillAll.TextSize = 18
KillAll.TextStrokeTransparency = 0

Underline_4.Name = "Underline"
Underline_4.Parent = KillAll
Underline_4.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_4.BorderSizePixel = 0
Underline_4.Position = UDim2.new(0, 0, 1, 0)
Underline_4.Size = UDim2.new(1, 0, 0, 5)
Underline_4.Font = Enum.Font.SourceSans
Underline_4.Text = ""
Underline_4.TextColor3 = Color3.new(0, 0, 0)
Underline_4.TextSize = 14

MurdererESP.Name = "MurdererESP"
MurdererESP.Parent = Main
MurdererESP.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
MurdererESP.BorderColor3 = Color3.new(0, 0, 0)
MurdererESP.BorderSizePixel = 0
MurdererESP.Position = UDim2.new(0, 10, 0, 10)
MurdererESP.Size = UDim2.new(0, 155, 0, 25)
MurdererESP.Font = Enum.Font.Fantasy
MurdererESP.Text = "Murderer ESP"
MurdererESP.TextColor3 = Color3.new(1, 1, 1)
MurdererESP.TextSize = 18
MurdererESP.TextStrokeTransparency = 0

Underline_5.Name = "Underline"
Underline_5.Parent = MurdererESP
Underline_5.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_5.BorderSizePixel = 0
Underline_5.Position = UDim2.new(0, 0, 1, 0)
Underline_5.Size = UDim2.new(1, 0, 0, 5)
Underline_5.Font = Enum.Font.SourceSans
Underline_5.Text = ""
Underline_5.TextColor3 = Color3.new(0, 0, 0)
Underline_5.TextSize = 14

Noclip.Name = "Noclip"
Noclip.Parent = Main
Noclip.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
Noclip.BorderColor3 = Color3.new(0, 0, 0)
Noclip.BorderSizePixel = 0
Noclip.Position = UDim2.new(0, 10, 0, 130)
Noclip.Size = UDim2.new(0, 155, 0, 25)
Noclip.Font = Enum.Font.Fantasy
Noclip.Text = "Noclip [B]"
Noclip.TextColor3 = Color3.new(1, 1, 1)
Noclip.TextSize = 18
Noclip.TextStrokeTransparency = 0

Underline_6.Name = "Underline"
Underline_6.Parent = Noclip
Underline_6.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_6.BorderSizePixel = 0
Underline_6.Position = UDim2.new(0, 0, 1, 0)
Underline_6.Size = UDim2.new(1, 0, 0, 5)
Underline_6.Font = Enum.Font.SourceSans
Underline_6.Text = ""
Underline_6.TextColor3 = Color3.new(0, 0, 0)
Underline_6.TextSize = 14

PlayerName.Name = "PlayerName"
PlayerName.Parent = Main
PlayerName.BackgroundColor3 = Color3.new(1, 1, 1)
PlayerName.BackgroundTransparency = 1
PlayerName.BorderSizePixel = 0
PlayerName.Position = UDim2.new(0, 175, 0, 350)
PlayerName.Size = UDim2.new(0, 155, 0, 25)
PlayerName.Font = Enum.Font.Fantasy
PlayerName.PlaceholderColor3 = Color3.new(0.490196, 0.490196, 0.490196)
PlayerName.PlaceholderText = "Player Name"
PlayerName.Text = ""
PlayerName.TextColor3 = Color3.new(1, 1, 1)
PlayerName.TextSize = 18
PlayerName.TextStrokeTransparency = 0

Underline_7.Name = "Underline"
Underline_7.Parent = PlayerName
Underline_7.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_7.BorderSizePixel = 0
Underline_7.Position = UDim2.new(0, 0, 1, 0)
Underline_7.Size = UDim2.new(1, 0, 0, 5)
Underline_7.Font = Enum.Font.SourceSans
Underline_7.Text = ""
Underline_7.TextColor3 = Color3.new(0, 0, 0)
Underline_7.TextSize = 14

SherrifESP.Name = "SherrifESP"
SherrifESP.Parent = Main
SherrifESP.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
SherrifESP.BorderColor3 = Color3.new(0, 0, 0)
SherrifESP.BorderSizePixel = 0
SherrifESP.Position = UDim2.new(0, 175, 0, 10)
SherrifESP.Size = UDim2.new(0, 155, 0, 25)
SherrifESP.Font = Enum.Font.Fantasy
SherrifESP.Text = "Sherrif ESP"
SherrifESP.TextColor3 = Color3.new(1, 1, 1)
SherrifESP.TextSize = 18
SherrifESP.TextStrokeTransparency = 0

Underline_8.Name = "Underline"
Underline_8.Parent = SherrifESP
Underline_8.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_8.BorderSizePixel = 0
Underline_8.Position = UDim2.new(0, 0, 1, 0)
Underline_8.Size = UDim2.new(1, 0, 0, 5)
Underline_8.Font = Enum.Font.SourceSans
Underline_8.Text = ""
Underline_8.TextColor3 = Color3.new(0, 0, 0)
Underline_8.TextSize = 14

ShowNames.Name = "ShowNames"
ShowNames.Parent = Main
ShowNames.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
ShowNames.BorderColor3 = Color3.new(0, 0, 0)
ShowNames.BorderSizePixel = 0
ShowNames.Position = UDim2.new(0, 175, 0, 50)
ShowNames.Size = UDim2.new(0, 155, 0, 25)
ShowNames.Font = Enum.Font.Fantasy
ShowNames.Text = "Show Names"
ShowNames.TextColor3 = Color3.new(1, 1, 1)
ShowNames.TextSize = 18
ShowNames.TextStrokeTransparency = 0

Underline_9.Name = "Underline"
Underline_9.Parent = ShowNames
Underline_9.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_9.BorderSizePixel = 0
Underline_9.Position = UDim2.new(0, 0, 1, 0)
Underline_9.Size = UDim2.new(1, 0, 0, 5)
Underline_9.Font = Enum.Font.SourceSans
Underline_9.Text = ""
Underline_9.TextColor3 = Color3.new(0, 0, 0)
Underline_9.TextSize = 14

TPtoLobby.Name = "TPtoLobby"
TPtoLobby.Parent = Main
TPtoLobby.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
TPtoLobby.BorderColor3 = Color3.new(0, 0, 0)
TPtoLobby.BorderSizePixel = 0
TPtoLobby.Position = UDim2.new(0, 10, 0, 270)
TPtoLobby.Size = UDim2.new(0, 155, 0, 25)
TPtoLobby.Font = Enum.Font.Fantasy
TPtoLobby.Text = "TP to Lobby"
TPtoLobby.TextColor3 = Color3.new(1, 1, 1)
TPtoLobby.TextSize = 18
TPtoLobby.TextStrokeTransparency = 0

Underline_10.Name = "Underline"
Underline_10.Parent = TPtoLobby
Underline_10.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_10.BorderSizePixel = 0
Underline_10.Position = UDim2.new(0, 0, 1, 0)
Underline_10.Size = UDim2.new(1, 0, 0, 5)
Underline_10.Font = Enum.Font.SourceSans
Underline_10.Text = ""
Underline_10.TextColor3 = Color3.new(0, 0, 0)
Underline_10.TextSize = 14

TPtoMap.Name = "TPtoMap"
TPtoMap.Parent = Main
TPtoMap.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
TPtoMap.BorderColor3 = Color3.new(0, 0, 0)
TPtoMap.BorderSizePixel = 0
TPtoMap.Position = UDim2.new(0, 175, 0, 310)
TPtoMap.Size = UDim2.new(0, 155, 0, 25)
TPtoMap.Font = Enum.Font.Fantasy
TPtoMap.Text = "TP to Map"
TPtoMap.TextColor3 = Color3.new(1, 1, 1)
TPtoMap.TextSize = 18
TPtoMap.TextStrokeTransparency = 0

Underline_11.Name = "Underline"
Underline_11.Parent = TPtoMap
Underline_11.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_11.BorderSizePixel = 0
Underline_11.Position = UDim2.new(0, 0, 1, 0)
Underline_11.Size = UDim2.new(1, 0, 0, 5)
Underline_11.Font = Enum.Font.SourceSans
Underline_11.Text = ""
Underline_11.TextColor3 = Color3.new(0, 0, 0)
Underline_11.TextSize = 14

TPtoMuderer.Name = "TPtoMuderer"
TPtoMuderer.Parent = Main
TPtoMuderer.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
TPtoMuderer.BorderColor3 = Color3.new(0, 0, 0)
TPtoMuderer.BorderSizePixel = 0
TPtoMuderer.Position = UDim2.new(0, 175, 0, 270)
TPtoMuderer.Size = UDim2.new(0, 155, 0, 25)
TPtoMuderer.Font = Enum.Font.Fantasy
TPtoMuderer.Text = "TP to Murderer"
TPtoMuderer.TextColor3 = Color3.new(1, 1, 1)
TPtoMuderer.TextSize = 18
TPtoMuderer.TextStrokeTransparency = 0

Underline_12.Name = "Underline"
Underline_12.Parent = TPtoMuderer
Underline_12.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_12.BorderSizePixel = 0
Underline_12.Position = UDim2.new(0, 0, 1, 0)
Underline_12.Size = UDim2.new(1, 0, 0, 5)
Underline_12.Font = Enum.Font.SourceSans
Underline_12.Text = ""
Underline_12.TextColor3 = Color3.new(0, 0, 0)
Underline_12.TextSize = 14

TPtoPlayer.Name = "TPtoPlayer"
TPtoPlayer.Parent = Main
TPtoPlayer.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
TPtoPlayer.BorderColor3 = Color3.new(0, 0, 0)
TPtoPlayer.BorderSizePixel = 0
TPtoPlayer.Position = UDim2.new(0, 10, 0, 350)
TPtoPlayer.Size = UDim2.new(0, 155, 0, 25)
TPtoPlayer.Font = Enum.Font.Fantasy
TPtoPlayer.Text = "TP to Player >"
TPtoPlayer.TextColor3 = Color3.new(1, 1, 1)
TPtoPlayer.TextSize = 18
TPtoPlayer.TextStrokeTransparency = 0

Underline_13.Name = "Underline"
Underline_13.Parent = TPtoPlayer
Underline_13.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_13.BorderSizePixel = 0
Underline_13.Position = UDim2.new(0, 0, 1, 0)
Underline_13.Size = UDim2.new(1, 0, 0, 5)
Underline_13.Font = Enum.Font.SourceSans
Underline_13.Text = ""
Underline_13.TextColor3 = Color3.new(0, 0, 0)
Underline_13.TextSize = 14

TPtoSherrif.Name = "TPtoSherrif"
TPtoSherrif.Parent = Main
TPtoSherrif.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
TPtoSherrif.BorderColor3 = Color3.new(0, 0, 0)
TPtoSherrif.BorderSizePixel = 0
TPtoSherrif.Position = UDim2.new(0, 10, 0, 310)
TPtoSherrif.Size = UDim2.new(0, 155, 0, 25)
TPtoSherrif.Font = Enum.Font.Fantasy
TPtoSherrif.Text = "TP to Sherrif"
TPtoSherrif.TextColor3 = Color3.new(1, 1, 1)
TPtoSherrif.TextSize = 18
TPtoSherrif.TextStrokeTransparency = 0

Underline_14.Name = "Underline"
Underline_14.Parent = TPtoSherrif
Underline_14.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_14.BorderSizePixel = 0
Underline_14.Position = UDim2.new(0, 0, 1, 0)
Underline_14.Size = UDim2.new(1, 0, 0, 5)
Underline_14.Font = Enum.Font.SourceSans
Underline_14.Text = ""
Underline_14.TextColor3 = Color3.new(0, 0, 0)
Underline_14.TextSize = 14

Walkspeed.Name = "Walkspeed"
Walkspeed.Parent = Main
Walkspeed.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
Walkspeed.BorderColor3 = Color3.new(0, 0, 0)
Walkspeed.BorderSizePixel = 0
Walkspeed.Position = UDim2.new(0, 10, 0, 170)
Walkspeed.Size = UDim2.new(0, 155, 0, 25)
Walkspeed.Font = Enum.Font.Fantasy
Walkspeed.Text = "Set WalkSpeed"
Walkspeed.TextColor3 = Color3.new(1, 1, 1)
Walkspeed.TextSize = 18
Walkspeed.TextStrokeTransparency = 0

Underline_15.Name = "Underline"
Underline_15.Parent = Walkspeed
Underline_15.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_15.BorderSizePixel = 0
Underline_15.Position = UDim2.new(0, 0, 1, 0)
Underline_15.Size = UDim2.new(1, 0, 0, 5)
Underline_15.Font = Enum.Font.SourceSans
Underline_15.Text = ""
Underline_15.TextColor3 = Color3.new(0, 0, 0)
Underline_15.TextSize = 14

JumpPower.Name = "JumpPower"
JumpPower.Parent = Main
JumpPower.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
JumpPower.BorderColor3 = Color3.new(0, 0, 0)
JumpPower.BorderSizePixel = 0
JumpPower.Position = UDim2.new(0, 10, 0, 210)
JumpPower.Size = UDim2.new(0, 155, 0, 25)
JumpPower.Font = Enum.Font.Fantasy
JumpPower.Text = "Set JumpPower"
JumpPower.TextColor3 = Color3.new(1, 1, 1)
JumpPower.TextSize = 18
JumpPower.TextStrokeTransparency = 0

Underline_16.Name = "Underline"
Underline_16.Parent = JumpPower
Underline_16.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_16.BorderSizePixel = 0
Underline_16.Position = UDim2.new(0, 0, 1, 0)
Underline_16.Size = UDim2.new(1, 0, 0, 5)
Underline_16.Font = Enum.Font.SourceSans
Underline_16.Text = ""
Underline_16.TextColor3 = Color3.new(0, 0, 0)
Underline_16.TextSize = 14

WSInput.Name = "WSInput"
WSInput.Parent = Main
WSInput.BackgroundColor3 = Color3.new(1, 1, 1)
WSInput.BackgroundTransparency = 1
WSInput.BorderSizePixel = 0
WSInput.Position = UDim2.new(0, 175, 0, 170)
WSInput.Size = UDim2.new(0, 100, 0, 25)
WSInput.Font = Enum.Font.Fantasy
WSInput.PlaceholderColor3 = Color3.new(0.490196, 0.490196, 0.490196)
WSInput.PlaceholderText = "WS Input"
WSInput.Text = ""
WSInput.TextColor3 = Color3.new(1, 1, 1)
WSInput.TextSize = 18
WSInput.TextStrokeTransparency = 0

Underline_17.Name = "Underline"
Underline_17.Parent = WSInput
Underline_17.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_17.BorderSizePixel = 0
Underline_17.Position = UDim2.new(0, 0, 1, 0)
Underline_17.Size = UDim2.new(1, 0, 0, 5)
Underline_17.Font = Enum.Font.SourceSans
Underline_17.Text = ""
Underline_17.TextColor3 = Color3.new(0, 0, 0)
Underline_17.TextSize = 14

JPInput.Name = "JPInput"
JPInput.Parent = Main
JPInput.BackgroundColor3 = Color3.new(1, 1, 1)
JPInput.BackgroundTransparency = 1
JPInput.BorderSizePixel = 0
JPInput.Position = UDim2.new(0, 175, 0, 210)
JPInput.Size = UDim2.new(0, 100, 0, 25)
JPInput.Font = Enum.Font.Fantasy
JPInput.PlaceholderColor3 = Color3.new(0.490196, 0.490196, 0.490196)
JPInput.PlaceholderText = "JP Input"
JPInput.Text = ""
JPInput.TextColor3 = Color3.new(1, 1, 1)
JPInput.TextSize = 18
JPInput.TextStrokeTransparency = 0

Underline_18.Name = "Underline"
Underline_18.Parent = JPInput
Underline_18.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_18.BorderSizePixel = 0
Underline_18.Position = UDim2.new(0, 0, 1, 0)
Underline_18.Size = UDim2.new(1, 0, 0, 5)
Underline_18.Font = Enum.Font.SourceSans
Underline_18.Text = ""
Underline_18.TextColor3 = Color3.new(0, 0, 0)
Underline_18.TextSize = 14

WSReset.Name = "WSReset"
WSReset.Parent = Main
WSReset.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
WSReset.BorderColor3 = Color3.new(0, 0, 0)
WSReset.BorderSizePixel = 0
WSReset.Position = UDim2.new(0, 280, 0, 170)
WSReset.Size = UDim2.new(0, 50, 0, 25)
WSReset.Font = Enum.Font.Fantasy
WSReset.Text = "Reset"
WSReset.TextColor3 = Color3.new(1, 1, 1)
WSReset.TextSize = 18
WSReset.TextStrokeTransparency = 0

Underline_19.Name = "Underline"
Underline_19.Parent = WSReset
Underline_19.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_19.BorderSizePixel = 0
Underline_19.Position = UDim2.new(0, 0, 1, 0)
Underline_19.Size = UDim2.new(1, 0, 0, 5)
Underline_19.Font = Enum.Font.SourceSans
Underline_19.Text = ""
Underline_19.TextColor3 = Color3.new(0, 0, 0)
Underline_19.TextSize = 14

JPReset.Name = "JPReset"
JPReset.Parent = Main
JPReset.BackgroundColor3 = Color3.new(0.117647, 0.117647, 0.117647)
JPReset.BorderColor3 = Color3.new(0, 0, 0)
JPReset.BorderSizePixel = 0
JPReset.Position = UDim2.new(0, 280, 0, 210)
JPReset.Size = UDim2.new(0, 50, 0, 25)
JPReset.Font = Enum.Font.Fantasy
JPReset.Text = "Reset"
JPReset.TextColor3 = Color3.new(1, 1, 1)
JPReset.TextSize = 18
JPReset.TextStrokeTransparency = 0

Underline_20.Name = "Underline"
Underline_20.Parent = JPReset
Underline_20.BackgroundColor3 = Color3.new(0.392157, 0, 1)
Underline_20.BorderSizePixel = 0
Underline_20.Position = UDim2.new(0, 0, 1, 0)
Underline_20.Size = UDim2.new(1, 0, 0, 5)
Underline_20.Font = Enum.Font.SourceSans
Underline_20.Text = ""
Underline_20.TextColor3 = Color3.new(0, 0, 0)
Underline_20.TextSize = 14
-- Scripts:
function SCRIPT_TXVI67_FAKESCRIPT() -- OpenClose.OpenClose 
	local script = Instance.new('LocalScript')
	script.Parent = OpenClose
	local toggle = true
	local playerListOpen = false
	
	script.Parent.MouseButton1Click:Connect(function()
		if toggle == false then
			toggle = true
			script.Parent.Rotation = -90
		else
			toggle = false
			script.Parent.Rotation = 90
		end	
		
		
		if toggle then
			script.Parent.Parent.Parent.Parent.Holder:TweenPosition(UDim2.new(1, -350, 1, 0), "Out", "Quart", 0.5)
			
			if script.Parent.Parent.Parent.PlayerList.Top.OpenClose.Rotation == 0 then
				playerListOpen = true
				script.Parent.Parent.Parent.PlayerList:TweenPosition(UDim2.new(0, -25, 0, 0), "Out", "Quart", 0.5)
			else
				playerListOpen = false
			end	
			
		else
			if playerListOpen == true then
				script.Parent.Parent.Parent.PlayerList:TweenPosition(UDim2.new(0, -175, 0, 0), "Out", "Quart", 0.5)
			end					
			script.Parent.Parent.Parent.Parent.Holder:TweenPosition(UDim2.new(1, -350, 1, -405), "Out", "Quart", 0.5)
		end	
	end)

end
coroutine.resume(coroutine.create(SCRIPT_TXVI67_FAKESCRIPT))
function SCRIPT_UWJS74_FAKESCRIPT() -- OpenClose_2.OpenClose 
	local script = Instance.new('LocalScript')
	script.Parent = OpenClose_2
	local toggle = false
	
	script.Parent.MouseButton1Click:Connect(function()
		if toggle == false then
			toggle = true
			script.Parent.Rotation = 0
		else
			toggle = false
			script.Parent.Rotation = 180
		end	
		
		
		if not toggle then
			script.Parent.Parent.Parent:TweenPosition(UDim2.new(0, -25, 0, 0), "Out", "Quart", 0.5)		
		else				
			script.Parent.Parent.Parent:TweenPosition(UDim2.new(0, -175, 0, 0), "Out", "Quart", 0.5)
		end	
	end)

end
coroutine.resume(coroutine.create(SCRIPT_UWJS74_FAKESCRIPT))
function SCRIPT_HYTP71_FAKESCRIPT() -- Player1.GetPlayerName 
	local script = Instance.new('LocalScript')
	script.Parent = Player1
	script.Parent.MouseButton1Click:Connect(function()
		
		if script.Parent.Text ~= "" then
			script.Parent.Parent.Parent.Parent.Main.PlayerName.Text = script.Parent.Text
		end
		
	end)

end
coroutine.resume(coroutine.create(SCRIPT_HYTP71_FAKESCRIPT))
function SCRIPT_ZPMH72_FAKESCRIPT() -- Player2.GetPlayerName 
	local script = Instance.new('LocalScript')
	script.Parent = Player2
	script.Parent.MouseButton1Click:Connect(function()
		
		if script.Parent.Text ~= "" then
			script.Parent.Parent.Parent.Parent.Main.PlayerName.Text = script.Parent.Text
		end
		
	end)

end
coroutine.resume(coroutine.create(SCRIPT_ZPMH72_FAKESCRIPT))
function SCRIPT_PPKR75_FAKESCRIPT() -- Player3.GetPlayerName 
	local script = Instance.new('LocalScript')
	script.Parent = Player3
	script.Parent.MouseButton1Click:Connect(function()
		
		if script.Parent.Text ~= "" then
			script.Parent.Parent.Parent.Parent.Main.PlayerName.Text = script.Parent.Text
		end
		
	end)

end
coroutine.resume(coroutine.create(SCRIPT_PPKR75_FAKESCRIPT))
function SCRIPT_MJMP67_FAKESCRIPT() -- Player4.GetPlayerName 
	local script = Instance.new('LocalScript')
	script.Parent = Player4
	script.Parent.MouseButton1Click:Connect(function()
		
		if script.Parent.Text ~= "" then
			script.Parent.Parent.Parent.Parent.Main.PlayerName.Text = script.Parent.Text
		end
		
	end)

end
coroutine.resume(coroutine.create(SCRIPT_MJMP67_FAKESCRIPT))
function SCRIPT_CYEV85_FAKESCRIPT() -- Player6.GetPlayerName 
	local script = Instance.new('LocalScript')
	script.Parent = Player6
	script.Parent.MouseButton1Click:Connect(function()
		
		if script.Parent.Text ~= "" then
			script.Parent.Parent.Parent.Parent.Main.PlayerName.Text = script.Parent.Text
		end
		
	end)

end
coroutine.resume(coroutine.create(SCRIPT_CYEV85_FAKESCRIPT))
function SCRIPT_ERRH84_FAKESCRIPT() -- Player5.GetPlayerName 
	local script = Instance.new('LocalScript')
	script.Parent = Player5
	script.Parent.MouseButton1Click:Connect(function()
		
		if script.Parent.Text ~= "" then
			script.Parent.Parent.Parent.Parent.Main.PlayerName.Text = script.Parent.Text
		end
		
	end)

end
coroutine.resume(coroutine.create(SCRIPT_ERRH84_FAKESCRIPT))
function SCRIPT_FSET86_FAKESCRIPT() -- Player8.GetPlayerName 
	local script = Instance.new('LocalScript')
	script.Parent = Player8
	script.Parent.MouseButton1Click:Connect(function()
		
		if script.Parent.Text ~= "" then
			script.Parent.Parent.Parent.Parent.Main.PlayerName.Text = script.Parent.Text
		end
		
	end)

end
coroutine.resume(coroutine.create(SCRIPT_FSET86_FAKESCRIPT))
function SCRIPT_BGYF75_FAKESCRIPT() -- Player7.GetPlayerName 
	local script = Instance.new('LocalScript')
	script.Parent = Player7
	script.Parent.MouseButton1Click:Connect(function()
		
		if script.Parent.Text ~= "" then
			script.Parent.Parent.Parent.Parent.Main.PlayerName.Text = script.Parent.Text
		end
		
	end)

end
coroutine.resume(coroutine.create(SCRIPT_BGYF75_FAKESCRIPT))
function SCRIPT_PNRM77_FAKESCRIPT() -- Player10.GetPlayerName 
	local script = Instance.new('LocalScript')
	script.Parent = Player10
	script.Parent.MouseButton1Click:Connect(function()
		
		if script.Parent.Text ~= "" then
			script.Parent.Parent.Parent.Parent.Main.PlayerName.Text = script.Parent.Text
		end
		
	end)

end
coroutine.resume(coroutine.create(SCRIPT_PNRM77_FAKESCRIPT))
function SCRIPT_MYVX75_FAKESCRIPT() -- Player11.GetPlayerName 
	local script = Instance.new('LocalScript')
	script.Parent = Player11
	script.Parent.MouseButton1Click:Connect(function()
		
		if script.Parent.Text ~= "" then
			script.Parent.Parent.Parent.Parent.Main.PlayerName.Text = script.Parent.Text
		end
		
	end)

end
coroutine.resume(coroutine.create(SCRIPT_MYVX75_FAKESCRIPT))
function SCRIPT_BFYP71_FAKESCRIPT() -- Player12.GetPlayerName 
	local script = Instance.new('LocalScript')
	script.Parent = Player12
	script.Parent.MouseButton1Click:Connect(function()
		
		if script.Parent.Text ~= "" then
			script.Parent.Parent.Parent.Parent.Main.PlayerName.Text = script.Parent.Text
		end
		
	end)

end
coroutine.resume(coroutine.create(SCRIPT_BFYP71_FAKESCRIPT))
function SCRIPT_ISFC72_FAKESCRIPT() -- Player9.GetPlayerName 
	local script = Instance.new('LocalScript')
	script.Parent = Player9
	script.Parent.MouseButton1Click:Connect(function()
		
		if script.Parent.Text ~= "" then
			script.Parent.Parent.Parent.Parent.Main.PlayerName.Text = script.Parent.Text
		end
		
	end)

end
coroutine.resume(coroutine.create(SCRIPT_ISFC72_FAKESCRIPT))
function SCRIPT_OJXE82_FAKESCRIPT() -- Players.GetPlayers 
	local script = Instance.new('LocalScript')
	script.Parent = Players
	local buttons = {
		script.Parent.Player1,
		script.Parent.Player2,
		script.Parent.Player3,
		script.Parent.Player4,
		script.Parent.Player5,
		script.Parent.Player6,
		script.Parent.Player7,
		script.Parent.Player8,
		script.Parent.Player9,
		script.Parent.Player10,
		script.Parent.Player11,
		script.Parent.Player12,
	}
	
	for i, v in pairs(game.Players:GetChildren()) do
	    buttons[i].Text = v.Name
	    buttons[i].Visible = true
	end
	
	game.Players.PlayerRemoving:connect(function()
		    for i, v in pairs(game.Players:GetChildren()) do
				buttons[i].Text = v.Name
				buttons[i].Visible = true
		    end
		end)
		
	game.Players.PlayerAdded:connect(function()
	    for i, v in pairs(game.Players:GetChildren()) do
			buttons[i].Text = v.Name
	        buttons[i].Visible = true
	    end
	end)
	
	for i,v in pairs(script.Parent:GetChildren()) do
		if v.Text == "Player" then
			v.Text = ""
		end
	end

end
coroutine.resume(coroutine.create(SCRIPT_OJXE82_FAKESCRIPT))
function SCRIPT_AJZK70_FAKESCRIPT() -- Roles.GetRoles 
	local script = Instance.new('LocalScript')
	script.Parent = Roles
	while wait(0.5) do	
		local Players = game:GetService("Players")
			
		for i, Plr in pairs(Players:GetPlayers()) do
		    for i, Bp in pairs(Plr:GetChildren()) do
		        if Bp.Name == "Backpack" then
		            if Bp:FindFirstChild("Knife") ~= nil then
						local playerId = Bp.Parent.UserId
						script.Parent.Murderer.Image = "https://web.roblox.com/Thumbs/Avatar.ashx?x=100&y=100&Format=Png&userid=".. playerId
		       		end
		
					if Bp:FindFirstChild("Gun") ~= nil then
						local playerId = Bp.Parent.UserId
						script.Parent.Sherrif.Image = "https://web.roblox.com/Thumbs/Avatar.ashx?x=100&y=100&Format=Png&userid=".. playerId	
			        end
		        end
		    end
		end
	end

end
coroutine.resume(coroutine.create(SCRIPT_AJZK70_FAKESCRIPT))
function SCRIPT_ZSRN70_FAKESCRIPT() -- CoinFarm.CoinFarm 
	local script = Instance.new('LocalScript')
	script.Parent = CoinFarm
	local toggle = false
	
	script.Parent.MouseButton1Click:Connect(function()	
		if toggle == false then
			toggle = true
			script.Parent.Underline.BackgroundColor3 = Color3.fromRGB(0, 255, 25)
		else
			toggle = false
			script.Parent.Underline.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
		end
		
		while toggle do wait(.25)
			local place = workspace:GetChildren()	
			local currentX = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X
			local currentY = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y
			local currentZ = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z
			
			for i,v in pairs(place) do	    
			    local vChildren = v:GetChildren()
			    for i,child in pairs(vChildren) do
			        if child.Name == "CoinContainer" then
			            
						if child.Coin_Server:FindFirstChild("Coin") ~= nil then
				            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = child.Coin_Server.Coin.CFrame
						else
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(currentX, currentY, currentZ)
							script.Parent.Underline.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
							toggle = false
						end
			
			        end
			    end	
			end
		end
		
	end)

end
coroutine.resume(coroutine.create(SCRIPT_ZSRN70_FAKESCRIPT))
function SCRIPT_ZXKM71_FAKESCRIPT() -- Fly.Fly 
	local script = Instance.new('LocalScript')
	script.Parent = Fly
	flying = false
	lplayer = game.Players.LocalPlayer
	speedget = 1
	speedfly = 1
	Mouse = lplayer:GetMouse()
	
	script.Parent.MouseButton1Click:Connect(function()
		if flying == false then
			script.Parent.Underline.BackgroundColor3 = Color3.fromRGB(0, 255, 25)
			
			repeat wait() until lplayer and lplayer.Character and lplayer.Character:FindFirstChild('HumanoidRootPart') and lplayer.Character:FindFirstChild('Humanoid')
			repeat wait() until Mouse
			
			local T = lplayer.Character.HumanoidRootPart
			local CONTROL = {F = 0, B = 0, L = 0, R = 0}
			local lCONTROL = {F = 0, B = 0, L = 0, R = 0}
			local SPEED = speedget
			
			local function fly()
				flying = true
				local BG = Instance.new('BodyGyro', T)
				local BV = Instance.new('BodyVelocity', T)
				BG.P = 9e4
				BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
				BG.cframe = T.CFrame
				BV.velocity = Vector3.new(0, 0.1, 0)
				BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
				spawn(function()
				repeat wait()
				lplayer.Character.Humanoid.PlatformStand = true
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0.1, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
				until not flying
					CONTROL = {F = 0, B = 0, L = 0, R = 0}
					lCONTROL = {F = 0, B = 0, L = 0, R = 0}
					SPEED = 0
					BG:destroy()
					BV:destroy()
					lplayer.Character.Humanoid.PlatformStand = false
				end)
			end
			Mouse.KeyDown:connect(function(KEY)
				if KEY:lower() == 'w' then
					CONTROL.F = speedfly
				elseif KEY:lower() == 's' then
					CONTROL.B = -speedfly
				elseif KEY:lower() == 'a' then
					CONTROL.L = -speedfly 
				elseif KEY:lower() == 'd' then 
					CONTROL.R = speedfly
				end
			end)
			Mouse.KeyUp:connect(function(KEY)
				if KEY:lower() == 'w' then
					CONTROL.F = 0
				elseif KEY:lower() == 's' then
					CONTROL.B = 0
				elseif KEY:lower() == 'a' then
					CONTROL.L = 0
				elseif KEY:lower() == 'd' then
					CONTROL.R = 0
				end
			end)
			fly()
		else
			flying = false
			script.Parent.Underline.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
			lplayer.Character.Humanoid.PlatformStand = false
		end
	end)
	
	Mouse.KeyDown:Connect(function(k)
		if k == "l" then
			
			if flying == false then
				script.Parent.Underline.BackgroundColor3 = Color3.fromRGB(0, 255, 25)
				
				repeat wait() until lplayer and lplayer.Character and lplayer.Character:FindFirstChild('HumanoidRootPart') and lplayer.Character:FindFirstChild('Humanoid')
				repeat wait() until Mouse
				
				local T = lplayer.Character.HumanoidRootPart
				local CONTROL = {F = 0, B = 0, L = 0, R = 0}
				local lCONTROL = {F = 0, B = 0, L = 0, R = 0}
				local SPEED = speedget
				
				local function fly()
					flying = true
					local BG = Instance.new('BodyGyro', T)
					local BV = Instance.new('BodyVelocity', T)
					BG.P = 9e4
					BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
					BG.cframe = T.CFrame
					BV.velocity = Vector3.new(0, 0.1, 0)
					BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
					spawn(function()
					repeat wait()
					lplayer.Character.Humanoid.PlatformStand = true
					if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 then
						SPEED = 50
					elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0) and SPEED ~= 0 then
						SPEED = 0
					end
					if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 then
						BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
						lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
					elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and SPEED ~= 0 then
						BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					else
						BV.velocity = Vector3.new(0, 0.1, 0)
					end
					BG.cframe = workspace.CurrentCamera.CoordinateFrame
					until not flying
						CONTROL = {F = 0, B = 0, L = 0, R = 0}
						lCONTROL = {F = 0, B = 0, L = 0, R = 0}
						SPEED = 0
						BG:destroy()
						BV:destroy()
						lplayer.Character.Humanoid.PlatformStand = false
					end)
				end
				Mouse.KeyDown:connect(function(KEY)
					if KEY:lower() == 'w' then
						CONTROL.F = speedfly
					elseif KEY:lower() == 's' then
						CONTROL.B = -speedfly
					elseif KEY:lower() == 'a' then
						CONTROL.L = -speedfly 
					elseif KEY:lower() == 'd' then 
						CONTROL.R = speedfly
					end
				end)
				Mouse.KeyUp:connect(function(KEY)
					if KEY:lower() == 'w' then
						CONTROL.F = 0
					elseif KEY:lower() == 's' then
						CONTROL.B = 0
					elseif KEY:lower() == 'a' then
						CONTROL.L = 0
					elseif KEY:lower() == 'd' then
						CONTROL.R = 0
					end
				end)
				fly()
			else
				flying = false
				script.Parent.Underline.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
				lplayer.Character.Humanoid.PlatformStand = false
			end
			
		end
	end)

end
coroutine.resume(coroutine.create(SCRIPT_ZXKM71_FAKESCRIPT))
function SCRIPT_MMKD76_FAKESCRIPT() -- GunDropGrabber.GunDropGrabber 
	local script = Instance.new('LocalScript')
	script.Parent = GunDropGrabber
	script.Parent.MouseButton1Click:Connect(function()
		
		local currentX = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X
		local currentY = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y
		local currentZ = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z	
		
		if workspace:FindFirstChild("GunDrop") ~= nil then
		
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace:FindFirstChild("GunDrop").CFrame	
		wait(.25)	
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(currentX, currentY, currentZ)
			
		else
			
			script.Parent.Parent.ErrorLabel.Text = "There's no gun to grab yet, wait for the sherrif to die"
		
		wait(3)
			
			script.Parent.Parent.ErrorLabel.Text = ""
			
		end
			
	end)

end
coroutine.resume(coroutine.create(SCRIPT_MMKD76_FAKESCRIPT))
function SCRIPT_MOWM88_FAKESCRIPT() -- KillAll.KillAll 
	local script = Instance.new('LocalScript')
	script.Parent = KillAll
	script.Parent.MouseButton1Click:Connect(function(input)
	
		if game.Players.LocalPlayer.Backpack:FindFirstChild("Knife") ~= nil then -- Only works if you're the murderer
	
	    	local Players = game:GetService("Players")	
		    for i, Victim in pairs(Players:GetPlayers()) do
		        if Victim.Name ~= game.Players.LocalPlayer.Name then
		
		            repeat wait()
		                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Victim.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
		            until
		                Victim.Character.Humanoid.Health == 0
		
		        end
		    end
		
		else
		
		    script.Parent.Parent.ErrorLabel.Text = "You need to be murderer in order to do this"
		
		wait(3)
		
			script.Parent.Parent.ErrorLabel.Text = ""
		
		end
	
	end)

end
coroutine.resume(coroutine.create(SCRIPT_MOWM88_FAKESCRIPT))
function SCRIPT_FZXM74_FAKESCRIPT() -- MurdererESP.MurdererESP 
	local script = Instance.new('LocalScript')
	script.Parent = MurdererESP
	local toggle = false
	
	script.Parent.MouseButton1Click:Connect(function()
		if toggle == false then
			toggle = true
			script.Parent.Underline.BackgroundColor3 = Color3.fromRGB(0, 255, 25)
		else
			toggle = false
			script.Parent.Underline.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
		end
			
		
		while toggle do wait(.1)		
			local Players = game:GetService("Players")
			
			for i, Plr in pairs(Players:GetPlayers()) do
			    for i, Bp in pairs(Plr:GetChildren()) do
			        if Bp.Name == "Backpack" then
			            if Bp:FindFirstChild("Knife") ~= nil then
							if Bp.Parent.Character.UpperTorso:FindFirstChild("BoxHandleAdornment") == nil then
				                local box = Instance.new("BoxHandleAdornment", Bp.Parent.Character.UpperTorso)
								box.Size = Bp.Parent.Character.UpperTorso.Size
								box.Adornee = Bp.Parent.Character.UpperTorso
								box.ZIndex = 5
								box.AlwaysOnTop = true
								box.Color3 = Color3.fromRGB(255, 0, 25)
								
								local at0 = Instance.new("Attachment", game.Players.LocalPlayer.Character.UpperTorso)
								local at1 = Instance.new("Attachment", Bp.Parent.Character.UpperTorso)
								local beam = Instance.new("Beam", game.Players.LocalPlayer.Character)
								beam.Color = ColorSequence.new(Color3.fromRGB(255, 0, 25), Color3.fromRGB(255, 0, 25))
								beam.FaceCamera = true
								beam.Width0 = 0.2
								beam.Width1 = 0.2
								beam.Attachment0 = at0
								beam.Attachment1 = at1
							end
			            end
			        end
			    end
			end
		end
		
		
		while toggle == false do wait()		
			local Players = game:GetService("Players")
			
			for i, Plr in pairs(Players:GetPlayers()) do
			    for i, Bp in pairs(Plr:GetChildren()) do
			        if Bp.Name == "Backpack" then
			            if Bp:FindFirstChild("Knife") ~= nil then
							if Bp.Parent.Character.UpperTorso:FindFirstChild("BoxHandleAdornment") ~= nil then
								Bp.Parent.Character.UpperTorso:FindFirstChild("BoxHandleAdornment"):Destroy()
								
							elseif game.Players.LocalPlayer.Character:FindFirstChild("Beam") ~= nil then
								game.Players.LocalPlayer.Character:FindFirstChild("Beam"):Destroy()
							end
			            end
			        end
			    end
			end	
		end
	end)

end
coroutine.resume(coroutine.create(SCRIPT_FZXM74_FAKESCRIPT))
function SCRIPT_GVGT66_FAKESCRIPT() -- Noclip.Noclip 
	local script = Instance.new('LocalScript')
	script.Parent = Noclip
	noclip = false
	local Mouse = game.Players.LocalPlayer:GetMouse()
	
	game:GetService('RunService').Stepped:connect(function()
		if noclip then
			game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
		end
	end)
	
	script.Parent.MouseButton1Down:connect(function()
		noclip = not noclip
		if noclip then
			script.Parent.Underline.BackgroundColor3 = Color3.fromRGB(0, 255, 25)
		else
			script.Parent.Underline.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
		end
	end)
	
	Mouse.KeyDown:Connect(function(k)
		if k == "b" then
			
			noclip = not noclip
			if noclip then
				script.Parent.Underline.BackgroundColor3 = Color3.fromRGB(0, 255, 25)
			else
				script.Parent.Underline.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
			end
			
		end	
	end)

end
coroutine.resume(coroutine.create(SCRIPT_GVGT66_FAKESCRIPT))
function SCRIPT_CTQL79_FAKESCRIPT() -- SherrifESP.SherrifESP 
	local script = Instance.new('LocalScript')
	script.Parent = SherrifESP
	local toggle = false
	
	script.Parent.MouseButton1Click:Connect(function()
		if toggle == false then
			toggle = true
			script.Parent.Underline.BackgroundColor3 = Color3.fromRGB(0, 255, 25)
		else
			toggle = false
			script.Parent.Underline.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
		end
			
		
		while toggle do wait(.1)		
			local Players = game:GetService("Players")
			
			for i, Plr in pairs(Players:GetPlayers()) do
			    for i, Bp in pairs(Plr:GetChildren()) do
			        if Bp.Name == "Backpack" then
			            if Bp:FindFirstChild("Gun") ~= nil then
							if Bp.Parent.Character.UpperTorso:FindFirstChild("BoxHandleAdornment") == nil then
				                local box = Instance.new("BoxHandleAdornment", Bp.Parent.Character.UpperTorso)
								box.Size = Bp.Parent.Character.UpperTorso.Size
								box.Adornee = Bp.Parent.Character.UpperTorso
								box.ZIndex = 5
								box.AlwaysOnTop = true
								box.Color3 = Color3.fromRGB(0, 50, 255)
								
								local at0 = Instance.new("Attachment", game.Players.LocalPlayer.Character.UpperTorso)
								local at1 = Instance.new("Attachment", Bp.Parent.Character.UpperTorso)
								local beam = Instance.new("Beam", game.Players.LocalPlayer.Character)
								beam.Color = ColorSequence.new(Color3.fromRGB(0, 50, 255), Color3.fromRGB(0, 50, 255))
								beam.FaceCamera = true
								beam.Width0 = 0.2
								beam.Width1 = 0.2
								beam.Attachment0 = at0
								beam.Attachment1 = at1
							end
			            end
			        end
			    end
			end
		end
		
		
		while toggle == false do wait()		
			local Players = game:GetService("Players")
			
			for i, Plr in pairs(Players:GetPlayers()) do
			    for i, Bp in pairs(Plr:GetChildren()) do
			        if Bp.Name == "Backpack" then
			            if Bp:FindFirstChild("Gun") ~= nil then
							if Bp.Parent.Character.UpperTorso:FindFirstChild("BoxHandleAdornment") ~= nil then
								Bp.Parent.Character.UpperTorso:FindFirstChild("BoxHandleAdornment"):Destroy()
								
							elseif game.Players.LocalPlayer.Character:FindFirstChild("Beam") ~= nil then
								game.Players.LocalPlayer.Character:FindFirstChild("Beam"):Destroy()
							end
			            end
			        end
			    end
			end	
		end
	end)

end
coroutine.resume(coroutine.create(SCRIPT_CTQL79_FAKESCRIPT))
function SCRIPT_SUEV76_FAKESCRIPT() -- ShowNames.ShowNames 
	local script = Instance.new('LocalScript')
	script.Parent = ShowNames
	local toggle = false
	local db = false
	
	script.Parent.MouseButton1Click:Connect(function()
		if toggle == false then
			toggle = true
			script.Parent.ActiveFrame.Visible = true
		else
			toggle = false
			script.Parent.ActiveFrame.Visible = false
		end
		
		
		while db == false do wait(.25)
			if toggle then
				
				if game.StarterPlayer.NameDisplayDistance ~= 100 then
					game.StarterPlayer.NameDisplayDistance = 100
					db = true
				else
					game.StarterPlayer.NameDisplayDistance = 0
					db = false
					toggle = false
				end
				
			end
		end
			
	end)

end
coroutine.resume(coroutine.create(SCRIPT_SUEV76_FAKESCRIPT))
function SCRIPT_BKLO89_FAKESCRIPT() -- TPtoLobby.TPLobby 
	local script = Instance.new('LocalScript')
	script.Parent = TPtoLobby
	script.Parent.MouseButton1Click:Connect(function()
		
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108.5, 145, 0.6)
		
	end)

end
coroutine.resume(coroutine.create(SCRIPT_BKLO89_FAKESCRIPT))
function SCRIPT_XMKA81_FAKESCRIPT() -- TPtoMap.TPtoMap 
	local script = Instance.new('LocalScript')
	script.Parent = TPtoMap
	script.Parent.MouseButton1Click:Connect(function()	
		local Workplace = workspace:GetChildren()
		
		for i, Thing in pairs(Workplace) do
		
		    local ThingChildren = Thing:GetChildren()
		    for i, Child in pairs(ThingChildren) do
		        if Child.Name == "Spawns" then
		           
		           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Child.Spawn.CFrame
		
		        end
		    end
		end
	end)

end
coroutine.resume(coroutine.create(SCRIPT_XMKA81_FAKESCRIPT))
function SCRIPT_KCFZ83_FAKESCRIPT() -- TPtoMuderer.TPtoMuderer 
	local script = Instance.new('LocalScript')
	script.Parent = TPtoMuderer
	script.Parent.MouseButton1Click:Connect(function()	
		local Players = game:GetService("Players")			
		for i, player in pairs(Players:GetPlayers()) do
			
		    local bp = player.Backpack:GetChildren()
		    for i, tool in pairs(bp) do
		        if tool.Name == "Knife" then
												
			    	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[tool.Parent.Parent.Name].Character.HumanoidRootPart.CFrame
			
				end
			end
		
		end
	end)

end
coroutine.resume(coroutine.create(SCRIPT_KCFZ83_FAKESCRIPT))
function SCRIPT_AGFB74_FAKESCRIPT() -- TPtoPlayer.TPtoPlayer 
	local script = Instance.new('LocalScript')
	script.Parent = TPtoPlayer
	script.Parent.MouseButton1Click:Connect(function()	
	
		local Victim = script.Parent.Parent.PlayerName.Text
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[Victim].Character.HumanoidRootPart.CFrame 
	
	end)

end
coroutine.resume(coroutine.create(SCRIPT_AGFB74_FAKESCRIPT))
function SCRIPT_HFLO69_FAKESCRIPT() -- TPtoSherrif.TPtoSherrif 
	local script = Instance.new('LocalScript')
	script.Parent = TPtoSherrif
	script.Parent.MouseButton1Click:Connect(function()	
		local Players = game:GetService("Players")			
		for i, player in pairs(Players:GetPlayers()) do
			
		    local bp = player.Backpack:GetChildren()
		    for i, tool in pairs(bp) do
		        if tool.Name == "Gun" then
												
			    	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[tool.Parent.Parent.Name].Character.HumanoidRootPart.CFrame
			
				end
			end
		
		end
	end)

end
coroutine.resume(coroutine.create(SCRIPT_HFLO69_FAKESCRIPT))
function SCRIPT_QSMY75_FAKESCRIPT() -- Walkspeed.Walkspeed 
	local script = Instance.new('LocalScript')
	script.Parent = Walkspeed
	script.Parent.MouseButton1Down:connect(function()	
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = script.Parent.Parent.WSInput.Text	
	end)

end
coroutine.resume(coroutine.create(SCRIPT_QSMY75_FAKESCRIPT))
function SCRIPT_OPBW78_FAKESCRIPT() -- JumpPower.JumpPower 
	local script = Instance.new('LocalScript')
	script.Parent = JumpPower
	script.Parent.MouseButton1Down:connect(function()	
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = script.Parent.Parent.JPInput.Text	
	end)

end
coroutine.resume(coroutine.create(SCRIPT_OPBW78_FAKESCRIPT))
function SCRIPT_MVXU65_FAKESCRIPT() -- WSReset.WSReset 
	local script = Instance.new('LocalScript')
	script.Parent = WSReset
	script.Parent.MouseButton1Down:connect(function()	
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
		script.Parent.Parent.WSInput.Text = ""	
	end)

end
coroutine.resume(coroutine.create(SCRIPT_MVXU65_FAKESCRIPT))
function SCRIPT_PMUA78_FAKESCRIPT() -- JPReset.JPReset 
	local script = Instance.new('LocalScript')
	script.Parent = JPReset
	script.Parent.MouseButton1Down:connect(function()	
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = 48
		script.Parent.Parent.JPInput.Text = ""
	end)

end
coroutine.resume(coroutine.create(SCRIPT_PMUA78_FAKESCRIPT))
function SCRIPT_HGEW74_FAKESCRIPT() -- Main.Auto Positioning 
	local script = Instance.new('LocalScript')
	script.Parent = Main
	script.Parent.Parent.Position  = UDim2.new(1, -350, 1, 0)
	script:Destroy()

end
coroutine.resume(coroutine.create(SCRIPT_HGEW74_FAKESCRIPT))
