local gameIds = {
    ["Build A Boat"] = 537413528,
}
local foundHit

local function import(file)
    loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/RevertSucks/PartyTime/main/scripts/%s.lua"):format(file)),file..'.lua')()
end

local function load()
    for i,v in pairs(gameIds) do
        if game.PlaceId == v then
            print(i)
            foundHit = string.gsub(i," ","%%20")
            print(foundHit)
        end
    end
    if foundHit ~= nil then
        import(foundHit)
    else
        import("Universal")
    end
end

load()
