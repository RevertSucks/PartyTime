local ESP = {
    Enabled = false,
    FillColor = Color3.fromRGB(255,0,0),
    FillTransparency = 0.5,
    OutlineColor = Color3.fromRGB(255,255,255),
    OutlineTransparency = 0
}

for i,v in pairs(game.Players:GetPlayers()) do
    if v ~= game.Players.LocalPlayer then
    local newHighlight = Instance.new("Highlight")
    
    newHighlight.Name = "HumanoidRootPart"
    newHighlight.Parent = character
    
    local function updateOutline()
        game:GetService("RunService").RenderStepped:Connect(function()
            newHighlight.Enabled = ESP.Enabled
            newHighlight.FillColor = ESP.FillColor
            newHighlight.FillTransparency = ESP.FillTransparency
            newHighlight.outlinecolor = ESP.OutlineColor
            newHighlight.OutlineTransparency = ESP.OutlineTransparency
        end)
    end
    
    coroutine.wrap(updateOutline)()
    
    v.CharacterAdded:Connect(function(char)
        newHighlight.Parent = char
    end)
    end
end

game.Players.PlayerAdded:Connect(function(v)
    local newHighlight = Instance.new("Highlight")
    
    newHighlight.Name = "HumanoidRootPart"
    newHighlight.Parent = character
    
    local function updateOutline()
        game:GetService("RunService").RenderStepped:Connect(function()
            newHighlight.Enabled = ESP.Enabled
            newHighlight.FillColor = ESP.FillColor
            newHighlight.FillTransparency = ESP.FillTransparency
            newHighlight.outlinecolor = ESP.OutlineColor
            newHighlight.OutlineTransparency = ESP.OutlineTransparency
        end)
    end
    
    coroutine.wrap(updateOutline)()
    
    v.CharacterAdded:Connect(function(char)
        newHighlight.Parent = char
    end)
end)

return ESP
