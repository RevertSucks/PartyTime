--[[
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
]]--
-- // Protected by luaGuard - Security Level basic

-- This file was generated using Luraph Obfuscator v13.5.4

rconsoleclear()
rconsoleprint("@@GREEN@@")
rconsolename("Dark Life - God Mode Log - Made By Exxen#0001")

local function char()
    return game.Players.LocalPlayer.Character
end

rconsoleprint("\nStarting...")

local function init()
    local hrp = char().HumanoidRootPart
    local weld = hrp:FindFirstChildOfClass("Weld")
    local weld2 = char().Head:FindFirstChild("Weld")
    if weld then
        weld:Destroy()
    end
    if weld2 then
        weld2:Destroy()
    end
    rconsoleprint("@@GREEN@@")
    rconsoleprint("\nToggled God")
end

init()

rconsoleprint("@@RED@@")
rconsoleprint("\n\nBEWARE, TURRENTS(AND TRAPS), LAVA, AND EXPLOSIVES CAN STILL KILL YOU!")
rconsoleprint("\nALSO FOR SOME REASON YOU CAN BE TASED, JUST NOT SHOT, AND BEING RAGDOLL WITH 5HP WILL LET PEOPLE STOMP U")

game.Players.LocalPlayer.CharacterAdded:connect(function()
    wait(.5)
    init()
end)
