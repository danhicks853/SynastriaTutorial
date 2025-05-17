TriggerDef = {}
TriggerDef.NEXT_BUTTON = function(event, ...)
    return event == "NEXT_BUTTON"
end
TriggerDef.GOSSIP_SHOW = function(event, ...)
    return event == "GOSSIP_SHOW"
end
TriggerDef.PLAYER_LEVEL_UP = function(event, ...)
    return event == "PLAYER_LEVEL_UP"
end
TriggerDef.ZONE_CHANGED_NEW_AREA = function(event, ...)
    return event == "ZONE_CHANGED_NEW_AREA"
end
TriggerDef.HEARTHSTONE_SET = function(event, ...)
    if event ~= "CHAT_MSG_SYSTEM" then return false end
    local msg = ...
    return msg and msg:find("Dalaran is now your home.") ~= nil
end
TriggerDef.BAG_UPDATE = function(event, ...)
    return event == "BAG_UPDATE"
end
TriggerDef.PERK_FRAME_OPENED = function(event, ...)
    return event == "PERK_FRAME_OPENED"
end