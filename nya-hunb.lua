-- Gui stuff Made by : https://v3rmillion.net/member.php?action=profile&uid=507120

local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()

local w = library:CreateWindow("nya hub") -- Creates the window

local b = w:CreateFolder("Utility") -- Creates the folder(U will put here your buttons,etc)

b:Button("Destroy Gui",function()
    w:Destroy()
end)

b:Button("SimpleSpy",function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua')))()
end)

b:Button("Anti-Afk",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/KazeOnTop/Rice-Anti-Afk/main/Wind", true))()
end)

b:Button("R15 Animations",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FocaNTG/Roblox-Stuff/main/folder%20for%20scripts%20i%20uploaded/443244_source.lua"))()
end)

local g = w:CreateFolder("Fun")

g:Button("R15 Animations",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FocaNTG/Roblox-Stuff/main/folder%20for%20scripts%20i%20uploaded/443244_source.lua"))()
end)

b:DestroyGui()

local j1 = w:CreateFolder("Games")

j1:Button("Murder mystery Vynixu",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FocaNTG/Robloz-Hax/main/folder%20for%20scripts%20i%20uploaded/mm2%20vynixu.lua"))()
end)

j1:Button("Arsenal aimbot & esp",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FocaNTG/Roblox-Stuff/main/folder%20for%20scripts%20i%20uploaded/44_source.lua"))()
end)

j1:Button("Flee The Facility",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FocaNTG/Robloz-Hax/main/folder%20for%20scripts%20i%20uploaded/flee%20the%20facc.lua"))()
end)

j1:Button("Big Paintball all guns",function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/FocaNTG/Robloz-Hax/main/folder%20for%20scripts%20i%20uploaded/big_paintball.lua"))()
end)
