if game:GetService("Workspace").Lobby:FindFirstChild("brazil") then
    game:GetService("Workspace").Lobby:FindFirstChild("brazil"):Destroy()
end
if game:GetService("Workspace").Lobby:FindFirstChild("Teleport3") then
    game:GetService("Workspace").Lobby:FindFirstChild("Teleport3"):Destroy()
end
if game:GetService("Workspace").Lobby:FindFirstChild("Teleport4") then
    game:GetService("Workspace").Lobby:FindFirstChild("Teleport4"):Destroy()
end

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

local kicktab = GUI:Tab{
	Name = "Kick",
	Icon = "rbxassetid://6034227141"
}
local animations = GUI:Tab{
	Name = "Animations (USELESS)",
	Icon = "rbxassetid://6031154857"
}

local method

kicktab:Dropdown{Name = "Method",StartingText = "Placeholder",Description = "Method Selection (where the selected person gets tped,slap royale sucks btw)",Items = {"Kick","Serverhop","Slap Royale"},Callback = function(item)
    method = item
end}

local plr = game.Players.LocalPlayer

local function attach(speaker,target)
    local char = speaker.Character
    local tchar = target.Character
    local hum = speaker.Character:FindFirstChild("Humanoid")
    local hrp = char.HumanoidRootPart
    local hrp2 = tchar.HumanoidRootPart
    hum.Name = "1"
    local newHum = hum:Clone()
    newHum.Parent = char
    newHum.Name = "Humanoid"
    wait()
    hum:Destroy()
    workspace.CurrentCamera.CameraSubject = char
    newHum.DisplayDistanceType = "None"
    local tool = speaker:FindFirstChildOfClass("Backpack"):FindFirstChildOfClass("Tool") or speaker.Character:FindFirstChildOfClass("Tool")
    tool.Parent = char
    hrp.CFrame = hrp2.CFrame * CFrame.new(0, 0, 0) * CFrame.new(math.random(-100, 100)/200,math.random(-100, 100)/200,math.random(-100, 100)/200)
    local n = 0
    repeat
        task.wait()
        n = n +1
        hrp.CFrame = hrp2.CFrame
    until (tool.Parent ~= char or not hrp or not hrp2 or not hrp.Parent or not hrp2.Parent or n > 150) and n > 2
end

local function bring(lplr,plr)
if (plr and plr.Character) and (lplr and lplr.Character) then
    wait(1)
    attach(lplr,plr)
    wait(1)
    local n = 0
    repeat
        task.wait()
        n = n+1
        if method == "Kick" then
            lplr.Character.HumanoidRootPart.CFrame = CFrame.new(-282.155212, 305.095917, -1.95643675, 0, -1, 0, 0, 0, 1, -1, 0, 0)+Vector3.new(0,math.random(0,2),0)
        elseif method == "Serverhop" then
            lplr.Character.HumanoidRootPart.CFrame = CFrame.new(-361.273865, 327.288757, -21.3077393, 0, 0, 1, 0, -1, 0, 1, 0, -0)+Vector3.new(0,math.random(0,2),0)
        elseif method == "Slap Royale" then
            lplr.Character.HumanoidRootPart.CFrame = CFrame.new(-361.053223, 327.288757, 17.0403557, 0, 0, -1, 0, -1, -0, -1, 0, -0)+Vector3.new(0,math.random(0,2),0)
        end
    until not plr or n > 1000
end
end

local function char()
    return plr.Character
end

local function hrp()
    return char().HumanoidRootPart
end

local deathMark = false
local fastOrbit = false
local stopOrbit = false
local autoSlapples = false
local selected
local viewing = false
local playerlist = {}
local anims = {}
local selectedanim
local loadedtrack

for i,v in pairs(game:GetService("ReplicatedStorage").AnimationPack:GetChildren()) do
    if v:IsA("Animation") then
        table.insert(anims,v)
    end
end

animations:Dropdown{Name = "Method",StartingText = "Placeholder",Description = "Method Selection (where the selected person gets tped,slap royale sucks btw)",Items = anims,Callback = function(item)
    selectedanim = item
end}
animations:Button{Name = "Run Animation",Description = "Starts a teleport",Callback = function()
    loadedtrack = char().Humanoid:LoadAnimation(selectedanim)
    loadedtrack:Play()
end}
animations:Button{Name = "Stop Animation",Description = "Starts a teleport",Callback = function()
    loadedtrack:Stop()
end}

for _,v in pairs(game.Players:GetPlayers()) do
    table.insert(playerlist,v)
end
local plrDropdown = kicktab:Dropdown{Name = "Player",StartingText = "Placeholder",Description = "Select Player For Teleporting",Items = playerlist,Callback = function(item)
    selected = item
end}
game.Players.PlayerAdded:Connect(function(plr)
    plrDropdown:AddItems({plr})
end)
game.Players.PlayerRemoving:Connect(function(plr)
    if tostring(plr) == tostring(selected) then
        GUI:Notification{Title = "Alert",Text = "Selected player left or was kicked!",Duration = 3,Callback = function() end}
    end
    plrDropdown:RemoveItems({plr})
end)

kicktab:Button{Name = "Kick Player",Description = "Starts a teleport",Callback = function()
    firetouchinterest(char().HumanoidRootPart,game:GetService("Workspace").Lobby.Teleport2,0)
    firetouchinterest(char().HumanoidRootPart,game:GetService("Workspace").Lobby.Teleport2,1)
    bring(game.Players.LocalPlayer,selected)
end}

kicktab:Toggle{Name = "Spectate Player", StartingState = false,Description = nil,Callback = function(state)
    viewing = state
end}

gloves:Toggle{Name = "Fast Orbit Glove(s)", StartingState = false,Description = "Makes orbit glove(s) spin fast, so you can combo better(?)",Callback = function(state)
    fastOrbit = state

    if char().HumanoidRootPart:FindFirstChild("OrbitGloves") and state then
        char().HumanoidRootPart:FindFirstChild("OrbitGloves").HingePart.HingeConstraint.AngularVelocity = -math.huge
    elseif char().HumanoidRootPart:FindFirstChild("OrbitGloves") and not state then
        char().HumanoidRootPart:FindFirstChild("OrbitGloves").HingePart.HingeConstraint.AngularVelocity = 5
    end
end}

gloves:Toggle{Name = "Stop Orbit Glove(s)", StartingState = false,Description = "Makes orbit glove(s) stop spinning, not sure why you'd want this tbh",Callback = function(state)
    stopOrbit = state
    if char().HumanoidRootPart:FindFirstChild("OrbitGloves") and state then
        char().HumanoidRootPart:FindFirstChild("OrbitGloves").HingePart.HingeConstraint.LimitsEnabled = true
    elseif char().HumanoidRootPart:FindFirstChild("OrbitGloves") and not state then
        char().HumanoidRootPart:FindFirstChild("OrbitGloves").HingePart.HingeConstraint.LimitsEnabled = false
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

plrtab:Toggle{Name = "Auto Grab Slapples", StartingState = false,Description = "ez autofarm method loool",Callback = function(state)
    autoSlapples = state
    if state == true then
        for i,v in pairs(game:GetService("Workspace").Arena.island5.Slapples:GetDescendants()) do
            if v.Name == "TouchInterest" then
               firetouchinterest(char().HumanoidRootPart,v.Parent,0)
               firetouchinterest(char().HumanoidRootPart,v.Parent,1)
            end
        end
    end
end}

plrtab:Toggle{Name = "Anti-Void (MAIN)", StartingState = false,Description = "Anti-Void on main island.",Callback = function(state)
    if state == true then
        local original = game.Workspace.DEATHBARRIER
        local new = original:Clone()
        for i,v in pairs(new:GetDescendants()) do
            if v:IsA("Script") or v:IsA("TouchInterest") then
                v:Destroy()
            end
        end
        new.Name = "Fake"
        new.Parent = workspace
        original.Parent = game.ReplicatedStorage
        new.Touched:Connect(function(prt)
            local hrp = prt.Parent:FindFirstChild("HumanoidRootPart")
            if hrp and hrp.Parent.Name == game.Players.LocalPlayer.Name then
                hrp.CFrame = CFrame.new(10.2121372, -5.17293787, -8.65606403, -0.997390509, -5.49543451e-08, -0.0721953213, -6.0797106e-08, 1, 7.87323771e-08, 0.0721953213, 8.29161877e-08, -0.997390509)
            end
        end)
        local looped = 0
        repeat
            local part = new:FindFirstChild("BLOCK")
            part.Name = "I WANNA KILL MY SELF"
            part.Touched:Connect(function(prt)
                local hrp = prt.Parent:FindFirstChild("HumanoidRootPart")
                if hrp and hrp.Parent.Name == game.Players.LocalPlayer.Name then
                    hrp.CFrame = CFrame.new(10.2121372, -5.17293787, -8.65606403, -0.997390509, -5.49543451e-08, -0.0721953213, -6.0797106e-08, 1, 7.87323771e-08, 0.0721953213, 8.29161877e-08, -0.997390509)
                end
            end)
            looped = looped+1
        until looped == 4
    else
        game.ReplicatedStorage.DEATHBARRIER.Parent = workspace
        workspace.Fake:Destroy()
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
--loops
game:GetService("Workspace").Arena.island5.Slapples.DescendantAdded:Connect(function(obj)
    if obj.Name == "TouchInterest" and autoSlapples and char():FindFirstChild("HumanoidRootPart") then
        firetouchinterest(char().HumanoidRootPart,obj.Parent,0)
        firetouchinterest(char().HumanoidRootPart,obj.Parent,1)
     end
end)
game:GetService("RunService").Heartbeat:Connect(function()
    if viewing then
        if selected ~= plr then
            game.Workspace.CurrentCamera.CameraSubject = selected.Character.Humanoid
        end
    else
        game.Workspace.CurrentCamera.CameraSubject = char().Humanoid    
    end
end)
--loops end
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
