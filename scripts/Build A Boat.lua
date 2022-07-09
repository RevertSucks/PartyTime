local autofarmToggle
local autofarmToggle2 = false
local autofarmSpeed = 25
local autofarmSpeed2 = 1
local autofarmInstaLoad = false

local winterChest = false
local winterAmount = 1

local selectedChestTog = false
local selectedChest
local selectedAmount

local function closeUi()
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v.name == "Discord" then
            v:Destroy()
            autofarmToggle = false
            winterChest = false
        end
    end
end
closeUi()

local function char()
    return game.Players.LocalPlayer.Character
end

local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()

local win = DiscordLib:Window("Build A Boat")
local serv = win:Server("Made By Exxen#0001", "http://www.roblox.com/asset/?id=6031075938")

local autofarmChan = serv:Channel("Autofarm")
local buyingChan = serv:Channel("Buying")
local morphChan = serv:Channel("Morphs")
local playerChan = serv:Channel("Player")

local fireworkType = "FireworkA"
local fireworkAmount = 1

local waterDamage

local function teleport(time,cframe)
    local Time = time
    local CFrameEnd = cframe
    local tween =  game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Time), {CFrame = CFrameEnd})
    tween:Play()
    tween.Completed:Wait()
end

buyingChan:Dropdown("Firework Buy", {"A","B","C","D"}, function(t)
   fireworkType = "Firework"..t
end)

buyingChan:Slider("Amount (100 per)", 1, 250,1,function(t)
    fireworkAmount = t
end)

buyingChan:Button("Buy", function()
    workspace.ItemBoughtFromShop:InvokeServer(fireworkType, fireworkAmount)
    DiscordLib:Notification("Alert!", "Attempted to buy "..fireworkType..", "..fireworkAmount.." times!", "Okay!")
end)

buyingChan:Seperator()

buyingChan:Slider("Amount (60 per)", 1, 250,1,function(t)
    winterAmount = t
end)

buyingChan:Button("Buy Winter Chest", function()
    workspace.ItemBoughtFromShop:InvokeServer("Winter Chest", winterAmount)
     DiscordLib:Notification("Alert!", "Attempted to buy Winter Chest!", "Okay!")
 end)

 buyingChan:Toggle("Auto Buy Winter Chest",false, function(t)
    winterChest = t
end)

buyingChan:Seperator()

buyingChan:Dropdown("Selected Chest Buy", {"Common","Uncommon","Rare","Epic","Legendary"}, function(t)
    selectedChest = t.." Chest"
 end)

buyingChan:Slider("Amount", 1, 250,1,function(t)
    selectedAmount = t
end)

buyingChan:Button("Buy Selected Chest", function()
    workspace.ItemBoughtFromShop:InvokeServer(selectedChest, selectedAmount)
     DiscordLib:Notification("Alert!", "Attempted to buy Winter Chest!", "Okay!")
 end)

 buyingChan:Toggle("Auto Buy Selected Chest",false, function(t)
    selectedChestTog = t
end)

autofarmChan:Toggle("Auto-Farm Coins",false, function(t)
    autofarmToggle = t
end)
autofarmChan:Slider("Speed (lower = faster)", 0, 60,25,function(t)
    autofarmSpeed = t
end)

autofarmChan:Slider("Start/End Speed (lower = faster)", 0, 5,1,function(t)
    autofarmSpeed2 = t
end)

morphChan:Button("Fox", function()
    workspace.ChangeCharacter:FireServer("FoxCharacter")
    DiscordLib:Notification("Alert!", "Morped into Fox!", "Okay!")
end)

morphChan:Button("Penguin", function()
    workspace.ChangeCharacter:FireServer("PenguinCharacter")
    DiscordLib:Notification("Alert!", "Morped into Penguin!", "Okay!")
end)

morphChan:Button("Chicken", function()
    workspace.ChangeCharacter:FireServer("ChickenCharacter")
    DiscordLib:Notification("Alert!", "Morped into Chicken!", "Okay!")
end)

local NewJumppower = 50
local NewWalkspeed = 16

playerChan:Slider("Walkspeed", 16, 500,16,function(t)
    NewWalkspeed = t
end)

playerChan:Slider("Jumppower", 50, 500,50,function(t)
    NewJumppower = t
end)

playerChan:Button("No Water Damage", function()
    game.Workspace.Water.CanTouch = false
    for i,v in pairs(workspace.BoatStages:GetDescendants()) do
        if v.Name == "Water" then
            v.CanTouch = false
        end   
    end
    waterDamage = true
end)

workspace.BoatStages.DescendantAdded:Connect(function(obj)
    if waterDamage == true then
        if obj.Name == "Water" then
            obj.CanTouch = false
        end
    end
end)

local mainLoop = game:GetService('RunService').Heartbeat:connect(function()
    local suc,err = pcall(function()
        if autofarmToggle2 == false then
            if autofarmToggle == true then
                autofarmToggle2 = true
                workspace[tostring(game.Players.LocalPlayer.TeamColor).."Zone"].VoteLaunchRE:FireServer()
                workspace.ClaimRiverResultsGold:FireServer()
                teleport(autofarmSpeed2,CFrame.new(-46.0902061, 48.5532112, 306.818024, -0.99999994, 3.08585768e-05, -0.000243538874, -9.61094049e-09, 0.992062867, 0.125742793, 0.000245486124, 0.125742793, -0.992062867))
                teleport(autofarmSpeed,CFrame.new(-45.6405792, 130.776764, 8651.52832, -0.999574065, -0.00129274174, 0.0291543398, 8.45643378e-09, 0.999018371, 0.0442980789, -0.0291829873, 0.0442792103, -0.998592854))
                teleport(autofarmSpeed2,CFrame.new(-54.9334946, -360.095276, 9488.80078, -0.964331031, -0.0507260226, 0.259793192, -0.0149418572, 0.990332782, 0.137904868, -0.264277071, 0.129104152, -0.955766559))
                teleport(5,CFrame.new(-54.9334946, -360.095276, 9488.80078, -0.964331031, -0.0507260226, 0.259793192, -0.0149418572, 0.990332782, 0.137904868, -0.264277071, 0.129104152, -0.955766559))
                repeat wait() until autofarmInstaLoad == true
                autofarmInstaLoad = false
                wait(1)
                autofarmToggle2 = false
            end
        end
        if winterChest == true then
            workspace.ItemBoughtFromShop:InvokeServer("Winter Chest", 1)
        end
        if selectedChestTog == true then
            workspace.ItemBoughtFromShop:InvokeServer(selectedChest, 1)
        end
    end)
    if not suc then warn(err) end
end)

local mt = getrawmetatable(game)
local oldnamecall = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    if self == workspace.InstaLoadFunction and getnamecallmethod() == "InvokeServer" then
        autofarmInstaLoad = true
        return oldnamecall(self,...)
    end
    return oldnamecall(self, ...)
end)

local gmt = getrawmetatable(game)
local OldIndex = nil

OldIndex = hookmetamethod(game, "__index",function(Self, Key)
    if not checkcaller() and Self == "Humanoid" and Key == "WalkSpeed" then
        return 16
    end
    if not checkcaller() and Self == "Humanoid" and Key == "JumpPower" then
        return 50
    end
    return OldIndex(Self, Key)
end)
setreadonly(gmt, true)

local walkspeed = game:GetService("RunService").RenderStepped:Connect(function()
    if game.Players.LocalPlayer and char():FindFirstChild("Humanoid") and char():FindFirstChild("Humanoid").Health ~= 0 then
        char().Humanoid.WalkSpeed = NewWalkspeed
    end
end)
local jumppower = game:GetService("RunService").RenderStepped:Connect(function()
    if game.Players.LocalPlayer and char():FindFirstChild("Humanoid") and char():FindFirstChild("Humanoid").Health ~= 0 then
        char().Humanoid.JumpPower = NewJumppower
    end
end)

playerChan:Button("Close UI", function()
    closeUi()
    walkspeed:Disconnect()
    jumppower:Disconnect()
    mainLoop:Disconnect()
    char().Humanoid.JumpPower = 50
    char().Humanoid.WalkSpeed = 16
end)

playerChan:Bind("Hide UI", Enum.KeyCode.N, function()
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == "Discord" then
            if v.Enabled == true then
                v.Enabled = false
            else
                v.Enabled = true
            end
        end
    end
end)

_G.loader = "3w4g0hdsp"
