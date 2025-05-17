ActionDef = {}

ActionDef.MarkNPC = function(step, NPCName)
    print("[ActionDef] MarkNPC for step: " .. (step.StepLabel or "") .. ", NPCName: " .. tostring(NPCName))
    if NPCName then
        SendChatMessage(".findnpc " .. NPCName, "SAY")
    end
end

ActionDef.ShowClassPerks = function(step)
    local _, class = UnitClass("player") -- e.g., "WARRIOR"
    local perks = PerkRecs and PerkRecs[class]
    if not perks then
        step.StepText = "No perk recommendations found for your class."
        return
    end
    local text = "|cff00ff00Recommended Perks for " .. class .. " (" .. (perks.Spec or "") .. "):|r\n\n"
    local function addSection(title, list)
        if list and #list > 0 then
            text = text .. "|cffffff00" .. title .. ":|r " .. table.concat(list, ", ") .. "\n"
        end
    end
    addSection("Offense", perks.OffensePerks)
    addSection("Defense", perks.DefensePerks)
    addSection("Support", perks.SupportPerks)
    addSection("Utility", perks.UtilityPerks)
    addSection("Class", perks.ClassPerks)
    step.StepText = text
end


-- Highlights a gossip option by its displayed text
function HighlightGossipOptionByText(targetText)
    print("[Tutorial Debug] HighlightGossipOptionByText called with:", targetText)
    for i = 1, 32 do
        local button = _G["GossipTitleButton"..i]
        if button and button:IsShown() then
            -- Always reset to default
            local fontString = button:GetFontString()
            if fontString then
                fontString:SetFont("Fonts\\FRIZQT__.TTF", 12, "")
                fontString:SetTextColor(0.2, 0.16, 0.08)
            end
            if button.glow then
                button.glow:Hide()
            end
            -- Now apply highlight if this is the matching one
            if button:GetText() == targetText then
                print("[Tutorial Debug] Match found! Adding quest highlight to button", i)
                if not button.glow then
                    local glow = button:CreateTexture(nil, "ARTWORK")
                    glow:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
                    glow:SetBlendMode("ADD")
                    glow:SetPoint("LEFT", button, "LEFT", 4, 0)
                    glow:SetPoint("RIGHT", button, "RIGHT", -4, 0)
                    glow:SetHeight(18)
                    glow:SetAlpha(0.7)
                    button.glow = glow
                end
                button.glow:Show()
                -- Set text to larger and dark red
                if fontString then
                    fontString:SetFont("Fonts\\FRIZQT__.TTF", 15, "")
                    fontString:SetTextColor(0.8, 0, 0)
                end
            end
        end
    end
end

-- Ensure global access for action execution
_G.HighlightGossipOptionByText = HighlightGossipOptionByText

-- Clears all gossip option highlights
function ClearGossipHighlights()
    for i = 1, 32 do
        local button = _G["GossipTitleButton"..i]
        if button and button.glow then
            button.glow:Hide()
        end
    end
end

return ActionDef
