--FROSTWEAVE.GG -- HC MODE -- / /
local function OnHardCoreLogin(event, player)
    if player:HasItem(666, 1) then
        player:SendAreaTriggerMessage("|cFFffffffWelcome to HardCore Mode, " ..
            player:GetName() .. ".|r Watch your step!|r")
    end
end

local function OnCanTrade(event, player, target)
    if player:HasItem(666, 1) or target:HasItem(666, 1) then
        player:SendBroadcastMessage("|cffffd000 Hardcore Mode is active. You are not authorized to perform this action.")
        return false
    end
    return true
end

local function OnCanSendMail(event, player, receiverGuid, mailbox, subject, body, money, cod, item)
    local receiver = GetPlayerByGUID(receiverGuid)
    if player:HasItem(666, 1) or (receiver and receiver:HasItem(666, 1)) then
        player:SendBroadcastMessage(
            "|cffffd000 Hardcore Mode is detected. You are not authorized to perform this action.")
        return false
    end
    return true
end

local function OnCanGroupInvite(event, player, memberName)
    local member = GetPlayerByName(memberName)
    if player:HasItem(666, 1) or (member and member:HasItem(666, 1)) then
        player:SendBroadcastMessage("|cffffd000 Hardcore Mode is detected. You are not authorized to make a group.")
        return false
    end
    return true
end


local enabledBankers = false
local Bankers = {
    2455, 2456, 2457, 2458, 2459, 2460, 2461, 2625, 2996, 3309, 3318, 3320, 3496, 4155, 4208, 4209, 4549, 4550, 5060,
    5099, 7799, 8119, 8123, 8124, 8356, 8357,
    13917, 16615, 16616, 16617, 16710, 17631, 17632, 17633, 17773, 18350, 19034, 19246, 19318, 19338, 21732, 21733,
    21734, 28343, 28675, 28676, 28677, 28678,
    28679, 28680, 29282, 29283, 29530, 30604, 30605, 30606, 30607, 30608, 31420, 31421, 31422, 36284, 36351, 36352,
    38919, 38920, 38921
}
local function BlockBankers(event, player, creature)
    if creature:IsBanker() then
        if player:HasItem(666, 1) then
            player:SendBroadcastMessage("|cffffd000Hardcore Mode is detected. You are not authorized to use the bank.")
        else
            player:SendShowBank(creature)
        end
    end
end

if enabledBankers then
    for _, v in pairs(Bankers) do
        RegisterCreatureGossipEvent(v, 1, BlockBankers)
    end
end

local enabledMail = true
local Mailboxes = { 32349, 140908, 142075, 142089, 142093, 142094, 142095, 142102, 142103, 142109, 142110, 142111,
    142117, 142119, 143981, 143982,
    143983, 143984, 143985, 143986, 143987, 143988, 143989, 143990, 144011, 144112, 144125, 144126, 144127, 144128,
    144129, 144130, 144131, 144179,
    144570, 153578, 153716, 157637, 163313, 163645, 164618, 164840, 171556, 171699, 171752, 173047, 173221, 175864,
    176319, 176324, 176404, 177044,
    178864, 179895, 179896, 180451, 181236, 181380, 181381, 181639, 181883, 181980, 182356, 182357, 182359, 182360,
    182361, 182362, 182363, 182364,
    182365, 182567, 182939, 182946, 182948, 182949, 182950, 182955, 183037, 183038, 183039, 183040, 183042, 183047,
    183167, 183856, 183857, 183858,
    184085, 184133, 184134, 184135, 184136, 184137, 184138, 184139, 184140, 184147, 184148, 184490, 184652, 184944,
    185102, 185471, 185472, 185473,
    185477, 185965, 186230, 186435, 186506, 186629, 186687, 187113, 187260, 187268, 187316, 187322, 188123, 188132,
    188241, 188256, 188355, 188486,
    188531, 188534, 188541, 188604, 188618, 188682, 188710, 189328, 189329, 189969, 190914, 190915, 191228, 191521,
    191832, 191946, 191947, 191948,
    191949, 191950, 191951, 191952, 191953, 191954, 191955, 191956, 191957, 192952, 193043, 193044, 193045, 193071,
    193791, 193972, 194016, 194027,
    194147, 194492, 194788, 195218, 195219, 195467, 195468, 195528, 195529, 195530, 195554, 195555, 195556, 195557,
    195558, 195559, 195560, 195561,
    195562, 195603, 195604, 195605, 195606, 195607, 195608, 195609, 195610, 195611, 195612, 195613, 195614, 195615,
    195616, 195617, 195618, 195619,
    195620, 195624, 195625, 195626, 195627, 195628, 195629 }

local ObjectRespawnRange = 5
if enabledMail then
    for _, v in ipairs(Mailboxes) do
        RegisterGameObjectEvent(v, 1, function(event, gameobject)
            local players = gameobject:GetPlayersInRange(ObjectRespawnRange)
            local shouldDespawn = false
            for _, player in ipairs(players) do
                if player:HasItem(666, 1) then
                    shouldDespawn = true
                    break
                end
            end
            if shouldDespawn then
                gameobject:Despawn()
            else
                gameobject:Respawn(ObjectRespawnRange)
            end
        end)
    end
end


RegisterPlayerEvent(3, OnHardCoreLogin)
RegisterPlayerEvent(48, OnCanTrade)
RegisterPlayerEvent(49, OnCanSendMail)
RegisterPlayerEvent(55, OnCanGroupInvite)
