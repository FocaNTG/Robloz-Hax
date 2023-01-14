--Main Stuff--
Bypass = "death"
loadstring(game:GetObjects("rbxassetid://5325226148")[1].Source)()
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
if v:IsA("BasePart") and v.Name ~="HumanoidRootPart" then 
game:GetService("RunService").Heartbeat:connect(function()
v.Velocity = Vector3.new(0,35,0)
wait(0.5)
end)
end
end
local plr = game.Players.LocalPlayer
local char = plr.Character

local larm = char["Left Arm"]
local rarm = char["Right Arm"]
local torso = char["Torso"]
local lleg = char["Left Leg"]
local rleg = char["Right Leg"]
local head = char["Head"]
local humrp = char["HumanoidRootPart"]
--Left Arm--
local la = Instance.new("Attachment", larm)
la.Position = Vector3.new(-1.5,0,0)
la.Rotation = Vector3.new(0,0,0)

local t = Instance.new("Attachment", head)
t.Position = Vector3.new(0,-2.5,0)


local pla = Instance.new("AlignPosition", larm)
pla.Attachment0 = la
pla.Attachment1 = t
pla.RigidityEnabled = true


local apla = Instance.new("AlignOrientation", larm)
apla.Attachment0 = la
apla.Attachment1 = t
apla.RigidityEnabled = true
--Right Arm--
local ra = Instance.new("Attachment", rarm)
ra.Position = Vector3.new(1.5,0,0)
ra.Rotation = Vector3.new(0,0,0)

local pra = Instance.new("AlignPosition", rarm)
pra.Attachment0 = ra
pra.Attachment1 = t
pra.RigidityEnabled = true

local apra = Instance.new("AlignOrientation", rarm)
apra.Attachment0 = ra
apra.Attachment1 = t
apra.RigidityEnabled = true
--Left Leg--
local ll = Instance.new("Attachment", lleg)
ll.Position = Vector3.new(-0.5,2,0)
ll.Rotation = Vector3.new(0,0,0)

local pll = Instance.new("AlignPosition", lleg)
pll.Attachment0 = ll
pll.Attachment1 = t
pll.RigidityEnabled = true

local apll = Instance.new("AlignOrientation", lleg)
apll.Attachment0 = ll
apll.Attachment1 = t
apll.RigidityEnabled = true
--Right Leg--
local rl = Instance.new("Attachment", rleg)
rl.Position = Vector3.new(0.5,2,0)
rl.Rotation = Vector3.new(0,0,0)

local prl = Instance.new("AlignPosition", rleg)
prl.Attachment0 = rl
prl.Attachment1 = t
prl.RigidityEnabled = true

local aprl = Instance.new("AlignOrientation", rleg)
aprl.Attachment0 = rl
aprl.Attachment1 = t
aprl.RigidityEnabled = true
--Head--
local h = Instance.new("Attachment", head)
h.Position = Vector3.new(0,4.5,0)
h.Rotation = Vector3.new(0,0,0)

local ph = Instance.new("AlignPosition", head)
ph.Attachment0 = h
ph.Attachment1 = t
ph.RigidityEnabled = true

local aph = Instance.new("AlignOrientation", head)
aph.Attachment0 = h
aph.Attachment1 = t
aph.RigidityEnabled = true
--Torso--
local tt = Instance.new("Attachment", torso)
tt.Position = Vector3.new(0,0,0)
tt.Rotation = Vector3.new(0,0,0)

local pt = Instance.new("AlignPosition", torso)
pt.Attachment0 = tt
pt.Attachment1 = t
pt.RigidityEnabled = true

local apt = Instance.new("AlignOrientation", torso)
apt.Attachment0 = tt
apt.Attachment1 = t
apt.RigidityEnabled = true
--Fling (TEST)--
local IsDead = false
local StateMover = true
 
local playerss = workspace.non
local bbv,bullet
if Bypass == "death" then
 bullet = game.Players.LocalPlayer.Character["HumanoidRootPart"]
 bullet.Transparency = (FlingBlockInvisible ~= true and 0 or 1)
 bullet.Massless = true

 
 bbv = Instance.new("BodyPosition",bullet)
    bbv.Position = playerss.Torso.CFrame.p
end
 
if Bypass == "death" then
coroutine.wrap(function()
 while true do
  if not playerss or not playerss:FindFirstChildOfClass("Humanoid") or playerss:FindFirstChildOfClass("Humanoid").Health <= 0 then IsDead = true; return end
  if StateMover then
   bbv.Position = playerss.HumanoidRootPart.CFrame.p
      bullet.Position = playerss.HumanoidRootPart.CFrame.p
  end
  game:GetService("RunService").RenderStepped:wait()
 end
end)()
end
 
--[[local force = Instance.new("BodyForce",bullet)
force.Force = Vector3.new(800,800,800)]]--
 
if HighlightFlingBlock ~= false then
    local Highlight = Instance.new("SelectionBox")
    Highlight.Adornee = bullet
    Highlight.Color3 = (typeof(FlingHighlightColor)=="Color3" and FlingHighlightColor) or (Color3.fromRGB(255,0,0))
    Highlight.Parent = bullet
    Highlight.Name = "HighlightBox"
end
 
bbav = Instance.new("BodyAngularVelocity",bullet)
    bbav.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
    bbav.P = 100000000000000000000000000000
    bbav.AngularVelocity = Vector3.new(10000000000000000000000000000000,100000000000000000000000000,100000000000000000)
 
local CDDF = {}
local DamageFling = function(DmgPer)
    if Fling ~= true then return end
 if IsDead or Bypass ~= "death" or (DmgPer.Name == playerss.Name and DmgPer.Name == "non") or CDDF[DmgPer] or not DmgPer or not DmgPer:FindFirstChildOfClass("Humanoid") or DmgPer:FindFirstChildOfClass("Humanoid").Health <= 0 then return end
 CDDF[DmgPer] = true; StateMover = false
 local PosFling = (DmgPer:FindFirstChild("HumanoidRootPart") and DmgPer:FindFirstChild("HumanoidRootPart") .CFrame.p) or (DmgPer:FindFirstChildOfClass("Part") and DmgPer:FindFirstChildOfClass("Part").CFrame.p)
    bullet.Rotation = playerss.Torso.Rotation
    bbav = Instance.new("BodyAngularVelocity",bullet)
    bbav.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
    bbav.P = 100000000000000000000000000000
    bbav.AngularVelocity = Vector3.new(10000000000000000000000000000000,100000000000000000000000000,100000000000000000)
 
 for _=1,15 do
  bbv.Position = PosFling
  bullet.Position = PosFling
  wait(0.03)
 end
 bbav:Destroy()
 bbv.Position = playerss.Torso.CFrame.p
    bullet.Position = playerss.Torso.CFrame.p
 CDDF[DmgPer] = false; StateMover = true
end
 
wait(.2)
humrp.Transparency = 1
--Animations--
while true do
tt.Position = Vector3.new(0,-4,0)
rl.Position = Vector3.new(4,-6,0)
ll.Position = Vector3.new(-3,-8,0)
ra.Position = Vector3.new(4,-2,0)
la.Position = Vector3.new(1,-4,0)
wait(0.001)
tt.Position = Vector3.new(0,-4.3,0)
rl.Position = Vector3.new(4,-6,0)
ll.Position = Vector3.new(-5,-2,0)
ra.Position = Vector3.new(-5,-3,0)
la.Position = Vector3.new(3,-6,0)
wait(0.001)
tt.Position = Vector3.new(0,-4.8,0)
rl.Position = Vector3.new(4,-3,0)
ll.Position = Vector3.new(-3,-6,0)
ra.Position = Vector3.new(4.5,-8,0)
la.Position = Vector3.new(-8,-6,0)
wait(0.001)
tt.Position = Vector3.new(0,-5,0)
rl.Position = Vector3.new(4,-3,0)
ll.Position = Vector3.new(-3,-2,0)
ra.Position = Vector3.new(-5,-3,0)
la.Position = Vector3.new(-4,-6,0)
wait(0.001)
tt.Position = Vector3.new(0,-4.8,0)
rl.Position = Vector3.new(4,-6,0)
ll.Position = Vector3.new(-5,-2,0)
ra.Position = Vector3.new(-5,-3,0)
la.Position = Vector3.new(3,-6,0)
wait(0.001)
tt.Position = Vector3.new(0,-4.3,0)
rl.Position = Vector3.new(4,-3,0)
ll.Position = Vector3.new(-6,-6,0)
ra.Position = Vector3.new(4.5,-8,0)
la.Position = Vector3.new(-8,-6,0)
wait(0.001)
tt.Position = Vector3.new(0,-4,0)
rl.Position = Vector3.new(-1,-3,0)
ll.Position = Vector3.new(-2,-2,0)
ra.Position = Vector3.new(4,-3,0)
la.Position = Vector3.new(-4,-6,0)
wait(0.001)
end
