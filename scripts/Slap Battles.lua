local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local GUI = Mercury:Create{
    Name = "Party Time",
    Size = UDim2.fromOffset(600, 400),
    Theme = Mercury.Themes.Dark,
    Link = "Slap.Battles"
}

local gloves = GUI:Tab{
	Name = "Gloves",
	Icon = "rbxassetid://6022668888"
}

local plrtab = GUI:Tab{
	Name = "Player",
	Icon = "rbxassetid://6022668945"
}

local plr = game.Players.LocalPlayer

local function char()
    return plr.Character
end

local function hrp()
    return char().HumanoidRootPart
end

local deathMark = false
local fastOrbit = false
local stopOrbit = false

gloves:Toggle{Name = "Fast Orbit Glove(s)", StartingState = false,Description = "Makes orbit glove(s) spin fast, so you can combo better(?)",Callback = function(state)
    fastOrbit = state

    if hrp():FindFirstChild("OrbitGloves") and state then
        hrp():FindFirstChild("OrbitGloves").HingePart.HingeConstraint.AngularVelocity = -math.huge
    elseif hrp():FindFirstChild("OrbitGloves") and not state then
        hrp():FindFirstChild("OrbitGloves").HingePart.HingeConstraint.AngularVelocity = 5
    end
end}

gloves:Toggle{Name = "Stop Orbit Glove(s)", StartingState = false,Description = "Makes orbit glove(s) stop spinning, not sure why you'd want this tbh",Callback = function(state)
    stopOrbit = state
    if hrp():FindFirstChild("OrbitGloves") and state then
        hrp():FindFirstChild("OrbitGloves").HingePart.HingeConstraint.LimitsEnabled = true
    elseif hrp():FindFirstChild("OrbitGloves") and not state then
        hrp():FindFirstChild("OrbitGloves").HingePart.HingeConstraint.LimitsEnabled = false
    end
end}

plrtab:Toggle{Name = "Anti-Reaper Glove", StartingState = false,Description = "Tired of reaper glove users? turn this on, you wont be affected anymore!",Callback = function(state)
    deathMark = state
    if char():FindFirstChild("DeathMark") and state == true then
        game:GetService("ReplicatedStorage").ReaperGone:FireServer(char():FindFirstChild("DeathMark"))
        game:GetService("Lighting"):FindFirstChild("DeathMarkColorCorrection"):Destroy()
        game:GetService("Workspace"):FindFirstChild("reaperambiance"):Destroy()
    end
end}

--reaper glove start
char().ChildAdded:Connect(function(obj)
    if obj.Name == "DeathMark" and deathMark then
        game:GetService("ReplicatedStorage").ReaperGone:FireServer(obj)
        game:GetService("Lighting"):WaitForChild("DeathMarkColorCorrection"):Destroy()
        game:GetService("Workspace"):WaitForChild("reaperambiance"):Destroy()
    end
end)
plr.CharacterAdded:Connect(function()
    char().ChildAdded:Connect(function(obj)
        if obj.Name == "DeathMark" and deathMark then
            game:GetService("ReplicatedStorage").ReaperGone:FireServer(obj)
            game:GetService("Lighting"):WaitForChild("DeathMarkColorCorrection"):Destroy()
            game:GetService("Workspace"):WaitForChild("reaperambiance"):Destroy()
        end
    end)
end)
--reaper glove end
--orbit glove start

hrp().ChildAdded:Connect(function(obj)
    if obj.Name == "OrbitGloves" then
        if fastOrbit then
            repeat wait() until obj.HingePart
            repeat wait() until obj.HingePart.HingeConstraint
            obj.HingePart.HingeConstraint.AngularVelocity = -math.huge
        elseif stopOrbit then
            repeat wait() until obj.HingePart
            repeat wait() until obj.HingePart.HingeConstraint
            obj.HingePart.HingeConstraint.Enabled = true
        end
    end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
    repeat wait() until game.Players.LocalPlayer.Character.HumanoidRootPart
    hrp().ChildAdded:Connect(function(obj)
        if obj.Name == "OrbitGloves" then
            if fastOrbit then
                repeat wait() until obj.HingePart
                repeat wait() until obj.HingePart.HingeConstraint
                obj.HingePart.HingeConstraint.AngularVelocity = -math.huge
            elseif stopOrbit then
                repeat wait() until obj.HingePart
                repeat wait() until obj.HingePart.HingeConstraint
                obj.HingePart.HingeConstraint.LimitsEnabled = true
            end
        end
    end)
end)
--orbit glove end
