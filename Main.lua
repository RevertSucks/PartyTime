local gameIds = {
    ["Build A Boat"] = 537413528,
}
local foundHit

local function load()
    for i,v in pairs(gameIds) do
        if game.PlaceId == v then
            print(i)
            foundHit = string.gsub(i," ","%%20")
            print(foundHit)
        end
    end
    if foundHit ~= nil then
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/RevertSucks/PartyTime/main/scripts/"..foundHit..".lua"))()
    else
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/RevertSucks/PartyTime/main/scripts/Universal.lua"))()
    end
end

load()
