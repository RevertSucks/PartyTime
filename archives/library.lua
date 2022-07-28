local script = game:GetService("Players").LocalPlayer.PlayerGui.GameMenus.MenuFunctions2
local functions
functions.__index = functions

function functions:notification(p16,p17,p18)
    if script.Parent:FindFirstChild("MenuNotification") then
    	script.Parent.MenuNotification:Destroy();
    end;
	local v5 = script.MenuNotification:Clone();
	v5.Position = UDim2.new(1, 300, 0, 60);
	v5.Parent = script.Parent;
	if p16 then
		v5.Title.Text = p16;
	end;
	if p17 then
		v5.Description.Text = p17;
	end;
	if typeof(p18) == "Color3" then
		v5.Line.BackgroundColor3 = p18;
		v5.Gradient.BackgroundColor3 = p18;
	elseif typeof(p18) == "string" then
		if p18 == "Red" then
			v5.Line.BackgroundColor3 = Color3.new(1, 0, 0);
			v5.Gradient.BackgroundColor3 = Color3.new(1, 0, 0);
		elseif p18 == "Gold" then
			v5.Line.BackgroundColor3 = _G.GoldColor;
			v5.Gradient.BackgroundColor3 = _G.GoldColor;
		elseif p18 == "White" then
			v5.Line.BackgroundColor3 = Color3.new(1, 1, 1);
			v5.Gradient.BackgroundColor3 = Color3.new(1, 1, 1);
		elseif p18 == "Green" then
    		v5.Line.BackgroundColor3 = Color3.new(0, 0.886275, 0);
    		v5.Gradient.BackgroundColor3 = Color3.new(0, 0.886275, 0);
    end
end
v5.Visible = true;
	v5:TweenPosition(UDim2.new(1, 0, 0, 60), "Out", "Quad", 0.3);
	spawn(function()
		wait(3);
		if v5 and v5.Parent == script.Parent then
			v5:TweenPosition(UDim2.new(1, 300, 0, 60), "In", "Quad", 0.3);
			wait(0.3);
			v5:Destroy();
		end;
	end);
end
function functions:char()
    return plr.Character
end
function functions:teleport(cframe,time)
    if time == nil then
        char().HumanoidRootPart.CFrame = cframe
        for _, v in ipairs(char():GetDescendants()) do
			if v.IsA(v, "BasePart") then
				v.Velocity, v.RotVelocity = Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)
			end
		end
    else
        local tween =  game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(time), {CFrame = cframe})
        char().Humanoid.Sit = true
        tween:Play()
        tween.Completed:Wait()
        char().Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        for _, v in ipairs(char():GetDescendants()) do
			if v.IsA(v, "BasePart") then
				v.Velocity, v.RotVelocity = Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)
			end
		end
        GUI:Notification{Title = "Alert",Text = "Completed! If the map is loading and your frozen then wait.",Duration = 5,Callback = function() end}
    end
end
function functions:carTeleport(model,cframe,time)
	local CFrameValue = Instance.new("CFrameValue")
	CFrameValue.Value = model:GetPrimaryPartCFrame()

	CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
		model:SetPrimaryPartCFrame(CFrameValue.Value)
	end)
	
	local tween = game:GetService("TweenService"):Create(CFrameValue, TweenInfo.new(time,Enum.EasingStyle.Linear), {Value = cframe})
	tween:Play()
	
	tween.Completed:Connect(function()
		CFrameValue:Destroy()
	end)
end
function functions:speedFunc(char,speed,usecar)
if usecar == false then
    if UIS.MouseBehavior == Enum.MouseBehavior.LockCenter and not (UIS:GetFocusedTextBox()) then --if shiftlock/firstperson then
        if UIS:IsKeyDown(Enum.KeyCode.W) then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0,0,-speed)
        end;
        if UIS:IsKeyDown(Enum.KeyCode.A) then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(-speed,0,0)
        end;
        if UIS:IsKeyDown(Enum.KeyCode.S) then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0,0,speed)
        end;
        if UIS:IsKeyDown(Enum.KeyCode.D) then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(speed,0,0)
        end;
        elseif UIS.MouseBehavior ~= Enum.MouseBehavior.LockCenter and not (UIS:GetFocusedTextBox()) then --if not shiftlock then
        if UIS:IsKeyDown(Enum.KeyCode.W) then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0,0,-speed)
        end;
        if UIS:IsKeyDown(Enum.KeyCode.A) then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0,0,-speed)
        end;
        if UIS:IsKeyDown(Enum.KeyCode.S) then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0,0,-speed)
        end;
        if UIS:IsKeyDown(Enum.KeyCode.D) then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0,0,-speed)
        end
    end
end
end
function functions:generateAnimation(name,id)
    local instance = Instance.new("Animation")
    instance.Parent = char():FindFirstChild("Animation Runner")
    instance.Name = name
    instance.AnimationId = id
    local instancClone = instance:Clone()
    instancClone.Parent = animationHolder
end
function functions:saveAnimation(name,id)
    local folderPath = "Exxen/ERLC/Animations/"
    if not isfolder("Exxen") then
        makefolder("Exxen")
    end
    if not isfolder("Exxen/ERLC") then
        makefolder("Exxen/ERLC")
    end
    if not isfolder(folderPath) then
        makefolder(folderPath)
    end
    if not isfile(folderPath..name..".Animation") then
        writefile(folderPath..name..".Animation",id)
        return true
    else
        GUI:Notification{Title = "Alert",Text = "You already have an animation with this name!",Duration = 3,Callback = function() end}
        return false
    end
end

function functions:importAnimations()
    local files = listfiles("Exxen/ERLC/Animations")
    for i,v in pairs(files) do
        local filepath = string.split(v,".")[1]
        filepath = string.split(filepath,[[\]])[2]
        if not char()["Animation Runner"]:FindFirstChild(filepath) then
            generateAnimation(filepath,readfile(v))
            animations:Toggle{Name = filepath, StartingState = false,Description = nil,Callback = function(state)
                if state == true then
                    game:GetService("ReplicatedStorage").ClientBinds.PlayAnimation:Fire(filepath)
                else
                    game:GetService("ReplicatedStorage").ClientBinds.StopAnimation:Fire(filepath)
                end
            end}
        end
    end
end
function functions:collidesWith(gui1, gui2)
    local gui1_topLeft = gui1.AbsolutePosition
    local gui1_bottomRight = gui1_topLeft + gui1.AbsoluteSize

    local gui2_topLeft = gui2.AbsolutePosition
    local gui2_bottomRight = gui2_topLeft + gui2.AbsoluteSize

    return ((gui1_topLeft.x < gui2_bottomRight.x and gui1_bottomRight.x > gui2_topLeft.x) and (gui1_topLeft.y < gui2_bottomRight.y and gui1_bottomRight.y > gui2_topLeft.y)) 
end
function functions:onScreen(frame)
    if frame.Position.X.Scale < 1 and frame.Position.Y.Scale < 1 then
        return true
    else
        return false
    end
end



notification("Made By Exxen","nigger",Color3.new(255,0,255))
