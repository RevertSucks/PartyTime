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
local info = main:CreateCategory("Info")

local credits = info:CreateSection("Credits")
local supported = info:CreateSection("Supported Games")

local playerSec = category:CreateSection("Local Player")
local miscSec = category:CreateSection("Misc")

local plr = game:GetService("Players").LocalPlayer
local function char()
    return plr.Character
end
local OldWalkspeed = char().Humanoid.WalkSpeed
local OldJumppower = char().Humanoid.JumpPower

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
    if state == false then
        char().Humanoid.WalkSpeed = OldWalkspeed
    end
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
    if state == false then
        char().Humanoid.JumpPower = OldJumppower
    end
end,
    {
        default = false,
    }
)

playerSec:Create("Button","Reset",function()
    char():BreakJoints()
end,
    {
        animated = true,
    }
)

miscSec:Create("KeyBind","Hide Menu", function()
    for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
        if v.Name == "PartyTime" then
            if v.Enabled == true then
                v.Enabled = false
            else
                v.Enabled = true
            end
        end
    end
end,
    {
        default = Enum.KeyCode.N
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
    if plr and char():FindFirstChild("Humanoid") and char():FindFirstChild("Humanoid").Health ~= 0 then
        if WalkspeedToggle == true then
            char().Humanoid.WalkSpeed = NewWalkspeed
        end
    end
end)
local jumppower = game:GetService("RunService").RenderStepped:Connect(function()
    if plr and char():FindFirstChild("Humanoid") and char():FindFirstChild("Humanoid").Health ~= 0 then
        if JumppowerToggle == true then
            char().Humanoid.JumpPower = NewJumppower
        end
    end
end)

miscSec:Create("Button","Close Menu",function()
    for i,v in pairs(game:GetService("CoreGui"):GetChildren()) do
        if v.Name == "PartyTime" then
            v:Destroy()
            jumppower:Disconnect()
            walkspeed:Disconnect()
            char().Humanoid.WalkSpeed = OldWalkspeed
            char().Humanoid.JumpPower = OldJumppower
        end
    end
end,
    {
        animated = true,
    }
)

credits:Create("Textlabel","Exxen - Scripting")
credits:Create("Textlabel","Dawid - Discord UI")
credits:Create("Textlabel","xTheAlex14 - Zypher UI")

for i,v in pairs(game:GetService("HttpService"):JSONDecode(game:HttpGet("https://raw.githubusercontent.com/RevertSucks/PartyTime/main/Supported.lua"))) do
    supported:Create("Textlabel",i.." | "..v)
end
