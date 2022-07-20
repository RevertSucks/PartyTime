local function closeUi()
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v.name == "Discord" then
            v:Destroy()
        end
    end
end
closeUi()

local function char()
    return game.Players.LocalPlayer.Character
end

local devMode = true

--[[
    for i,v in pairs(game:GetService("Workspace").Trees:GetChildren()) do
    workspace.Main.UprootTree:FireServer(v)
end
]]



local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()

local win = DiscordLib:Window("Fired From a Pizza Place")
local serv = win:Server("Made By Exxen#0001", "http://www.roblox.com/asset/?id=6031075938")

local mainChan = serv:Channel("Main")
local setttingChan = serv:Channel("Settings")

local oldFace = char().Head.face.Texture
local house = game.Players.LocalPlayer.House.Value
print(house.Name)

local teamswitcher = false
local faceToggle = false
local faceImage
local found = false
local sitToggle = false
local breakCars = false
local autofarmToggle = false

local ignoreLocal = false

setttingChan:Toggle("Ignore Local Player",false, function(bool)
    ignoreLocal = bool
end)

local function sitPlayers()
    if found == false then
        local oldCFrame = char().HumanoidRootPart.CFrame
        for i,v in pairs(house:GetDescendants()) do
            if v.Name == "Floor" then
                char().HumanoidRootPart.CFrame = v.CFrame
            end
        end
        repeat wait() until house.Furniture:FindFirstChild("Tot Slide")
        char().HumanoidRootPart.CFrame = oldCFrame
    end
    if house.Furniture:FindFirstChild("Tot Slide") then
        found = true
        for i,v in pairs(game.Players:GetPlayers()) do
            if ignoreLocal == true and v.Name ~= game.Players.LocalPlayer.Name or ignoreLocal == false then
                local touchpart = v.Character.HumanoidRootPart
                house.Furniture["Tot Slide"].TouchEvent:FireServer(touchpart, house.Furniture["Tot Slide"].Trip)
            end
        end
    else
        found = false
        DiscordLib:Notification("Notification", "Not Found", "Okay!")
    end
end

mainChan:Toggle("Every team",false, function(bool)
    teamswitcher = bool
end)

mainChan:Seperator()

mainChan:Textbox("Custom Face ID", "Decal ID or Image ID", true, function(t)
    faceImage = string.format("rbxthumb://type=Asset&id=%s&w=420&h=420", t)
end)

mainChan:Toggle("Custom Face",false, function(bool)
    faceToggle = bool
    if bool == false then
        wait(.1)
        workspace.Main.ChangeFace:FireServer(char().Head.face, oldFace)
    end
end)

mainChan:Seperator()

mainChan:Button("Sit All", function()
    sitPlayers()
end)

local runningSit = false
mainChan:Toggle("Loop Sit All",false, function(bool)
    sitToggle = bool
    if bool == false then
        runningSit = false
    end
end)

mainChan:Toggle("Break Cars",false, function(bool)
    breakCars = bool
end)

mainChan:Seperator()

--[[mainChan:Toggle("Autofarm",false, function(bool)
    autofarmToggle = bool
end)]]--

local runningTeam = false
local runningAuto = false

local mainLoop = game:GetService('RunService').Heartbeat:connect(function()
local suc,err = pcall(function()
        if teamswitcher == true and runningTeam == false then
            runningTeam = true
            for i,v in pairs(game:GetService("Teams"):GetChildren()) do
                if teamswitcher == true then
                task.wait()
                game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob", v.Name)
                else
                    break
                end
            end
            runningTeam = false
        end
        if faceToggle == true then
            workspace.Main.ChangeFace:FireServer(char().Head.face, faceImage)
        end
        if breakCars == true then
            sitPlayers()
        end
        if sitToggle == true and runningSit == false then
            runningSit = true
            sitPlayers()
            task.wait(.7)
            runningSit = false
        end
        if autofarmToggle == true and runningAuto == false then
            --teleport to house method no work...
        end
    end)
    if not suc and devMode == true then warn(err) end
end)

mainChan:Seperator()

mainChan:Button("Close Menu", function()
mainLoop:Disconnect()
closeUi()
end)
