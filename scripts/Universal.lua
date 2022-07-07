local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/teppyboy/RbxScripts/master/Misc/UI_Libraries/Zypher/Library.lua"))()

for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v.Name == "PartyTime" then
        v:Destroy()
    end
end

local main = library:CreateMain({
	projName = "PartyTime",
	Resizable = true,
	MinSize = UDim2.new(0,400,0,400),
	MaxSize = UDim2.new(0,750,0,500),
})
 
local category = main:CreateCategory("Main")
local playerSec = category:CreateSection("Local Player")

local plr = game:GetService("Players").LocalPlayer
local char = plr.Character
local OldWalkspeed = char.Humanoid.WalkSpeed
local OldJumppower = char.Humanoid.JumpPower

--//Variables\\--
local NewWalkspeed = 0
local WalkspeedToggle = false
local NewJumppower = 0
local JumppowerToggle = false


playerSec:Create("Slider","Walkspeed",function(value)
    NewWalkspeed = value
end,
    {
        min = 1,
        max = 500,
        default = OldWalkspeed,
        changablevalue = true
    }
)

playerSec:Create("Toggle","Toggle Walkspeed",function(state)
    WalkspeedToggle = state
end,
    {
        default = false,
    }
)

playerSec:Create("Slider","Jumppower",function(value)
    NewJumppower = value
end,
    {
        min = 1,
        max = 500,
        default = OldJumppower,
        changablevalue = true
    }
)

playerSec:Create("Toggle","Toggle Jumppower",function(state)
    JumppowerToggle = state
end,
    {
        default = false,
    }
)

local gmt = getrawmetatable(game)
local OldIndex = nil
setreadonly(gmt, false)
OldIndex = hookmetamethod(game, "__index",function(Self, Key)
    if not checkcaller() and Self == "Humanoid" and Key == "WalkSpeed" then
        return OldWalkspeed
    end
    if not checkcaller() and Self == "Humanoid" and Key == "JumpPower" then
        return OldJumppower
    end
    return OldIndex(Self, Key)
end)
setreadonly(gmt, true)

local walkspeed = game:GetService("RunService").RenderStepped:Connect(function()
    if plr and char:FindFirstChild("Humanoid") and char:FindFirstChild("Humanoid").Health ~= 0 and WalkspeedToggle == true then
        char.Humanoid.WalkSpeed = NewWalkspeed
    end
end)
local jumppower = game:GetService("RunService").RenderStepped:Connect(function()
    if plr and char:FindFirstChild("Humanoid") and char:FindFirstChild("Humanoid").Health ~= 0 and JumppowerToggle == true then
        char.Humanoid.JumpPower = NewJumppower
    end
end)
