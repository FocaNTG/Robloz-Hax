-- [[ Credits for the gui go to the Mercury Lib creators ]] -- 
  
  
  
 -- getting the library 
 local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))() 
  
 -- creating the gui 
 local GUI = Mercury:Create{ Name = "Mercury", 
      Size = UDim2.fromOffset(600, 400),  
      Theme = Mercury.Themes.Dark,  
      Link = "https://github.com/deeeity/mercury-lib"  
 } 
  
 -- making a new tab 
 local Tab = GUI:Tab{ 
      Name = "Utility Scripts", 
      Icon = "rbxassetid://8569322835" 
 } 
  
 -- adding some buttons for stuff 
 Tab:Button{ 
      Name = "Infinite Yield", 
      Description = "the famous admin script", 
      Callback = function() 
           loadstring(game:HttpGet("https://raw.githubusercontent.com/FocaNTG/Robloz-Hax/main/folder%20for%20scripts%20i%20uploaded/actual_iy.lua"))()  
         
      end 
 } 

 Tab:Button{ 
      Name = "BTools classic", 
      Description = "the old btools", 
      Callback = function() 
           
             loadstring(game:HttpGet("https://raw.githubusercontent.com/FocaNTG/Robloz-Hax/main/folder%20for%20scripts%20i%20uploaded/btools.lua"))() 
        
      end 
 } 
  
  
 local Tab0 = GUI:Tab{ 
      Name = "Game Scripts", 
      Icon = "rbxassetid://8569322835" 
 } 
  
  
 Tab0:Button{ 
      Name = "Aimlock + esp for most games", 
      Description = "X to toggle the aimlock, T to update esp", 
      Callback = function() 
         
             loadstring(game:HttpGet("https://raw.githubusercontent.com/FocaNTG/Robloz-Hax/main/folder%20for%20scripts%20i%20uploaded/44%20no%20gui.lua"))()  
         
      end 
 } 
  
 local Tab1 = GUI:Tab{ 
      Name = "Fun Scripts", 
      Icon = "rbxassetid://8569322835" 
 } 
  
  
 Tab1:Button{ 
      Name = "Pendulum", 
      Description = "sussy script owo", 
      Callback = function() 
         
              loadstring(game:HttpGet("https://raw.githubusercontent.com/FocaNTG/Robloz-Hax/main/folder%20for%20scripts%20i%20uploaded/pendd22.lua"))() 
      
      end 
 } 
  
 -- at the end, we will notify the player that the script has been loaded successfully 
 GUI:Notification{ 
      Title = "Loaded!", 
      Text = "Thanks for using Nya Hub", 
      Duration = 3, 
      Callback = function() end  
 }