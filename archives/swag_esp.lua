local ESP = {
    Chams = false,
    FillColor = Color3.fromRGB(255,0,0),
    FillTransparency = 0.5,
    OutlineColor = Color3.fromRGB(255,255,255),
    OutlineTransparency = 0,

    Username = false,
    TextColor = Color3.fromRGB(255,255,255),
    TextSize = 14,
    Center = true,
    TextOutline = true,
    TextOutlineColor = Color3.fromRGB(0,0,0),
    Font = Drawing.Fonts["System"],
    HeightOffset = Vector3.new(0,0.5,0)
}


local camera = game.Workspace.CurrentCamera

for i,v in pairs(game.Players:GetPlayers()) do
    if v ~= game.Players.LocalPlayer then
    local newHighlight = Instance.new("Highlight")
    newHighlight.Parent = v.Character

    local newUsername = Drawing.new("Text")
    newUsername.Text = v.Name
    
    local function updateOutline(plr)
        game:GetService("RunService").RenderStepped:Connect(function()
            newHighlight.Enabled = ESP.Chams
            newHighlight.FillColor = ESP.FillColor
            newHighlight.FillTransparency = ESP.FillTransparency
            newHighlight.OutlineColor = ESP.OutlineColor
            newHighlight.OutlineTransparency = ESP.OutlineTransparency

            newUsername.Size = ESP.TextSize
            newUsername.Color = ESP.TextColor
            newUsername.Center = ESP.Center
            newUsername.Outline = ESP.TextOutline
            newUsername.OutlineColor = ESP.TextOutlineColor
            newUsername.Font = ESP.Font

            if ESP.Username and plr.Character ~= nil and (v.Character:FindFirstChildOfClass("Humanoid") and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 ) and plr.Character:FindFirstChild("HumanoidRootPart") and plr ~= game.Players.LocalPlayer then
                local vector,onScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)

                local char = plr.Character
                local rootPart = char.HumanoidRootPart
                local head = char.Head
                local rootPos, RootVis = camera:WorldToViewportPoint(rootPart.Position)
                local headPos, headVis = camera:WorldToViewportPoint(head.Position + Vector3.new(0,0.5,0))
                local legPos, legVis = camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0,3,0))
                

                local dist = (camera.CFrame.Position - rootPart.Position).Magnitude
                if onScreen then
                    newUsername.Position = Vector2.new(headPos.X, headPos.Y-ESP.HeightOffset.Y)
                    newUsername.Visible = true 
                else
                    newUsername.Visible = false
                end
            else
                newUsername.Visible = false
            end
        end)
    end
    
    coroutine.wrap(updateOutline)(v)
    
    v.CharacterAdded:Connect(function(char)
        newHighlight.Parent = char
    end)
    end
end

game.Players.PlayerAdded:Connect(function(v)
    if v ~= game.Players.LocalPlayer then
        local newHighlight = Instance.new("Highlight")
        newHighlight.Parent = v.Character
    
        local newUsername = Drawing.new("Text")
        newUsername.Text = v.Name
        
        local function updateOutline(plr)
            game:GetService("RunService").RenderStepped:Connect(function()
                newHighlight.Enabled = ESP.Chams
                newHighlight.FillColor = ESP.FillColor
                newHighlight.FillTransparency = ESP.FillTransparency
                newHighlight.OutlineColor = ESP.OutlineColor
                newHighlight.OutlineTransparency = ESP.OutlineTransparency
    
                newUsername.Size = ESP.TextSize
                newUsername.Color = ESP.TextColor
                newUsername.Center = ESP.Center
                newUsername.Outline = ESP.TextOutline
                newUsername.OutlineColor = ESP.TextOutlineColor
                newUsername.Font = ESP.Font
    
                if ESP.Username and plr.Character ~= nil and (v.Character:FindFirstChildOfClass("Humanoid") and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 ) and plr.Character:FindFirstChild("HumanoidRootPart") and plr ~= game.Players.LocalPlayer then
                    local vector,onScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
    
                    local char = plr.Character
                    local rootPart = char.HumanoidRootPart
                    local head = char.Head
                    local rootPos, RootVis = camera:WorldToViewportPoint(rootPart.Position)
                    local headPos, headVis = camera:WorldToViewportPoint(head.Position + Vector3.new(0,0.5,0))
                    local legPos, legVis = camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0,3,0))
                    
    
                    local dist = (camera.CFrame.Position - rootPart.Position).Magnitude
                    if onScreen then
                        newUsername.Position = Vector2.new(headPos.X, headPos.Y-ESP.HeightOffset.Y)
                        newUsername.Visible = true 
                    else
                        newUsername.Visible = false
                    end
                else
                    newUsername.Visible = false
                end
            end)
        end
        
        coroutine.wrap(updateOutline)(v)
        
        v.CharacterAdded:Connect(function(char)
            newHighlight.Parent = char
        end)
    end
end)


return ESP
