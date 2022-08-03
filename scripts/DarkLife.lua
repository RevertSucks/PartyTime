--severe WIP, currently only picks up printer money you own and are inside the house of
if (rconsoleprint) then
  local hasFound
  local function FireRay(character)
    local rayOrigin = character.HumanoidRootPart.Position
    local rayDirection = Vector3.new(0, -100, 0)

    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {character}
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    if raycastResult.Instance.Name == "buildable" then
        hasFound = true
        return raycastResult.Instance.Parent.Parent
    else
        rconsolewarn("Not Standing On Green Buildable Zone!")
      end
  end
  repeat
      FireRay(game.Players.LocalPlayer.Character) task.wait()
  until
      hasFound == true

  local house = FireRay(game.Players.LocalPlayer.Character)

  while task.wait() do
      for i,v in pairs(house:GetChildren()) do
          if v.Name == "Bitcoin" or v.Name == "Printers" then
              print(v.Display.ProximityPrompt:GetFullName())
              fireproximityprompt(v.Display.ProximityPrompt)
          end
      end
  end
else warn("missing required function.")
end
