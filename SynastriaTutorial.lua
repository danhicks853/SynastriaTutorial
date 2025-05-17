
print("[Tutorial Debug] Addon loading: main file execution started.")

local StepByLabel = {}
for _, step in ipairs(TutorialSteps) do
    if step.StepLabel then
        StepByLabel[step.StepLabel] = step
    end
end
print("[Tutorial Debug] StepByLabel built.")

-- Debug: Output all tutorial steps during load
print("[Tutorial Debug] Listing all tutorial steps:")
for idx, step in ipairs(TutorialSteps) do
    print(string.format("Step %d: %s - %s", idx, step.StepLabel or "(no label)", step.StepText or "(no text)"))
end

local currentStepLabel = TutorialSteps[1].StepLabel

print("[Tutorial Debug] Defining core functions...")

local function GetCurrentStep()
    return StepByLabel[currentStepLabel]
end

local function ExecuteStepActions(step)
    for i = 1, 3 do
        local action = step["Action"..i]
        if action then
            if type(action) == "table" and ActionDef and ActionDef[action[1]] then
                -- Pass step as first arg, then unpack the rest
                ActionDef[action[1]](step, unpack(action, 2))
            elseif type(action) == "string" and ActionDef and ActionDef[action] then
                ActionDef[action](step)
            end
        end
    end
end

local function SetCurrentStep(label)
    print("[Tutorial Debug] SetCurrentStep called with label:", label)
    if label and StepByLabel[label] then
        currentStepLabel = label
        print("[Tutorial Debug] currentStepLabel set to:", currentStepLabel)
        local step = StepByLabel[label]
        ExecuteStepActions(step)
        return true
    end
    print("[Tutorial Debug] SetCurrentStep failed for label:", label)
    return false
end

local function GoToNextStep()
    local step = GetCurrentStep()
    print("[Tutorial Debug] GoToNextStep called. Current step:", step and step.StepLabel, "NextStepLabel:", step and step.NextStepLabel)
    if step and step.NextStepLabel then
        local result = SetCurrentStep(step.NextStepLabel)
        print("[Tutorial Debug] GoToNextStep result:", result)
        return result
    end
    print("[Tutorial Debug] GoToNextStep failed: No next step.")
    return false
end

local function AdvanceTutorial()
    print("[Tutorial Debug] AdvanceTutorial called.")
    if GoToNextStep() then
        print("[Tutorial Debug] AdvanceTutorial: Step advanced. Calling UpdateTutorialUI.")
        UpdateTutorialUI()
    else
        print("[Tutorial Debug] AdvanceTutorial: Step did not advance.")
    end
end

local lastAnchor = nil

local function AnchorTutorialFrame(anchor)
    if anchor == "LAST" and lastAnchor then
        return
    end
    SynastriaTutorialFrame:ClearAllPoints()
    if anchor == "CENTER" then
        SynastriaTutorialFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 220)
    else
        -- Generalize for any FrameName:RIGHT pattern
        local frameName, position = string.match(anchor or "", "^(.-):(RIGHT)$")
        if frameName and position then
            local frame = _G[frameName]
            if frame then
                SynastriaTutorialFrame:SetPoint("LEFT", frame, "RIGHT", 25, 0)
            else
                SynastriaTutorialFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 220)
            end
        elseif anchor == "GossipFrame:RIGHT" then
            SynastriaTutorialFrame:SetPoint("LEFT", GossipFrame, "RIGHT", 25, 0)
        else
            SynastriaTutorialFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 220)
        end
    end
    lastAnchor = anchor
end

local function UpdateTutorialUI()
    local step = GetCurrentStep()
    if SynastriaTutorialFrame and step then
        SynastriaTutorialFrame:Show()
        local maxWidth = 270
        SynastriaTutorialFrameText:SetWidth(maxWidth)
        SynastriaTutorialFrameText:SetText(step.StepText)
        -- Calculate needed height for the text
        local textHeight = SynastriaTutorialFrameText:GetStringHeight() or 0
        local titleHeight = SynastriaTutorialFrameTitle and SynastriaTutorialFrameTitle:GetHeight() or 24
        local buttonHeight = SynastriaTutorialFrameNextButton and SynastriaTutorialFrameNextButton:GetHeight() or 30
        local paddingTop = 60 -- includes title and spacing
        local paddingBottom = 40 -- includes button and spacing
        local totalHeight = paddingTop + textHeight + paddingBottom
        -- Set minimum and maximum height
        if totalHeight < 120 then totalHeight = 120 end
        if totalHeight > 500 then totalHeight = 500 end
        SynastriaTutorialFrame:SetWidth(maxWidth + 50)
        SynastriaTutorialFrame:SetHeight(totalHeight)
        if step.FrameAnchor then
            AnchorTutorialFrame(step.FrameAnchor)
        end
        if SynastriaTutorialFrameNextButton then
            SynastriaTutorialFrameNextButton:SetText("Next")
            if step.NextStepTrigger == "NEXT_BUTTON" then
                SynastriaTutorialFrameNextButton:Show()
            else
                SynastriaTutorialFrameNextButton:Hide()
            end
        end
    end
end

local function AdvanceTutorial()
    if GoToNextStep() then
        UpdateTutorialUI()
    end
end

function OnTutorialEvent(self, event, ...)
    local step = GetCurrentStep()
    print("[Tutorial Debug] Event:", event, "Current Step:", step and step.StepLabel, "NextStepTrigger:", step and step.NextStepTrigger)
    if step and step.NextStepTrigger and TriggerDef[step.NextStepTrigger] then
        local triggered = TriggerDef[step.NextStepTrigger](event, ...)
        print("[Tutorial Debug] TriggerDef result:", triggered)
        if triggered then
            AdvanceTutorial()
        end
    end
    UpdateTutorialUI()
end

print("[Tutorial Debug] Creating eventFrame and registering events...")
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:RegisterEvent("PLAYER_LEVEL_UP")
eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
eventFrame:RegisterEvent("BAG_UPDATE")
eventFrame:RegisterEvent("CHAT_MSG_SYSTEM")
eventFrame:RegisterEvent("GOSSIP_SHOW")

-- Modular: Generic function to hook custom frames and fire tutorial events
local function HookCustomFrameOnShow(frameName, eventName)
    local pollFrameName = "SynastriaTutorial_Poll_" .. frameName
    if not _G[pollFrameName] then
        _G[pollFrameName] = CreateFrame("Frame")
    end
    local pollFrame = _G[pollFrameName]
    pollFrame:SetScript("OnUpdate", function(self, elapsed)
        local frame = _G[frameName]
        if frame and not frame.__tutorialHooked then
            print("[Tutorial Debug] Hooking OnShow for " .. frameName)
            frame:HookScript("OnShow", function()
                print("[Tutorial Debug] " .. frameName .. " OnShow fired. Sending " .. eventName .. " event.")
                OnTutorialEvent(nil, eventName)
            end)
            frame.__tutorialHooked = true
            self:SetScript("OnUpdate", nil)
        elseif frame and frame.__tutorialHooked then
            self:SetScript("OnUpdate", nil)
        end
    end)
end

eventFrame:HookScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        HookCustomFrameOnShow("PerkMgrFrame", "PERK_FRAME_OPENED")
        HookCustomFrameOnShow("RBankFrame", "RBANK_FRAME_OPENED")
        HookCustomFrameOnShow("TPortFrame", "TPORT_FRAME_OPENED")
        HookCustomFrameOnShow("TransmogFrame", "TRANSMOG_FRAME_OPENED")
        HookCustomFrameOnShow("LootDBFrame", "LOOTDB_FRAME_OPENED")
        HookCustomFrameOnShow("LBoardFrame", "LBOARD_FRAME_OPENED")
        HookCustomFrameOnShow("ChangelogFrame", "CHANGELOG_FRAME_OPENED")
        HookCustomFrameOnShow("LFilterFrame", "LFILTER_FRAME_OPENED")
        HookCustomFrameOnShow("ItemAttuneFrame", "ITEM_ATTUNE_FRAME_OPENED")
        HookCustomFrameOnShow("AttuneMgrFrame", "ATTUNE_FRAME_OPENED")
    end
end)

local function OnTutorialEvent(self, event, ...)
    local step = GetCurrentStep()
    print("[Tutorial Debug] Event:", event, "Current Step:", step and step.StepLabel, "NextStepTrigger:", step and step.NextStepTrigger)
    if step and step.NextStepTrigger and TriggerDef[step.NextStepTrigger] then
        local triggered = TriggerDef[step.NextStepTrigger](event, ...)
        print("[Tutorial Debug] TriggerDef result:", triggered)
        if triggered then
            AdvanceTutorial()
        end
    end
    UpdateTutorialUI()
end

print("[Tutorial Debug] Setting up custom frame hooks...")
print("[Tutorial Debug] Main file execution finished.")

-- Runs Action1, Action2, Action3 from the current step if present
local function RunTutorialStepActions(step)
    for i = 1, 3 do
        local action = step["Action"..i]
        if action and type(action) == "table" then
            local funcName = action[1]
            local param = action[2]
            local func = _G[funcName]
            if type(func) == "function" then
                if funcName == "HighlightGossipOptionByText" then
                    if GossipFrame and GossipFrame:IsShown() then
                        func(param)
                    end
                else
                    func(param)
                end
            end
        end
    end
end

-- Patch: After updating the current step, run actions if any
local orig_UpdateTutorialUI = UpdateTutorialUI
function UpdateTutorialUI(...)
    local result = {orig_UpdateTutorialUI(...)}
    local step = GetCurrentStep and GetCurrentStep()
    if step then
        RunTutorialStepActions(step)
    end
    return unpack(result)
end

-- Highlight the 'I would like to skip leveling!' gossip option during the CHOOSE_LEVEL step
local function SynastriaTutorial_OnGossipShow()
    print("[Tutorial Debug] Entered SynastriaTutorial_OnGossipShow");
    local step = GetCurrentStep and GetCurrentStep()
    if step then
        print("[Tutorial Debug] Current step label:", step.StepLabel or "nil")
        -- Always clear highlights first
        if ClearGossipHighlights then
            ClearGossipHighlights()
        end
        for i = 1, 3 do
            local action = step["Action"..i]
            if action and type(action) == "table" then
                local funcName = action[1]
                local param = action[2]
                if funcName == "HighlightGossipOptionByText" then
                    local func = _G[funcName]
                    if type(func) == "function" then
                        func(param)
                    end
                end
            end
        end
    else
        print("[Tutorial Debug] No current step, clearing highlights if possible.")
        if ClearGossipHighlights then
            ClearGossipHighlights()
        end
    end
end

-- Register GOSSIP_SHOW event to handle highlighting
local st_gossip_highlight_frame = CreateFrame("Frame")
st_gossip_highlight_frame:RegisterEvent("GOSSIP_SHOW")
st_gossip_highlight_frame:SetScript("OnEvent", function(self, event, ...)
    if event == "GOSSIP_SHOW" then
        SynastriaTutorial_OnGossipShow()
    end
end)

-- Slash command to force skip to next tutorial step
SLASH_STFORCENEXT1 = "/stforcenext"
SlashCmdList["STFORCENEXT"] = function(msg)
    print("[Tutorial Debug] /stforcenext used: advancing tutorial.")
    AdvanceTutorial()
end

-- All custom frame hooks must be set up AFTER all function definitions
HookCustomFrameOnShow("PerkMgrFrame", "PERK_FRAME_OPENED")
HookCustomFrameOnShow("RBankFrame", "RBANK_FRAME_OPENED")
HookCustomFrameOnShow("TPortFrame", "TPORT_FRAME_OPENED")
HookCustomFrameOnShow("TransmogFrame", "TRANSMOG_FRAME_OPENED")
HookCustomFrameOnShow("LootDBFrame", "LOOTDB_FRAME_OPENED")
HookCustomFrameOnShow("LBoardFrame", "LBOARD_FRAME_OPENED")
HookCustomFrameOnShow("ChangelogFrame", "CHANGELOG_FRAME_OPENED")
HookCustomFrameOnShow("LFilterFrame", "LFILTER_FRAME_OPENED")
HookCustomFrameOnShow("ItemAttuneFrame", "ITEM_ATTUNE_FRAME_OPENED")
HookCustomFrameOnShow("AttuneMgrFrame", "ATTUNE_FRAME_OPENED")

eventFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        if not SynastriaTutorial_Completed then
            -- Only reset to first step if not already on a valid step
            if not currentStepLabel or not StepByLabel[currentStepLabel] then
                currentStepLabel = TutorialSteps[1].StepLabel
                UpdateTutorialUI()
                if SynastriaTutorialFrame then
                    SynastriaTutorialFrame:Show()
                end
            end
        end
    end
    OnTutorialEvent(self, event, ...)
end)

if SynastriaTutorialFrameNextButton then
    SynastriaTutorialFrameNextButton:SetScript("OnClick", function()
        AdvanceTutorial()
    end)
end

-- 2. Info Browser (minimap icon)
-- Placeholder for minimap button and info browser logic
-- TODO: Implement minimap icon and article browser UI
